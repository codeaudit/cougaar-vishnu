// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpGet.java,v 1.1 2001-08-15 18:21:53 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operator GET
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpGet extends Operator {

  public String getName() {
    return "get";
  }

  protected int numArgs() {
    return 3;
  }

  protected boolean opScheduleDependent() {
    return false;
  }

  public String getResultType() {
    return argTypes[2];
  }

  protected boolean opArgTypesLegal() {
    return true;
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    stack.addCommand (ExecutionStack.GET,
                      ((Literal) args[1]).getCachedObject(),
                      -1);
  }

}
