/*
 * <copyright>
 *  
 *  Copyright 2003-2004 BBNT Solutions, LLC
 *  under sponsorship of the Defense Advanced Research Projects
 *  Agency (DARPA).
 * 
 *  You can redistribute this software and/or modify it under the
 *  terms of the Cougaar Open Source License as published on the
 *  Cougaar Open Source Website (www.cougaar.org).
 * 
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *  
 * </copyright>
 */
package org.cougaar.lib.vishnu.client;

import org.cougaar.lib.param.ParamMap;
import com.bbn.vishnu.scheduling.Assignment;
import com.bbn.vishnu.scheduling.MultitaskAssignment;
import com.bbn.vishnu.scheduling.Resource;
import com.bbn.vishnu.scheduling.Scheduler;
import com.bbn.vishnu.scheduling.SchedulingData;
import com.bbn.vishnu.scheduling.TimeOps;
import org.cougaar.util.StringKey;
import org.cougaar.util.MutableTimeSpan;
import org.cougaar.util.TimeSpan;
import org.cougaar.util.TimeSpanSet;
import org.cougaar.util.NonOverlappingTimeSpanSet;
import org.cougaar.util.log.Logger;

import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.asset.Asset;

import org.w3c.dom.Document;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

/** 
 * <pre>
 * For Direct mode.  Handles results returned directly from scheduler.
 * 
 * Creates an internal instance of the scheduler and talks to it, instead
 * of to a web server.  Uses direct translation of Cougaar to Vishnu objects,
 * and reads the assignments directly.  <b>No XML involved.</b>
 *
 * Needs the plugin to be a DirectResultListener.  Mainly this means implementing
 * the prepareVishnuObjects method.
 * </pre>
 * @see DirectResultListener#prepareVishnuObjects
 */
public class DirectResultHandler extends PluginHelper implements ResultHandler {

  /** 
   * For every assignment, remember the start time + resource id, which uniquely identifies each assignment
   * This way we can tell if the resource has been used before
   */
  Set knownTimeResourceIDPairs = new HashSet ();

  /** records reference to ResultListener parent */
  public DirectResultHandler (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
			      VishnuDomUtil domUtil, VishnuConfig config, 
			      ParamMap myParamTable, Logger logger) {
    super (parent, comm, xmlProcessor, domUtil, config, 
	   myParamTable, logger);
    resultListener = (ResultListener) parent;
    localSetup ();
  }
	
  /** sets parameter : debugParseAnswer */
  protected void localSetup () {
    super.localSetup ();

    try {debugParseAnswer = 
	   getMyParams().getBooleanParam("debugParseAnswer");}    
    catch(Exception e) {debugParseAnswer = false;}

    try {
      if (getMyParams().hasParam("writeXMLToFile"))    
	writeXMLToFile = 
	  getMyParams().getBooleanParam("writeXMLToFile");    
      else 
	writeXMLToFile = false;
    } catch (Exception e) {}
  }
  
  /** 
   * <pre>
   * Directly handle assignments. 
   *
   * If the assignment is a one-to-one assignment, call parseAssignment directly.
   * parseAssignment will call the resultHandler's handleAssignment.  This typically
   * results in an allocation or expansion.
   *
   * Otherwise if it's a multi-task assignment, calls handleMultiAssignment. This
   * typically results in an aggregation set and an MPTask.
   *
   * Asks the scheduler for which assignment is being done.  
   * Asks the scheduler data for the list of tasks and resources.
   * Uses the time ops object to convert Vishnu time into ALP time.
   *
   * WARNING WARNING WARNING WARNING WARNING WARNING 
   *
   * The multitask flag must be set to grouped if using a VishnuAggregator.
   * If not, things won't work properly here.
   *
   * WARNING WARNING WARNING WARNING WARNING WARNING 
   *
   * </pre>
   * @see com.bbn.vishnu.scheduling.Scheduler#assignmentsMultitask
   * @see com.bbn.vishnu.scheduling.SchedulingData#getTasks
   * @see com.bbn.vishnu.scheduling.SchedulingData#getResources
   * @see ResultListener#handleAssignment
   * @see ResultListener#handleMultiAssignment
   **/
  Map resourcesToTimeSpanSet = new HashMap ();

  public void directlyHandleAssignments (Scheduler sched, SchedulingData data,
					 TimeOps timeOps) {
    Date start = new Date ();

    // This shows how to extract the assignments after scheduling.
    // When sched.assignmentsMultitask() is true, the assignments
    // will actually be MultitaskAssignment objects instead.
    StringBuffer buffer = new StringBuffer();
    if (! sched.assignmentsMultitask()) {
      com.bbn.vishnu.scheduling.Task[] tasks = data.getTasks();

      for (int i = 0; i < tasks.length; i++) {
        boolean hasChanged =
            (!tasks[i].isFrozen() || data.changedSinceCheckpoint(tasks[i]));
        if (!hasChanged)
         continue;

        if (logger.isDebugEnabled()) {
         logger.debug("Task " + tasks[i].getKey() +
            " frozen " + tasks[i].isFrozen() +
            " changed " + data.changedSinceCheckpoint(tasks[i]));
        }

        Assignment assign = tasks[i].getAssignment();

        if (logger.isDebugEnabled())
          logger.debug ("Assign was " + assign);

        if (assign != null) {
          com.bbn.vishnu.scheduling.Task task = assign.getTask();
          Resource resource = assign.getResource();

          if (writeXMLToFile) {
            String assignXML = assign.toString(); // must repair since doesn't include task text
            assignXML = assignXML.replaceFirst ("text=\"\"",
                "text=\"" + sched.getSpecs().taskText(task) + "\"");
            buffer.append (assignXML);
          }

          parseAssignment (task.getKey(),
              resource.getKey(),
              timeOps.timeToDate (assign.getTaskStartTime()),
              timeOps.timeToDate (assign.getTaskEndTime()),
              timeOps.timeToDate (assign.getStartTime()), // setup
              timeOps.timeToDate (assign.getEndTime()), // wrapup
              assign.getContribString(),
              sched.getSpecs().taskText(task));

          /*
          TimeSpanSet timeSpanSet;
          if ((timeSpanSet = (TimeSpanSet) resourcesToTimeSpanSet.get(resource)) == null) {
          timeSpanSet = new NonOverlappingTimeSpanSet ();
          resourcesToTimeSpanSet.put (resource, timeSpanSet);
          }

          MutableTimeSpan timeSpan = new MutableTimeSpan ();
          timeSpan.setTimeSpan (
          timeOps.timeToDate (assign.getTaskStartTime()).getTime(),
          timeOps.timeToDate (assign.getTaskEndTime()).getTime());
          try {
          timeSpanSet.add (timeSpan);
          System.out.println ("Adding task " + task.getKey() + " to resource " + resource.getKey() + " " +
          timeOps.timeToDate (assign.getTaskStartTime()) + "-" +
          timeOps.timeToDate (assign.getTaskEndTime()) + " Performance ");
          } catch (IllegalArgumentException iae) {
          logger.error (getName () + ".directlyHandleAssignments - overlapping time spans for resource " +
          resource.getKey() + "\n\tTime spans were\n" + timeSpanSet +
          "\n\tAnd overlapping new one was\n" +
          new Date(timeSpan.getStartTime()) + "-" + new Date(timeSpan.getEndTime()));
          }

          timeSpan = new MutableTimeSpan ();
          try {
          timeSpan.setTimeSpan (
          timeOps.timeToDate (assign.getStartTime()).getTime(), // setup
          timeOps.timeToDate (assign.getTaskStartTime()).getTime());
          System.out.println ("Adding task " + task.getKey() + " to resource " + resource.getKey() + " " +
          timeOps.timeToDate (assign.getStartTime()) + "-" +
          timeOps.timeToDate (assign.getTaskStartTime()) + " setup ");
          } catch (Exception e) {}
          try {
          timeSpanSet.add (timeSpan);
          } catch (IllegalArgumentException iae) {
          logger.error (getName () + ".directlyHandleAssignments - overlapping time spans for resource " +
          resource.getKey() + "\n\tTime spans were\n" + timeSpanSet +
          "\n\tAnd overlapping new one was\n" +
          new Date(timeSpan.getStartTime()) + "-" + new Date(timeSpan.getEndTime()));
          }

          timeSpan = new MutableTimeSpan ();
          try {
          timeSpan.setTimeSpan (
          timeOps.timeToDate (assign.getTaskEndTime()).getTime(),
          timeOps.timeToDate (assign.getEndTime()).getTime());  // wrapup
          System.out.println ("Adding task " + task.getKey() + " to resource " + resource.getKey() + " " +
          timeOps.timeToDate (assign.getTaskEndTime()) + "-" +
          timeOps.timeToDate (assign.getEndTime()) + " wrapup ");
          } catch (Exception e) {}
          try {
          timeSpanSet.add (timeSpan);
          } catch (IllegalArgumentException iae) {
          logger.error (getName () + ".directlyHandleAssignments - overlapping time spans for resource " +
          resource.getKey() + "\n\tTime spans were\n" + timeSpanSet +
          "\n\tAnd overlapping new one was\n" +
          new Date(timeSpan.getStartTime()) + "-" + new Date(timeSpan.getEndTime()));
          }

          int j=0;
          System.out.println ("resource " + resource.getKey()+ " role schedule now:");

          for (Iterator iter = timeSpanSet.iterator(); iter.hasNext(); ) {
          TimeSpan ts = (TimeSpan) iter.next();
          System.out.println ("#" + (j++) + " " + new Date(ts.getStartTime()) + "-" + new Date(ts.getEndTime()));
          }
          */
        }
        else
          logger.debug (getName () + ".directlyHandleAssignments - no assignment for task " +
              tasks[i].getKey() + "?");
      }
    } else {
      Resource[] resources = data.getResources();

      if (logger.isDebugEnabled())
        logger.debug (getName () + " scanning " + resources.length + " resources.");

      for (int i = 0; i < resources.length; i++) {
        MultitaskAssignment[] multi = resources[i].getMultitaskAssignments();
        if (multi.length == 0) {
          if (logger.isDebugEnabled())
            logger.debug (getName () + " huh? " + resources[i] + " had no assignments?");
        }
        if (multi.length > 0) {
          if (logger.isInfoEnabled())
            logger.info (getName () + " for resource " + resources[i].getKey() +
                " got " + multi.length + " task groups assigned.");

          for (int j = 0; j < multi.length; j++) {
            boolean assetWasUsedBefore = false;
            Vector tasks = new Vector ();
            MultitaskAssignment assign = multi[j];

            if (logger.isInfoEnabled()) {
              logger.info (getName () + " for resource " + resources[i].getKey() +
                  " multi assign #" + j + " had " +multi[j].getTasks().size() + " tasks, start time was " +
                  timeOps.timeToDate(assign.getTaskStartTime()) +  " end " +
                  timeOps.timeToDate (assign.getTaskEndTime())
              );
            }

            String resourceKey = assign.getResource().getKey();
            boolean printedMsg = false;
            for (Iterator iter = multi[j].getTasks().iterator(); iter.hasNext(); ) {
              com.bbn.vishnu.scheduling.Task vishnuTask = (com.bbn.vishnu.scheduling.Task) iter.next();

              boolean hasChanged =
                (!vishnuTask.isFrozen() || data.changedSinceCheckpoint(vishnuTask));
              if (!hasChanged)
                continue;

              Task task = getTaskFromAssignment(vishnuTask.getKey());
              if (task != null) {
                tasks.add (task);
              }
              else { // if this is a task from an earlier batch, then this resource was used before
                if (logger.isInfoEnabled() && !printedMsg) {
                  logger.info (getName() + " - asset " + resourceKey + " was used before at " +
                      timeOps.timeToDate(assign.getTaskStartTime()));
                  printedMsg = true;
                }

                assetWasUsedBefore = true;
              }
            }

            if (!tasks.isEmpty ()) {
              resultListener.handleMultiAssignment (tasks,
                  getAssignedAsset   (resourceKey),
                  timeOps.timeToDate (assign.getTaskStartTime()),
                  timeOps.timeToDate (assign.getTaskEndTime()),
                  timeOps.timeToDate (assign.getStartTime()), // setup
                  timeOps.timeToDate (assign.getEndTime()),// wrapup
                  assetWasUsedBefore);

              /*
              TimeSpanSet timeSpanSet;
              if ((timeSpanSet = (TimeSpanSet) resourcesToTimeSpanSet.get(assign.getResource())) == null) {
              timeSpanSet = new NonOverlappingTimeSpanSet ();
              resourcesToTimeSpanSet.put (assign.getResource(), timeSpanSet);
              }

              MutableTimeSpan timeSpan = new MutableTimeSpan ();
              timeSpan.setTimeSpan (
              timeOps.timeToDate (assign.getTaskStartTime()).getTime(),
              timeOps.timeToDate (assign.getTaskEndTime()).getTime());
              try {
              timeSpanSet.add (timeSpan);
              } catch (IllegalArgumentException iae) {
              logger.error (getName () + ".directlyHandleAssignments - (performance) overlapping time spans for resource " +
              assign.getResource().getKey() +
              "\n\tAnd overlapping new one was\n" +
              new Date(timeSpan.getStartTime()) + "-" + new Date(timeSpan.getEndTime()));
              int k=0;
              logger.error ("resource " + assign.getResource().getKey()+ " role schedule now:");

              java.util.Collection overlapped = timeSpanSet.intersectingSet (timeSpan);

              for (Iterator iter = timeSpanSet.iterator(); iter.hasNext(); ) {
              TimeSpan ts = (TimeSpan) iter.next();
              boolean overlap = overlapped.contains(ts);
              logger.error ("#" + (k++) + " " + new Date(ts.getStartTime()) + "-" + new Date(ts.getEndTime()) + (overlap ? " OVERLAP!" : ""));
              }
              }

              timeSpan = new MutableTimeSpan ();
              try {
              timeSpan.setTimeSpan (
              timeOps.timeToDate (assign.getStartTime()).getTime(), // setup
              timeOps.timeToDate (assign.getTaskStartTime()).getTime());
              } catch (Exception e) {}
              try {
              timeSpanSet.add (timeSpan);
              } catch (IllegalArgumentException iae) {
              logger.error (getName () + ".directlyHandleAssignments - (setup) overlapping time spans for resource " +
              assign.getResource().getKey() +
              "\n\tAnd overlapping new one was\n" +
              new Date(timeSpan.getStartTime()) + "-" + new Date(timeSpan.getEndTime()));
              int k=0;
              logger.error ("resource " + assign.getResource().getKey()+ " role schedule now:");

              java.util.Collection overlapped = timeSpanSet.intersectingSet (timeSpan);

              for (Iterator iter = timeSpanSet.iterator(); iter.hasNext(); ) {
              TimeSpan ts = (TimeSpan) iter.next();
              boolean overlap = overlapped.contains(ts);
              logger.error ("#" + (k++) + " " + new Date(ts.getStartTime()) + "-" + new Date(ts.getEndTime()) + (overlap ? " OVERLAP!" : ""));
              }
              }

              timeSpan = new MutableTimeSpan ();
              try {
              timeSpan.setTimeSpan (
              timeOps.timeToDate (assign.getTaskEndTime()).getTime(),
              timeOps.timeToDate (assign.getEndTime()).getTime());  // wrapup
              } catch (Exception e) {}
              try {
              timeSpanSet.add (timeSpan);
              } catch (IllegalArgumentException iae) {
              logger.error (getName () + ".directlyHandleAssignments - (wrapup) overlapping time spans for resource " +
              assign.getResource().getKey() +
              "\n\tAnd overlapping new one was\n" +
              new Date(timeSpan.getStartTime()) + "-" + new Date(timeSpan.getEndTime()) + "\n\tTime spans were\n");
              int k=0;
              logger.error ("resource " + assign.getResource().getKey()+ " role schedule now:");

              java.util.Collection overlapped = timeSpanSet.intersectingSet (timeSpan);

              for (Iterator iter = timeSpanSet.iterator(); iter.hasNext(); ) {
              TimeSpan ts = (TimeSpan) iter.next();
              boolean overlap = overlapped.contains(ts);
              logger.error ("#" + (k++) + " " + new Date(ts.getStartTime()) + "-" + new Date(ts.getEndTime()) + (overlap ? " OVERLAP!" : ""));
              }
              }
              */
              /*
              int j=0;
              System.out.println ("resource " + resource.getKey()+ " role schedule now:");

              for (Iterator iter = timeSpanSet.iterator(); iter.hasNext(); ) {
              TimeSpan ts = (TimeSpan) iter.next();
              System.out.println ("#" + (j++) + " " + new Date(ts.getStartTime()) + "-" + new Date(ts.getEndTime()));
              }
              */

            }
          }
        }
      }
    }

    if (writeXMLToFile)
      comm.writeBufferToFile ("assignment", buffer.toString());

    if (showTiming)
      domUtil.reportTime (".directlyHandleAssignments - parsed assignments in ", start);
  }


  /** 
   * Called by directlyHandleAssignment when the scheduler is finished for each assignment <p>
   *
   * Calls resultHandler's handleAssignment after calling getTaskFromAssignment and getAssignedAsset
   *
   * @see #directlyHandleAssignments
   * @see #getTaskFromAssignment
   * @see #getAssignedAsset
   * @see VishnuPlugin#handleAssignment
   * @see VishnuAggregatorPlugin#handleAssignment
   * @see VishnuAllocatorPlugin#handleAssignment
   */
  protected void parseAssignment (String task, String resource, Date assignedStart, Date assignedEnd, 
				  Date assignedSetup, Date assignedWrapup, String contribs, String taskText) {
    if (debugParseAnswer)
      logger.debug ("Assignment: "+
			  "\ntask     = " + task +
			  "\nresource = " + resource +
			  "\nsetup    = " + assignedSetup +
			  "\nstart    = " + assignedStart +
			  "\nend      = " + assignedEnd +
			  "\nwrapup   = " + assignedWrapup +
                          "\ncontribs = " + contribs +
                          "\ntask-text = " + taskText);

    Task handledTask    = getTaskFromAssignment (task);
    Asset assignedAsset = getAssignedAsset (resource);

    if (handledTask != null) {
      resultListener.handleAssignment (handledTask, assignedAsset, assignedStart, assignedEnd, assignedSetup, assignedWrapup, contribs, taskText);
    }
    else 
      logger.warn (getName() + ".parseAssignment - handledTask was null?");
  }
  
  /** 
   * Asks resultListener for task corresponding to key <tt>task</tt>.<p>
   *
   * Removes the task from the the list of known tasks kept in the plugin 
   * 
   * @see VishnuPlugin#removeTask
   * @param task key returned from assignment xml
   * @return equivalent ALP task
   */
  protected Task getTaskFromAssignment (String task) {
    StringKey taskKey = new StringKey (task);
    Task handledTask  = resultListener.getTaskForKey (taskKey);
    if (handledTask == null) {
      if (logger.isDebugEnabled())
	logger.debug (getName () + ".getTaskFromAssignment - NOTE - no ALP task found for task key " + taskKey);
      return null;
    }
    else {
      resultListener.removeTask (taskKey);
    }
	
    return handledTask;
  }
  
  /** 
   * Asks resultListener for asset corresponding to key <tt>resource</tt> 
   *
   * @param resource key returned from assignment xml
   * @return equivalent ALP asset
   */
  protected Asset getAssignedAsset (String resource) {
    Asset assignedAsset = resultListener.getAssetForKey (new StringKey (resource));
    if (assignedAsset == null) 
      logger.warn (getName() + ".parseMultiAssignment - ERROR - no asset found with " + resource);
    return assignedAsset;
  }

  protected String getName () { return parent.getName () + "-DirectResultHandler"; }

  protected boolean debugParseAnswer = false;
  ResultListener resultListener;
  /** parameter -- write xml to a file */
  protected boolean writeXMLToFile = false;
}
