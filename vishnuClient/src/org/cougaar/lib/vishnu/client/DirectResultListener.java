package org.cougaar.lib.vishnu.client;

import java.util.Collection;

import java.util.List;
import org.w3c.dom.Document;

import org.cougaar.lib.vishnu.server.TimeOps;

public interface DirectResultListener extends ResultListener {
  public void prepareVishnuObjects (List tasksAndResources, Collection changedAsssets,
									List vishnuTasks, List vishnuResources, List changedVishnuResources,
									Document objectFormat, TimeOps timeOps);

}
