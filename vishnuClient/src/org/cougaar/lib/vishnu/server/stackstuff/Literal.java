// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/Literal.java,v 1.1 2001-08-15 18:21:51 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.HashMap;
import java.util.Map;

/**
 * A literal is either a constant or a variable.  Literals are the
 * leaves of the parse trees of formulas/expressions.
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class Literal extends ResultProducer {

  private String value;
  private boolean constant;
  private String datatype;
  private Object cachedObject = null;
  private static boolean debug = 
    ("true".equals (System.getProperty ("vishnu.debugLiteral")));

  public Literal (String value, String type,
                  String datatype, TimeOps timeOps) {
    this.value = value;
    constant = type.equals ("constant");
    this.datatype = datatype;
    if (constant) {
      if (datatype.equals ("string"))
        cachedObject = value;
      else if (datatype.equals ("number"))
        cachedObject = new Reusable.RFloat (Float.parseFloat (value));
      else if (datatype.equals ("boolean"))
        cachedObject = Boolean.valueOf (value);
      else if (datatype.equals ("datetime"))
        cachedObject =
          new Reusable.RInteger (timeOps.stringToTime (value));
    }
  }

  public void addToStack (ExecutionStack stack) {
    stack.addCommand (constant ? ExecutionStack.CONSTANT :
                      ExecutionStack.VARIABLE, 
                      constant ? cachedObject : value,
                      -1);
  }

  public Object getCachedObject() {
    return cachedObject;
  }

  public String getResultType() {
    return datatype;
  }

  public String toString () {
    return "Literal : " + datatype +
           ((cachedObject == null) ? "" : " " + cachedObject);
  }

  public String toXML() {
    return ("<LITERAL value=\"" + value + "\" type=\"" +
            (constant ? "constant" : "variable") +
            "\" datatype=\"" + datatype + "\" />\n");
  }

  public boolean containsVariable (String name) {
    return (! constant) && (name.equals (value));
  }

}
