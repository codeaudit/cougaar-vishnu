// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Task.java,v 1.7 2001-07-29 21:33:01 gvidaver Exp $

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
  private int myNum = 0;

  private static int num = 0;
  private Object mutex = new Object(); // synchronizes access to num
  
  public Task (TimeOps timeOps) {
    super (timeOps);
	synchronized (mutex) {
	  myNum = ++num;
	}
  }

  public Assignment getAssignment()  { return assignment; }

  public void setAssignment (Assignment a)  { assignment = a; }

  public float[] getCapacityContribs()  { return capacityContribs; }

  public void setCapacityContribs (float[] contribs) {
    capacityContribs = contribs;
  }

  public Task[] getPrerequisites()  { return prerequisites; }

  public void setPrerequisites (Task[] p)  { prerequisites = p; }

  public boolean groupableWith (Task[] tasks, SchedulingSpecs specs) {
    for (int i = 0; i < tasks.length; i++)
      if (! groupableWith (tasks[i], specs))
        return false;
    return true;
  }

  public boolean groupableWith (Task task, SchedulingSpecs specs) {
    if (groupableTasks == null) {
	  synchronized (mutex) {
		groupableTasks = new boolean [num + 1];
		ungroupableTasks = new boolean [num + 1];
	  }
      if (! specs.hasGroupableSpec()) {
        java.util.Arrays.fill (groupableTasks, true);
        return true;
      }
    }
    else {
      if (groupableTasks [task.myNum])
        return true;
      if (ungroupableTasks [task.myNum])
        return false;
    }

    if (specs.areGroupable (this, task) &&
        specs.areGroupable (task, this)) {
      groupableTasks [task.myNum] = true;
      return true;
    }
    else {
      ungroupableTasks [task.myNum] = true;
      return false;
    }
  }

  public String toString () {
    return "Task #" + myNum + " : " + super.toString ();
  }
}
