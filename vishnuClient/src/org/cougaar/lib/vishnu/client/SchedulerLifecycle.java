package org.cougaar.lib.vishnu.client;

import java.util.Enumeration;
import java.util.List;
import org.w3c.dom.Document;

public interface SchedulerLifecycle {
  void setupScheduler ();
  void initializeWithFormat ();
  void handleRemovedTasks (Enumeration tasks);
  void prepareData (List stuffToSend, Document objectFormatDoc);
  void run ();
}
