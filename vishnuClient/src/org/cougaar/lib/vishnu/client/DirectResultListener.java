package org.cougaar.lib.vishnu.client;

import java.util.Collection;

import java.util.List;
import org.w3c.dom.Document;

import org.cougaar.lib.vishnu.server.TimeOps;

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
				    Document objectFormat, TimeOps timeOps);

}
