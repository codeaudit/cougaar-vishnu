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
import java.util.Enumeration;
import java.util.List;
import org.w3c.dom.Document;

/**
 * Defines the lifecycle of a Scheduler Mode, one of External, Internal, or Direct. 
 * <p>
 * A mode has to deal with four basic steps (setup, initialize, prepare data, run).
 * <p>
 * It also has to deal with removed tasks, since the scheduler may have state associated
 * with past tasks. <p>
 *
 * Paired with the ModeListener.
 * @see ModeListener
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

  void unfreezeTasks (Collection tasks);
  Collection getTaskKeys ();

  /** queries the scheduler to get a full specification of the problem
   *   (including specs, logic, gaspecs, objects, assignments, etc)
   */
  String dumpToXML();
}
