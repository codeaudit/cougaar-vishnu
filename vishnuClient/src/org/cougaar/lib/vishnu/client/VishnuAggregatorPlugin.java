/*
 * <copyright>
 *  Copyright 2001 BBNT Solutions, LLC
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

import org.cougaar.lib.util.UTILAllocate;
import org.cougaar.lib.util.UTILAggregate;
import org.cougaar.lib.util.UTILExpand;
import org.cougaar.lib.util.UTILPluginException;
import org.cougaar.lib.util.UTILPreference;
import org.cougaar.lib.util.UTILPrepPhrase;
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
import org.cougaar.core.plugin.PluginBindingSite;

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

  protected XMLResultHandler createXMLResultHandler () {
    return new AggregateXMLResultHandler (this, comm, xmlProcessor, domUtil, config, getMyParams ());
  }

  public void localSetup() {     
    super.localSetup();

    try {propagateRescindPastAggregation = getMyParams().getBooleanParam("propagateRescindPastAggregation");}    
    catch(Exception e) {propagateRescindPastAggregation = true;}
  }

  /** adds the aggregation filter */
  public void setupFilters () {
    super.setupFilters ();

    if (myExtraOutput)
      System.out.println (getName () + " : Filtering for Aggregations...");

    addFilter (myAggCallback    = createAggCallback    ());

    if (myExtraOutput)
      System.out.println (getName () + " : Filtering for Expansions...");

    addFilter (new UTILExpansionCallback (this));
  }


  /*** Callback for input tasks ***/
  protected UTILWorkflowCallback   myWorkflowCallback;
  /** Callback for input tasks ***/
  protected UTILFilterCallback createThreadCallback (UTILGenericListener bufferingThread) { 
    if (myExtraOutput)
      System.out.println (getName () + " Filtering for tasks with Workflows...");

    myWorkflowCallback = new UTILWorkflowCallback  (bufferingThread); 
    myWorkflowCallback.setExtraDebug (myExtraOutput);
    myWorkflowCallback.setExtraExtraDebug (myExtraExtraOutput);
	
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
    return new UTILAggregationCallback  (this); 
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
      System.out.println (getName () + ".interestingParentTask - ignoring failed task : " + t.getUID ());
    }
	
    return isInteresting;
  }

  /** implemented for AggregationListener */
  public boolean needToRescind (Aggregation agg) { return false; }
  /** implemented for AggregationListener */
  public void reportChangedAggregation(Aggregation agg) { updateAllocationResult (agg); }
  /** implemented for AggregationListener */
  public void handleSuccessfulAggregation(Aggregation agg) {
    if (agg.getEstimatedResult().getConfidenceRating() > UTILAllocate.MEDIUM_CONFIDENCE) {
      // handleRemovedAggregation (agg);
    } else if (myExtraOutput) {
      System.out.println (getName () + 
			  ".handleSuccessfulAggregation : got changed agg (" + 
			  agg.getUID () + 
			  ") with intermediate confidence."); 
    }
  }

  /** implemented for AggregationListener */
  public void handleRemovedAggregation (Aggregation agg) {	
    // System.out.println("VishnuAggregatorPlugin.handleRemovedAggregation called");

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
      return UTILPrepPhrase.hasPrepNamed ((Task)firstTask, "VISHNU"); 
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
    if (myExtraExtraOutput || 
	(exp.getReportedResult () != null && !exp.getReportedResult().isSuccess ()))
      System.out.println (getName () + 
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
    if (myExtraOutput) {
      System.out.println (getName() + ".handleMultiAssignment : ");
      System.out.println ("\nAssigned tasks : ");
      for (int i = 0; i < tasks.size (); i++) {
	Task task = (Task) tasks.get(i);

	Date ready = UTILPreference.getReadyAt   (task);
	Date early = UTILPreference.getEarlyDate (task);
	Date late  = UTILPreference.getLateDate  (task);

	System.out.println ("" + task.getUID() +
			    " - ready " + ready + (start.before(ready) ? (" AFTER start " + start) : "") +
			    " early " + early   + (end.before(early) ? (" AFTER end " + end) : "") +
			    " best " + UTILPreference.getBestDate (task) + 
			    " late " + late     + (end.after(late) ? (" BEFORE end " + end) : ""));
      }
      System.out.println ("\nresource = " + asset +
			  "\nsetup    = " + setupStart +
			  "\nstart    = " + start +
			  "\nend      = " + end +
			  "\nwrapup   = " + wrapupEnd);
    }
  
    makePlanElement (tasks, asset, start, end, setupStart, wrapupEnd, assetWasUsedBefore);
  }
  
  /**
   * <pre>
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
   * Also fixes up the following when an additional tasks are added to a previous
   * assignment:
   *  1) Adds to the d.o. of the transport task allocated to the asset
   *  2) (Optional) If setup task, adds to the d.o. of the task
   *  3) (Optional) If wrapup task, adds to the d.o. of the task
   *  4) Adds to the d.o. of the mp task
   *  5) Makes Mp task parent task list reflect new parent tasks
   *  6) Makes aggregations connecting parent tasks to mp task
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
   * @see http://www.cougaar.org/projects/vishnu/fulldoc.html#specs
   */
  public void makePlanElement (Vector tasklist, Asset anAsset, Date start, Date end, Date setupStart, Date wrapupEnd,
			       boolean assetWasUsedBefore) {
    if (myExtraOutput) UTILAggregate.setDebug (true);

    if (assetWasUsedBefore) {
      if (addToPrevious (tasklist, anAsset, start, end, setupStart, wrapupEnd))
	return;
    }

    List aggResults = UTILAggregate.makeAggregation(this,
						    ldmf,
						    realityPlan,
						    tasklist,
						    getVerbForAgg(tasklist),
						    getPrepPhrasesForAgg(anAsset, tasklist),
						    getDirectObjectsForAgg(tasklist),
						    getPreferencesForAgg(anAsset, tasklist, start, end),
						    ((PluginBindingSite) getBindingSite()).getAgentIdentifier(),
						    getAspectValuesMap(tasklist, start, end),
						    UTILAllocate.MEDIUM_CONFIDENCE);
    if (myExtraOutput) UTILAggregate.setDebug (false);

    publishList(aggResults);
      
    cleanupAggregation(anAsset, tasklist, aggResults);

    Task mpTask = findMPTask (aggResults);

    makeSetupWrapupExpansion (mpTask, anAsset, start, end, setupStart, wrapupEnd);
  }

  public boolean addToPrevious (Vector tasklist, Asset anAsset, Date start, Date end, Date setupStart, Date wrapupEnd) {
    Task previousTask = getEncapsulatedTask (anAsset, start, end);

    if (previousTask != null) { // found transport task
      if (myExtraOutput) 
	System.out.println (getName () + ".addToPrevious - found previous task for asset " + 
			    anAsset.getUID());

      Vector directObjects = getDirectObjectsForAgg(tasklist); 
      // step 1 - add to d.o. of transport task
      Asset directObject = addToDirectObject (previousTask, directObjects);
      if (makeSetupAndWrapupTasks) {
	if (setupStart.getTime() < start.getTime()) {
	  Task setupTask = getEncapsulatedTask (anAsset, setupStart, start);
	  // step 2 - add to d.o. of setup
	  ((NewTask) setupTask).setDirectObject (directObject);
	  publishChange (setupTask);
	}
	if (wrapupEnd.getTime() > end.getTime()) {
	  Task wrapupTask = getEncapsulatedTask (anAsset, end, wrapupEnd);
	  // step 3 - add to d.o. of wrapup
	  ((NewTask) wrapupTask).setDirectObject (directObject);
	  publishChange (wrapupTask);
	}
      }
      MPTask mpTask = getMPTask (previousTask.getParentTaskUID ());
      // step 4 - add to d.o. of MPTask parent
      ((NewMPTask) mpTask).setDirectObject (directObject);

      // step 5 - Make MP Task know of new parents
      Enumeration parents = mpTask.getParentTasks ();
      Vector parentsVector = enumToVector (parents);
      ((NewMPTask)mpTask).setParentTasks (getEnumWithNewParents (parentsVector, tasklist));
      publishChange (mpTask);

      // step 6 - make aggregations for connecting parent tasks to MPTask
      NewComposition comp = (NewComposition) mpTask.getComposition ();
      addAggregations (comp, parentsVector, start, end);
      publishChange (comp);
      
      return true;
    }
    return false;
  }

  /** look for a plan element that covers exactly the same span of time */
  protected Task getEncapsulatedTask (Asset asset, Date start, Date end) {
    Collection tasks = asset.getRoleSchedule().getEncapsulatedRoleSchedule (start, end);
    if (tasks.isEmpty ())
      return null;
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
    }
    return null;
  }

  protected AssetGroup addToDirectObject (Task task, Vector objects) {
    AssetGroup group = (AssetGroup) task.getDirectObject ();
    Vector assetsInGroup = group.getAssets ();
    assetsInGroup.addAll (objects);
    publishChange (task);
    return group;
  }

  protected MPTask getMPTask (final UID parentUID) {
    Collection stuff = blackboard.query (new UnaryPredicate () {
	public boolean execute (Object obj) {
	  boolean isMPTask = (obj instanceof MPTask);
	  if (!isMPTask) return false;
	  boolean match = ((MPTask) obj).getUID ().toString().equals (parentUID.toString());
	  /*
	  System.out.println (getName () + ".getMPTask - Comparing uid " +
			      ((MPTask) obj).getUID ().toString() + " with key " + parentUID + 
			      ((match) ? " MATCH! " : " no match"));
	  */
	  return match;
	}
      });

    return (MPTask) stuff.iterator().next ();
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

      if (myExtraOutput) UTILAllocate.setDebug (true); // will show comparison of prefs to aspect value

      boolean isSuccess = !UTILAllocate.exceedsPreferences (parentTask, aspectValues);

      if (!isSuccess) {
	showDebugIfFailure ();
	System.out.println ("VishnuAggregatorPlugin.makeAggregation - making failed aggregation for " + parentTask);
	UTILExpand.showPlanElement (parentTask);
      }
	  
      if (myExtraOutput) UTILAllocate.setDebug (false);
	
      AllocationResult estAR = ldmf.newAVAllocationResult(UTILAllocate.HIGHEST_CONFIDENCE,
							  isSuccess,
							  aspectValues);
      Aggregation agg = ldmf.createAggregation(parentTask.getPlan(),
					       parentTask,
					       comp,
					       estAR);
      if (myExtraOutput)
	System.out.println ("VishnuAggregatorPlugin.makeAggregation - Making aggregation for task " + 
			    parentTask.getUID () + 
			    " agg " + agg.getUID());
      publishAdd (agg);
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
   * @see org.cougaar.lib.callback.UTILAggregate#makeAggregation
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

    Date earlyDate = start.after (UTILPreference.getEarlyDate(firstParentTask)) ?
      start : UTILPreference.getEarlyDate(firstParentTask);
	
    Vector prefs = UTILAllocate.enumToVector(firstParentTask.getPreferences());
    prefs = UTILPreference.replacePreference (prefs, UTILPreference.makeStartDatePreference (ldmf, start));
    prefs = UTILPreference.replacePreference (prefs, 
					      UTILPreference.makeEndDatePreference (ldmf, 
										    earlyDate,
										    end,
										    UTILPreference.getLateDate(firstParentTask)));
    long totalQuantity = 0l;
    if (UTILPreference.hasPrefWithAspectType(firstParentTask, AspectType.QUANTITY)) {
      for (Iterator iter = g.iterator (); iter.hasNext (); ) {
	try {
	  totalQuantity += UTILPreference.getQuantity ((Task) iter.next());
	} catch (UTILRuntimeException re) {
	  totalQuantity += 1; // the task didn't have a quantity preference
	}
      }

      prefs = 
	UTILPreference.replacePreference (prefs, UTILPreference.makeQuantityPreference (ldmf, totalQuantity));
    }

    return prefs;
  }

  /**
   * <pre>
   * Defines how to get the asset representing the task->asset association.
   *
   * Should be in sync with getPrepPhrasesForAgg, which attaches the prep.
   * </pre>
   * @see #getPrepPhrasesForAgg
   * @param combinedTask - the MPTask generated by the plugin
   * @return the asset on the task
   */
  protected Asset getAssetFromMPTask (MPTask combinedTask) {
    return (Asset) UTILPrepPhrase.getIndirectObject(combinedTask, Constants.Preposition.WITH);
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
    Vector firstTaskPreps = UTILAllocate.enumToVector(((Task)g.get(0)).getPrepositionalPhrases());
    Vector preps = new Vector (firstTaskPreps);
	
    preps.addElement(UTILPrepPhrase.makePrepositionalPhrase(ldmf, 
							    Constants.Preposition.WITH, 
							    a));
    return preps;
  }

  /**
   * <pre>
   * Create aspect values so that the start time aspect is the assigned 
   * start time, and the end time aspect is the 
   * assigned end time.
   * (The downstream allocator should just echo these values.)
   *
   * Gets the preferences and makes aspect values that echo them. At this
   * point the start and end time preferences have been set to the assigned 
   * times.
   * 
   * </pre>
   * @param a - the asset associated with the MPTask
   * @param g - parent task list
   * @return AspectValue[] - returned aspect values
   */
  protected AspectValue [] getAVsForAgg(Asset a, List g, Date start, Date end) {
    return makeAVsFromPrefs(getPreferencesForAgg(a, g, start, end));
  }

  /**
   * <pre>
   * Create aspect values so that the start time aspect is the assigned 
   * start time, and the end time aspect is the 
   * assigned end time.
   * (The downstream allocator should just echo these values.)
   *
   * Gets the preferences and makes aspect values that echo them. At this
   * point the start and end time preferences have been set to the assigned 
   * times.
   * 
   * </pre>
   * @param a - the asset associated with the MPTask
   * @param g - parent task list
   * @return AspectValue[] - returned aspect values
   */
  protected Map getAspectValuesMap(List g, Date start, Date end) {
    Map taskToAspectValue = new HashMap ();
    for (Iterator iter = g.iterator (); iter.hasNext (); ) {
      Task task = (Task) iter.next ();
      taskToAspectValue.put (task, 
			     makeAVsFromPrefs(UTILAllocate.enumToVector(task.getPreferences ()), start, end));
    }
    return taskToAspectValue;
  }

  /**
   * <pre>
   * Create aspect values so that the start time aspect is the assigned 
   * start time, and the end time aspect is the 
   * assigned end time.
   * (The downstream allocator should just echo these values.)
   *
   * Takes the preferences and makes aspect values that echo them. At this
   * point the start and end time preferences have been set to the assigned 
   * times.
   * 
   * </pre>
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

      tmp_av_vec.addElement(new AspectValue(at, result));

      //System.out.println (getName() + ".makeAVsFromPrefs - adding type " + at + " value " + result);
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
      tmp_av_vec.addElement(new AspectValue(at, result));
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
   * <pre>
   * publish the generated plan elements, compositions, and tasks
   * 
   * Also informs of failed tasks.
   *
   * <pre>
   * @param toPublish stuff to publish
   */
  protected void publishList(List toPublish) {
    Iterator i = toPublish.iterator();
    while (i.hasNext()) {
      Object next_o = i.next();
      if (next_o instanceof Task) {
	Task taskToPublish = (Task) next_o;
	PlanElement pe = taskToPublish.getPlanElement ();
	if (pe != null && !pe.getEstimatedResult().isSuccess () && myExtraOutput) {
	  System.out.println (getName () + 
			      ".publishList - Task " + taskToPublish.getUID () +
			      " failed : ");
	  UTILExpand.showPlanElement (taskToPublish);
	}
      }
      else if (next_o instanceof Composition) {
	((NewComposition) next_o).setIsPropagating(propagateRescindPastAggregation);
      }
	  
      boolean success = publishAdd(next_o);
    }
  }

  private Map compositionToNumberTasks = new HashMap();
  boolean propagateRescindPastAggregation;
}

