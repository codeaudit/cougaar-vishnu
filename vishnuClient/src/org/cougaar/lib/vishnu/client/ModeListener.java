package org.cougaar.lib.vishnu.client;

import java.util.Collection;

/** 
 * What a plugin must do for a SchedulerLifecycle mode. 
 * 
 * The lifecycle must know what tasks are required to schedule,
 * which assets are available to use to handle those tasks, 
 * and if the assets change.
 *
 * @see SchedulerLifecycle
 */
public interface ModeListener {
  // task stuff
  /** 
   * Contains both tasks and assets, initially, and after that only 
   * has assets if new assets arrive in the cluster 
   */
  Collection getTasks ();
  /** number of tasks */
  int getNumTasks ();

  // asset stuff
  /** which assets were changed since they were added as new assets? */
  Collection getChangedAssets ();
  /** after the scheduler is informed of the changed assets, forget about them */
  void clearChangedAssets ();

  // misc
  String getName ();
}
