// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpIf.java,v 1.1 2001-08-15 18:21:53 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operator IF
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpIf extends Operator {

  public String getName() {
    return "if";
  }

  protected int numArgs() {
    return -1;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public String getResultType() {
    return argTypes[1];
  }

  protected boolean opArgTypesLegal() {
    return ((argTypes.length >= 2) &&
            argTypes[0].equals ("boolean") &&
            ((argTypes.length == 2) ||
             argTypes[2].equals (argTypes[1])));
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    int pt1 = stack.currentSize() + args[1].numStackCommands() + 2;
    int pt2 = pt1 + args[2].numStackCommands();
    stack.addCommand (ExecutionStack.JUMPNULL, null, pt2);
    stack.addCommand (ExecutionStack.JUMPIFNOT, null, pt1);
    args[1].addToStack (stack);
    stack.addCommand (ExecutionStack.JUMP, null, pt2);
    args[2].addToStack (stack);
  }

}
