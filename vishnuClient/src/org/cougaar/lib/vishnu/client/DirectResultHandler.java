package org.cougaar.lib.vishnu.client;

import org.cougaar.lib.param.ParamMap;
import org.cougaar.lib.vishnu.server.Assignment;
import org.cougaar.lib.vishnu.server.MultitaskAssignment;
import org.cougaar.lib.vishnu.server.Resource;
import org.cougaar.lib.vishnu.server.Scheduler;
import org.cougaar.lib.vishnu.server.SchedulingData;
import org.cougaar.lib.vishnu.server.TimeOps;
import org.cougaar.util.StringKey;

import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.asset.Asset;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import org.w3c.dom.Document;

/** 
 * Direct mode.  
 * <p>
 * Creates an internal instance of the scheduler and talks to it, instead
 * of to a web server.  Uses direct translation of Cougaar to Vishnu objects,
 * and reads the assignments directly.  <b>No XML involved.</b>
 *
 * Needs the plugin to be a DirectResultListener.  Mainly this means implementing
 * the prepareVishnuObjects method.
 * @see DirectResultListener
 */
public class DirectResultHandler extends PlugInHelper implements ResultHandler {
  public DirectResultHandler (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
			      VishnuDomUtil domUtil, VishnuConfig config, 
			      ParamMap myParamTable) {
    super (parent, comm, xmlProcessor, domUtil, config, 
	   myParamTable);
    resultListener = (ResultListener) parent;
    localSetup ();
  }
	
  protected void localSetup () {
    super.localSetup ();

    try {debugParseAnswer = 
	   getMyParams().getBooleanParam("debugParseAnswer");}    
    catch(Exception e) {debugParseAnswer = false;}
  }
  
  /** directly handle assignments */
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
	  System.out.println (getName () + ".directlyHandleAssignments - no assignment for task " + 
			      tasks[i].getKey() + "?");
      }
    } else {
      Resource[] resources = data.getResources();
      for (int i = 0; i < resources.length; i++) {
        MultitaskAssignment[] multi = resources[i].getMultitaskAssignments();
	if (multi.length > 0) {
	  if (myExtraOutput) 
	    System.out.println (getName () + " for resource " + resources[i].getKey() +
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


  /** called by runDirectly when the scheduler is finished for each assignment */
  protected void parseAssignment (String task, String resource, Date assignedStart, Date assignedEnd, 
				  Date assignedSetup, Date assignedWrapup) {
    if (debugParseAnswer)
      System.out.println ("Assignment: "+
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
   * Removes the task from the the list of known tasks kept in the plugin 
   * 
   * @see VishnuPlugIn#removeTask
   */
  protected Task getTaskFromAssignment (String task) {
    StringKey taskKey = new StringKey (task);
    Task handledTask  = resultListener.getTaskForKey (taskKey);
    if (handledTask == null) {
      if (myExtraOutput)
	System.err.println (getName () + ".getTaskFromAssignment - NOTE - no ALP task found for task key " + taskKey);
      return null;
    }
    else {
      resultListener.removeTask (taskKey);
    }
	
    return handledTask;
  }
  
  protected Asset getAssignedAsset (String resource) {
    Asset assignedAsset = resultListener.getAssetForKey (new StringKey (resource));
    if (assignedAsset == null) 
      System.out.println (getName() + ".parseMultiAssignment - ERROR - no asset found with " + resource);
    return assignedAsset;
  }

  protected String getName () { return parent.getName () + "-DirectResultHandler"; }

  protected boolean debugParseAnswer = false;
  ResultListener resultListener;
}
