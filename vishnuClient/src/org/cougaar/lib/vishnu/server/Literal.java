// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Literal.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

import java.util.HashMap;
import java.util.Map;

/**
 * A literal is either a constant or a variable.  Literals are the
 * leaves of the parse trees of formulas/expressions.
 *
 * Copyright (C) 2000 BBN Technologies
 */

public class Literal implements ResultProducer {

  private String value;
  private boolean constant;
  private String datatype;
  private Object cachedObject = null;
  private static boolean debug = 
    ("true".equals (System.getProperty ("org.cougaar.lib.vishnu.server.debugLiteral")));

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

  public Object getResult (Map data) {
    if (debug) {
      Object result = constant ? cachedObject : data.get (value);
      System.out.println ("Literal.getResult - value " + value + 
			  " => " + result);
      if (result == null)
	System.out.println ("\tnull, but hash was " + data);
    }

    return constant ? cachedObject : data.get (value);
  }

  public String getResultType() {
    return datatype;
  }

  public String toString () {
    return "Literal : " + datatype + ((cachedObject == null) ? "" : " " + cachedObject);
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
