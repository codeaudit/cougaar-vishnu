// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpArith.java,v 1.1 2001-08-15 18:21:52 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operators MULT, DIVIDE, MOD
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpArith extends Operator {

  private int op;

  public OpArith (int op) {
    this.op = op;
  }

  public String getName() {
    switch (op) {
      case ExecutionStack.TIMES: return "*";
      case ExecutionStack.DIVIDE: return "/";
      case ExecutionStack.MOD: return "mod";
    }
    return "Unknown arithmetic operator " + op;
  }

  protected int numArgs() {
    return 2;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public String getResultType() {
    return "number";
  }

  protected boolean opArgTypesLegal() {
    return (argTypes[0].equals ("number") &&
            argTypes[1].equals ("number"));
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    stack.addCommand (ExecutionStack.PUSH, null, -1);
    args[1].addToStack (stack);
    stack.addCommand (op, null, -1);
  }

}
