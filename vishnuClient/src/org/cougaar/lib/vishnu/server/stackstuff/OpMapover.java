// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpMapover.java,v 1.1 2001-08-15 18:21:53 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operator MAPOVER
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpMapover extends Operator {

  public String getName() {
    return "mapover";
  }

  protected int numArgs() {
    return 3;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public int variableUsed() {
    return 2;
  }

  public String getResultType() {
    return isList (argTypes[2]) ? argTypes[2] : ("list:" + argTypes[2]);
  }

  protected boolean opArgTypesLegal() {
    return (isList (argTypes[0]) &&
            argTypes[1].equals ("string"));
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    int start = stack.currentSize() + 2;
    int end = start + args[2].numStackCommands() + 3;
    stack.addCommand (ExecutionStack.JUMPNULL, null, end);
    stack.addCommand (ExecutionStack.ITER_INIT, null, -1);
    stack.addCommand (ExecutionStack.NEW_LIST, null, -1);
    stack.addCommand (ExecutionStack.ITER_START,
                      ((Literal) args[1]).getCachedObject(), end);
    args[2].addToStack (stack);
    stack.addCommand (ExecutionStack.ADD_TO_LIST, null, -1);
    stack.addCommand (ExecutionStack.JUMP, null, start);
  }

}
