package org.cougaar.lib.vishnu.client;

import java.util.Date;
import java.util.Vector;

import org.cougaar.util.StringKey;
import org.cougaar.domain.planning.ldm.plan.Task;
import org.cougaar.domain.planning.ldm.asset.Asset;

public interface ResultListener extends ModeListener {
  // task stuff
  void clearTasks ();
  Task getTaskForKey (StringKey key);
  void removeTask (StringKey key);

  // asset stuff
  int getNumAssets ();
  Asset getAssetForKey (StringKey key);

  void handleAssignment (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd);
  void handleMultiAssignment (Vector tasks, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd);

  // misc
  String getName ();
}
