// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpNot.java,v 1.1 2001-08-15 18:21:54 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operator NOT
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpNot extends Operator {

  public String getName() {
    return "not";
  }

  protected int numArgs() {
    return 1;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public String getResultType() {
    return "boolean";
  }

  protected boolean opArgTypesLegal() {
    return argTypes[0].equals ("boolean");
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    stack.addCommand (ExecutionStack.NOT, null, -1);
  }

}
