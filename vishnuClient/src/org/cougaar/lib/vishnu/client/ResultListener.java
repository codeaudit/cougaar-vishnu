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
import java.util.Date;
import java.util.Vector;

import org.cougaar.util.StringKey;
import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.asset.Asset;

/** 
 * What the plugin must do to handle scheduler results  <p>
 *
 * @see ResultHandler
 **/
public interface ResultListener {
  // task stuff
  /** 
   * Used to look up Cougaar task when result returned by Vishnu 
   */ 
  Task getTaskForKey (StringKey key);
  /** tells the plugin to remove the task from its list of tasks sent to Vishnu scheduler */
  void removeTask (StringKey key);

  // asset stuff
  /** get the total number of assets */
  int getNumAssets ();
  /** get the Cougaar asset with UID key <tt>key</tt> */
  Asset getAssetForKey (StringKey key);
  /** which assets were changed since they were added as new assets? */
  Collection getChangedAssets ();

  /** 
   * Called for each Vishnu assignment that needs to be translated into a Cougaar plan element 
   * This is for one-to-one assignments : allocations
   */
  void handleAssignment (org.cougaar.planning.ldm.plan.Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd, String contribs, String taskText);

  /**
   * Called for each Vishnu assignment that needs to be translated into a Cougaar plan element 
   * This is for many-to-one assignments : aggregations.
   */
  void handleMultiAssignment (Vector tasks, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd, boolean assetWasUsedBefore);

  // misc
  /** get the name of the listener */
  String getName ();
}
