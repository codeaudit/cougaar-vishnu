package org.cougaar.lib.vishnu.client;

import org.cougaar.lib.param.ParamMap;
import org.cougaar.lib.vishnu.server.Assignment;
import org.cougaar.lib.vishnu.server.MultitaskAssignment;
import org.cougaar.lib.vishnu.server.Resource;
import org.cougaar.lib.vishnu.server.Scheduler;
import org.cougaar.lib.vishnu.server.SchedulingData;
import org.cougaar.lib.vishnu.server.TimeOps;
import org.cougaar.util.StringKey;

import org.cougaar.domain.planning.ldm.plan.Task;
import org.cougaar.domain.planning.ldm.asset.Asset;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import org.w3c.dom.Document;

public class DirectMode extends InternalMode {
  public DirectMode (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
					 VishnuDomUtil domUtil, VishnuConfig config, 
					 ParamMap myParamTable) {
	super (parent, comm, xmlProcessor, domUtil, config, 
		   null /*direct mode doesn't need a result handler */, 
		   myParamTable);
	resultListener = (DirectResultListener) parent;
	localSetup ();
  }
	
  protected void localSetup () {
	super.localSetup ();

	try {debugParseAnswer = 
		   getMyParams().getBooleanParam("debugParseAnswer");}    
	catch(Exception e) {debugParseAnswer = false;}
  }
  
  public void prepareData (List stuffToSend, Document objectFormatDoc) {
	vishnuTasks     = new ArrayList ();
	vishnuResources = new ArrayList ();
	changedVishnuResources = new ArrayList ();

	Date start = new Date ();
	   
	resultListener.prepareVishnuObjects (stuffToSend, resultListener.getChangedAssets(), 
										 vishnuTasks, vishnuResources, changedVishnuResources,
										 objectFormatDoc, sched.getTimeOps());
	parent.clearChangedAssets ();

	if (myExtraOutput)
	  System.out.println (getName () + ".prepareData - clearing changed assets!");
	   
	if (showTiming)
	  domUtil.reportTime (".prepareData - prepared vishnu objects in ", start);
	   
	// think it's OK to send this more than once
	comm.serializeAndPostData (xmlProcessor.getVanillaHeader ());

	sendOtherData ();
  }

  /**
   * Run directly.  Give Vishnu tasks and resources to scheduler and get assignments
   * back, <i>without</i> using XML. <p>
   *
   * Uses <tt>internalBuffer</tt> to send the specs, the object format and other data.<br>
   * Adds the task and resources (<tt>addTasksDirectly</tt>), and then runs the scheduler
   * (<tt>Scheduler.scheduleInternal</tt>).  Reads the assignments with 
   * <tt>directlyHandleAssignments</tt>.  Any tasks not handled = any which are left in the
   * <tt>myTaskUIDtoObject</tt> map get sent to <tt>handleImpossibleTasks</tt>.<p>
   *
   * <tt>vishnuTasks</tt> and <tt>vishnuResources</tt> are created in prepareData and populated
   * in #prepareVishnuObjects. <p>
   *
   * @see #addTasksDirectly
   * @see #prepareData
   * @see #prepareVishnuObjects
   * @see org.cougaar.lib.vishnu.server.Scheduler#scheduleInternal
   */
  public void run () {
	Date start = new Date ();

	int unhandledTasks = prepareScheduler ();
	 
	// These are things created by the scheduler during setup that
	// are needed for direct object writing.
	TimeOps timeOps = sched.getTimeOps();
	SchedulingData data = sched.getSchedulingData();

	// add tasks and resources to data
	// vishnuTasks & Resources created in prepareData and set in prepareVishnuObjects
	addTasksDirectly (data, vishnuTasks, vishnuResources, changedVishnuResources);

	 // Call scheduleInternal after adding all the data
	Date start2 = new Date ();

	try {
	  sched.scheduleInternal();

	  if (showTiming)
		domUtil.reportTime (".runDirectly - scheduler processed " +
							parent.getNumTasks () + " tasks in ", start2);

	  // get the assignments the scheduler made, make plan elements
	  directlyHandleAssignments (sched, data, timeOps);
	} catch (Exception e) {
	  System.out.println (getName () + ".runDirectly - Got error running scheduler : " + e.getMessage ());
      e.printStackTrace ();
	} finally {
	  cleanUpAfterScheduling (unhandledTasks);
	}
  }
  protected void addTasksDirectly (SchedulingData data, List vishnuTasks, List vishnuResources,
								   List changedVishnuResources) {
	Date start = new Date ();

	if (myExtraOutput || true) 
	  System.out.println(getName () + ".runDirectly - adding " + 
						 vishnuTasks.size() + " tasks, " +
						 vishnuResources.size () + " resources, " +
						 changedVishnuResources.size () + " changed resources to scheduler data.");

	for (int i = 0; i < vishnuTasks.size (); i++) {
	  Object vishnuObject = vishnuTasks.get(i);
	  data.addTask ((org.cougaar.lib.vishnu.server.Task) vishnuObject);
	}
	for (int i = 0; i < vishnuResources.size (); i++) {
	  Object vishnuObject = vishnuResources.get(i);
	  data.addResource ((Resource) vishnuObject);
	}
	for (int i = 0; i < changedVishnuResources.size (); i++) {
	  Object vishnuObject = changedVishnuResources.get(i);
	  data.replaceResource ((Resource) vishnuObject);
	}
	if (myExtraExtraOutput)
	  for (int i = 0; i < data.getResources ().length; i++) {
		System.out.println (getName () + ".addTasksDirectly - Known Resource #" + i + 
							" : \n" + data.getResources()[i]);
	  }
  }

   protected void directlyHandleAssignments (Scheduler sched, SchedulingData data,
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
		  
		  for (int j = 0; j < multi.length; j++) {
			org.cougaar.lib.vishnu.server.Task [] multiTasks = multi[j].getTasks();
			Vector tasks = new Vector ();
			MultitaskAssignment assign = multi[j];
			
			for (int k = 0; k < multiTasks.length; k++) {
			  Task task = getTaskFromAssignment(multiTasks[k].getKey());
			  if (task != null)
				tasks.add (task);
			}

			if (!tasks.isEmpty ()) {
			  resultListener.handleMultiAssignment (tasks, 
											getAssignedAsset   (assign.getResource().getKey()),
											timeOps.timeToDate (assign.getTaskStartTime()),
											timeOps.timeToDate (assign.getTaskEndTime()),
											timeOps.timeToDate (assign.getStartTime()), // setup
											timeOps.timeToDate (assign.getEndTime()));  // wrapup
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

  protected String getName () { return "DirectMode"; }

  protected List vishnuTasks, vishnuResources, changedVishnuResources;
  protected boolean debugParseAnswer = false;
  DirectResultListener resultListener;
}
