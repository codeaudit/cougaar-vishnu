package org.cougaar.lib.vishnu.client;

import java.util.Collection;
import java.util.Date;
import java.util.Vector;

import org.cougaar.util.StringKey;
import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.asset.Asset;

/** What the plugin must do to handle scheduler results */
public interface ResultListener {
  // task stuff
  /** 
   * Used to look up Cougaar task when result returned by Vishnu 
   */ 
  Task getTaskForKey (StringKey key);
  void removeTask (StringKey key);

  // asset stuff
  int getNumAssets ();
  Asset getAssetForKey (StringKey key);
  /** which assets were changed since they were added as new assets? */
  Collection getChangedAssets ();

  /** 
   * Called for each Vishnu assignment that needs to be translated into a Cougaar plan element 
   * This is for one-to-one assignments : allocations
   */
  void handleAssignment (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd);

  /**
   * Called for each Vishnu assignment that needs to be translated into a Cougaar plan element 
   * This is for many-to-one assignments : aggregations.
   */
  void handleMultiAssignment (Vector tasks, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd);

  // misc
  String getName ();
}
