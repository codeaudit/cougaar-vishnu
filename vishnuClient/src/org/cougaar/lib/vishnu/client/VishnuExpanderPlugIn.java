package org.cougaar.lib.vishnu.client;

import org.cougaar.domain.glm.ldm.Constants;

import org.cougaar.lib.callback.UTILAssetCallback;
import org.cougaar.lib.callback.UTILAssetListener;
import org.cougaar.lib.callback.UTILExpandableTaskCallback;
import org.cougaar.lib.callback.UTILExpansionCallback;
import org.cougaar.lib.callback.UTILFilterCallback;
import org.cougaar.lib.callback.UTILGenericListener;

import org.cougaar.lib.filter.UTILExpanderPlugIn;
import org.cougaar.lib.filter.UTILBufferingPlugInAdapter;

import org.cougaar.lib.param.ParamException;

import org.cougaar.lib.util.UTILAllocate;
import org.cougaar.lib.util.UTILExpand;
import org.cougaar.lib.util.UTILPrepPhrase;
import org.cougaar.lib.util.UTILPreference;
import org.cougaar.lib.util.UTILRuntimeException;

import org.cougaar.domain.planning.ldm.asset.Asset;
import org.cougaar.domain.planning.ldm.plan.AllocationResultAggregator;
import org.cougaar.domain.planning.ldm.plan.Expansion;
import org.cougaar.domain.planning.ldm.plan.NewTask;
import org.cougaar.domain.planning.ldm.plan.Task;
import org.cougaar.domain.planning.ldm.plan.Workflow;

import org.cougaar.core.util.XMLizable;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;

import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

public class VishnuExpanderPlugIn extends VishnuPlugIn implements UTILExpanderPlugIn {
  /**
   * Provide the callback that is paired with the buffering thread, which is a
   * listener.  The buffering thread is the listener to the callback
   *
   * @return an ExpandableTaskCallback with the buffering thread as its listener
   * @see org.cougaar.lib.callback.UTILWorkflowCallback
   */
  protected UTILFilterCallback createThreadCallback (UTILGenericListener bufferingThread) { 
    if (myExtraOutput)
      System.out.println (getName () + " : Filtering for Expandable Tasks...");

    myInputTaskCallback = new UTILExpandableTaskCallback (bufferingThread);  
    myInputTaskCallback.setExtraDebug (myExtraExtraOutput);
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
    publishAdd (UTILExpand.makeFailedExpansion (null, ldmf, t));
  }

  /**
   * create the expansion callback
   */
  protected UTILFilterCallback createExpansionCallback () { 
    if (myExtraOutput)
      System.out.println (getName () + " : Filtering for Expansions...");
        
    return new UTILExpansionCallback (this); 
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
   * @param expansion that failed
   * @param list of Constraints that have been violated
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
   * @param expansion to check
   * @return true if plugin wants to change expansion
   */
  public boolean wantToChangeExpansion(Expansion exp) {
    return false;
  }

  /**
   * The plugin changes the expansion.
   *
   * Default does nothing.
   *
   * @see wantToChangeExpansion
   * @param expansion to change
   */
  public void changeExpansion(Expansion exp) {}

  /**
   * publish the change
   *
   * @see wantToChangeExpansion
   * @param expansion to change
   */
  public void publishChangedExpansion(Expansion exp) {
    publishChange (exp);
  }

  /**
   * Report to superior that the expansion has changed.  Includes a pass
   * through to the UTILPlugInAdapter's updateAllocationResult.
   * Updates and publishes allocation result of expansion.
   *
   * @param exp Expansion that has changed.
   * @see UTILPlugInAdapter#updateAllocationResult
   */
  public void reportChangedExpansion(Expansion exp) { 
      if (myExtraExtraOutput)
	  System.out.println (getName () + 
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
      if (myExtraOutput)
	  System.out.println (getName () + 
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
      if (myExtraOutput)
	  System.out.println (getName () + 
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
   * if no asset could be found to handle the task, handle them in some way -
   * Tasks that did not get expanded become failed expansions.
   *
   * debugging may come on automatically
   */
  public void handleImpossibleTasks (List unallocatedTasks) {
    super.handleImpossibleTasks (unallocatedTasks);
  }

  public void handleAssignment (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
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

  public void handleRemovedTask(Task t) {}

  /**
   * Implemented for UTILExpanderPlugIn interface
   *
   * The guts of the expansion.
   *
   * Default does nothing!  Subclass should override.
   */
  public Vector getSubtasks(Task t) { 
    System.out.println (getName () + 
			" : WARNING - getSubtasks should be overriden." +
			" Default does nothing.");
    return new Vector (); 
  }

  protected UTILExpandableTaskCallback myInputTaskCallback;
}
