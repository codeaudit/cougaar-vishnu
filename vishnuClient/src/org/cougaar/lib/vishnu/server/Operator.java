// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Operator.java,v 1.4 2001-04-06 18:50:31 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

/**
 * The class Operator implements the operators, functions, and
 * accessors.  These are the non-terminal nodes of the parse trees
 * for formulas/expressions.
 *
 * When adding a new function, there are certain steps that should be
 * followed:
 * (1) Define a new constant for this function whose value is equal to
 *     NUM_OPS and set NUM_OPS to the next higher number.
 * (2) In the method initOpStrings, set opStrings[<const>] = <name>,
 *     numArgs[<const>] = <number of arguments>, and
 *     opsScheduleDependent[<const>] = <whether the value of this function
 *                             can be changed by changing the assignments>
 * (3) In getResult, implement what the function does.
 * (4) In getResultType, tell what type will be returned given particular
 *     input types.
 * (5) In argTypesLegal, check whether or not the given input types
 *     are legal for this function.
 * (6) If the function defines a new variable, in variablesUsed, tell
 *     how many.
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public class Operator implements ResultProducer {

  public static final Boolean FALSE = new Boolean (false);
  public static final Boolean TRUE = new Boolean (true);

  private static final int EQ = 0;
  private static final int NE = 1;
  private static final int LT = 2;
  private static final int GT = 3;
  private static final int LE = 4;
  private static final int GE = 5;
  private static final int AND = 6;
  private static final int OR = 7;
  private static final int NOT = 8;
  private static final int PLUS = 9;
  private static final int MINUS = 10;
  private static final int TIMES = 11;
  private static final int DIVIDE = 12;
  private static final int IF = 13;
  private static final int MAX = 14;
  private static final int MIN = 15;
  private static final int SUMOVER = 16;
  private static final int MAXOVER = 17;
  private static final int MINOVER = 18;
  private static final int MAPOVER = 19;
  private static final int LIST = 20;
  private static final int PREVIOUSDELTA = 21;
  private static final int DIST = 22;
  private static final int LATLONG_OP = 23;
  private static final int XY_COORD_OP = 24;
  private static final int INTERVAL_OP = 25;
  private static final int GET = 26;
  private static final int ENTRY = 27;
  private static final int MATENTRY = 28;
  private static final int BUSYTIME = 29;
  private static final int MOD = 30;
  private static final int HASVALUE = 31;
  private static final int PREPTIME = 32;
  private static final int COMPLETE = 33;
  private static final int TASKSTARTTIME = 34;
  private static final int TASKENDTIME = 35;
  private static final int RESOURCEFOR = 36;
  private static final int FIND = 37;
  private static final int ANDOVER = 38;
  private static final int OROVER = 39;
  private static final int LOOP = 40;
  private static final int LENGTH = 41;
  private static final int POSITION = 42;
  private static final int ABS = 43;
  private static final int TASKSFOR = 44;
  private static final int GLOBALGET = 45;
  private static final int APPEND = 46;
  private static final int STRING = 47;
  private static final int GROUPFOR = 48;
  private static final int NUM_OPS = 49;

  private static final float EARTH_RADIUS = 3437.75f; // nmi
  private static final float DEGREES_TO_RADIANS = (3.1415927f / 180.0f);

  private static String[] opStrings = null;
  private static String[] xmlStrings = null;
  private static boolean opStringsInitialized = false;
  private static int[] numArgs = null;
  private static boolean[] opsScheduleDependent = null;

  private static boolean debug = 
    ("true".equals (System.getProperty ("vishnu.debug")));

  private static void initOpStrings() {
    if (! opStringsInitialized) {
      opStringsInitialized = true;
      opStrings = new String [NUM_OPS];
      xmlStrings = new String [NUM_OPS];
      numArgs = new int [NUM_OPS];
      opsScheduleDependent = new boolean [NUM_OPS];
      opStrings [EQ] = "=";
      numArgs [EQ] = 2;
      opsScheduleDependent [EQ] = false;
      opStrings [NE] = "!=";
      numArgs [NE] = 2;
      opsScheduleDependent [NE] = false;
      opStrings [LT] = "<";
      numArgs [LT] = 2;
      opsScheduleDependent [LT] = false;
      opStrings [GT] = ">";
      numArgs [GT] = 2;
      opsScheduleDependent [GT] = false;
      opStrings [LE] = "<=";
      numArgs [LE] = 2;
      opsScheduleDependent [LE] = false;
      opStrings [GE] = ">=";
      numArgs [GE] = 2;
      opsScheduleDependent [GE] = false;
      opStrings [AND] = "and";
      numArgs [AND] = -1;
      opsScheduleDependent [AND] = false;
      opStrings [OR] = "or";
      numArgs [OR] = -1;
      opsScheduleDependent [OR] = false;
      opStrings [NOT] = "not";
      numArgs [NOT] = 1;
      opsScheduleDependent [NOT] = false;
      opStrings [PLUS] = "+";
      numArgs [PLUS] = 2;
      opsScheduleDependent [PLUS] = false;
      opStrings [MINUS] = "-";
      numArgs [MINUS] = 2;
      opsScheduleDependent [MINUS] = false;
      opStrings [TIMES] = "*";
      numArgs [TIMES] = 2;
      opsScheduleDependent [TIMES] = false;
      opStrings [DIVIDE] = "/";
      numArgs [DIVIDE] = 2;
      opsScheduleDependent [DIVIDE] = false;
      opStrings [IF] = "if";
      numArgs [IF] = -1;
      opsScheduleDependent [IF] = false;
      opStrings [MAX] = "max";
      numArgs [MAX] = -1;
      opsScheduleDependent [MAX] = false;
      opStrings [MIN] = "min";
      numArgs [MIN] = -1;
      opsScheduleDependent [MIN] = false;
      opStrings [SUMOVER] = "sumover";
      numArgs [SUMOVER] = 3;
      opsScheduleDependent [SUMOVER] = false;
      opStrings [MAXOVER] = "maxover";
      numArgs [MAXOVER] = 3;
      opsScheduleDependent [MAXOVER] = false;
      opStrings [MINOVER] = "minover";
      numArgs [MINOVER] = 3;
      opsScheduleDependent [MINOVER] = false;
      opStrings [MAPOVER] = "mapover";
      numArgs [MAPOVER] = 3;
      opsScheduleDependent [MAPOVER] = false;
      opStrings [LIST] = "list";
      numArgs [LIST] = -1;
      opsScheduleDependent [LIST] = false;
      opStrings [FIND] = "find";
      numArgs [FIND] = 3;
      opsScheduleDependent [FIND] = false;
      opStrings [APPEND] = "append";
      numArgs [APPEND] = 2;
      opsScheduleDependent [APPEND] = false;
      opStrings [DIST] = "dist";
      numArgs [DIST] = 2;
      opsScheduleDependent [DIST] = false;
      opStrings [LATLONG_OP] = "latlong";
      numArgs [LATLONG_OP] = 2;
      opsScheduleDependent [LATLONG_OP] = false;
      opStrings [XY_COORD_OP] = "xy_coord";
      numArgs [XY_COORD_OP] = 2;
      opsScheduleDependent [XY_COORD_OP] = false;
      opStrings [INTERVAL_OP] = "interval";
      numArgs [INTERVAL_OP] = -1;
      opsScheduleDependent [INTERVAL_OP] = false;
      opStrings [GET] = "get";
      numArgs [GET] = 3;
      opsScheduleDependent [GET] = false;
      opStrings [STRING] = "string";
      numArgs [STRING] = 1;
      opsScheduleDependent [STRING] = false;
      opStrings [GLOBALGET] = "globget";
      numArgs [GLOBALGET] = 3;
      opsScheduleDependent [GLOBALGET] = false;
      opStrings [ENTRY] = "entry";
      numArgs [ENTRY] = 2;
      opsScheduleDependent [ENTRY] = false;
      opStrings [MATENTRY] = "matentry";
      numArgs [MATENTRY] = 3;
      opsScheduleDependent [MATENTRY] = false;
      opStrings [BUSYTIME] = "busytime";
      numArgs [BUSYTIME] = 3;
      opsScheduleDependent [BUSYTIME] = true;
      opStrings [MOD] = "mod";
      numArgs [MOD] = 2;
      opsScheduleDependent [MOD] = false;
      opStrings [ABS] = "abs";
      numArgs [ABS] = 1;
      opsScheduleDependent [ABS] = false;
      opStrings [HASVALUE] = "hasvalue";
      numArgs [HASVALUE] = 1;
      opsScheduleDependent [HASVALUE] = false;
      opStrings [PREPTIME] = "preptime";
      numArgs [PREPTIME] = 1;
      opsScheduleDependent [PREPTIME] = true;
      opStrings [COMPLETE] = "complete";
      numArgs [COMPLETE] = 1;
      opsScheduleDependent [COMPLETE] = true;
      opStrings [TASKSTARTTIME] = "taskstarttime";
      numArgs [TASKSTARTTIME] = 1;
      opsScheduleDependent [TASKSTARTTIME] = true;
      opStrings [TASKENDTIME] = "taskendtime";
      numArgs [TASKENDTIME] = 1;
      opsScheduleDependent [TASKENDTIME] = true;
      opStrings [RESOURCEFOR] = "resourcefor";
      numArgs [RESOURCEFOR] = 1;
      opsScheduleDependent [RESOURCEFOR] = true;
      opStrings [TASKSFOR] = "tasksfor";
      numArgs [TASKSFOR] = 1;
      opsScheduleDependent [TASKSFOR] = true;
      opStrings [GROUPFOR] = "groupfor";
      numArgs [GROUPFOR] = 1;
      opsScheduleDependent [GROUPFOR] = true;
      opStrings [PREVIOUSDELTA] = "previousdelta";
      numArgs [PREVIOUSDELTA] = 1;
      opsScheduleDependent [PREVIOUSDELTA] = true;
      opStrings [ANDOVER] = "andover";
      numArgs [ANDOVER] = 3;
      opsScheduleDependent [ANDOVER] = false;
      opStrings [OROVER] = "orover";
      numArgs [OROVER] = 3;
      opsScheduleDependent [OROVER] = false;
      opStrings [LOOP] = "loop";
      numArgs [LOOP] = 3;
      opsScheduleDependent [LOOP] = false;
      opStrings [LENGTH] = "length";
      numArgs [LENGTH] = 1;
      opsScheduleDependent [LENGTH] = false;
      opStrings [POSITION] = "position";
      numArgs [POSITION] = 2;
      opsScheduleDependent [POSITION] = false;
      System.arraycopy (opStrings, 0, xmlStrings, 0, opStrings.length);
      xmlStrings [LT] = "&lt;";
      xmlStrings [LE] = "&lt;=";
      xmlStrings [GT] = "&gt;";
      xmlStrings [GE] = "&gt;=";
    }
  }

  private int operation = -1;
  private ResultProducer[] args = new ResultProducer[0];
  private String[] argTypes = new String[0];
  private SchedulingData sdata;
  private Reusable reuse;
  private TimeOps timeOps;

  public Operator (String operation) {
    initOpStrings();
    for (int i = 0; i < opStrings.length; i++) {
      if (operation.equals (opStrings[i])) {
        this.operation = i;
        break;
      }
    }
    if (this.operation == -1)
      System.out.println ("Operator.ctor - unknown operator " + operation);
  }

  /** instead of statics, each operator has own pointers */
  public void setData (SchedulingData sdata, Reusable reuse,
                       TimeOps timeOps) {
    this.sdata = sdata;
    this.reuse = reuse;
    this.timeOps = timeOps;
  }

  /** Useful in error messages from Expression Compiler */
  public String reportArgTypes () { 
	String retval = "";
	for (int i = 0; i < argTypes.length; i++)
	  retval = retval + "<li>Arg " + i + " : " + argTypes[i] + "<br>";
	return retval;
  }
  
  public boolean legalOperation()  { return operation != -1; }

  public String getName() {
    return (operation == -1) ? "UNKNOWN" : opStrings[operation];
  }

  public void addArgument (ResultProducer arg) {
    ResultProducer[] newargs = new ResultProducer [args.length + 1];
    System.arraycopy (args, 0, newargs, 0, args.length);
    newargs [args.length] = arg;
    args = newargs;
    String[] newargTypes = new String [argTypes.length + 1];
    System.arraycopy (argTypes, 0, newargTypes, 0, argTypes.length);
    newargTypes [argTypes.length] = arg.getResultType();;
    argTypes = newargTypes;
  }

  public String toXML() {
    String str = "<OPERATOR operation=\"" + xmlStrings[operation] + "\">\n";
    for (int i = 0; i < args.length; i++)
      str = str + args[i].toXML();
    return str + "</OPERATOR>\n";
  }

  /** is the variable used anywhere in the tree */
  public boolean containsVariable (String name) {
    for (int i = 0; i < args.length; i++)
      if (args[i].containsVariable (name))
        return true;
    return false;
  }

  /** does the value of this tree possibly depend on the assignments made */
  public boolean scheduleDependent() {
    if (opsScheduleDependent[operation])
      return true;
    for (int i = 0; i < args.length; i++)
      if ((args[i] instanceof Operator) &&
          ((Operator) args[i]).scheduleDependent())
        return true;
    return false;
  }

  /** accumulate the set of all fields accessed for each object type */
  public void objectAccesses (HashMap list) {
    if ((operation == GET) || (operation == GLOBALGET)) {
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

  /** execute the tree */
  public Object getResult (Map data) {
    ArrayList list;
    Object res;
    Object var;
    SchObject obj;
    Object obj1, obj2;
    Assignment[] a;
    Assignment a2;
    Resource resource;
    Task task;
    ArrayList lres;

    if (operation == -1) {
      System.out.println
        ("Operator.getResult - No operation specified for operator?");
      return FALSE;
    }

    switch (operation) {

    case EQ:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      return obj1.equals (obj2) ? TRUE : FALSE;

    case NE:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      return obj1.equals (obj2) ? FALSE : TRUE;

    case LT:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      if (obj1 instanceof Reusable.RFloat)
        return (((Reusable.RFloat) obj1).floatValue() <
                ((Reusable.RFloat) obj2).floatValue() ?
                TRUE : FALSE);
      else if (obj1 instanceof Reusable.RInteger)
        return (((Reusable.RInteger) obj1).intValue() <
                ((Reusable.RInteger) obj2).intValue() ?
                TRUE : FALSE);
      else
        return FALSE;

    case GT:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      if (obj1 instanceof Reusable.RFloat)
        return (((Reusable.RFloat) obj1).floatValue() >
                ((Reusable.RFloat) obj2).floatValue() ?
                TRUE : FALSE);
      else if (obj1 instanceof Reusable.RInteger)
        return (((Reusable.RInteger) obj1).intValue() >
                ((Reusable.RInteger) obj2).intValue() ?
                TRUE : FALSE);
      else
        return FALSE;

    case LE:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      if (obj1 instanceof Reusable.RFloat)
        return (((Reusable.RFloat) obj1).floatValue() <=
                ((Reusable.RFloat) obj2).floatValue() ?
                TRUE : FALSE);
      else if (obj1 instanceof Reusable.RInteger)
        return (((Reusable.RInteger) obj1).intValue() <=
                ((Reusable.RInteger) obj2).intValue() ?
                TRUE : FALSE);
      else
        return FALSE;

    case GE:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      if (obj1 instanceof Reusable.RFloat)
        return (((Reusable.RFloat) obj1).floatValue() >=
                ((Reusable.RFloat) obj2).floatValue() ?
                TRUE : FALSE);
      else if (obj1 instanceof Reusable.RInteger)
        return (((Reusable.RInteger) obj1).intValue() >=
                ((Reusable.RInteger) obj2).intValue() ?
                TRUE : FALSE);
      else
        return FALSE;

    case AND:
      for (int i = 0; i < args.length; i++) {
        obj1 = args[i].getResult (data);
        if (obj1 == null)
          return null;
        if (! ((Boolean) obj1).booleanValue())
          return FALSE;
      }
      return TRUE;

    case OR:
      for (int i = 0; i < args.length; i++) {
        obj1 = args[i].getResult (data);
        if (obj1 == null)
          return null;
        if (((Boolean) obj1).booleanValue())
          return TRUE;
      }
      return FALSE;

    case NOT:
      obj1 = args[0].getResult (data);
      if (obj1 == null)
        return null;
      return ((Boolean) obj1).booleanValue() ? FALSE : TRUE;

    case PLUS:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      if (obj1 instanceof Reusable.RInteger)
        return reuse.getInteger
          (((Reusable.RInteger) obj1).intValue() +
           ((int) ((Reusable.RFloat) obj2).floatValue()));
      else if (obj2 instanceof Reusable.RInteger)
        return reuse.getInteger
          (((int) ((Reusable.RFloat) obj1).floatValue()) +
           ((Reusable.RInteger) obj2).intValue());
      else
        return reuse.getFloat (((Reusable.RFloat) obj1).floatValue() +
                               ((Reusable.RFloat) obj2).floatValue());

    case MINUS:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      if (obj2 instanceof Reusable.RInteger)
        return reuse.getFloat
          ((float) (((Reusable.RInteger) obj1).intValue() -
                    ((Reusable.RInteger) obj2).intValue()));
      else if (obj1 instanceof Reusable.RFloat)
        return reuse.getFloat (((Reusable.RFloat) obj1).floatValue() -
                               ((Reusable.RFloat) obj2).floatValue());
      else
        return reuse.getInteger
          (((Reusable.RInteger) obj1).intValue() -
           ((int) ((Reusable.RFloat) obj2).floatValue()));

    case TIMES:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      return reuse.getFloat (((Reusable.RFloat) obj1).floatValue() *
                             ((Reusable.RFloat) obj2).floatValue());

    case DIVIDE:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      return reuse.getFloat (((Reusable.RFloat) obj1).floatValue() /
                             ((Reusable.RFloat) obj2).floatValue());

    case MOD:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      return reuse.getFloat (((Reusable.RFloat) obj1).floatValue() %
                             ((Reusable.RFloat) obj2).floatValue());

    case ABS:
      obj1 = args[0].getResult (data);
      if (obj1 == null)
        return null;
      return reuse.getFloat
        (Math.abs (((Reusable.RFloat) obj1).floatValue()));

    case IF:
      obj1 = args[0].getResult (data);
      if (obj1 == null)
        return null;

      if (!((Boolean) obj1).booleanValue() && (args.length == 2))
	return null;
      else
        return args[((Boolean) obj1).booleanValue() ? 1 : 2].getResult (data);

    case MAX:
      float max = Float.MIN_VALUE;
      for (int i = 0; i < args.length; i++) {
        Reusable.RFloat f = (Reusable.RFloat) args[i].getResult (data);
        if ((f != null) && (f.floatValue() > max))
          max = f.floatValue();
      }
      return (max == Float.MIN_VALUE) ? null : reuse.getFloat (max);

    case MIN:
      float min = Float.MAX_VALUE;
      for (int i = 0; i < args.length; i++) {
        Reusable.RFloat f = (Reusable.RFloat) args[i].getResult (data);
        if ((f != null) && (f.floatValue() < min))
          min = f.floatValue();
      }
      return (min == Float.MAX_VALUE) ? null : reuse.getFloat (min);

    case MAXOVER:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      res = null;
      var = args[1].getResult (data);
      if (var == null)
        return null;
      for (int i = 0; i < list.size(); i++) {
        data.put (var, list.get(i));
        Object val = args[2].getResult (data);
        if (val == null)
          continue;
        if (val instanceof Reusable.RFloat) {
          if ((res == null) ||
              (((Reusable.RFloat) val).floatValue() >
               ((Reusable.RFloat) res).floatValue()))
            res = val;
        }
        else if (val instanceof Reusable.RInteger) {
          if ((res == null) ||
              (((Reusable.RInteger) val).intValue() >
               ((Reusable.RInteger) res).intValue()))
            res = val;
        }
      }
      data.remove (var);
      return res;

    case MINOVER:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      res = null;
      var = args[1].getResult (data);
      if (var == null)
        return null;
      for (int i = 0; i < list.size(); i++) {
        data.put (var, list.get(i));
        Object val = args[2].getResult (data);
        if (val == null)
          continue;
        if (val instanceof Reusable.RFloat) {
          if ((res == null) ||
              (((Reusable.RFloat) val).floatValue() <
               ((Reusable.RFloat) res).floatValue()))
            res = val;
        }
        else if (val instanceof Reusable.RInteger) {
          if ((res == null) ||
              (((Reusable.RInteger) val).intValue() <
               ((Reusable.RInteger) res).intValue()))
            res = val;
        }
      }
      data.remove (var);
      return res;

    case SUMOVER:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      var = args[1].getResult (data);
      if (var == null)
        return null;
      float fres = 0.0f;
      for (int i = 0; i < list.size(); i++) {
        data.put (var, list.get(i));
        Object val = args[2].getResult (data);
        if (val != null)
          fres += ((Reusable.RFloat) val).floatValue();
      }
      data.remove (var);
      return reuse.getFloat (fres);

    case ANDOVER:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      var = args[1].getResult (data);
      if (var == null)
        return null;
      for (int i = 0; i < list.size(); i++) {
        data.put (var, list.get(i));
        Boolean val = (Boolean) args[2].getResult (data);
        if ((val != null) && (! val.booleanValue())) {
          data.remove (var);
          return FALSE;
        }
      }
      data.remove (var);
      return TRUE;

    case OROVER:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      var = args[1].getResult (data);
      if (var == null)
        return null;
      for (int i = 0; i < list.size(); i++) {
        data.put (var, list.get(i));
        Boolean val = (Boolean) args[2].getResult (data);
        if ((val != null) && val.booleanValue()) {
          data.remove (var);
          return TRUE;
        }
      }
      data.remove (var);
      return FALSE;

    case MAPOVER:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      var = args[1].getResult (data);
      if (var == null)
        return null;
      lres = reuse.getList();
      for (int i = 0; i < list.size(); i++) {
        data.put (var, list.get(i));
        Object val = args[2].getResult (data);
        if (val == null)
          continue;
        if (val instanceof ArrayList)
          lres.addAll ((ArrayList) val);
        else
          lres.add (val);
      }
      data.remove (var);
      return lres;

    case LOOP:
      Reusable.RFloat num = (Reusable.RFloat) args[0].getResult (data);
      if (num == null)
        return null;
      var = args[1].getResult (data);
      if (var == null)
        return null;
      lres = reuse.getList();
      for (int i = 1; i <= num.intValue(); i++) {
        data.put (var, reuse.getFloat ((float) i));
        Object val = args[2].getResult (data);
        if (val == null)
          continue;
        if (val instanceof ArrayList)
          lres.addAll ((ArrayList) val);
        else
          lres.add (val);
      }
      data.remove (var);
      return lres;

    case LENGTH:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      return reuse.getFloat (list.size());

    case POSITION:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      obj1 = args[1].getResult (data);
      if (obj1 == null)
        return null;
      int index = list.indexOf (obj1);
      if (index == -1)
        return null;
      return reuse.getFloat (index + 1);

    case LIST:
      list = reuse.getList();
      for (int i = 0; i < args.length; i++) {
        Object o1 = args[i].getResult (data);
        if (o1 != null)
          list.add (o1);
      }
      return list;

    case DIST:
      SchObject sobj1 = (SchObject) args[0].getResult (data);
      SchObject sobj2 = (SchObject) args[1].getResult (data);
      if ((sobj1 == null) || (sobj2 == null))
        return null;
      if (argTypes[0].equals ("xy_coord")) {
        float xdiff = (((Reusable.RFloat) sobj1.getField ("x")).floatValue() -
                       ((Reusable.RFloat) sobj2.getField ("x")).floatValue());
        float ydiff = (((Reusable.RFloat) sobj1.getField ("y")).floatValue() -
                       ((Reusable.RFloat) sobj2.getField ("y")).floatValue());
        double distval = Math.sqrt ((double) (xdiff * xdiff + ydiff * ydiff));
        return reuse.getFloat ((float) distval);
      }
      if (argTypes[0].equals ("latlong")) {
        float lat1 = (((Reusable.RFloat) sobj1.getField ("latitude")).
                      floatValue() * DEGREES_TO_RADIANS);
        float lat2 = (((Reusable.RFloat) sobj2.getField ("latitude")).
                      floatValue() * DEGREES_TO_RADIANS);
        float dlong = (((Reusable.RFloat) sobj1.getField ("longitude")).
                       floatValue() -
                       ((Reusable.RFloat) sobj2.getField ("longitude")).
                       floatValue()) * DEGREES_TO_RADIANS;
        double rads =
          Math.acos (Math.sin ((double) lat1) * Math.sin ((double) lat2) +
                     Math.cos ((double) lat1) * Math.cos ((double) lat2) *
                     Math.cos ((double) dlong));
        return reuse.getFloat (EARTH_RADIUS * (float) rads);
      }
      return null;

    case LATLONG_OP:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      obj = new SchObject (timeOps);
      obj.addField ("latitude", "", ((Reusable.RFloat) obj1).copy(),
                    false, false);
      obj.addField ("longitude", "", ((Reusable.RFloat) obj2).copy(),
                    false, false);
      return obj;

    case XY_COORD_OP:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      obj = new SchObject (timeOps);
      obj.addField ("x", "", ((Reusable.RFloat) obj1).copy(), false, false);
      obj.addField ("y", "", ((Reusable.RFloat) obj2).copy(), false, false);
      return obj;

    case INTERVAL_OP:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      obj = new SchObject (timeOps);
      obj.addField ("start", "", ((Reusable.RInteger) obj1).copy(),
                    false, false);
      obj.addField ("end", "", ((Reusable.RInteger) obj2).copy(),
                    false, false);
      if (argTypes.length > 2)
        obj.addField ("label1", "string", args[2].getResult (data),
                      false, false);
      if (argTypes.length > 3)
        obj.addField ("label2", "string", args[3].getResult (data),
                      false, false);
      return obj;

    case GET:
      obj = (SchObject) args[0].getResult (data);
      if (obj == null)
        return null;
      return obj.getField ((String) args[1].getResult (data));

    case STRING:
      obj1 = args[0].getResult (data);
      if (obj1 == null)
        return null;
      return SchedulingSpecs.stringForObject (obj1);

    case GLOBALGET:
      obj = (SchObject) args[0].getResult (data);
      if (obj == null)
        return null;
      String str = (String) obj.getField ((String) args[1].getResult (data));
      return (argTypes[2].equals (sdata.typeForGlobal (str)) ?
              data.get (str) : null);

    case ENTRY:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      obj2 = args[1].getResult (data);
      if (obj2 == null)
        return null;
      int entry = ((Reusable.RFloat) obj2).intValue() - 1;
      try {
        return list.get (entry);
      } catch (IndexOutOfBoundsException e) {
        return null;
      }

    case MATENTRY:
      obj = (SchObject) args[0].getResult (data);
      if (obj == null)
        return null;
      obj1 = args[1].getResult (data);
      obj2 = args[2].getResult (data);
      if ((obj1 == null) || (obj2 == null))
        return null;
      int row = ((Reusable.RFloat) obj1).intValue() - 1;
      int col = ((Reusable.RFloat) obj2).intValue() - 1;
      int entry2 = col + row *
        ((Reusable.RFloat) obj.getField ("numcols")).intValue();
      return ((ArrayList) obj.getField ("values")).get (entry2);

    case BUSYTIME:
      resource = (Resource) args[0].getResult (data);
      if (resource == null)
        return null;
      obj1 = args[1].getResult (data);
      obj2 = args[2].getResult (data);
      int start = ((obj1 == null) ? Integer.MIN_VALUE :
                   ((Reusable.RInteger) obj1).intValue());
      int end = ((obj2 == null) ? Integer.MAX_VALUE :
                 ((Reusable.RInteger) obj2).intValue());
      return reuse.getFloat (resource.busyTime (start, end));

    case PREPTIME:
      resource = (Resource) args[0].getResult (data);
      if (resource == null)
        return null;
      return reuse.getFloat (resource.prepTime());

    case COMPLETE:
      resource = (Resource) args[0].getResult (data);
      if (resource == null)
        return null;
      a = resource.getAssignments();
      int imax = Integer.MIN_VALUE;
      for (int i = 0; i < a.length; i++) {
        int wrapup2 = a[i].getEndTime();
        if (imax < wrapup2)
          imax = wrapup2;
      }
      return ((imax == Integer.MIN_VALUE) ?
              data.get ("start_time") : reuse.getInteger (imax));

    case TASKSTARTTIME:
      task = (Task) args[0].getResult (data);
      if (task == null)
        return null;
      a2 = task.getAssignment();
      return (a2 == null) ? null : reuse.getInteger (a2.getTaskStartTime());

    case TASKENDTIME:
      task = (Task) args[0].getResult (data);
      if (task == null)
        return null;
      a2 = task.getAssignment();
      return (a2 == null) ? null : reuse.getInteger (a2.getTaskEndTime());

    case RESOURCEFOR:
      task = (Task) args[0].getResult (data);
      if (task == null)
        return null;
      a2 = task.getAssignment();
      return (a2 == null) ? null : a2.getResource();

    case TASKSFOR:
      resource = (Resource) args[0].getResult (data);
      if (resource == null)
        return null;
      a = resource.getAssignments();
      list = reuse.getList();
      for (int i = 0; i < a.length; i++)
        list.add (a[i].getTask());
      return list;

    case GROUPFOR:
      task = (Task) args[0].getResult (data);
      if (task == null)
        return null;
      a2 = task.getAssignment();
      if (a2 == null)
        return null;
      return a2.getResource().getGroup (reuse.getList(), task);

    case PREVIOUSDELTA:
      resource = (Resource) args[0].getResult (data);
      if (resource == null)
        return null;
      return reuse.getFloat (resource.getSumOfDeltas());

    case HASVALUE:
      obj1 = args[0].getResult (data);
      return (obj1 != null) ? TRUE : FALSE;

    case FIND:
      list = (ArrayList) args[0].getResult (data);
      if (list == null)
        return null;
      var = args[1].getResult (data);
      if (var == null)
        return null;
      Object findres = null;
      for (int i = 0; i < list.size(); i++) {
        data.put (var, list.get(i));
        Boolean val = (Boolean) args[2].getResult (data);
        if (val == null)
          continue;
        if (val.booleanValue()) {
          findres = list.get(i);
          break;
        }
      }
      data.remove (var);
      return findres;

    case APPEND:
      obj1 = args[0].getResult (data);
      obj2 = args[1].getResult (data);
      if (obj1 == null)
        return obj2;
      if (obj2 == null)
        return obj1;
      if (argTypes[0].equals ("string"))
        return ((String) obj1) + ((String) obj2);
      lres = reuse.getList();
      lres.addAll ((ArrayList) obj1);
      lres.addAll ((ArrayList) obj2);
      return lres;

    default:
      System.out.println ("Unimplemented operation " + opStrings[operation]);
      return FALSE;
    }
  }

  public String getResultType() {
    switch (operation) {
    case EQ:
    case NE:
    case LT:
    case GT:
    case LE:
    case GE:
    case AND:
    case OR:
    case NOT:
      return "boolean";
    case PLUS:
      if (argTypes[0].equals ("number") && argTypes[1].equals ("number"))
        return "number";
      if (argTypes[0].equals ("number") && argTypes[1].equals ("datetime"))
        return "datetime";
      if (argTypes[0].equals ("datetime") && argTypes[1].equals ("number"))
        return "datetime";
      return "";
    case MINUS:
      if (argTypes[0].equals ("number") && argTypes[1].equals ("number"))
        return "number";
      if (argTypes[0].equals ("datetime") && argTypes[1].equals ("datetime"))
        return "number";
      if (argTypes[0].equals ("datetime") && argTypes[1].equals ("number"))
        return "datetime";
      return "";
    case TIMES:
    case DIVIDE:
    case MOD:
    case ABS:
      return "number";
    case IF:
      return argTypes[1];
    case MAX:
    case MIN:
      return argTypes[0];
    case SUMOVER:
      return "number";
    case MINOVER:
    case MAXOVER:
      return argTypes[2];
    case ANDOVER:
    case OROVER:
      return "boolean";
    case MAPOVER:
    case LOOP:
      return isList (argTypes[2]) ? argTypes[2] : ("list:" + argTypes[2]);
    case LIST:
      return "list:" + argTypes[0];
    case LENGTH:
      return "number";
    case POSITION:
      return "number";
    case DIST:
      return "number";
    case LATLONG_OP:
      return "latlong";
    case XY_COORD_OP:
      return "xy_coord";
    case INTERVAL_OP:
      return "interval";
    case STRING:
      return "string";
    case GET:
    case GLOBALGET:
      return argTypes[2];
    case ENTRY:
      return argTypes[0].substring(5);
    case MATENTRY:
      return "number";
    case BUSYTIME:
    case PREPTIME:
      return "number";
    case COMPLETE:
      return "datetime";
    case HASVALUE:
      return "boolean";
    case TASKSTARTTIME:
    case TASKENDTIME:
      return "datetime";
    case RESOURCEFOR:
      return "resource";
    case TASKSFOR:
    case GROUPFOR:
      return "list:task";
    case FIND:
      return argTypes[0].substring(5);
    case APPEND:
      return argTypes[0];
    case PREVIOUSDELTA:
      return "number";
    default:
      System.out.println ("Unimplemented operation " + opStrings[operation]);
      return "";
    }
  }


  boolean argTypesLegal() {
    if ((numArgs[operation] != -1) && (numArgs[operation] != args.length))
      return false;
    switch (operation) {
    case EQ:
    case NE:
      return argTypes[0].equals (argTypes[1]);
    case LT:
    case GT:
    case LE:
    case GE:
      return ((argTypes[0].equals ("number") &&
               argTypes[1].equals ("number")) ||
              (argTypes[0].equals ("datetime") &&
               argTypes[1].equals ("datetime")));
    case AND:
    case OR:
      for (int i = 0; i < argTypes.length; i++)
        if (! argTypes[i].equals ("boolean"))
          return false;
      return true;
    case NOT:
      return argTypes[0].equals ("boolean");
    case PLUS:
      return ((argTypes[0].equals ("number") &&
               argTypes[1].equals ("number")) ||
              (argTypes[0].equals ("number") &&
               argTypes[1].equals ("datetime")) ||
              (argTypes[0].equals ("datetime") &&
               argTypes[1].equals ("number")));
    case MINUS:
      return ((argTypes[0].equals ("number") &&
               argTypes[1].equals ("number")) ||
              (argTypes[0].equals ("datetime") &&
               argTypes[1].equals ("datetime")) ||
              (argTypes[0].equals ("datetime") &&
               argTypes[1].equals ("number")));
    case TIMES:
    case DIVIDE:
    case MOD:
      return (argTypes[0].equals ("number") &&
              argTypes[1].equals ("number"));
    case ABS:
      return argTypes[0].equals ("number");
    case IF:
      return ((argTypes.length >= 2) &&
              argTypes[0].equals ("boolean") &&
              ((argTypes.length == 2) ||
               argTypes[2].equals (argTypes[1])));
    case MAX:
    case MIN:
      for (int i = 0; i < argTypes.length; i++)
        if (! argTypes[i].equals ("number"))
          return false;
      return true;
    case SUMOVER:
      return (isList (argTypes[0]) &&
              argTypes[1].equals ("string") &&
              argTypes[2].equals ("number"));
    case MAXOVER:
    case MINOVER:
      return (isList (argTypes[0]) &&
              argTypes[1].equals ("string") &&
              (argTypes[2].equals ("number") ||
               argTypes[2].equals ("datetime")));
    case MAPOVER:
      return (isList (argTypes[0]) &&
              argTypes[1].equals ("string"));
    case LIST:
      if (argTypes.length == 0)
        return false;
      for (int i = 1; i < argTypes.length; i++)
        if (! argTypes[i].equals (argTypes[0]))
          return false;
      return true;
    case PREVIOUSDELTA:
      return (argTypes[0].equals ("resource"));
    case DIST:
      return ((argTypes[0].equals ("latlong") &&
               argTypes[1].equals ("latlong")) ||
              (argTypes[0].equals ("xy_coord") &&
               argTypes[1].equals ("xy_coord")));
    case LATLONG_OP:
      return (argTypes[0].equals ("number") &&
              argTypes[1].equals ("number"));
    case XY_COORD_OP:
      return (argTypes[0].equals ("number") &&
              argTypes[1].equals ("number"));
    case INTERVAL_OP:
      return ((argTypes.length >= 2) &&
              argTypes[0].equals ("datetime") &&
              argTypes[1].equals ("datetime") &&
              ((argTypes.length < 3) || argTypes[2].equals ("string")) &&
              ((argTypes.length < 4) || argTypes[3].equals ("string")));
    case STRING:
    case GET:
    case GLOBALGET:
      return true;
    case ENTRY:
      return (isList (argTypes[0]) &&
              argTypes[1].equals ("number"));
    case MATENTRY:
      return (argTypes[0].equals ("matrix") &&
              argTypes[1].equals ("number") &&
              argTypes[2].equals ("number"));
    case BUSYTIME:
      return (argTypes[0].equals ("resource") &&
              argTypes[1].equals ("datetime") &&
              argTypes[2].equals ("datetime"));
    case HASVALUE:
      return true;
    case PREPTIME:
      return argTypes[0].equals ("resource");
    case COMPLETE:
      return argTypes[0].equals ("resource");
    case TASKSTARTTIME:
    case TASKENDTIME:
    case RESOURCEFOR:
    case GROUPFOR:
      return argTypes[0].equals ("task");
    case TASKSFOR:
      return argTypes[0].equals ("resource");
    case FIND:
      return (isList (argTypes[0]) &&
              argTypes[1].equals ("string") &&
              argTypes[2].equals ("boolean"));
    case APPEND:
      return ((argTypes[0].equals (argTypes[1])) &&
              ((isList (argTypes[0]) || argTypes[0].equals ("string"))));
    case ANDOVER:
    case OROVER:
      return (isList (argTypes[0]) &&
              argTypes[1].equals ("string") &&
              argTypes[2].equals ("boolean"));
    case LOOP:
      return (argTypes[0].equals ("number") &&
              argTypes[1].equals ("string"));
    case LENGTH:
      return isList (argTypes[0]);
    case POSITION:
      return isList (argTypes[0]);
    default:
      System.out.println ("Unchecked operation " + opStrings[operation]);
      return false;
    }    
  }

  private boolean isList (String argType) {
    return argType.startsWith ("list:");
  }

  int variableUsed() {
    switch (operation) {
    case LOOP:
    case ANDOVER:
    case OROVER:
    case MAXOVER:
    case MINOVER:
    case MAPOVER:
    case SUMOVER:
    case FIND:
      return 2;
    default:
      return -1;
    }
  }

  void addVariable (Map variables) {
    if (operation == LOOP)
      variables.put (args[1].getResult (new HashMap()), "number");
    else
      variables.put (args[1].getResult (new HashMap()),
                     argTypes[0].substring(5));
  }

  void removeVariable (Map variables) {
    variables.remove (args[1].getResult (new HashMap()));
  }

}
