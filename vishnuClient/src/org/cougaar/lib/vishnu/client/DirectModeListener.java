package org.cougaar.lib.vishnu.client;

import java.util.Collection;

import java.util.List;
import org.w3c.dom.Document;

import com.bbn.vishnu.objects.SchedulingData;

/** defines what a plugin has to do to deal with Scheduler results when running in direct mode */
public interface DirectModeListener extends ModeListener {
  public void prepareVishnuObjects (List tasksAndResources, Collection changedAsssets,
				    List vishnuTasks, List vishnuResources, List changedVishnuResources,
				    Document objectFormat, SchedulingData schedData);
}
