// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Task.java,v 1.4 2001-05-31 22:32:11 gvidaver Exp $

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
  private HashSet groupableTasks = new HashSet();
  private static int num = 0;
  private int myNum = 0;
  private boolean groupable = false;
  
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

  public void setGroupable (boolean val) {
	groupable = val;
  }
  
  /** 
   * if there is no groupable spec, a task is promiscuously groupable 
   * with any other task.
   **/
  public boolean groupableWith (Task[] tasks) {
	if (groupable)
	  return true;
	
    for (int i = 0; i < tasks.length; i++)
      if (! groupableTasks.contains (tasks[i]))
        return false;
    return true;
  }

  public String toString () {
    return "Task #" + myNum + " : " + super.toString ();
  }
}
