// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpComp.java,v 1.1 2001-08-15 18:21:52 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operators LT, LE, GT, and GE
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpComp extends Operator {

  public final static int LT = 0;
  public final static int LE = 1;
  public final static int GT = 2;
  public final static int GE = 3;

  private int op;

  public OpComp (int op) {
    this.op = op;
  }

  public String getName() {
    switch (op) {
      case LT: return "<";
      case GT: return ">";
      case LE: return "<=";
      case GE: return ">=";
    }
    return "Unknown comparison operator " + op;
  }

  public String getXMLName() {
    switch (op) {
      case LT: return "&lt;";
      case GT: return "&gt;";
      case LE: return "&lt;=";
      case GE: return "&gt;=";
    }
    return super.getXMLName();
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
    return ((argTypes[0].equals ("number") &&
             argTypes[1].equals ("number")) ||
            (argTypes[0].equals ("datetime") &&
             argTypes[1].equals ("datetime")));
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    stack.addCommand (ExecutionStack.PUSH, null, -1);
    args[1].addToStack (stack);
    if ((op == LT) && (argTypes[0].equals ("number")))
      stack.addCommand (ExecutionStack.LT_FLT, null, -1);
    if ((op == LE) && (argTypes[0].equals ("number")))
      stack.addCommand (ExecutionStack.LE_FLT, null, -1);
    if ((op == GT) && (argTypes[0].equals ("number")))
      stack.addCommand (ExecutionStack.GT_FLT, null, -1);
    if ((op == GE) && (argTypes[0].equals ("number")))
      stack.addCommand (ExecutionStack.GE_FLT, null, -1);
    if ((op == LT) && (argTypes[0].equals ("datetime")))
      stack.addCommand (ExecutionStack.LT_INT, null, -1);
    if ((op == LE) && (argTypes[0].equals ("datetime")))
      stack.addCommand (ExecutionStack.LE_INT, null, -1);
    if ((op == GT) && (argTypes[0].equals ("datetime")))
      stack.addCommand (ExecutionStack.GT_INT, null, -1);
    if ((op == GE) && (argTypes[0].equals ("datetime")))
      stack.addCommand (ExecutionStack.GE_INT, null, -1);
  }

}
