// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OpDistance.java,v 1.1 2001-08-15 18:21:52 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * The operator DIST
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OpDistance extends Operator {

  public String getName() {
    return "dist";
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
    return ((argTypes[0].equals ("latlong") &&
             argTypes[1].equals ("latlong")) ||
            (argTypes[0].equals ("xy_coord") &&
             argTypes[1].equals ("xy_coord")));
  }

  public void addToStack (ExecutionStack stack) {
    args[0].addToStack (stack);
    stack.addCommand (ExecutionStack.PUSH, null, -1);
    args[1].addToStack (stack);
    stack.addCommand (argTypes[0].equals("latlong") ?
                      ExecutionStack.DIST_LL : ExecutionStack.DIST_XY,
                      null, -1);
  }

}
