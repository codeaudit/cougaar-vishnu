// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpScheduleDependent.java,v 1.1 2001-08-15 18:21:54 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operators that take a single resource or task as an argument
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpScheduleDependent extends Operator {

  private int op;

  public OpScheduleDependent (int op) {
    this.op = op;
  }

  public String getName() {
    switch (op) {
      case ExecutionStack.PREPTIME: return "preptime";
      case ExecutionStack.BUSYTIME: return "busytime";
      case ExecutionStack.COMPLETE: return "complete";
      case ExecutionStack.TASKSFOR: return "tasksfor";
      case ExecutionStack.RESOURCEFOR: return "resourcefor";
      case ExecutionStack.TASKSTARTTIME: return "taskstarttime";
      case ExecutionStack.TASKENDTIME: return "taskendtime";
      case ExecutionStack.TASKSETUPTIME: return "tasksetuptime";
      case ExecutionStack.TASKWRAPUPTIME: return "taskwrapuptime";
      case ExecutionStack.GROUPFOR: return "groupfor";
    }
    return "";
  }

  protected int numArgs() {
    return 1;
  }

  protected boolean opScheduleDependent() {
    return true;
  }

  public String getResultType() {
    switch (op) {
      case ExecutionStack.PREPTIME: return "number";
      case ExecutionStack.BUSYTIME: return "number";
      case ExecutionStack.COMPLETE: return "datetime";
      case ExecutionStack.TASKSFOR: return "list:task";
      case ExecutionStack.RESOURCEFOR: return "resource";
      case ExecutionStack.TASKSTARTTIME: return "datetime";
      case ExecutionStack.TASKENDTIME: return "datetime";
      case ExecutionStack.TASKSETUPTIME: return "datetime";
      case ExecutionStack.TASKWRAPUPTIME: return "datetime";
      case ExecutionStack.GROUPFOR: return "list:task";
    }
    return "";
  }

  protected boolean opArgTypesLegal() {
    switch (op) {
      case ExecutionStack.PREPTIME:
      case ExecutionStack.BUSYTIME:
      case ExecutionStack.COMPLETE:
      case ExecutionStack.TASKSFOR:
        return argTypes[0].equals ("resource");
      case ExecutionStack.RESOURCEFOR:
      case ExecutionStack.TASKSTARTTIME:
      case ExecutionStack.TASKENDTIME:
      case ExecutionStack.TASKSETUPTIME:
      case ExecutionStack.TASKWRAPUPTIME:
      case ExecutionStack.GROUPFOR:
        return argTypes[0].equals ("task");
    }
    return false;
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    stack.addCommand (op, null, -1);
  }

}
