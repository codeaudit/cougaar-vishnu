// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Task.java,v 1.9 2001-08-15 18:21:49 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.HashSet;

/**
 * A task object
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class Task extends SchObject {

  private Assignment assignment = null;
  private float[] capacityContribs;
  private Task[] prerequisites;
  private boolean[] groupableTasks = null;
  private boolean[] ungroupableTasks = null;
  private int myNum;
  protected GroupingInfo groupingInfo;
  private Resource.Block frozenBlock = null;
  
  public Task (TimeOps timeOps, GroupingInfo groupingInfo) {
    super (timeOps);
	this.groupingInfo = groupingInfo;
	myNum = groupingInfo.taskCounter++;
  }

  public final Assignment getAssignment()  { return assignment; }

  public final void setAssignment (Assignment a)  { assignment = a; }

  public final Resource.Block getFrozenBlock()  { return frozenBlock; }

  public final void setFrozenBlock (Resource.Block fb)  { frozenBlock = fb; }

  public final float[] getCapacityContribs()  { return capacityContribs; }

  public final void setCapacityContribs (float[] contribs) {
    capacityContribs = contribs;
  }

  public final Task[] getPrerequisites()  { return prerequisites; }

  public final void setPrerequisites (Task[] p)  { prerequisites = p; }

  public boolean groupableWith (Task[] tasks, SchedulingSpecs specs) {
    for (int i = 0; i < tasks.length; i++)
      if (! groupableWith (tasks[i], specs))
        return false;
    return true;
  }

  public boolean groupableWith (Task task, SchedulingSpecs specs) {
    try {
      return groupingInfo.isGroupable(task.myNum, specs);
    } catch (Exception e) {
      System.out.println ("groupableTasks length = " +
                          groupableTasks.length + " task num " + task.myNum);
    }
	
    if (groupingInfo.isUngroupable (task.myNum))
      return false;

    if (specs.areGroupable (this, task) &&
        specs.areGroupable (task, this)) {
      groupingInfo.setGroupable (task.myNum);
      return true;
    }
    else {
      groupingInfo.setUngroupable (task.myNum);
      return false;
    }
  }

  public String toString () {
    return "Task #" + myNum + " : " + super.toString ();
  }
}
