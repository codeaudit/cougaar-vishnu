package org.cougaar.lib.vishnu.server;

/** 
 * A little helper class for keeping track of which task can be grouped with which 
 * 
 * Also holds the taskCounter
 **/
public class GroupingInfo {
  protected int taskCounter = 0; // gives each task a unique ID
  private boolean[] groupableTasks = null;
  private boolean[] ungroupableTasks = null;

  public boolean isGroupable (int taskIndex, SchedulingSpecs specs) {
	if (groupableTasks == null)
	  setGroupableArrays (specs);
	else if (groupableTasks.length < taskCounter) 
	  growGroupableArrays (specs);
	
	return groupableTasks[taskIndex];
  }

  public boolean isUngroupable (int taskIndex) {
	return ungroupableTasks[taskIndex];
  }

  public void setGroupable (int taskIndex) {
	groupableTasks[taskIndex] = true;
  }

  public void setUngroupable (int taskIndex) {
	ungroupableTasks[taskIndex] = true;
  }

  public int makeNewTaskID () {
	return taskCounter++;
  }
  
  protected void setGroupableArrays (SchedulingSpecs specs) {
	groupableTasks   = new boolean [taskCounter];
	ungroupableTasks = new boolean [taskCounter];

	if (! specs.hasGroupableSpec())
	  java.util.Arrays.fill (groupableTasks, true);
  }

  protected void growGroupableArrays (SchedulingSpecs specs) {
	boolean [] oldGroupableTasks   = groupableTasks;
	boolean [] oldUngroupableTasks = ungroupableTasks;

	groupableTasks   = new boolean [taskCounter];
	ungroupableTasks = new boolean [taskCounter];
	  
	System.arraycopy (oldGroupableTasks,   0, groupableTasks,   0, oldGroupableTasks.length);
	System.arraycopy (oldUngroupableTasks, 0, ungroupableTasks, 0, oldUngroupableTasks.length);

	if (! specs.hasGroupableSpec())
	  java.util.Arrays.fill (groupableTasks, true);
  }
}
