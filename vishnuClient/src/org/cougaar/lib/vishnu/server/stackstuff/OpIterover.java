// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpIterover.java,v 1.1 2001-08-15 18:21:53 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operators MAXOVER, MINOVER, SUMOVER
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpIterover extends Operator {

  public static final int MAX = -1;
  public static final int MIN = 1;
  public static final int SUM = 0;

  private int op;

  public OpIterover (int op) {
    this.op = op;
  }

  public String getName() {
    switch (op) {
      case MAX: return "maxover";
      case MIN: return "minover";
      case SUM: return "sumover";
    }
    return "";
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
    return argTypes[2];
  }

  protected boolean opArgTypesLegal() {
    if (! (isList (argTypes[0]) &&
           argTypes[1].equals ("string")))
      return false;
    return (op == SUM) ? argTypes[2].equals ("number") :
           (argTypes[2].equals ("number") ||
            argTypes[2].equals ("datetime"));
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    int start = stack.currentSize() + 2;
    int end = start + args[2].numStackCommands() + 5;
    stack.addCommand (ExecutionStack.JUMPNULL, null, end);
    stack.addCommand (ExecutionStack.ITER_INIT, null, -1);
    if (argTypes[2].equals ("number"))
      stack.addCommand (ExecutionStack.NEW_FLT, null, op);
    else
      stack.addCommand (ExecutionStack.NEW_INT, null, op);
    stack.addCommand (ExecutionStack.ITER_START,
                      ((Literal) args[1]).getCachedObject(), end);
    args[2].addToStack (stack);
    stack.addCommand (ExecutionStack.JUMPNULL, null, start);
    if (op == SUM)
      stack.addCommand (ExecutionStack.PLUS_FLT_FLT, null, -1);
    else if ((op == MAX) && argTypes[2].equals ("number"))
      stack.addCommand (ExecutionStack.MAX_FLT, null, -1);
    else if (op == MAX)
      stack.addCommand (ExecutionStack.MAX_INT, null, -1);
    else if ((op == MIN) && argTypes[2].equals ("number"))
      stack.addCommand (ExecutionStack.MIN_FLT, null, -1);
    else if (op == MIN)
      stack.addCommand (ExecutionStack.MIN_INT, null, -1);
    stack.addCommand (ExecutionStack.PUSH, null, -1);
    stack.addCommand (ExecutionStack.JUMP, null, start);
    stack.addCommand (ExecutionStack.CMP_EXTREME, argTypes[2], op);
  }

}
