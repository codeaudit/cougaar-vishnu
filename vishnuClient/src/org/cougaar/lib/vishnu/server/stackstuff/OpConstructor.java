// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpConstructor.java,v 1.1 2001-08-15 18:21:52 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operators INTERVAL, XY_COORD, and LATLONG
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpConstructor extends Operator {

  private int op;

  public OpConstructor (int op) {
    this.op = op;
  }

  public String getName() {
    switch (op) {
      case ExecutionStack.INTERVAL: return "interval";
      case ExecutionStack.XY_COORD: return "xy_coord";
      case ExecutionStack.LATLONG: return "latlong";
    }
    return "";
  }

  protected int numArgs() {
    return (op == ExecutionStack.INTERVAL) ? -1 : 2;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public String getResultType() {
    return getName();
  }

  protected boolean opArgTypesLegal() {
    if (op == ExecutionStack.INTERVAL)
      return ((argTypes.length >= 2) &&
              argTypes[0].equals ("datetime") &&
              argTypes[1].equals ("datetime") &&
              ((argTypes.length < 3) || argTypes[2].equals ("string")) &&
              ((argTypes.length < 4) || argTypes[3].equals ("string")));
    else
      return (argTypes[0].equals ("number") &&
              argTypes[1].equals ("number"));
  }

  public void addToStack (ExecutionStack stack) {
    args[1].addToStack (stack);
    stack.addCommand (ExecutionStack.PUSH, null, -1);
    if (args.length > 2) {
      args[2].addToStack (stack);
      stack.addCommand (ExecutionStack.PUSH, null, -1);
    }
    if (args.length > 3) {
      args[3].addToStack (stack);
      stack.addCommand (ExecutionStack.PUSH, null, -1);
    }
    args[0].addToStack (stack);
    stack.addCommand (op, null, args.length - 1);
  }

}
