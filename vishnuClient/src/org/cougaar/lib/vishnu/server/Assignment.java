// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Assignment.java,v 1.8 2001-09-07 18:39:14 dmontana Exp $

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
  private String setupColor = null;
  private String wrapupColor = null;

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

  public void setResource (Resource r) { resource = r; }
  public void setSetupColor (String c) { setupColor = c; }
  public void setWrapupColor (String c) { wrapupColor = c; }

  public String toString() {
    return ("<ASSIGNMENT task=\"" + task.getKey() + "\" " +
            attributesString() +
            " frozen=\"" + (frozen ? "yes" : "no") + "\" />");
  }

  public String attributesString() {
    StringBuffer text = new StringBuffer (200);
    text.append("resource=\"").append(resource.getKey()).append
      ("\" setup=\"").append(timeOps.timeToString (getStartTime())).append
      ("\" start=\"").append(timeOps.timeToString (getTaskStartTime())).append
      ("\" end=\"").append(timeOps.timeToString (getTaskEndTime())).append
      ("\" wrapup=\"").append(timeOps.timeToString (getEndTime())).append
      ("\" ").append
      (((setupColor == null) ? "" :
       ("setupcolor=\"" + setupColor + "\" "))).append
      (((wrapupColor == null) ? "" :
       ("wrapupcolor=\"" + wrapupColor + "\" "))).append
      (displayAttributes());
    return new String (text);
  }
}
