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
