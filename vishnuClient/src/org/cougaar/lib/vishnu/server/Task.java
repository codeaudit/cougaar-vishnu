// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Task.java,v 1.5 2001-06-11 21:07:12 gvidaver Exp $

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
  private SchedulingSpecs specs;
  
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
   * <pre>
   * If there is no groupable spec, a task is promiscuously groupable 
   * with any other task.
   * 
   * Since groupable is transitive, we only check this task
   * against the first of the other tasks in the group.
   *
   * </pre>
   * @param tasks group to check
   * @return true if it's OK to group this task with the first task of <code>tasks</code>
   **/
  public boolean groupableWith (Task[] tasks) {
	if (groupable)
	  return true;
	
	Task task2 = tasks[0];
	  
	if (groupableTasks.contains (task2))
	  return true;

	if (specs.areGroupable (this, task2) &&
		specs.areGroupable (task2, this)) {
	  groupableTasks.add (task2);
	  return true;
	}

	return false;
  }

  /** 
   * called from SchedulingData.computeGroupings <p>
   * sets reference used in groupableWith
   *
   * @see SchedulingData#computeGroupings
   * @see #groupableWith 
   */
  public void setSpecs (SchedulingSpecs specs) {
	this.specs = specs;
  }
  
  public String toString () {
    return "Task #" + myNum + " : " + super.toString ();
  }
}
