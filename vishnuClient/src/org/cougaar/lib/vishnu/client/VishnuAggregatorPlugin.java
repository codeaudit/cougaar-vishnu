/*
 * <copyright>
 *  Copyright 2001-2003 BBNT Solutions, LLC
 *  under sponsorship of the Defense Advanced Research Projects Agency (DARPA).
 * 
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the Cougaar Open Source License as published by
 *  DARPA on the Cougaar Open Source Website (www.cougaar.org).
 * 
 *  THE COUGAAR SOFTWARE AND ANY DERIVATIVE SUPPLIED BY LICENSOR IS
 *  PROVIDED 'AS IS' WITHOUT WARRANTIES OF ANY KIND, WHETHER EXPRESS OR
 *  IMPLIED, INCLUDING (BUT NOT LIMITED TO) ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND WITHOUT
 *  ANY WARRANTIES AS TO NON-INFRINGEMENT.  IN NO EVENT SHALL COPYRIGHT
 *  HOLDER BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT OR CONSEQUENTIAL
 *  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE OF DATA OR PROFITS,
 *  TORTIOUS CONDUCT, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *  PERFORMANCE OF THE COUGAAR SOFTWARE.
 * </copyright>
 */
package org.cougaar.lib.vishnu.client;

import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.asset.AssetGroup;

import org.cougaar.planning.ldm.plan.Aggregation;
import org.cougaar.planning.ldm.plan.AllocationResult;
import org.cougaar.planning.ldm.plan.AspectScorePoint;
import org.cougaar.planning.ldm.plan.AspectType;
import org.cougaar.planning.ldm.plan.AspectValue;
import org.cougaar.planning.ldm.plan.Composition;
import org.cougaar.planning.ldm.plan.Expansion;
import org.cougaar.planning.ldm.plan.MPTask;
import org.cougaar.planning.ldm.plan.NewMPTask;
import org.cougaar.planning.ldm.plan.NewComposition;
import org.cougaar.planning.ldm.plan.PlanElement;
import org.cougaar.planning.ldm.plan.PrepositionalPhrase;
import org.cougaar.planning.ldm.plan.Preference;
import org.cougaar.planning.ldm.plan.ScoringFunction;
import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.plan.NewTask;
import org.cougaar.planning.ldm.plan.Verb;
import org.cougaar.planning.ldm.plan.Workflow;
import org.cougaar.planning.ldm.plan.Workflow;

import org.cougaar.glm.ldm.Constants;

import org.cougaar.lib.callback.UTILAggregationCallback;
import org.cougaar.lib.callback.UTILFilterCallback;
import org.cougaar.lib.callback.UTILGenericListener;
import org.cougaar.lib.callback.UTILWorkflowCallback;
import org.cougaar.lib.callback.UTILExpansionCallback;
import org.cougaar.lib.callback.UTILExpansionListener;

import org.cougaar.lib.filter.UTILAggregatorPlugin;

import org.cougaar.lib.util.UTILPluginException;
import org.cougaar.lib.util.UTILRuntimeException;

import java.net.URL;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.xml.sax.Attributes;

import org.cougaar.util.StringKey;
import org.cougaar.util.UnaryPredicate;
import org.cougaar.core.util.UID;

/**
 * Aggregator version of ALP-Vishnu Bridge.
 *                                                                          <p>
 * The key thing to note is that the asset in the task->asset               <br> 
 * association is on the WITH preposition of the generated MPTask.
 *                                                                          <p>
 * This is critical, because the allocator downstream will look for this    <br>
 * prep and pluck the asset off to make the allocation.                      
 *                                                                          <p>
 * Uses the assigned start and end times to set the preferences and         <br>
 * allocation results.
 *                                                                          <p>
 * Adjust preferences so that the start time preference is the assigned     <br>
 * start time, and the end time preference has a best date that is the      <br>
 * assigned end time.  The early and late dates of the end time preference  <br>
 * are the same as the first parent task. (This isn't very important, as the<br>
 * downstream allocator should just allocate to the start and best times.)
 *                                                                          <p>
 * Many times subclasses will want to redefine                              <br>
 * <code>interestingTask</code> and <code>interestingAsset</code> to filter <br>
 * what goes to the Vishnu scheduler.  If you do, it's good form to call    <br>
 * super.interestingTask().
 *                                                                          <p>
 * @see org.cougaar.lib.vishnu.client.VishnuPlugin#interestingAsset
 * <!--
 * (When printed, any longer line will wrap...)
 *345678901234567890123456789012345678901234567890123456789012345678901234567890
 *       1         2         3         4         5         6         7         8
 * -->
 */
public class VishnuAggregatorPlugin extends VishnuPlugin implements UTILAggregatorPlugin, UTILExpansionListener {
  // see explanation below for bug #11866
  protected Map tripletToTask = new HashMap ();
  // avoids blackboard query
  protected Map taskToMPTask  = new HashMap ();

  boolean propagateRescindPastAggregation;

  /** creates an XMLResultHandler specially for this plugin */
  protected XMLResultHandler createXMLResultHandler () {
    return new AggregateXMLResultHandler (this, comm, xmlProcessor, domUtil, config, getMyParams (), logger);
  }

  public void localSetup() {     
    super.localSetup();

    try {
      if (getMyParams().hasParam("propagateRescindPastAggregation"))    
	propagateRescindPastAggregation = getMyParams().getBooleanParam("propagateRescindPastAggregation");
      else
	propagateRescindPastAggregation = true;
    } catch(Exception e) {}
  }

  /** adds the aggregation filter */
  public void setupFilters () {
    super.setupFilters ();

    if (isInfoEnabled())
      info (getName () + " : Filtering for Aggregations...");

    addFilter (myAggCallback    = createAggCallback    ());

    if (isInfoEnabled())
      info (getName () + " : Filtering for Expansions...");

    addFilter (new UTILExpansionCallback (this, logger));
  }


  /*** Callback for input tasks ***/
  protected UTILWorkflowCallback   myWorkflowCallback;
  /** 
   * Callback for input tasks 
   *
   * Creates an instance of the WorkflowCallback, which means the plugin
   * is looking for tasks that are part of workflows.
   *
   * @param bufferingThread -- the thread the callback informs when there are new input tasks
   * @return UTILFilterCallback -- an instance of UTILWorkflowCallback
   **/
  protected UTILFilterCallback createThreadCallback (UTILGenericListener bufferingThread) { 
    if (isInfoEnabled())
      info (getName () + " Filtering for tasks with Workflows...");

    myWorkflowCallback = new UTILWorkflowCallback  (bufferingThread, logger); 

    return myWorkflowCallback;
  } 
  /** Callback for input tasks ***/
  protected UTILFilterCallback getWorkflowCallback () {
    return myWorkflowCallback;
  }
  
  /*** Callback for Aggregations ***/
  /** Callback for Aggregations **/
  protected UTILAggregationCallback   myAggCallback;
  /** Callback for Aggregations **/
  protected UTILAggregationCallback getAggCallback    () { return myAggCallback; }
  /** Callback for Aggregations **/
  protected UTILAggregationCallback createAggCallback () { 
    return new UTILAggregationCallback  (this, logger); 
  } 


  /*** Stuff for AggregationListener ***/

  /**
   * Should almost always call interestingTask. 
   **/
  public boolean interestingParentTask (Task t) { 
    boolean isInteresting = interestingTask(t); 

    if (!isInteresting && 
	((t.getPlanElement().getReportedResult() != null) && 
	 !t.getPlanElement().getReportedResult().isSuccess ())) {
      debug (getName () + ".interestingParentTask - ignoring failed task : " + t.getUID ());
    }
	
    return isInteresting;
  }

  /** implemented for AggregationListener */
  public boolean needToRescind (Aggregation agg) { return false; }
  /** implemented for AggregationListener */
  public void reportChangedAggregation(Aggregation agg) { updateAllocationResult (agg); }
  /** implemented for AggregationListener */
  public void handleSuccessfulAggregation(Aggregation agg) {
    if (agg.getEstimatedResult().getConfidenceRating() > allocHelper.MEDIUM_CONFIDENCE) {
      // don't do anything
    } else if (isDebugEnabled()) {
      debug (getName () + 
			  ".handleSuccessfulAggregation : got changed agg (" + 
			  agg.getUID () + 
			  ") with intermediate confidence."); 
    }
  }

  /** implemented for AggregationListener */
  public void handleRemovedAggregation (Aggregation agg) {	
    // debug("VishnuAggregatorPlugin.handleRemovedAggregation called");

    Vector removedTasks = new Vector();
    removedTasks.add(agg.getTask());

    handleRemovedTasks(removedTasks.elements());
  }

  /** implemented for AggregationListener */
  public boolean handleRescindedAggregation(Aggregation agg) { return false; }

  /** implemented for AggregationListener */
  public void publishRemovalOfAggregation (Aggregation aggToRemove) {
    Task changedTask = aggToRemove.getTask ();
    publishRemove (aggToRemove);
    publishChange (changedTask);
  }
  
  /** 
   * Implemented for ExpansionListener 
   *
   * Interested in expansions created by this plugin, labeled with a VISHNU prep.
   * (That's how it knows which to be interested in.)
   */
  public boolean interestingExpandedTask(Task t) { 
    Expansion exp = (Expansion) t.getPlanElement();
    if (exp == null)
      return false;
	
    Workflow wf = exp.getWorkflow();
	
    Enumeration enum = wf.getTasks();
	
    Object firstTask = null;
	
    if (enum.hasMoreElements ())
      firstTask = enum.nextElement();
    if (firstTask != null)
      return prepHelper.hasPrepNamed ((Task)firstTask, "VISHNU"); 
    else
      return false;
  }

  public boolean wantToChangeExpansion(Expansion exp) { return false; }
  public void changeExpansion(Expansion exp) {}
  public void publishChangedExpansion(Expansion exp) { publishChange (exp); }

  public void handleConstraintViolation(Expansion exp, List violatedConstraints) {}
  public void handleFailedExpansion(Expansion exp, List failedSubTasks) { reportChangedExpansion (exp); }
  public void handleSuccessfulExpansion(Expansion exp, List successfulSubtasks) {}
  
  /**
   * Implemented for ExpansionListener
   * Report to superior that the expansion has changed. Usually just a pass
   * through to the UTILPluginAdapter's updateAllocationResult.
   *
   * @param exp Expansion that has changed.
   * @see org.cougaar.lib.callback.UTILExpansionListener
   */
  public void reportChangedExpansion(Expansion exp) { 
    if (logger.isDebugEnabled() || 
	(exp.getReportedResult () != null && !exp.getReportedResult().isSuccess ()))
      debug (getName () + 
			  ".reportChangedExpansion : reporting " + 
			  (exp.getReportedResult().isSuccess () ? "" : " - FAILED - ") +
			  " changed expansion " + exp.getUID () + 
			  " of " + exp.getTask().getUID() + " to superior.");
      
    updateAllocationResult (exp); 
  }

  public void handleIllFormedTask (Task t) { reportIllFormedTask(t); }

  /** 
   * define in subclass -- create an aggregation
   *
   * The parameters are what got returned from the vishnu scheduler.
   *
   * @param tasks  tasks to be aggregated together and assigned to asset
   * @param asset asset handling task
   * @param start of main task
   * @param end   of main task
   * @param setupStart start of setup task
   * @param wrapupEnd end of wrapup task
   */
  public void handleMultiAssignment (Vector tasks, Asset asset, 
				     Date start, Date end, Date setupStart, Date wrapupEnd, boolean assetWasUsedBefore) {
    if (isDebugEnabled()) {
      debug (getName() + ".handleMultiAssignment : ");
      debug ("\nAssigned tasks : ");
      for (int i = 0; i < tasks.size (); i++) {
	Task task = (Task) tasks.get(i);

	Date ready = prefHelper.getReadyAt   (task);
	Date early = prefHelper.getEarlyDate (task);
	Date late  = prefHelper.getLateDate  (task);

	if (start.before(ready) ||
	    end.before  (early) ||
	    end.after   (late))
	  warn ("" + task.getUID() +
		" - ready " + ready + (start.before(ready) ? (" AFTER start " + start) : "") +
		" early " + early   + (end.before(early) ? (" AFTER end " + end) : "") +
		" best " + prefHelper.getBestDate (task) + 
		" late " + late     + (end.after(late) ? (" BEFORE end " + end) : ""));
	else
	  debug ("" + task.getUID() +
		 " - ready " + ready + (start.before(ready) ? (" AFTER start " + start) : "") +
		 " early " + early   + (end.before(early) ? (" AFTER end " + end) : "") +
		 " best " + prefHelper.getBestDate (task) + 
		 " late " + late     + (end.after(late) ? (" BEFORE end " + end) : ""));
      }
      debug ("\nresource = " + asset +
	     "\nsetup    = " + setupStart +
	     "\nstart    = " + start +
	     "\nend      = " + end +
	     "\nwrapup   = " + wrapupEnd);
    }
  
    makePlanElement (tasks, asset, start, end, setupStart, wrapupEnd, assetWasUsedBefore);
  }
  
  /**
   * <pre>
   * Background : the missions for a conveyance (ship, plane, truck)
   * are represented by MPTasks which assign an asset group of items
   * to a conveyance for a certain period of time.  We want to prevent
   * the case where multiple MPTasks together represent one actual
   * mission, i.e. they are for the same conveyance and the same period 
   * of time.  It's better for memory footprint, simplicity, and the
   * asset usage display in the TPFDD Viewer.
   * See bug #11866 : https://bugs.ultralog.net/show_bug.cgi?id=11866
   *
   * Makes an aggregation given a list of assignments.
   * 
   * Makes an aggregation with a medium confidence and publishes it.  
   * Also makes an expansion of the MPTask.  This may be a 1-to-1,
   * 1-to-2, or 1-to-3 expansion depending on the dates.  If the
   * setup start is before the task start, then a separate setup task
   * is created and added to the expansion.  Similarly for wrapup.
   * These dates are different if the vishnu scheduling specs define
   * setup (e.g. fueling an airplane) or wrapup (e.g. servicing an airplane)
   * durations.  See referenced Vishnu documentation for details on specs.
   *
   * Calls the base class function makeSetupWrapupExpansion.
   * 
   * Adds to a previously created MPTask when new tasks are assigned to an
   * asset.
   *
   * </pre>
   * @param taskList - tasks for this asset
   * @param anAsset that these tasks are grouped for
   * @param start time start
   * @param end time end
   * @param setupStart setup start
   * @param wrapupEnd wrapup end
   * @see org.cougaar.planning.ldm.plan.Aggregation
   * @see org.cougaar.planning.ldm.plan.MPTask
   * @see org.cougaar.lib.vishnu.client.VishnuPlugin#makeSetupWrapupExpansion
   * @see <a href="http://www.cougaar.org/projects/vishnu/fulldoc.html#specs">
   * Click here for more on setup and wrapup specifications.</a>
   * @see #addToPrevious
   */
  public void makePlanElement (Vector tasklist, Asset anAsset, Date start, Date end, Date setupStart, Date wrapupEnd,
			       boolean assetWasUsedBefore) {
    if (assetWasUsedBefore) {
      if (addToPrevious (tasklist, anAsset, start, end, setupStart, wrapupEnd))
	return;
      else {
	warn ("Though we believe " + anAsset + " was used before at " + start + 
	      " we could not find the previous task, so making a new one.");
      }
    }

    List aggResults = aggregateHelper.makeAggregation(this,
						      ldmf,
						realityPlan,
						tasklist,
						getVerbForAgg(tasklist),
						getPrepPhrasesForAgg(anAsset, tasklist),
						getDirectObjectsForAgg(tasklist),
						getPreferencesForAgg(anAsset, tasklist, start, end),
						getAgentIdentifier(),
						getAspectValuesMap(tasklist, start, end),
						allocHelper.MEDIUM_CONFIDENCE);
    publishList(aggResults);
      
    cleanupAggregation(anAsset, tasklist, aggResults);

    Task mpTask = findMPTask (aggResults);

    // store each distinct assignment so we can get it later in addToPrevious
    //
    // Bug #11866:
    //
    // The problem (https://bugs.ultralog.net/show_bug.cgi?id=11866) is that
    // addToPrevious initially looks on the role schedule for mptasks assigned to an asset.  
    // BUT the allocator plugin has to get a chance to run to update the role schedule.  So
    // it may seem like no previous task has been assigned, if you just look at the role schedule,
    // even though the assignment has been made (an MPTask created) but not yet reflected in
    // the role schedule via an allocation.  This results in multiple MPTasks being made for the same
    // mission - the same conveyance and for the same period of time.  
    //
    // We need to remember the assignment locally through a map to avoid this problem.

    if (assetWasUsedBefore) {
      warn ("asset was used before, but made a new mptask : " + mpTask.getUID());
    }

    Collection subtasks = makeSetupWrapupExpansion (mpTask, anAsset, start, end, setupStart, wrapupEnd);

    for (Iterator iter = subtasks.iterator(); iter.hasNext(); ) {
      Task subtask = (Task) iter.next();
      String taskKey = anAsset.getUID().toString() + "-" + prefHelper.getReadyAt(subtask).getTime() + "-" + 
	prefHelper.getBestDate(subtask).getTime();

      if (tripletToTask.get (taskKey) == null) {
	tripletToTask.put (taskKey, subtask);
	if (isInfoEnabled ()) {
	  info (getName ()+ " mapping " + taskKey + " to " + subtask.getUID());
	}
	taskToMPTask.put  (subtask, mpTask);
      }
      else {
	warn (getName () + " - unexpected : there already is a task in table with key " +taskKey);
      }
    }
  }

  /**
   * Fixes up the following when additional tasks are added to a previous
   * assignment:
   *  1) Adds to the d.o. of the transport task allocated to the asset
   *  2) (Optional) If setup task,  adds to the d.o. of the task
   *  3) (Optional) If wrapup task, adds to the d.o. of the task
   *  4) Adds to the d.o. of the mp task
   *  5) Makes Mp task parent task list reflect new parent tasks
   *  6) Makes aggregations connecting parent tasks to mp task
   *
   * @param taskList - tasks for this asset
   * @param anAsset that these tasks are grouped for/assigned to
   * @param start time start
   * @param end time end
   * @param setupStart setup start
   * @param wrapupEnd wrapup end
   */
  public boolean addToPrevious (Vector tasklist, Asset anAsset, Date start, Date end, Date setupStart, Date wrapupEnd) {
    // see explanation for bug #11866 above
    Task previousTask;
    String taskKey = anAsset.getUID().toString() + "-" + start.getTime() + "-" + end.getTime();
    previousTask = (Task) tripletToTask.get (taskKey);

    if (previousTask == null) {
      if (isInfoEnabled ()) {
	info (getName() + " - couldn't find task with key " + taskKey + 
	      " so looking in role schedule of " + anAsset.getUID());
      }
      previousTask = getEncapsulatedTask (anAsset, start, end); // look on asset's role schedule
      if (previousTask != null)
	tripletToTask.put (taskKey, previousTask);
    }

    if (previousTask != null) { // found transport task
      if (isDebugEnabled()) 
	debug (getName () + ".addToPrevious - found previous task for asset " + 
			    anAsset.getUID());

      Vector directObjects = getDirectObjectsForAgg(tasklist); 
      // step 1 - add to d.o. of transport task
      Asset directObject = addToDirectObject (previousTask, directObjects);
      if (makeSetupAndWrapupTasks) {
	if (setupStart.getTime() < start.getTime()) {
	  // step 2 - add to d.o. of setup
	  addToPreviousSetupWrapup (anAsset, directObject, setupStart, start, "setup");
	}
	if (wrapupEnd.getTime() > end.getTime()) {
	  // step 3 - add to d.o. of wrapup
	  addToPreviousSetupWrapup (anAsset, directObject, end, wrapupEnd, "wrapup");
	}
      }
      MPTask mpTask = (MPTask) taskToMPTask.get (previousTask);
      if (mpTask == null) { // should only happen after rehydration
	if (isInfoEnabled ()) {
	  info (getName() + " - looking for mptask parent of " + previousTask.getUID()+ " on blackboard via expensive query.");
	}
	// do expensive blackboard query
	mpTask = getMPTask (previousTask.getParentTaskUID ());
	taskToMPTask.put (previousTask, mpTask); // remember for next time 
      }

      if (mpTask == null) {
	if (isInfoEnabled ()) {
	  info ("Can't find mptask " + previousTask.getParentTaskUID () + 
		" parent of " + previousTask.getUID() + " on blackboard. Must have been removed.");
	}

	return false; // the MP task was removed from the blackboard while scheduler was running
      }

      // step 4 - add to d.o. of MPTask parent
      ((NewMPTask) mpTask).setDirectObject (directObject);

      // step 5 - Make MP Task know of new parents
      Enumeration parents = mpTask.getParentTasks ();
      Vector parentsVector = enumToVector (parents);
      ((NewMPTask)mpTask).setParentTasks (getEnumWithNewParents (parentsVector, tasklist));
      if (isInfoEnabled ()) {
	info (getName() + " - publish changing " + mpTask.getUID());
      }
      publishChange (mpTask);

      // step 6 - make aggregations for connecting parent tasks to MPTask
      NewComposition comp = (NewComposition) mpTask.getComposition ();
      addAggregations (comp, tasklist, start, end);
      publishChange (comp);
      
      return true;
    }
    return false;
  }

  /** 
   * Update the directObject of the setup and wrapup tasks when we get new assignments
   * to an existing mission.  publishChanges the task.
   * 
   * We need a triplet - the assigned asset and the start and end dates to unique identify
   * a setup or wrapup task.  These come from the anAsset, start, and end parameters.
   *
   * First looks in the tripletToTask map, and if can't find the task there, looks at the 
   * asset's role schedule, which is problematic (the allocator must have run), see above
   * discussion.  The only time the tripletToTask map will be empty will be after rehydration.
   */
  protected void addToPreviousSetupWrapup (Asset anAsset, Asset directObject, Date start, Date end, String info) {
    Task setupTask;
    String taskKey = anAsset.getUID().toString() + "-" + start.getTime() + "-" + end.getTime();
    if (isInfoEnabled ()) {
      info (getName() + " - " + info + " - checking tripletToTask map for " + taskKey);
    }
    setupTask = (Task) tripletToTask.get (taskKey);

    if (setupTask == null) {
      if (isInfoEnabled ()) {
	info (getName() + " - setup - nothing in tripletToTask map for " + taskKey + 
	      " so checking role schedule.");
      }
      setupTask = getEncapsulatedTask (anAsset, start, end);
      if (setupTask != null)
	tripletToTask.put (taskKey, setupTask);
    }

    if (setupTask == null) { // shouldn't happen
      warn (getAgentIdentifier () + " - " + 
	    " on " + anAsset + 
	    " missing a "+ info + 
	    " task from " + start + 
	    " to " + end + "?");
    }
    else {
      ((NewTask) setupTask).setDirectObject (directObject);
      if (isInfoEnabled ()) {
	info (getName() + " - publish changing " + setupTask.getUID());
      }
      publishChange (setupTask);
    }
  }

  /** 
   * look for a plan element that covers exactly the same span of time 
   */
  protected Task getEncapsulatedTask (Asset asset, Date start, Date end) {
    Collection tasks = asset.getRoleSchedule().getEncapsulatedRoleSchedule (start.getTime(), 
									    end.getTime());
    if (tasks.isEmpty ()) {
      if (isInfoEnabled ()) {
	info ("no task on role schedule of " + asset.getUID () + " - " + 
	      asset + " between " + start + " and " + end + 
	      "\nschedule was " + asset.getRoleSchedule());
      }
      return null;
    }
    for (Iterator iter=tasks.iterator (); iter.hasNext (); ) {
      PlanElement pe = (PlanElement) iter.next ();
      long startTime = 
	(long) pe.getEstimatedResult ().getValue(AspectType.START_TIME);
      long endTime = 
	(long) pe.getEstimatedResult ().getValue(AspectType.END_TIME);
      if (startTime == start.getTime () &&
	    endTime == end.getTime ()) {
	return pe.getTask ();
      } 
      else {
	if (isInfoEnabled ()) {
	  if (startTime == start.getTime ()) {
	    info (asset.getUID() + " - end times are different, pe end "+ new Date(endTime) + 
		  " vs assigned " + new Date (end.getTime()) + " for " +asset);
	  }
	  else if (endTime == end.getTime ()) {
	    info (asset.getUID() + " - start times are different, pe start "+ new Date(startTime) + 
		  " vs assigned " + new Date (start.getTime()) + " for " +asset);
	  }
	  else {
	    info (asset.getUID() + " - both start and end times are different for " + asset);
	  }
	}
      }
    }
    return null;
  }

  protected AssetGroup addToDirectObject (Task task, Vector objects) {
    AssetGroup group = (AssetGroup) task.getDirectObject ();
    Vector assetsInGroup = group.getAssets ();
    assetsInGroup.addAll (objects);
    if (isInfoEnabled ()) {
      info (getName() + " - publish changing " + task.getUID());
    }
    publishChange (task);
    return group;
  }

  /** 
   * very expensive - must examine every object on the blackboard - avoid if possible 
   * @param parentUID - uid of MPTask we want from the blackboard
   * @return MPTask with UID equal to the param parentUID
   */
  protected MPTask getMPTask (final UID parentUID) {
    Collection stuff = blackboard.query (new UnaryPredicate () {
	public boolean execute (Object obj) {
	  boolean isMPTask = (obj instanceof MPTask);
	  if (!isMPTask) return false;
	  boolean match = ((MPTask) obj).getUID ().toString().equals (parentUID.toString());
	  return match;
	}
      });

    if (stuff.iterator().hasNext())
      return (MPTask) stuff.iterator().next (); // better be only one!
    else
      return null;
  }

  protected Vector enumToVector (Enumeration enum) {
    Vector vector = new Vector (13);
    for (;enum.hasMoreElements ();) {
      vector.add (enum.nextElement ());
    }
    return vector;
  }

  protected Enumeration getEnumWithNewParents (Vector oldParents, Vector tasklist) {
    oldParents.addAll (tasklist);
    return oldParents.elements ();
  }

  protected void addAggregations (NewComposition comp, Vector parentTasks, Date start, Date end) {
    Map avMap = getAspectValuesMap(parentTasks, start, end);
    // create aggregations for each parent task
    for (Iterator i = parentTasks.iterator(); i.hasNext();){
      Task parentTask = (Task)i.next();
      AspectValue [] aspectValues = (AspectValue []) avMap.get (parentTask);

      boolean isSuccess = !allocHelper.exceedsPreferences (parentTask, aspectValues);

      if (!isSuccess) {
	warn ("VishnuAggregatorPlugin.addAggregations - making failed aggregation for " + parentTask);
	expandHelper.showPlanElement (parentTask);
      }
	  
      AllocationResult estAR = ldmf.newAllocationResult(allocHelper.HIGHEST_CONFIDENCE,
							isSuccess,
							aspectValues);
      Aggregation agg = ldmf.createAggregation(parentTask.getPlan(),
					       parentTask,
					       comp,
					       estAR);
      if (isDebugEnabled())
	debug ("VishnuAggregatorPlugin.makeAggregation - Making aggregation for task " + 
	       parentTask.getUID () + 
	       " agg " + agg.getUID());
      publishAddWithCheck(agg);
      comp.addAggregation (agg);
    }
  }

  /** 
   * hook for post-publish processing                           <br>
   * Default does nothing.                                      <br>
   * might want to do :	Task mpTask = findMPTask (aggResults);
   */
  protected void cleanupAggregation(Asset a, List tasklist, List aggResults) {
    //	Task mpTask = findMPTask (aggResults);
  }

  /** 
   * Find MPTask in list returned from UTILAggregate.makeAggregation
   *
   * @see org.cougaar.lib.util.UTILAggregate#makeAggregation
   */
  protected MPTask findMPTask(List results) {
    Iterator i = results.iterator();
    while (i.hasNext()) {
      Object next = i.next();
      if (next instanceof MPTask)
	return ((MPTask)next);
    }
    throw new UTILPluginException(myClusterName + " couldn't find MPTask in list of Aggregation products");
  }

  /** 
   * Defines the verb of the MPTask
   * Transport by default
   * 
   * @return Verb - Transport
   */
  protected Verb getVerbForAgg(List g) { 
    return Constants.Verb.Transport; 
  }

  /** 
   * Aggregates direct objects of parent tasks into a vector
   * 
   * @return aggregate of parent direct objects
   */
  protected Vector getDirectObjectsForAgg(List parentTasks) {
    Vector assets = new Vector();

    Iterator pt_i = parentTasks.iterator();
    // prepPhrases and directObjects
    while (pt_i.hasNext()) {
      Task currentTask = (Task)pt_i.next();
      assets.addElement(currentTask.getDirectObject());
    }

    return assets;
  }

  /**
   * Adjust preferences so that the start time preference is the assigned 
   * start time, and the end time preference has a best date that is the 
   * assigned end time.  The early and late dates of the end time preference
   * are the same as the first parent task. (This isn't very important, as the
   * downstream allocator should just allocate to the start and best times.)  <p>
   * 
   * If there is a quantity preference on the first task, will calculate an aggregate <br>
   * quantity preference.  Assumes then that all tasks will have a quantity pref.
   * @param a - the asset associated with the MPTask
   * @param g - parent task list
   * @param start - the date for the START_TIME preference
   * @param end - the best date for the END_TIME preference
   * @return Vector - list of preferences for the MPTask
   */
  protected Vector getPreferencesForAgg(Asset a, List g, Date start, Date end) { 
    Task firstParentTask = (Task)g.get(0);

    Date earlyDate = start.after (prefHelper.getEarlyDate(firstParentTask)) ?
      start : prefHelper.getEarlyDate(firstParentTask);
	
    Vector prefs;

    synchronized (firstParentTask) { // bug #2124
      prefs = allocHelper.enumToVector(firstParentTask.getPreferences());
    };

    prefs = prefHelper.replacePreference (prefs, prefHelper.makeStartDatePreference (ldmf, start));
    prefs = prefHelper.replacePreference (prefs, 
					      prefHelper.makeEndDatePreference (ldmf, 
										    earlyDate,
										    end,
										    prefHelper.getLateDate(firstParentTask)));
    long totalQuantity = 0l;
    if (prefHelper.hasPrefWithAspectType(firstParentTask, AspectType.QUANTITY)) {
      for (Iterator iter = g.iterator (); iter.hasNext (); ) {
	try {
	  totalQuantity += prefHelper.getQuantity ((Task) iter.next());
	} catch (UTILRuntimeException re) {
	  totalQuantity += 1; // the task didn't have a quantity preference
	}
      }

      prefs = 
	prefHelper.replacePreference (prefs, prefHelper.makeQuantityPreference (ldmf, totalQuantity));
    }

    return prefs;
  }

  /**
   * Defines how to get the asset representing the task->asset association.
   *
   * Should be in sync with getPrepPhrasesForAgg, which attaches the prep.
   * @see #getPrepPhrasesForAgg
   * @param combinedTask - the MPTask generated by the plugin
   * @return the asset on the task
   */
  protected Asset getAssetFromMPTask (MPTask combinedTask) {
    return (Asset) prepHelper.getIndirectObject(combinedTask, Constants.Preposition.WITH);
  }

  /**
   * <pre>
   * Defines how the MPTask holds the asset for the task->asset association.
   *
   * Should be in sync with getAssetFromMPTask, which accesses the prep.
   *
   * Critical, because the allocator downstream will look for this prep and
   * pluck the asset off to make the allocation.
   *
   * </pre>
   * @see #getAssetFromMPTask
   * @param a - asset to attach to task
   * @param g - parent tasks
   * @return the original set of prep phrases from the first parent task PLUS the WITH
   *         prep with the asset
   */
  protected Vector getPrepPhrasesForAgg(Asset a, List g) {
    Vector firstTaskPreps = allocHelper.enumToVector(((Task)g.get(0)).getPrepositionalPhrases());
    Vector preps = new Vector (firstTaskPreps);
	
    preps.addElement(prepHelper.makePrepositionalPhrase(ldmf, 
							Constants.Preposition.WITH, 
							a));
    return preps;
  }

  /**
   * Create aspect values so that the start time aspect is the assigned 
   * start time, and the end time aspect is the 
   * assigned end time.
   * (The downstream allocator should just echo these values.)
   *
   * Gets the preferences and makes aspect values that echo them. At this
   * point the start and end time preferences have been set to the assigned 
   * times.
   * 
   * @param a - the asset associated with the MPTask
   * @param g - parent task list
   * @return AspectValue[] - returned aspect values
   */
  protected AspectValue [] getAVsForAgg(Asset a, List g, Date start, Date end) {
    return makeAVsFromPrefs(getPreferencesForAgg(a, g, start, end));
  }

  /**
   * Create aspect values so that the start time aspect is the assigned 
   * start time, and the end time aspect is the 
   * assigned end time.
   * (The downstream allocator should just echo these values.)
   *
   * Gets the preferences and makes aspect values that echo them. At this
   * point the start and end time preferences have been set to the assigned 
   * times.
   * 
   * Does not create excess aspect value arrays.
   *
   * @param a - the asset associated with the MPTask
   * @param g - parent task list
   * @return AspectValue[] - returned aspect values
   */
  protected Map getAspectValuesMap(List g, Date start, Date end) {
    Map taskToAspectValue = new HashMap ();
    AspectValue [] timeOnlyAspects = null;
    int i = 0;
    for (Iterator iter = g.iterator (); iter.hasNext (); ) {
      Task task = (Task) iter.next ();
      Vector preferences;
      synchronized (task) { // synchronize on a task's preferences when you get them - bug #2124
	preferences = allocHelper.enumToVector(task.getPreferences ());
      }
      // all the time-only preference items will share the same aspects
      if (preferences.size () == 2) {
	if (timeOnlyAspects == null)
	  timeOnlyAspects = makeAVsFromPrefs(preferences, start, end);
	taskToAspectValue.put (task, timeOnlyAspects);
	i++;
      }
      else {
	taskToAspectValue.put (task, 
			       makeAVsFromPrefs(preferences, start, end));
      }
    }

    return taskToAspectValue;
  }

  /**
   * Create aspect values so that the start time aspect is the assigned 
   * start time, and the end time aspect is the 
   * assigned end time.
   * (The downstream allocator should just echo these values.)
   *
   * Takes the preferences and makes aspect values that echo them. At this
   * point the start and end time preferences have been set to the assigned 
   * times.
   * 
   * @param prefs - the preferences associated with the MPTask
   * @return AspectValue[] - returned aspect values
   */
  protected AspectValue [] makeAVsFromPrefs(Vector prefs) {
    Vector tmp_av_vec = new Vector(prefs.size());
    Iterator pref_i = prefs.iterator();
    while (pref_i.hasNext()) {
      // do something really simple for now.
      Preference pref = (Preference) pref_i.next();
      int at = pref.getAspectType();

      ScoringFunction sf = pref.getScoringFunction();
      // allocate as if you can do it at the "Best" point
      double result = ((AspectScorePoint)sf.getBest()).getValue();

      // sometimes would fail task due to rounding error 
      // (time would appear a few millis before the START_TIME pref)
      if (at == AspectType.START_TIME)
	result += 1000.0d; // BOZO : hack -- still needed?

      tmp_av_vec.addElement(AspectValue.newAspectValue(at, result));

      //debug (getName() + ".makeAVsFromPrefs - adding type " + at + " value " + result);
    }      

    AspectValue [] avs = new AspectValue[tmp_av_vec.size()];
    Iterator av_i = tmp_av_vec.iterator();
    int i = 0;
    while (av_i.hasNext())
      avs[i++] = (AspectValue)av_i.next();

    // if there were no preferences...return an empty vector (0 elements)
    return avs;
  }

  /** replace start and end time aspect values with those from the assignment */
  protected AspectValue [] makeAVsFromPrefs(Vector prefs, Date start, Date end) {
    Vector tmp_av_vec = new Vector(prefs.size());
    Iterator pref_i = prefs.iterator();
    while (pref_i.hasNext()) {
      // do something really simple for now.
      Preference pref = (Preference) pref_i.next();
      int at = pref.getAspectType();
      double result = 0;
	  
      if (at == AspectType.START_TIME) {
	result = (double) start.getTime();
      }
      else if (at == AspectType.END_TIME) {
	result = (double) end.getTime();
      }
      else {
	ScoringFunction sf = pref.getScoringFunction();
	// allocate as if you can do it at the "Best" point
	result = ((AspectScorePoint)sf.getBest()).getValue();
      }
      tmp_av_vec.addElement(AspectValue.newAspectValue(at, result));
    }      

    AspectValue [] avs = new AspectValue[tmp_av_vec.size()];
    Iterator av_i = tmp_av_vec.iterator();
    int i = 0;
    while (av_i.hasNext())
      avs[i++] = (AspectValue)av_i.next();

    // if there were no preferences...return an empty vector (0 elements)
    return avs;
  }

  /**
   * publish the generated plan elements, compositions, and tasks
   * 
   * Also informs of failed tasks.
   *
   * @param toPublish stuff to publish
   */
  protected void publishList(List toPublish) {
    Iterator i = toPublish.iterator();
    while (i.hasNext()) {
      Object next_o = i.next();
      if (next_o instanceof Task) {
	Task taskToPublish = (Task) next_o;
	PlanElement pe = taskToPublish.getPlanElement ();
	if (pe != null && !pe.getEstimatedResult().isSuccess () && isDebugEnabled()) {
	  debug (getName () + 
		 ".publishList - Task " + taskToPublish.getUID () +
		 " failed : ");
	  expandHelper.showPlanElement (taskToPublish);
	}
      }
      else if (next_o instanceof Composition) {
	((NewComposition) next_o).setIsPropagating(propagateRescindPastAggregation);
      }
	  
      publishAddWithCheck(next_o);
    }
  }
}

