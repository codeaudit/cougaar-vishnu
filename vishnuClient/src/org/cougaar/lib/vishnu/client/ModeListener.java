package org.cougaar.lib.vishnu.client;

import java.util.Collection;

public interface ModeListener {
  // task stuff
  Collection getTasks ();
  int getNumTasks ();

  // asset stuff
  Collection getChangedAssets ();
  void clearChangedAssets ();

  // misc
  String getName ();
}
