package org.cougaar.lib.vishnu.client;

import org.cougaar.lib.param.ParamMap;
import org.cougaar.lib.vishnu.server.Assignment;
import org.cougaar.lib.vishnu.server.MultitaskAssignment;
import org.cougaar.lib.vishnu.server.Resource;
import org.cougaar.lib.vishnu.server.Scheduler;
import org.cougaar.lib.vishnu.server.SchedulingData;
import org.cougaar.lib.vishnu.server.TimeOps;
import org.cougaar.util.StringKey;
import org.cougaar.util.log.Logger;

import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.asset.Asset;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import org.w3c.dom.Document;

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
   * </pre>
   * @see org.cougaar.lib.vishnu.server.Scheduler#assignmentsMultitask
   * @see org.cougaar.lib.vishnu.server.SchedulingData#getTasks
   * @see org.cougaar.lib.vishnu.server.SchedulingData#getResources
   * @see ResultListener#handleAssignment
   * @see ResultListener#handleMultiAssignment
   **/
  public void directlyHandleAssignments (Scheduler sched, SchedulingData data,
					 TimeOps timeOps) {
    Date start = new Date ();

    // This shows how to extract the assignments after scheduling.
    // When sched.assignmentsMultitask() is true, the assignments
    // will actually be MultitaskAssignment objects instead.
    if (! sched.assignmentsMultitask()) {
      org.cougaar.lib.vishnu.server.Task[] tasks = data.getTasks();
      for (int i = 0; i < tasks.length; i++) {
	Assignment assign = tasks[i].getAssignment();
	if (assign != null) {
	  org.cougaar.lib.vishnu.server.Task task = assign.getTask();
	  Resource resource = assign.getResource();
		 
	  parseAssignment (task.getKey(), 
			   resource.getKey(),
			   timeOps.timeToDate (assign.getTaskStartTime()),
			   timeOps.timeToDate (assign.getTaskEndTime()),
			   timeOps.timeToDate (assign.getStartTime()), // setup
			   timeOps.timeToDate (assign.getEndTime()));  // wrapup
	}
	else
	  logger.debug (getName () + ".directlyHandleAssignments - no assignment for task " + 
			      tasks[i].getKey() + "?");
      }
    } else {
      Resource[] resources = data.getResources();
      for (int i = 0; i < resources.length; i++) {
        MultitaskAssignment[] multi = resources[i].getMultitaskAssignments();
	if (multi.length > 0) {
	  if (logger.isDebugEnabled()) 
	    logger.debug (getName () + " for resource " + resources[i].getKey() +
			 " got " + multi.length + " task groups assigned.");
	  boolean assetWasUsedBefore = false;

	  for (int j = 0; j < multi.length; j++) {
	    org.cougaar.lib.vishnu.server.Task [] multiTasks = multi[j].getTasks();
	    Vector tasks = new Vector ();
	    MultitaskAssignment assign = multi[j];
			
	    for (int k = 0; k < multiTasks.length; k++) {
	      Task task = getTaskFromAssignment(multiTasks[k].getKey());
	      if (task != null) 
		tasks.add (task);
	      else // if this is a task from an earlier batch, then this resource was used before
		assetWasUsedBefore = true;
	    }

	    if (!tasks.isEmpty ()) {
	      resultListener.handleMultiAssignment (tasks, 
						    getAssignedAsset   (assign.getResource().getKey()),
						    timeOps.timeToDate (assign.getTaskStartTime()),
						    timeOps.timeToDate (assign.getTaskEndTime()),
						    timeOps.timeToDate (assign.getStartTime()), // setup
						    timeOps.timeToDate (assign.getEndTime()),// wrapup
						    assetWasUsedBefore);  
	    }
	  }
	}
      }
    } 

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
				  Date assignedSetup, Date assignedWrapup) {
    if (debugParseAnswer)
      logger.debug ("Assignment: "+
			  "\ntask     = " + task +
			  "\nresource = " + resource +
			  "\nsetup    = " + assignedSetup +
			  "\nstart    = " + assignedStart +
			  "\nend      = " + assignedEnd +
			  "\nwrapup   = " + assignedWrapup);

    Task handledTask    = getTaskFromAssignment (task);
    Asset assignedAsset = getAssignedAsset (resource);

    if (handledTask != null)
      resultListener.handleAssignment (handledTask, assignedAsset, assignedStart, assignedEnd, assignedSetup, assignedWrapup);
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
      logger.debug (getName() + ".parseMultiAssignment - ERROR - no asset found with " + resource);
    return assignedAsset;
  }

  protected String getName () { return parent.getName () + "-DirectResultHandler"; }

  protected boolean debugParseAnswer = false;
  ResultListener resultListener;
}
