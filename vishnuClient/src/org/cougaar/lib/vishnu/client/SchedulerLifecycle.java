package org.cougaar.lib.vishnu.client;

import java.util.Enumeration;
import java.util.List;
import org.w3c.dom.Document;

/**
 * Defines the lifecycle of a Scheduler Mode, one of External, Internal, or Direct. 
 * <p>
 * A mode has to deal with four basic steps (setup, initialize, prepare data, run).
 * <p>
 * It also has to deal with removed tasks, since the scheduler may have state associated
 * with past tasks.
 */
public interface SchedulerLifecycle {
  /** create scheduler, if needed */
  void setupScheduler ();
  /** tell Scheduler about the problem format */
  void initializeWithFormat ();
  /** tell Scheduler about tasks and assets to use */
  void prepareData (List stuffToSend, Document objectFormatDoc);
  /** run Scheduler, parse assignments, call ResultListener methods to create plan elements */
  void run ();

  /** tell Scheduler about tasks that have been rescinded */
  void handleRemovedTasks (Enumeration tasks);
}
