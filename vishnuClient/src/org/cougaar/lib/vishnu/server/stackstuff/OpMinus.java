// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpMinus.java,v 1.1 2001-08-15 18:21:54 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operators MINUS
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpMinus extends Operator {

  public String getName() {
    return "-";
  }

  protected int numArgs() {
    return 2;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public String getResultType() {
    if (argTypes[0].equals ("number") && argTypes[1].equals ("number"))
      return "number";
    if (argTypes[0].equals ("datetime") && argTypes[1].equals ("datetime"))
      return "number";
    if (argTypes[0].equals ("datetime") && argTypes[1].equals ("number"))
      return "datetime";
    return "";
  }

  protected boolean opArgTypesLegal() {
    return ((argTypes[0].equals ("number") &&
             argTypes[1].equals ("number")) ||
            (argTypes[0].equals ("datetime") &&
             argTypes[1].equals ("datetime")) ||
            (argTypes[0].equals ("datetime") &&
             argTypes[1].equals ("number")));
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    stack.addCommand (ExecutionStack.PUSH, null, -1);
    args[1].addToStack (stack);
    if (argTypes[0].equals ("number"))
      stack.addCommand (ExecutionStack.MINUS_FLT_FLT, null, -1);
    else if (argTypes[1].equals ("number"))
      stack.addCommand (ExecutionStack.MINUS_INT_FLT, null, -1);
    else
      stack.addCommand (ExecutionStack.MINUS_INT_INT, null, -1);
  }

}
