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
  /** e.g. Transport, Supply */
  String getTaskName();

  // asset stuff
  /** which assets were changed since they were added as new assets? */
  Collection getChangedAssets ();
  /** after the scheduler is informed of the changed assets, forget about them */
  void clearChangedAssets ();

  // misc
  String getName ();
}
