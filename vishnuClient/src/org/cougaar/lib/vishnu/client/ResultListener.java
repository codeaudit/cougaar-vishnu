/*
 * <copyright>
 *  
 *  Copyright 2003-2004 BBNT Solutions, LLC
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
