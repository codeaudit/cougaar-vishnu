// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/ExpressionCompiler.java,v 1.2 2001-01-25 20:49:38 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

/**
 * The process that reads compilation requests from the web server
 * and writes back the XML corresponding to the expression
 *
 * Copyright (C) 2000 BBN Technologies
 */

public class ExpressionCompiler {

  private String problem = null;
  private String expression = null;
  private String spec = null;
  private Map variables = null;
  private String taskObject = null;
  private String resourceObject = null;
  private Map objectStructures = null;
  private Map objectGlobalPtrs = null;
  private long waitInterval = 5000;

  private static boolean php4 = 
    ("true".equals (System.getProperty ("org.cougaar.lib.vishnu.server.Scheduler.php4")));
  private static String PHP_SUFFIX = ".php";

  // need to receive data structure defs, variable names/types, and
  // expected return type to check validity, plus name of problem
  // and name of field in constraints where to put it when done

  private void run() {
    ClientComms.initialize();
    while (true) {
      boolean success = getProblem() == null;
      if ((! success) || (problem == null))
        try { Thread.sleep (waitInterval); } catch (Exception e) {}
      else {
        System.out.println ("prob = " + problem + " exp = " + expression);
        if (expression.trim().length() == 0)
          writeResult ("NULL");
        else
          writeResult (doCompile (expression, getLegalTypes ()).toXML());
        problem = null;
      }
    }
  }

  private Exception getProblem() {
    return ClientComms.readXML (ClientComms.defaultArgs(),
                                "compilerrequest" + PHP_SUFFIX,
                                new RequestHandler());
  }

  private void writeResult (String result) {
    Map args = ClientComms.defaultArgs();
    args.put ("problem", problem);
    args.put ("spec", spec);
    args.put ("result", result);
    System.out.println ("res = " + result);
    ClientComms.postToURL (args, "postcompilerresult"  + PHP_SUFFIX);
  }

  private String[] getLegalTypes () {
    if (spec.equals ("capability"))
      return new String[] {"boolean"};
    else if (spec.equals ("opt_criterion"))
      return new String[] {"number"};
    else if (spec.equals ("delta_criterion"))
      return new String[] {"number"};
    else if (spec.equals ("best_time"))
      return new String[] {"datetime"};
    else if (spec.equals ("task_duration"))
      return new String[] {"number"};
    else if (spec.equals ("setup_duration"))
      return new String[] {"number"};
    else if (spec.equals ("wrapup_duration"))
      return new String[] {"number"};
    else if (spec.equals ("prerequisites"))
      return new String[] {"list:string"};
    else if (spec.equals ("task_unavail"))
      return new String[] {"list:interval"};
    else if (spec.equals ("resource_unavail"))
      return new String[] {"list:interval"};
    else if (spec.equals ("capacity_contrib"))
      return new String[] {"number", "list:number"};
    else if (spec.equals ("capacity_thresh"))
      return new String[] {"number", "list:number"};
    else if (spec.equals ("groupable"))
      return new String[] {"boolean"};
    else if (spec.equals ("linked"))
      return new String[] {"boolean"};
    else if (spec.equals ("link_time_diff"))
      return new String[] {"number"};
    else if (spec.equals ("task_text") ||
             spec.equals ("grouped_text") ||
             spec.equals ("activity_text"))
      return new String[] {"string", "number", "boolean"};
    else if (spec.equals ("task_color") ||
             spec.equals ("grouped_color") ||
             spec.equals ("activity_color"))
      return new String[] {"boolean"};
    else {
      System.out.println ("Spec type " + spec + " not currently handled");
      return new String[0];
    }
  }

  private void addVariablesForSpec () {
    variables.put ("start_time", "datetime");
    variables.put ("end_time", "datetime");
    variables.put ("tasks", "list:task");
    variables.put ("resources", "list:resource");
    if (spec.equals ("capability")) {
      variables.put ("task", "task");
      variables.put ("resource", "resource");
    }
    else if (spec.equals ("opt_criterion")) {
    }
    else if (spec.equals ("delta_criterion")) {
      variables.put ("task", "task");
      variables.put ("resource", "resource");
    }
    else if (spec.equals ("best_time")) {
      variables.put ("task", "task");
      variables.put ("resource", "resource");
    }
    else if (spec.equals ("task_duration")) {
      variables.put ("task", "task");
      variables.put ("resource", "resource");
    }
    else if (spec.equals ("setup_duration")) {
      variables.put ("task", "task");
      variables.put ("previous", "task");
      variables.put ("resource", "resource");
    }
    else if (spec.equals ("wrapup_duration")) {
      variables.put ("task", "task");
      variables.put ("next", "task");
      variables.put ("resource", "resource");
    }
    else if (spec.equals ("prerequisites")) {
      variables.put ("task", "task");
    }
    else if (spec.equals ("task_unavail")) {
      variables.put ("task", "task");
      variables.put ("resource", "resource");
      variables.put ("prerequisites", "list:task");
    }
    else if (spec.equals ("resource_unavail")) {
      variables.put ("resource", "resource");
    }
    else if (spec.equals ("capacity_contrib")) {
      variables.put ("task", "task");
    }
    else if (spec.equals ("capacity_thresh")) {
      variables.put ("resource", "resource");
    }
    else if (spec.equals ("groupable")) {
      variables.put ("task1", "task");
      variables.put ("task2", "task");
    }
    else if (spec.equals ("linked")) {
      variables.put ("task1", "task");
      variables.put ("task2", "task");
    }
    else if (spec.equals ("link_time_diff")) {
      variables.put ("task1", "task");
      variables.put ("task2", "task");
    }
    else if (spec.equals ("task_text")) {
      variables.put ("task", "task");
    }
    else if (spec.equals ("activity_text")) {
      variables.put ("interval", "interval");
    }
    else if (spec.equals ("task_color")) {
      variables.put ("task", "task");
    }
    else if (spec.equals ("activity_color")) {
      variables.put ("interval", "interval");
    }
    else if (spec.equals ("grouped_color")) {
    }
    else {
      System.out.println ("Spec type " + spec + " not currently handled");
    }
  }


  private static class ErrorResult implements ResultProducer {
    private String errorString;
    ErrorResult (String str)  { errorString = str; }
    public Object getResult (Map data)  { return null; }
    public String getResultType()  { return null; }
    public String toXML()  { return "Error: " + errorString + "\n"; }
    public boolean containsVariable (String name)  { return false; }
  }


  private ResultProducer doCompile (String str, String[] legalTypes) {
    str = str.trim();
    if (str.length() == 0)
      return new ErrorResult ("Missing value");
    if (! checkParens (str))
      return new ErrorResult ("Unbalanced parentheses in " + str);
    int opIndex = findOperator (str);
    if (opIndex != -1)
      return compileOperator (str, opIndex, legalTypes);
    if (str.charAt(0) == '"') {
      if (str.charAt(str.length() - 1) != '"')
        return new ErrorResult ("Missing quotes at end of " + str);
      return literal (str.substring (1, str.length() - 1),
                      "constant", "string", legalTypes);
    }
    if ((str.charAt (0) == '(') &&
        (str.charAt (str.length() - 1) == ')'))
      return doCompile (str.substring (1, str.length() - 1), legalTypes);
    if (str.charAt (str.length() - 1) == ')')
      return compileFunction (str, legalTypes);
    if (((str.charAt(0) >= '0') && (str.charAt(0) <= '9')) ||
        (str.charAt(0) == '-')){
      try {
        return literal (Float.valueOf(str).toString(), "constant",
                        "number", legalTypes);
      } catch (NumberFormatException e) {
        return new ErrorResult ("Bad number " + str);
      }
    }
    if (str.equalsIgnoreCase ("true"))
      return literal ("true", "constant", "boolean", legalTypes);
    if (str.equalsIgnoreCase ("false"))
      return literal ("false", "constant", "boolean", legalTypes);
    int dot = findNextChar (str, '.');
    if (dot != -1)
      return compileAccessor (str, dot, legalTypes);
    return compileVariable (str, legalTypes);
  }

  private boolean checkParens (String str) {
    int count = 0;
    boolean counting = true;
    for (int index = 0; index < str.length(); index++) {
      char ch = str.charAt (index);
      if (ch == '"')
        counting = ! counting;
      else if ((ch == '(') && counting)
        count++;
      else if ((ch == ')') && counting) {
        count--;
        if (count < 0)
          return false;
      }
    }
    return (count == 0) && counting;
  }

  private boolean isSubtract (String str, int index) {
    if (index == 0)
      return false;
    str = str.substring (0, index).trim();
    char ch = str.charAt (str.length() - 1);
    return ((ch != '*') && (ch != '/'));
  }

  private int findOperator (String str) {
    char[] chars = new char[] {'!', '<', '>', '=', '+', '-', '*', '/'};
    for (int i = 0; i < chars.length; i++) {
      int index = findNextChar (str, chars[i]);
      if (index != -1) {
        if (chars[i] != '-')
          return index;
        while (true) {
          if (isSubtract (str, index))
            return index;
          String str2 = str.substring (index + 1);
          int index2 = findNextChar (str2, '-');
          if (index2 == -1)
            break;
          index += 1 + index2;
        }
      }
    }
    return -1;
  }

  private ResultProducer compileOperator (String str, int index,
                                          String[] legalTypes) {
    String str2 = str;
    char ch = str.charAt (index);
    int numChars = 1;
    if (((ch == '!') || (ch == '<') || (ch == '>')) &&
        (str.charAt (index + 1) == '='))
      numChars = 2;
    String op = str.substring (index, index + numChars);
    Operator oper = new Operator (op);
    ResultProducer arg1 = doCompile (str.substring(0, index).trim(), null);
    if (arg1 instanceof ErrorResult)
      return arg1;
    oper.addArgument (arg1);
    ResultProducer arg2 =
      doCompile (str.substring(index + numChars).trim(), null);
    if (arg2 instanceof ErrorResult)
      return arg2;
    oper.addArgument (arg2);
    if (! oper.argTypesLegal())
      return new ErrorResult ("Illegal argument types for operator <font color='green'>" + op + 
							  "</font>.<br>Types given were : " + oper.reportArgTypes());
    ResultProducer check = checkLegalTypes (oper.getResultType(),
                                            legalTypes, str2);
    if (check != null)
      return check;
    return oper;
  }

  private ResultProducer compileFunction (String str, String[] legalTypes) {
    String str2 = str;
    int paren = str.indexOf ('(');
    String op = str.substring(0, paren).trim();
    Operator oper = new Operator (op);
    if (! oper.legalOperation())
      return new ErrorResult ("Unknown function " + op);
    str = str.substring(paren + 1, str.length() - 1).trim();
    ArrayList args = new ArrayList(4);
    if (str.length() != 0) {
      while (true) {
        int comma = findNextChar (str, ',');
        if (comma == -1) {
          args.add (str);
          break;
        }
        args.add (str.substring(0, comma).trim());
        str = str.substring(comma + 1, str.length()).trim();
      }
    }
    int dynamicVarArg = oper.variableUsed();
    for (int i = 0; i < args.size(); i++) {
      if (i == dynamicVarArg)
        oper.addVariable (variables);
      ResultProducer arg = doCompile ((String) args.get(i), null);
      if (i == dynamicVarArg)
        oper.removeVariable (variables);
      if (arg instanceof ErrorResult)
        return arg;
      oper.addArgument (arg);
    }
    if (! oper.argTypesLegal())
      return new ErrorResult ("Illegal argument types for function <font color='green'>" + op + 
							  "</font>.<br>Types given were : " + oper.reportArgTypes());
    ResultProducer check = checkLegalTypes (oper.getResultType(),
                                            legalTypes, str2);
    if (check != null)
      return check;
    return oper;
  }

  int findNextChar (String str, char ch2) {
    int count = 0;
    boolean counting = true;
    for (int index = 0; index < str.length(); index++) {
      char ch = str.charAt (index);
      if (ch == '"')
        counting = ! counting;
      else if ((ch == '(') && counting)
        count++;
      else if ((ch == ')') && counting)
        count--;
      else if ((ch == ch2) && counting && (count == 0))
        return index;
    }
    return -1;
  }

  private ResultProducer compileVariable (String str, String[] legalTypes) {
    String type = (String) variables.get (str);
    if (type == null)
      return new ErrorResult ("No variable named " + str +
                              " in this context");
    return literal (str, "variable", type, legalTypes);
  }

  private ResultProducer compileAccessor (String str, int div,
                                          String[] legalTypes) {
    ResultProducer obj = doCompile (str.substring (0, div), null);
    if (obj instanceof ErrorResult)
      return obj;
    return compileAccessor2 (str.substring (div + 1), obj, legalTypes, str);
  }

  private ResultProducer compileAccessor2 (String access, ResultProducer obj,
                                           String[] legalTypes, String full) {
    String objType = obj.getResultType();
    Map object = (Map) objectStructures.get (objType);
    if (object == null)
      return new ErrorResult ("No object definition for object " + objType);
    ResultProducer gl = compileGlobalPtr (access, obj, legalTypes, full);
    if (gl != null)
      return gl;
    String accType = (String) object.get (access);
    if (accType  == null)
      return new ErrorResult ("No field named " + access +
                              " in object " + objType);
    ResultProducer check = checkLegalTypes (accType, legalTypes, full);
    if (check != null)
      return check;
    Operator oper = new Operator ("get");
    oper.addArgument (obj);
    oper.addArgument (new Literal (access, "constant", "string", null));
    oper.addArgument (new Literal ("", "variable", accType, null));
    return oper;
  }

  private ResultProducer compileGlobalPtr (String access, ResultProducer obj,
                                           String[] legalTypes, String full) {
    String objType = obj.getResultType();
    ArrayList gps = (ArrayList) objectGlobalPtrs.get (objType);
    for (int i = 0; i < gps.size(); i++) {
      String gp = (String) gps.get (i);
      if (access.startsWith (gp)) {
        boolean same = access.length() == gp.length();
        if (same || (access.charAt (gp.length()) == '.')) {
          Operator oper = new Operator ("globget");
          Map object = (Map) objectStructures.get (objType);
          String accType = (String) object.get (gp);
          oper.addArgument (obj);
          oper.addArgument (new Literal (gp, "constant", "string", null));
          oper.addArgument (new Literal ("", "variable", accType, null));
          if (! same)
            return compileAccessor2 (access.substring (gp.length() + 1),
                                     oper, legalTypes, full);
          ResultProducer check = checkLegalTypes (accType, legalTypes, full);
          if (check != null)
            return check;
          return oper;
        }
      }
    }
    return null;
  }

  private ResultProducer literal (String value, String type, String datatype,
                                  String[] legalTypes) {
    ResultProducer res = checkLegalTypes (datatype, legalTypes, value);
    if (res != null)
      return res;
    return new Literal (value, type, datatype, null);
  }

  private ResultProducer checkLegalTypes (String type, String[] legalTypes,
                                          String varName) {
    if (legalTypes == null)
      return null;
    for (int i = 0; i < legalTypes.length; i++)
      if (type.equals (legalTypes[i]))
        return null;
    String str = (legalTypes.length > 0) ? legalTypes[0] : "??";
    for (int i = 1; i < legalTypes.length; i++)
      str = str + " or " + legalTypes[i];
    return new ErrorResult ("Got type " + type + ", expected type " +
                            str + " for \"" + varName + "\"");
  }

  private class RequestHandler extends DefaultHandler {

    private Map currentObject = null;
    private ArrayList currentGlobalPtrs = null;

    public void startElement (String uri, String local,
                              String name, Attributes atts) {
      if (name.equals ("PROBLEM")) {
        problem = atts.getValue ("name");
        spec = atts.getValue ("spec");
        expression = atts.getValue ("expression");
        taskObject = null;
        resourceObject = null;
        variables = new HashMap (11);
        objectStructures = new HashMap (19);
        objectGlobalPtrs = new HashMap (19);
      }
      else if (name.equals ("TASKOBJECT")) {
        taskObject = atts.getValue ("name");
      }
      else if (name.equals ("RESOURCEOBJECT")) {
        resourceObject = atts.getValue ("name");
      }
      else if (name.equals ("GLOBAL")) {
        variables.put (atts.getValue ("name"), atts.getValue ("datatype"));
      }
      else if (name.equals ("OBJECT")) {
        currentObject = new HashMap (11);
        currentGlobalPtrs = new ArrayList();
        objectStructures.put (atts.getValue ("name"), currentObject);
        objectGlobalPtrs.put (atts.getValue ("name"), currentGlobalPtrs);
      }
      else if (name.equals ("FIELD")) {
        currentObject.put (atts.getValue ("name"), atts.getValue ("type"));
        if (atts.getValue ("globalptr") != null)
          currentGlobalPtrs.add (atts.getValue ("name"));
      }
    }

    public void endElement (String uri, String local, String name) {
      if (name.equals ("COMPILERREQUEST") && (problem != null)) {
        addVariablesForSpec();
        objectStructures.put ("task", objectStructures.get (taskObject));
        objectStructures.put ("resource",
                              objectStructures.get (resourceObject));
        objectGlobalPtrs.put ("task", objectGlobalPtrs.get (taskObject));
        objectGlobalPtrs.put ("resource",
                              objectGlobalPtrs.get (resourceObject));
      }
    }
  }

  public static void main (String[] args) {
    ExpressionCompiler s = new ExpressionCompiler();
    s.run();
  }

}
