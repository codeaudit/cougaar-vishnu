// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/MultitaskAssignment.java,v 1.4 2001-08-06 15:23:29 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Assignment of multiple tasks to a single resource for a period of time
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class MultitaskAssignment extends Assignment {

  private Task[] tasks;
  private Resource resource;
  private float[] capacities;

  public MultitaskAssignment (Task[] tasks, Resource resource,
                              float[] capacities, int startTime,
                              int taskStartTime, int taskEndTime,
                              int endTime, TimeOps timeOps) {
    super ((tasks.length > 0) ? tasks[0] : null, resource,
           startTime, taskStartTime, taskEndTime, endTime, false, timeOps);
    this.tasks = tasks;
    this.resource = resource;
    this.capacities = capacities;
  }

  public Task[] getTasks() { return tasks; }
  public Resource getResource() { return resource; }
  public float[] getCapacities() { return capacities; }

  public void addTask (Task task) {
    Task[] tasks2 = new Task [tasks.length + 1];
    System.arraycopy (tasks, 0, tasks2, 0, tasks.length);
    tasks2 [tasks.length] = task;
    tasks = tasks2;
    float[] contribs = task.getCapacityContribs();
    if (contribs.length != capacities.length) {
      System.out.println ("Not same number of capacity thresholds " +
                          "as capacity contributions");
    } else {
      float[] caps = new float [capacities.length];
      for (int j = 0; j < caps.length; j++)
        caps[j] = capacities[j] + contribs[j];
      capacities = caps;
    }
  }

  public void setStartTime (int startTime) {
    if (startTime != getStartTime()) {
      super.setStartTime (startTime);
      for (int i = 0; i < tasks.length; i++)
        tasks[i].getAssignment().setStartTime (startTime);
    }
  }

  public void setEndTime (int endTime) {
    if (endTime != getEndTime()) {
      super.setEndTime (endTime);
      for (int i = 0; i < tasks.length; i++)
        tasks[i].getAssignment().setEndTime (endTime);
    }
  }

  public boolean enoughCapacity (float[] contribs) {
    if (contribs.length != capacities.length) {
      System.out.println ("Not same number of capacity thresholds " +
                          "as capacity contributions");
      return true;
    }
    for (int i = 0; i < contribs.length; i++) {
      if (capacities[i] + contribs[i] > resource.getCapacities()[i])
        return false;
    }
    return true;
  }

  public String toString() {
    String str = "<MULTITASK " + attributesString() + ">\n";
    for (int i = 0; i < tasks.length; i++)
      str = str + "<TASK task=\"" + tasks[i].getKey() + "\"/>\n";
    str = str + "</MULTITASK>\n";
    return str;
  }

  public String attributesString() {
    return ("capacities_used=\"" + arrayToString (capacities) +
            "\" capacities=\"" + arrayToString (resource.getCapacities()) +
            "\" " + super.attributesString());
  }

  private String arrayToString (float[] arr) {
    String str = "";
    for (int i = 0; i < arr.length; i++)
      str = str + ((i == 0) ? "" : "*%*") + arr[i];
    return str;
  }

}
