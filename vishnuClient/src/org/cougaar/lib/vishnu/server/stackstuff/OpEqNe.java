// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpEqNe.java,v 1.1 2001-08-15 18:21:53 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operators EQ and NE
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpEqNe extends Operator {

  private boolean isEq;

  public OpEqNe (boolean isEq) {
    this.isEq = isEq;
  }

  public String getName() {
    return isEq ? "=" : "!=";
  }

  protected int numArgs() {
    return 2;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public String getResultType() {
    return "boolean";
  }

  protected boolean opArgTypesLegal() {
    return argTypes[0].equals (argTypes[1]);
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    stack.addCommand (ExecutionStack.PUSH, null, -1);
    args[1].addToStack (stack);
    stack.addCommand (isEq ? ExecutionStack.EQ : ExecutionStack.NE, null, -1);
  }

}
