/* $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/client/Attic/VishnuAllocatorPlugIn.java,v 1.1 2001-01-10 19:29:55 rwu Exp $ */

package org.cougaar.lib.vishnu.client;

import org.cougaar.domain.planning.ldm.asset.Asset;

import org.cougaar.domain.planning.ldm.plan.Role;
import org.cougaar.domain.planning.ldm.plan.Allocation;
import org.cougaar.domain.planning.ldm.plan.AuxiliaryQueryType;
import org.cougaar.domain.planning.ldm.plan.PlanElement;
import org.cougaar.domain.planning.ldm.plan.Role;
import org.cougaar.domain.planning.ldm.plan.Task;

import org.cougaar.lib.callback.UTILAllocationCallback;
import org.cougaar.lib.callback.UTILFilterCallback;
import org.cougaar.lib.callback.UTILGenericListener;
import org.cougaar.lib.callback.UTILWorkflowCallback;

import org.cougaar.lib.util.UTILAllocate;
import org.cougaar.lib.util.UTILPreference;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.cougaar.lib.filter.UTILAllocatorPlugIn;

public class VishnuAllocatorPlugIn extends VishnuPlugIn implements UTILAllocatorPlugIn {

  /**
   * The idea is to add subscriptions (via the filterCallback), and when 
   * they change, to have the callback react to the change, and tell 
   * the listener (many times the plugin) what to do.
   *
   * Override and call super to add new filters, or override 
   * createXXXCallback to change callback behaviour.
   *
   * By default adds allocation callback after creating it.
   *
   * @see #createAllocCallback
   */
  public void setupFilters () {
    super.setupFilters ();

    if (myExtraOutput)
      System.out.println (getName () + " : Filtering for Allocations...");

    addFilter (myAllocCallback    = createAllocCallback    ());
  }

  /**
   * Provide the callback that is paired with the buffering thread, which is a
   * listener.  The buffering thread is the listener to the callback
   *
   * @return a WorkflowCallback with the buffering thread as its listener
   */
  protected UTILFilterCallback createThreadCallback (UTILGenericListener bufferingThread) { 
    if (myExtraOutput)
      System.out.println (getName () + " Filtering for tasks with Workflows...");

    myWorkflowCallback = new UTILWorkflowCallback  (bufferingThread); 
    return myWorkflowCallback;
  } 

  protected UTILFilterCallback getWorkflowCallback () {
    return myWorkflowCallback;
  }


  protected UTILAllocationCallback getAllocCallback    () { return myAllocCallback; }
  /**
   * Override to replace with a callback that has a different predicate
   * or different behaviour when triggered.
   */
  protected UTILAllocationCallback createAllocCallback () { 
    return new UTILAllocationCallback  (this); 
  } 

  /** 
   * Implemented for UTILBufferingPlugin
   *
   * Got an ill-formed task, now handle it, by
   * publishing a failed plan allocation for the task.
   * @param t badly-formed task to handle
   */
  public void handleIllFormedTask (Task t) {
    reportIllFormedTask(t);
    publishAdd (UTILAllocate.makeFailedDisposition (null, ldmf, t));
  }

  /**
   * Implemented for UTILAllocationListener        <p>
   *
   * WARNING: The filters from the XML file will
   * not be considered here unless you make a 
   * call to the GSScheduler somehow. (i.e.
   * via interestingTask or similar method)
   * 
   * OVERRIDE to see which task notifications you
   * think are interesting
   * @param t task to check for notification
   * @return boolean true if task is interesting
   */
  public boolean interestingNotification(Task t) { 
    return interestingTask(t);
  }

  /**
   * Implemented for UTILAllocationListener
   *
   * Defines conditions for rescinding tasks.
   *
   * Only return true if the plugin can do something different 
   * with the task that failed.  See UTILAllocate.isFailedPE.
   *
   * When returns TRUE, handleRescindedAlloc is called. 
   *
   * Returns TRUE when downstream, a FailedAllocation is made.
   *
   *
   * If in making an allocation, a preference
   * threshold is exceeded, the returned plan element will be
   * a FailedAllocation (see UTILAllocate.makeAllocation ()).
   *
   * TOPS does not create any allocations with 
   * AllocationResults w/ isSuccess = false, but ALP will roll
   * up the results of a workflow, and create an AllocResult
   * w/ isSuccess = False if it contains a FailedAllocation.
   *
   * Called by UTILAllocationCallback.reactToChangedAlloc.
   *
   * @param alloc the allocation to check
   * @return boolean true if the allocation need to be rescinded
   *         Also returns false if there is no report alloc result
   *         attached to allocation
   * @see #handleRescindedAlloc
   * @see org.cougaar.lib.callback.UTILAllocationCallback#reactToChangedAlloc
   * @see org.cougaar.lib.util.UTILAllocate#makeAllocation
   * @see org.cougaar.lib.util.UTILAllocate#isFailedPE
   */
  public boolean needToRescind(Allocation alloc){
    return false;
  }

  /**
   * Implemented for UTILAllocationListener
   *
   * Public version of publishRemove
   *
   * Called by UTILAllocationCallback.reactToChangedAlloc.
   *
   * @param alloc Allocation to remove from cluster's memory
   * @see org.cougaar.lib.callback.UTILAllocationCallback#reactToChangedAlloc
   */
  public void publishRemovalOfAllocation (Allocation alloc) { 
    publishRemove (alloc); 
  }

  /**
   * Implemented for UTILAllocationListener
   *
   * Defines re-allocation of a rescinded task.  
   * Overriders need to take into consideration that 
   * the asset chosen last time is not available this time.
   *
   * Note that updateAllocationResult is called automatically by
   * the UTILAllocationCallback if the allocation has changed 
   * (typically if its allocation result has changed) 
   * but it does NOT need to be rescinded.
   *
   * Called by UTILAllocationCallback.reactToChangedAlloc.
   *
   * Only called when needToRescind returns TRUE.
   * See comment on needToRescind.
   *
   * Does nothing by default.
   *
   * @param alloc the allocation that should be rescinded
   * @see UTILPlugInAdapter#updateAllocationResult
   * @see UTILAllocationListener#updateAllocationResult
   * @see org.cougaar.lib.callback.UTILAllocationCallback#reactToChangedAlloc
   * @see #needToRescind
   */
  public boolean handleRescindedAlloc (Allocation alloc) {
    return false;
  }

  /**
   * Implemented for UTILAllocationListener
   *
   * Called automatically by the UTILAllocationCallback 
   * if the allocation has changed but it does NOT need 
   * to be rescinded. 
   * updateAllocationResult is called first and then this method 
   * gets called.
   *
   * Called by UTILAllocationCallback.reactToChangedAlloc.
   *
   * Only called when needToRescind returns FALSE.
   * See comment on needToRescind.
   *
   * Does nothing by default.
   *
   * @param alloc the allocation that was successful
   * @see UTILPlugInAdapter#updateAllocationResult
   * @see UTILAllocationListener#updateAllocationResult
   * @see org.cougaar.lib.callback.UTILAllocationCallback#reactToChangedAlloc
   * @see #needToRescind
   */
  public void handleSuccessfulAlloc (Allocation alloc) {
	if (alloc.getEstimatedResult().getConfidenceRating() > UTILAllocate.MEDIUM_CONFIDENCE)
	  handleRemovedAlloc (alloc);
	else if (myExtraOutput) {
      System.out.println (getName () + ".handleSuccessfulAlloc : got changed alloc (" + alloc.getUID () + 
						  " with intermediate confidence."); 
	}
  }

  /** 
   * Called when an allocation is removed from the cluster.
   * I.e. an upstream cluster removed an allocation, and this 
   * rescind has resulted in this allocation being removed.
   *
   * If the plugin maintains some local state of the availability
   * of assets, it should update them here.
   *
   * Does nothing by default.
   */
  public void handleRemovedAlloc (Allocation alloc) {
	Set tasks = new HashSet();
	tasks.add(alloc.getTask ());
	  
	sendUpdatedRoleSchedule(alloc, alloc.getAsset (), tasks);
  }

  /**
   * if no asset could be found to handle the task, handle them in some way -
   * Tasks that did not get expanded become failed expansions.
   *
   * debugging may come on automatically
   */
  public void handleImpossibleTasks (List unallocatedTasks) {
    super.handleImpossibleTasks (unallocatedTasks);
  }

  /**
   * <pre>
   * Makes allocations given the task to asset assignment.
   * 
   * If the task has a setup or wrapup duration, and expansion is made and
   * then the subtasks get allocated with the setup and wrapup durations.
   *
   * Calls sendUpdatedRoleSchedule at the end so vishnu will
   * know about change to availability of asset AND to unfreeze the assignment.
   *
   * Only does this if we're not sending the assets again with every new set of
   * tasks.
   * </pre>
   */
  public void handleAssignment (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
    if (myExtraOutput)
      System.out.println ("VishnuAllocatorPlugIn.makePlanElement : " + 
			  " assigning " + task.getUID() + 
			  "\nto " + asset.getUID () +
			  " from " + start + 
			  " to " + end);

    if (myExtraOutput) UTILAllocate.setDebug (true);
	
	if (makeSetupAndWrapupTasks && 
		((setupStart.getTime() < start.getTime()) ||
		 (wrapupEnd.getTime () > end.getTime  ()))) {
	  List subtasks = makeSetupWrapupExpansion (task, asset, start, end, setupStart, wrapupEnd);
	  
	  for (Iterator iter = subtasks.iterator(); iter.hasNext(); ) {
		Task subtask = (Task) iter.next();
		createAllocation (subtask, asset, 
						  UTILPreference.getReadyAt (subtask), 
						  UTILPreference.getBestDate (subtask), 
						  UTILAllocate.HIGHEST_CONFIDENCE,
						  Role.getRole("Transporter"));
	  }
	} else {
		createAllocation (task, asset, 
						  start,
						  end,
						  UTILAllocate.HIGHEST_CONFIDENCE,
						  Role.getRole("Transporter"));
	}
    if (myExtraOutput) UTILAllocate.setDebug (false);

	Set tasks = new HashSet ();
	
	tasks.add (task);
	
	//	if (mySentAssetDataAlready)
	//	  sendUpdatedRoleSchedule(allocation, asset, tasks);
  }

	/**
	 * <pre>
	 * NOTE! By default, sets highest confidence on allocation.
	 * This is only usually appropriate for allocation to Physical Assets.
	 * If your allocator allocates to organizations, you probably want to override
	 * this function and set the confidence to UTILAllocate.MEDIUM_CONFIDENCE.
	 * e.g.
	 * return super.createAllocation (...., UTILAllocate.MEDIUM_CONFIDENCE);
	 *
	 * Or, you could copy this function and comment out the code that looks at
	 * the asset to see whether it's physical or not. (This can only be done if
	 * the alpine.jar is available.  E.g. not for Books On Line.)
	 *
	 * Also, this here you could set a different role than the default "Transporter"
	 * </pre>
	 */
	protected PlanElement createAllocation (Task task,
											Asset asset,
											Date start,
											Date end,
											double confidence,
											Role role) {
		//		double confidence = ((ALPAsset) asset).hasPhysicalPG () ? 
		// UTILAllocate.HIGHEST_CONFIDENCE : UTILAllocate.MEDIUM_CONFIDENCE;
		PlanElement allocation = UTILAllocate.makeAllocation(this,
															 ldmf, realityPlan, 
															 task, asset,
															 start, 
															 end, 
															 confidence,
															 role);
		
		publishAdd(allocation);
		return allocation;
	}

  protected UTILWorkflowCallback   myWorkflowCallback;
  protected UTILAllocationCallback myAllocCallback;
}
