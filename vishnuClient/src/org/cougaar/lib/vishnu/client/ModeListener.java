/*
 * <copyright>
 *  Copyright 2003 BBNT Solutions, LLC
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
