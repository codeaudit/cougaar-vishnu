// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Task.java,v 1.10 2001-08-15 22:36:55 dmontana Exp $

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
  private Resource.Block frozenBlock = null;
  
  public Task (TimeOps timeOps) {
    super (timeOps);
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

  public String toString () {
    return "Task " + getKey() + " : " + super.toString ();
  }
}
