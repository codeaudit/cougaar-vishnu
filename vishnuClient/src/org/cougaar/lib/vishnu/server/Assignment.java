// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Assignment.java,v 1.3 2001-04-12 17:50:30 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Assignment of a single task to a single resource
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class Assignment extends TimeBlock {

  private Task task;
  private Resource resource;
  private int taskEndTime;
  private int taskStartTime;
  private boolean frozen = false;

  public Assignment (Task task, Resource resource, int startTime,
                     int taskStartTime, int taskEndTime, int endTime,
                     boolean frozen, TimeOps timeOps) {
    super (startTime, endTime, timeOps);
    this.task = task;
    this.resource = resource;
    this.taskStartTime = taskStartTime;
    this.taskEndTime = taskEndTime;
    this.frozen = frozen;
  }

  public Task getTask() { return task; }
  public Resource getResource() { return resource; }
  public int getTaskStartTime() { return taskStartTime; }
  public int getTaskEndTime() { return taskEndTime; }
  public boolean getFrozen() { return frozen; }

  public String toString() {
    return ("<ASSIGNMENT " + attributesString() + " />");
  }

  public String attributesString() {
    return ("task=\"" + task.getKey()
            + "\" resource=\"" + resource.getKey()
            + "\" taskstart=\"" + timeOps.timeToString (getTaskStartTime())
            + "\" taskend=\"" + timeOps.timeToString (getTaskEndTime())
            + "\" frozen=\"" + (frozen ? "yes" : "no")
            + "\" " + super.attributesString());
  }
}
