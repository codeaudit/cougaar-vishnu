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

import com.bbn.vishnu.objects.SchedulingData;

import java.util.Collection;
import java.util.List;

import org.w3c.dom.Document;

/** 
 * Listener to be paired with a DirectResultHandler 
 */
public interface DirectResultListener extends ResultListener {
  /** 
   * The listener must take alp tasks and resources and convert them directly into 
   * Vishnu tasks and resources.
   *
   * @param tasksAndResources - Cougaar tasks and resources to translate
   * @param changedAssets - list of changed Cougaar assets
   * @param vishnuTasks - list to add Vishnu tasks to 
   * @param vishnuResources - list to add Vishnu resources to 
   * @param changedVishnuResources - list of changed Vishnu resources
   * @param timeOps - time object used when making Vishnu dates
   */
  public void prepareVishnuObjects (List tasksAndResources, Collection changedAsssets,
				    List vishnuTasks, List vishnuResources, List changedVishnuResources,
				    Document objectFormat, SchedulingData data);
}
