// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpAndOr.java,v 1.1 2001-08-15 18:21:52 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operators AND and OR
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpAndOr extends Operator {

  private boolean isAnd;

  public OpAndOr (boolean isAnd) {
    this.isAnd = isAnd;
  }

  public String getName() {
    return isAnd ? "and" : "or";
  }

  protected int numArgs() {
    return -1;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public String getResultType() {
    return "boolean";
  }

  protected boolean opArgTypesLegal() {
    if (args.length == 0)
      return false;
    for (int i = 0; i < argTypes.length; i++)
      if (! argTypes[i].equals ("boolean"))
        return false;
    return true;
  }

  public void addToStack (ExecutionStack stack) {
    int jumpPoint = stack.currentSize() - 2;
    for (int i = 0; i < args.length; i++)
      jumpPoint += args[i].numStackCommands() + 1;
    for (int i = 0; i < args.length; i++) {
      args[i].addToStack (stack);
      if (i != args.length - 1)
        stack.addCommand (isAnd ? ExecutionStack.JUMPIFNOT :
                          ExecutionStack.JUMPIF, null, jumpPoint);
    }
  }

}
