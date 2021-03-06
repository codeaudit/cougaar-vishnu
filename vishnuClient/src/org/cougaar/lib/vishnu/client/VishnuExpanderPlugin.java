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

import org.cougaar.lib.callback.UTILExpandableTaskCallback;
import org.cougaar.lib.callback.UTILExpansionCallback;
import org.cougaar.lib.callback.UTILFilterCallback;
import org.cougaar.lib.callback.UTILGenericListener;
import org.cougaar.lib.filter.UTILExpanderPlugin;
import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.Expansion;
import org.cougaar.planning.ldm.plan.Task;

import java.util.Date;
import java.util.List;
import java.util.Vector;

/**
 * <pre>
 * A simple expander base class.  
 *
 * Must subclass to get full behavior.  
 *
 * Especially consider overriding handleAssignment to make the subtasks 
 * appropriate for your application.
 *
 * </pre>
 * @see #handleAssignment
 */
public class VishnuExpanderPlugin extends VishnuPlugin implements UTILExpanderPlugin {
  /**
   * <pre>
   * Provide the callback that is paired with the buffering thread, which is a
   * listener.  The buffering thread is the listener to the callback
   *
   * Creates an instance of the ExpandableTaskCallback, which means the plugin
   * is looking for tasks that are naked, and not yet expanded or part of workflows.
   *
   * </pre>
   * @param bufferingThread -- the thread the callback informs when there are new input tasks
   * @return an ExpandableTaskCallback with the buffering thread as its listener
   * @see org.cougaar.lib.callback.UTILWorkflowCallback
   */
  protected UTILFilterCallback createThreadCallback (UTILGenericListener bufferingThread) { 
    if (isInfoEnabled())
      debug (getName () + " : Filtering for Expandable Tasks...");

    myInputTaskCallback = new UTILExpandableTaskCallback (bufferingThread, logger);  
    return myInputTaskCallback;
  } 

  /** 
   * Implemented for UTILBufferingPlugin
   *
   * Got an ill-formed task, now handle it, by
   * publishing a failed expansion for the task.
   * @param t badly-formed task to handle
   */
  public void handleIllFormedTask (Task t) {
    reportIllFormedTask(t);
    Object obj = expandHelper.makeFailedExpansion (null, ldmf, t);
    publishAddWithCheck (obj);
  }

  /**
   * create the expansion callback
   */
  protected UTILFilterCallback createExpansionCallback () { 
    if (isInfoEnabled())
      debug (getName () + " : Filtering for Expansions...");
        
    return new UTILExpansionCallback (this, logger); 
  }

  /**
   * Implemented for UTILExpansionListener
   *
   * Gives plugin a way to filter out which expanded tasks it's
   * interested in.
   *
   * @param t Task that has been expanded (getTask of Expansion)
   * @return true if task is interesting to this plugin
   */
  public boolean interestingExpandedTask (Task t) { return interestingTask(t); }

  /**
   * At least one constraint has been violated.  It's up to the plugin how to deal 
   * with the violation(s).
   *
   * Ideally, this will not happen very often, and when it does, we should hear about it.
   *
   * @param exp that failed
   * @param violatedConstraints of Constraints that have been violated
   */
  public void handleConstraintViolation(Expansion exp, List violatedConstraints) {
  }

  /**
   * Implemented for UTILExpansionListener
   *
   * Does the plugin want to change the expansion?
   *
   * For instance, although no individual preference may have been exceeded,
   * the total score for the expansion may exceed some threshold, and so the
   * plugin may want to alter the expansion.
   *
   * Defaults to FALSE.
   *
   * @param exp to check
   * @return true if plugin wants to change expansion
   */
  public boolean wantToChangeExpansion(Expansion exp) {
    return false;
  }

  /**
   * The plugin changes the expansion.  Only called if wantToChangeExpansion returns true.
   *
   * Default does nothing.
   *
   * @see #wantToChangeExpansion
   * @param exp to change
   */
  public void changeExpansion(Expansion exp) {}

  /**
   * publish the change
   *
   * @see #wantToChangeExpansion
   * @param exp to change
   */
  public void publishChangedExpansion(Expansion exp) {
    publishChange (exp);
  }

  /**
   * Report to superior that the expansion has changed.  Includes a pass
   * through to the UTILPluginAdapter's updateAllocationResult.
   * Updates and publishes allocation result of expansion.
   *
   * @param exp Expansion that has changed.
   * @see org.cougaar.lib.filter.UTILPluginAdapter#updateAllocationResult
   */
  public void reportChangedExpansion(Expansion exp) { 
      if (logger.isDebugEnabled())
	  debug (getName () + 
			      " : reporting changed expansion to superior.");
      updateAllocationResult (exp);
  }

  /**
   * Handle a successful expansion
   * Also must remove the GSTaskGroup from the GSS SchedulerResult
   * storage
   *
   * @param exp Expansion that has succeeded.
   */
  public void handleSuccessfulExpansion(Expansion exp, List successfulSubtasks) { 
      if (isInfoEnabled())
	  debug (getName () + 
			      " : got successful expansion for task " + exp.getTask ().getUID());
  }

  /**
   * Handle a failed expansion
   * Also must remove the GSTaskGroup from the GSS SchedulerResult
   * storage
   *
   * @param exp Expansion that has succeeded.
   */
  public void handleFailedExpansion(Expansion exp, List failedSubtasks) { 
      if (isInfoEnabled())
	  debug (getName () + 
			      " : got failed expansion for task " + exp.getTask ().getUID());
  }

  /**
   * The idea is to add subscriptions (via the filterCallback), and when 
   * they change, to have the callback react to the change, and tell 
   * the listener (many times the plugin) what to do.
   *
   * Override and call super to add new filters, or override 
   * createXXXCallback to change callback behaviour.
   */
  public void setupFilters () {
    super.setupFilters ();
              
    addFilter (createExpansionCallback());
  }

  /**
   * Makes expansions given the task-to-asset assignment.<p>
   * 
   * If the task has a setup or wrapup duration, and expansion is made and
   * then the subtasks get allocated with the setup and wrapup durations.  <p>
   *
   * Subclasses should override with a method that attaches information representing
   * the assignment via a preposition and also call <code>makeSetupAndWrapupTasks</code> to 
   * create the optional setup and wrapup tasks.  Probably a downstream allocator will
   * use the preposition information to create an allocation to the assigned asset.
   *
   * @see org.cougaar.lib.vishnu.client.VishnuPlugin#makeSetupAndWrapupTasks
   * @param task task being assigned to asset
   * @param asset asset handling the task
   * @param start start of the main task
   * @param end   end   of the main task
   * @param setupStart start of a setup task, equal to start if there is no setup task
   * @param wrapupEnd  end   of a wrapup task, equal to end if there is no wrapup task
   **/
  public void handleAssignment (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd, String contribs, String taskText) {
    makeSetupWrapupExpansion (task, asset, start, end, setupStart, wrapupEnd);
  }

  /** 
   * Implemented for UTILGenericListener interface
   *
   * This method Expands the given Task and publishes the PlanElement.
   * The method expandTask should be implemented by child classes.
   * @param t the task to be expanded.
   */
  public void handleTask(Task t) {}

  /**
   * Here's where we react to a rescinded task.
   * 
   * does nothing by default 
   */
  public void handleRemovedTask(Task t) {}

  /**
   * Implemented for expand.rPlugin interface
   *
   * The guts of the expansion.
   *
   * Default does nothing!  Subclass should override.
   */
  public Vector getSubtasks(Task t) { 
    debug (getName () + 
	   " : WARNING - getSubtasks should be overriden." +
	   " Default does nothing.");
    return new Vector (); 
  }

  protected UTILExpandableTaskCallback myInputTaskCallback;
}
