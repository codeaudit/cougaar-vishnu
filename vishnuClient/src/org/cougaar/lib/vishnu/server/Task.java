// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Task.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

import java.util.HashSet;

/**
 * A task object
 *
 * Copyright (C) 2000 BBN Technologies
 */

public class Task extends SchObject {

  private Assignment assignment = null;
  private float[] capacityContribs;
  private Task[] prerequisites;
  private HashSet groupableTasks = new HashSet();
  private static int num = 0;
  private int myNum = 0;

  public Task (TimeOps timeOps) {
    super (timeOps);
    myNum = ++num;
  }

  public Assignment getAssignment()  { return assignment; }

  public void setAssignment (Assignment a)  { assignment = a; }

  public float[] getCapacityContribs()  { return capacityContribs; }

  public void setCapacityContribs (float[] contribs) {
    capacityContribs = contribs;
  }

  public Task[] getPrerequisites()  { return prerequisites; }

  public void setPrerequisites (Task[] p)  { prerequisites = p; }

  public void addGroupableTask (Task t)  { groupableTasks.add (t); }

  public boolean isGroupable()  { return groupableTasks.size() > 0; }

  public boolean groupableWith (Task[] tasks) {
    for (int i = 0; i < tasks.length; i++)
      if (! groupableTasks.contains (tasks[i]))
        return false;
    return true;
  }

  public String toString () {
    return "Task #" + myNum + " : " + super.toString ();
  }
}
