// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/Operator.java,v 1.1 2001-08-15 18:21:55 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.HashSet;
import java.util.HashMap;
import java.util.Map;

/**
 * The class Operator implements the operators, functions, and
 * accessors.  These are the non-terminal nodes of the parse trees
 * for formulas/expressions.
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public abstract class Operator extends ResultProducer implements Cloneable {

  public abstract String getName();
  protected abstract boolean opScheduleDependent();
  protected abstract boolean opArgTypesLegal();
  protected abstract int numArgs();

  /** by default, XML name is same as standard name */
  public String getXMLName() {
    return getName();
  }

  /** where a dynamically added variable is used; by default, not used */
  public int variableUsed() {
    return -1;
  }

  protected void addVariable (Map variables) {
    variables.put (args[1].getResult (new HashMap()),
                   argTypes[0].substring(5));
  }

  private final static Operator[] operators =
    {new OpGet(), new OpAndOr (true), new OpAndOr (false), new OpNot(),
     new OpEqNe (true), new OpEqNe (false),
     new OpComp (OpComp.LT), new OpComp (OpComp.LE),
     new OpComp (OpComp.GT), new OpComp (OpComp.GE),
     new OpIf(), new OpPlus(), new OpMinus(),
     new OpArith (ExecutionStack.TIMES),
     new OpArith (ExecutionStack.DIVIDE),
     new OpArith (ExecutionStack.MOD),
     new OpMapover(), new OpDistance(),
     new OpScheduleDependent (ExecutionStack.COMPLETE),
     new OpScheduleDependent (ExecutionStack.PREPTIME),
     new OpScheduleDependent (ExecutionStack.TASKSFOR),
     new OpScheduleDependent (ExecutionStack.RESOURCEFOR),
     new OpScheduleDependent (ExecutionStack.GROUPFOR),
     new OpScheduleDependent (ExecutionStack.TASKSETUPTIME),
     new OpScheduleDependent (ExecutionStack.TASKSTARTTIME),
     new OpScheduleDependent (ExecutionStack.TASKENDTIME),
     new OpScheduleDependent (ExecutionStack.TASKWRAPUPTIME),
     new OpConstructor (ExecutionStack.XY_COORD),
     new OpConstructor (ExecutionStack.LATLONG),
     new OpConstructor (ExecutionStack.INTERVAL),
     new OpIterover (OpIterover.MAX),
     new OpIterover (OpIterover.MIN),
     new OpIterover (OpIterover.SUM),
     };
/*    {
     new OpMax(),
     new OpMin(),
     new OpList(),
     new OpFind(),
     new OpAppend(),
     new OpDist(),
     new OpString(),
     new OpGlobalget(),
     new OpEntry(),
     new OpMatentry(),
     new OpBusytime(),
     new OpAbs(),
     new OpHasvalue(),
     new OpPreviousdelta(),
     new OpAndover(),
     new OpOrover(),
     new OpLoop(),
     new OpLength(),
     new OpPosition()};
*/

  protected ResultProducer[] args = new ResultProducer[0];
  protected String[] argTypes = new String[0];

  public static Operator getOperatorNamed (String name) {
    try {
      for (int i = 0; i < operators.length; i++)
        if (operators[i].getName().equalsIgnoreCase (name))
          return (Operator) operators[i].clone();
    } catch (Exception e) {
      e.printStackTrace();
      return null;
    }
    System.out.println ("Unknown operator " + name);
    return null;
  }

  public final void addArgument (ResultProducer arg) {
    ResultProducer[] newargs = new ResultProducer [args.length + 1];
    System.arraycopy (args, 0, newargs, 0, args.length);
    newargs [args.length] = arg;
    args = newargs;
    String[] newargTypes = new String [argTypes.length + 1];
    System.arraycopy (argTypes, 0, newargTypes, 0, argTypes.length);
    newargTypes [argTypes.length] = arg.getResultType();
    argTypes = newargTypes;
  }

  public final String toXML() {
    String str = "<OPERATOR operation=\"" + getXMLName() + "\">\n";
    for (int i = 0; i < args.length; i++)
      str = str + args[i].toXML();
    return str + "</OPERATOR>\n";
  }

  public final boolean argTypesLegal() {
    if ((numArgs() != -1) && (numArgs() != args.length))
      return false;
    return opArgTypesLegal();
  }

  /** is the variable used anywhere in the tree */
  public final boolean containsVariable (String name) {
    for (int i = 0; i < args.length; i++)
      if (args[i].containsVariable (name))
        return true;
    return false;
  }

  /** Useful in error messages from Expression Compiler */
  public final String reportArgTypes () { 
    String retval = "";
    for (int i = 0; i < argTypes.length; i++)
      retval = retval + "<li>Arg " + i + " : " + argTypes[i] + "<br>";
    return retval;
  }

  /** does the value of this tree possibly depend on the assignments made */
  public final boolean scheduleDependent() {
    if (opScheduleDependent())
      return true;
    for (int i = 0; i < args.length; i++)
      if ((args[i] instanceof Operator) &&
          ((Operator) args[i]).scheduleDependent())
        return true;
    return false;
  }

  /** accumulate the set of all fields accessed for each object type */
  public final void objectAccesses (HashMap list) {
    if (getName().equals ("GET") || getName().equals ("GLOBALGET")) {
      String type = args[0].getResultType();
      HashSet set = (HashSet) list.get (type);
      if (set == null) {
        set = new HashSet();
        list.put (type, set);
      }
      set.add (args[1].getResult (null));
    }
    for (int i = 0; i < args.length; i++)
      if (args[i] instanceof Operator)
        ((Operator) args[i]).objectAccesses (list);
  }

  protected final boolean isList (String argType) {
    return argType.startsWith ("list:");
  }

  protected final void removeVariable (Map variables) {
    variables.remove (args[1].getResult (new HashMap()));
  }

}
