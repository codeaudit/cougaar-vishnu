/*
 * <copyright>
 *  
 *  Copyright 2001-2004 BBNT Solutions, LLC
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

import org.cougaar.lib.callback.UTILAllocationCallback;
import org.cougaar.lib.callback.UTILFilterCallback;
import org.cougaar.lib.callback.UTILGenericListener;
import org.cougaar.lib.callback.UTILWorkflowCallback;
import org.cougaar.lib.filter.UTILAllocatorPlugin;
import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.Allocation;
import org.cougaar.planning.ldm.plan.AspectType;
import org.cougaar.planning.ldm.plan.AspectValue;
import org.cougaar.planning.ldm.plan.PlanElement;
import org.cougaar.planning.ldm.plan.Role;
import org.cougaar.planning.ldm.plan.Task;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

/**
 * Vishnu plugin that takes Vishnu assignments and creates allocations out of them
 * 
 */
public class VishnuAllocatorPlugin extends VishnuPlugin implements UTILAllocatorPlugin {
  /**
   * <pre>
   * The idea is to add subscriptions (via the filterCallback), and when 
   * they change, to have the callback react to the change, and tell 
   * the listener (many times the plugin) what to do.
   *
   * Override and call super to add new filters, or override 
   * createXXXCallback to change callback behaviour.
   *
   * By default adds allocation callback after creating it.
   *
   * </pre>
   * @see #createAllocCallback
   */
  public void setupFilters () {
    super.setupFilters ();

    if (isInfoEnabled())
      info (getName () + " : Filtering for Allocations...");

    addFilter (myAllocCallback    = createAllocCallback    ());
  }

  /**
   * <pre>
   * Callback for input tasks 
   *
   * Provide the callback that is paired with the buffering thread, which is a
   * listener.  The buffering thread is the listener to the callback
   *
   * Creates an instance of the WorkflowCallback, which means the plugin
   * is looking for tasks that are part of workflows.
   *
   * </pre>
   * @param bufferingThread -- the thread the callback informs when there are new input tasks
   * @return a WorkflowCallback with the buffering thread as its listener
   */
  protected UTILFilterCallback createThreadCallback (UTILGenericListener bufferingThread) { 
    if (isInfoEnabled())
      info (getName () + " Filtering for tasks with Workflows...");

    myWorkflowCallback = new UTILWorkflowCallback  (bufferingThread, logger); 
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
    return new UTILAllocationCallback  (this, logger); 
  } 

  /** 
   * Implemented for UTILBufferingPlugin <p>
   *
   * Got an ill-formed task, now handle it, by <br>
   * publishing a failed plan allocation for the task.
   * @param t badly-formed task to handle
   */
  public void handleIllFormedTask (Task t) {
    reportIllFormedTask(t);
    Object obj = allocHelper.makeFailedDisposition (null, ldmf, t);
    publishAddWithCheck (obj);
  }

  /**
   * Implemented for UTILAllocationListener        <p>
   *
   * OVERRIDE to specify task notifications (i.e. changed 
   * (allocations) the plugin is interested in. <p>
   *
   * Just calls interestingTask by default, which is generally
   * what you want.
   *
   * @param t task to check for notification
   * @return boolean true if task is interesting
   */
  public boolean interestingNotification(Task t) { 
    return interestingTask(t);
  }

  /**
   * <pre>
   * Implemented for UTILAllocationListener
   *
   * Defines conditions for rescinding tasks.
   *
   * Only return true if the plugin can do something different 
   * with the task that failed.  See allocHelper.isFailedPE.
   *
   * When returns TRUE, handleRescindedAlloc is called. 
   *
   * If in making an allocation, a preference
   * threshold is exceeded, the returned plan element will be
   * a Disposition (see UTILAllocate.makeAllocation ()).
   *
   * Called by UTILAllocationCallback.reactToChangedAlloc.
   *
   * </pre>
   * @param alloc the allocation to check
   * @return boolean true if the allocation needs to be rescinded
   *         Also returns false if there is no reported alloc result
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
   * <pre>
   * Implemented for UTILAllocationListener
   *
   * Public version of publishRemove
   *
   * Called by UTILAllocationCallback.reactToChangedAlloc.
   *
   * </pre>
   * @param alloc Allocation to remove from cluster's logPlan
   * @see org.cougaar.lib.callback.UTILAllocationCallback#reactToChangedAlloc
   */
  public void publishRemovalOfAllocation (Allocation alloc) { 
    publishRemove (alloc); 
  }

  /**
   * <pre>
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
   * </pre>
   * @param alloc the allocation that should be rescinded
   * @return false since doesn't rescind the allocation
   * @see org.cougaar.lib.filter.UTILPluginAdapter#updateAllocationResult
   * @see org.cougaar.lib.callback.UTILAllocationListener#updateAllocationResult
   * @see org.cougaar.lib.callback.UTILAllocationCallback#reactToChangedAlloc
   * @see #needToRescind
   */
  public boolean handleRescindedAlloc (Allocation alloc) { return false; }

  /**
   * <pre>
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
   * </pre>
   * @param alloc the allocation that was successful
   * @see org.cougaar.lib.filter.UTILPluginAdapter#updateAllocationResult
   * @see org.cougaar.lib.callback.UTILAllocationListener#updateAllocationResult
   * @see org.cougaar.lib.callback.UTILAllocationCallback#reactToChangedAlloc
   * @see #needToRescind
   */
  public void handleSuccessfulAlloc (Allocation alloc) {}

  /** 
   * <pre>
   * Called when an allocation is removed from the cluster.
   * I.e. an upstream cluster removed an allocation, and that 
   * rescind has resulted in this allocation being removed.
   *
   * If the plugin maintains some local state of the availability
   * of assets, it should update them here.
   *
   * This is different from the needToRescind-handleRescindedAlloc pair
   * which are used when the plugin gets a result that it wants to
   * replan.  If needToRescind returns true, a downstream
   * cluster will see handleRemovedAlloc get called.
   *
   * Calls VishnuPlugin.handleRemovedTasks.  If in incremental mode,
   * the SchedulerLifecycle Mode will tell the scheduler to forget about
   * the removed task.
   * </pre>
   * @param alloc that was removed from the blackboard
   * @see org.cougaar.lib.vishnu.client.VishnuPlugin#handleRemovedTasks
   * @see org.cougaar.lib.vishnu.client.InternalMode#handleRemovedTasks
   * @see org.cougaar.lib.vishnu.client.ExternalMode#handleRemovedTasks
   */
  public void handleRemovedAlloc (Allocation alloc) {
    if (isDebugEnabled()) {
      String owner = "?";
      try {
	owner =  alloc.getTask().getDirectObject().getUID().getOwner();
      } catch (Exception e) {}
	
      debug(getName() + ".handleRemovedAlloc called for task " + alloc.getTask().getUID() + 
			 " from unit " + owner);
    }

    Vector removedTasks = new Vector();
    removedTasks.add(alloc.getTask());

    handleRemovedTasks(removedTasks.elements());
  }

  /**
   * Makes allocations given the task to asset assignment. <p>
   * 
   * If the task has a setup or wrapup duration, and expansion is made and <br>
   * then the subtasks get allocated with the setup and wrapup durations.  <p>
   *
   * Calls <code>createAllocation</code> to create the allocation of 
   * task to asset, and <code>makeSetupAndWrapupTasks</code> to create the 
   * optional setup and wrapup tasks.  <code>createAllocation</code>is called
   * using <code>getConfidence</code> and <code>getRole</code>.
   *
   * @see #createAllocation
   * @see #makeSetupAndWrapupTasks
   * @param task task being assigned to asset
   * @param asset asset handling the task
   * @param start start of the main task
   * @param end   end   of the main task
   * @param setupStart start of a setup task, equal to start if there is no setup task
   * @param wrapupEnd  end   of a wrapup task, equal to end if there is no wrapup task
   **/
  public void handleAssignment (org.cougaar.planning.ldm.plan.Task task, Asset asset, 
				Date start, Date end, Date setupStart, Date wrapupEnd, String contribs, String taskText) {
    if (isDebugEnabled())
      debug ("got here with " + task + " and asset " + asset + " with contribs " + contribs + " and taskText " + taskText);

    if (isDebugEnabled())
      debug ("VishnuAllocatorPlugin.makePlanElement : " + 
	     " assigning " + task.getUID() + 
	     "\nto " + asset.getUID () +
	     " from " + start + 
	     " to " + end);

    double quantity = -1;
    try { quantity = Double.parseDouble (contribs); }
    catch (Exception e) { info ("Could not parse <" + contribs + "> as double."); }

    if (makeSetupAndWrapupTasks && 
	((setupStart.getTime() < start.getTime()) ||
	 (wrapupEnd.getTime () > end.getTime  ()))) {
      List subtasks = makeSetupWrapupExpansion (task, asset, start, end, setupStart, wrapupEnd);
	  
      for (Iterator iter = subtasks.iterator(); iter.hasNext(); ) {
	Task subtask = (Task) iter.next();

	createAllocation (subtask, asset, 
			  prefHelper.getReadyAt (subtask), 
			  prefHelper.getBestDate (subtask), 
			  getConfidence (asset),
			  getRole(),  quantity);
      }
    } else {
      createAllocation (task, asset, 
			start,
			end,
			getConfidence (asset),
			getRole(),  quantity);
    }
  }

  /**
   * <pre>
   * By default, sets highest confidence on allocation. <br>
   * This is usually only appropriate for allocation to Physical Assets.  <br>
   * If your allocator allocates to organizations, you probably want to override <br>
   * this function and set the confidence to alloc.MEDIUM_CONFIDENCE. <p>
   * 
   * Or you could do : <code>
   * double confidence = ((GLMAsset) asset).hasPhysicalPG () ? 
   * alloc.HIGHEST_CONFIDENCE : alloc.MEDIUM_CONFIDENCE; </code>
   * </pre>
   **/
  protected double getConfidence (Asset asset) {
    return allocHelper.HIGHEST_CONFIDENCE;
  }

  /** 
   * Transporter by default, override to use a different role
   * Specifies role in the allocation plan element. 
   */
  protected Role getRole () {
    return Role.getRole("Transporter");
  }
  
  /**
   * Creates an allocation or dispostion if the start and end times
   * violate the preferences.
   * 
   * @param task task being assigned to asset
   * @param asset asset handling the task
   * @param start start of the task
   * @param end   end   of the task
   * @param confidence of the allocation
   * @param role of the allocation
   * @return Allocation or Disposition
   */
  protected PlanElement createAllocation (Task task,
					  Asset asset,
					  Date start,
					  Date end,
					  double confidence,
					  Role role, double quantity) {
    AspectValue[] aspects;

    if (prefHelper.hasPrefWithAspectType (task, AspectType.QUANTITY)) {
      aspects = new AspectValue[3];
      aspects[2] = AspectValue.newAspectValue (AspectType.QUANTITY,   quantity);
    }
    else {
      aspects = new AspectValue[2];
    }

    aspects[0] = AspectValue.newAspectValue (AspectType.START_TIME, start.getTime ());
    aspects[1] = AspectValue.newAspectValue (AspectType.END_TIME,   end.getTime ());

    PlanElement allocation = allocHelper.makeAllocation(this,
							ldmf, realityPlan, 
							task, asset,
							aspects, 
							confidence,
							role);
		
    publishAdd(allocation);
    return allocation;
  }

  /** callback handling/monitoring incoming tasks */
  protected UTILWorkflowCallback   myWorkflowCallback;
  /** callback handling/monitoring outgoing allocation */
  protected UTILAllocationCallback myAllocCallback;
}
