// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/ExecutionStack.java,v 1.3 2001-08-13 19:35:07 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.Map;
import java.util.ArrayList;

/**
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class ExecutionStack {

  public static final Boolean FALSE = new Boolean (false);
  public static final Boolean TRUE = new Boolean (true);

  public static final int PUSH = 0;
  public static final int VARIABLE = 1;
  public static final int CONSTANT = 2;
  public static final int GET = 220;
  public static final int SET = 3;
  public static final int UNSET = 201;
  public static final int JUMP = 202;
  public static final int JUMPNULL = 203;
  public static final int JUMPIF = 4;
  public static final int JUMPIFNOT = 224;
  public static final int ITER_INIT = 214;
  public static final int ITER_START = 215;
  public static final int ITER_END = 216;
  public static final int EQ = 5;
  public static final int NE = 6;
  public static final int LT_FLT = 7;
  public static final int GT_FLT = 8;
  public static final int LE_FLT = 9;
  public static final int GE_FLT = 10;
  public static final int LT_INT = 207;
  public static final int GT_INT = 208;
  public static final int LE_INT = 209;
  public static final int GE_INT = 210;
  public static final int NOT = 11;
  public static final int PLUS_FLT_INT = 12;
  public static final int PLUS_INT_FLT = 13;
  public static final int PLUS_FLT_FLT = 14;
  public static final int MINUS_INT_INT = 15;
  public static final int MINUS_INT_FLT = 204;
  public static final int MINUS_FLT_FLT = 205;
  public static final int TIMES = 16;
  public static final int DIVIDE = 17;
  public static final int MAX = 18;
  public static final int MIN = 19;
  public static final int ADD_TO_LIST = 20;
  public static final int NEW_LIST = 211;
  public static final int APPEND_LIST = 21;
  public static final int APPEND_STRING = 22;
  public static final int COMPLETE = 23;

  private ArrayList tempCommands = new ArrayList();
  private int[] commands;
  private ArrayList tempArgs1 = new ArrayList();
  private Object[] args1;
  private ArrayList tempArgs2 = new ArrayList();
  private int[] args2;

  private Object[] dataStack = new Object[40];
  private int dataPtr = 0;

  private Reusable reuse;
  private TimeOps timeOps;


  public ExecutionStack (Reusable reuse, TimeOps timeOps) {
    this.reuse = reuse;
    this.timeOps = timeOps;
  }

  public void convertToArrays() {
    commands = new int [tempCommands.size()];
    args1 = new Object [commands.length];
    args2 = new int [commands.length];
    for (int i = 0; i < commands.length; i++) {
      commands[i] = ((Integer) tempCommands.get(i)).intValue();
      args1[i] = tempArgs1.get(i);
      args2[i] = ((Integer) tempArgs2.get(i)).intValue();
    }
  }

  public void addCommand (int command, Object arg1, int arg2) {
    tempCommands.add (new Integer (command));
    tempArgs1.add (arg1);
    tempArgs2.add (new Integer (arg2));
  }

  public int currentSize() {
    return tempCommands.size();
  }

  public Object getResult (Map data) {
    Object curr = null;
    int cmdPtr = -1;
    int num;

    while (++cmdPtr < commands.length) {
      switch (commands[cmdPtr]) {

        case PUSH:
          dataStack [dataPtr] = curr;
          dataPtr++;
          break;

        case VARIABLE:
          curr = data.get (args1[cmdPtr]);
          break;

        case CONSTANT:
          curr = args1[cmdPtr];
          break;

        case GET:
          curr = ((SchObject) curr).getField ((String) args1[cmdPtr]);
          break;

        case SET:
          data.put (args1[cmdPtr], curr);
          break;

        case UNSET:
          data.remove (args1[cmdPtr]);
          break;

        case JUMP:
          cmdPtr = args2[cmdPtr];
          break;

        case JUMPNULL:
          if (curr == null)
            cmdPtr = args2[cmdPtr];
          break;

        case JUMPIF:
          if (((Boolean) curr).booleanValue())
            cmdPtr = args2[cmdPtr];
          break;

        case JUMPIFNOT:
          if (! ((Boolean) curr).booleanValue())
            cmdPtr = args2[cmdPtr];
          break;

        case EQ:
          dataPtr--;
          curr = dataStack[dataPtr].equals (curr) ? TRUE : FALSE;
          break;

        case NE:
          dataPtr--;
          curr = dataStack[dataPtr].equals (curr) ? FALSE : TRUE;
          break;

        case LT_FLT:
          dataPtr--;
          curr = (((Reusable.RFloat) dataStack[dataPtr]).floatValue() <
                  ((Reusable.RFloat) curr).floatValue() ?
                  TRUE : FALSE);
          break;

        case LT_INT:
          dataPtr--;
          curr = (((Reusable.RInteger) dataStack[dataPtr]).intValue() <
                  ((Reusable.RInteger) curr).intValue() ?
                  TRUE : FALSE);
          break;

        case GT_FLT:
          dataPtr--;
          curr = (((Reusable.RFloat) dataStack[dataPtr]).floatValue() >
                  ((Reusable.RFloat) curr).floatValue() ?
                  TRUE : FALSE);
          break;

        case GT_INT:
          dataPtr--;
          curr = (((Reusable.RInteger) dataStack[dataPtr]).intValue() >
                  ((Reusable.RInteger) curr).intValue() ?
                  TRUE : FALSE);
          break;

        case LE_FLT:
          dataPtr--;
          curr = (((Reusable.RFloat) dataStack[dataPtr]).floatValue() <=
                  ((Reusable.RFloat) curr).floatValue() ?
                  TRUE : FALSE);
          break;

        case LE_INT:
          dataPtr--;
          curr = (((Reusable.RInteger) dataStack[dataPtr]).intValue() <=
                  ((Reusable.RInteger) curr).intValue() ?
                  TRUE : FALSE);
          break;

        case GE_FLT:
          dataPtr--;
          curr = (((Reusable.RFloat) dataStack[dataPtr]).floatValue() >=
                  ((Reusable.RFloat) curr).floatValue() ?
                  TRUE : FALSE);
          break;

        case GE_INT:
          dataPtr--;
          curr = (((Reusable.RInteger) dataStack[dataPtr]).intValue() >=
                  ((Reusable.RInteger) curr).intValue() ?
                  TRUE : FALSE);
          break;

        case NOT:
          curr = ((Boolean) curr).booleanValue() ? FALSE : TRUE;
          break;

        case PLUS_INT_FLT:
          dataPtr--;
          curr = reuse.getInteger
            (((Reusable.RInteger) dataStack[dataPtr]).intValue() +
             ((int) ((Reusable.RFloat) curr).floatValue()));
          break;

        case PLUS_FLT_INT:
          dataPtr--;
          curr = reuse.getInteger
            (((int) ((Reusable.RFloat) dataStack[dataPtr]).floatValue()) +
             ((Reusable.RInteger) curr).intValue());
          break;

        case PLUS_FLT_FLT:
          dataPtr--;
          curr = reuse.getFloat
            (((Reusable.RFloat) dataStack[dataPtr]).floatValue() +
             ((Reusable.RFloat) curr).floatValue());
          break;

        case MINUS_INT_FLT:
          dataPtr--;
          curr = reuse.getInteger
            (((Reusable.RInteger) dataStack[dataPtr]).intValue() -
             ((int) ((Reusable.RFloat) curr).floatValue()));
          break;

        case MINUS_FLT_FLT:
          dataPtr--;
          curr = reuse.getFloat
            (((Reusable.RFloat) dataStack[dataPtr]).floatValue() -
             ((Reusable.RFloat) curr).floatValue());
          break;

        case MINUS_INT_INT:
          dataPtr--;
          curr = reuse.getFloat
            ((float) (((Reusable.RInteger) dataStack[dataPtr]).intValue() -
                      ((Reusable.RInteger) curr).intValue()));
          break;

        case TIMES:
          dataPtr--;
          curr = reuse.getFloat
            (((Reusable.RFloat) dataStack[dataPtr]).floatValue() *
             ((Reusable.RFloat) curr).floatValue());
          break;

        case DIVIDE:
          dataPtr--;
          curr = reuse.getFloat
            (((Reusable.RFloat) dataStack[dataPtr]).floatValue() /
             ((Reusable.RFloat) curr).floatValue());
          break;

        case MAX:
          dataPtr--;
          if (((Reusable.RFloat) dataStack[dataPtr]).floatValue() >
              ((Reusable.RFloat) curr).floatValue())
            curr = dataStack[dataPtr];
          break;

        case MIN:
          dataPtr--;
          if (((Reusable.RFloat) dataStack[dataPtr]).floatValue() <
              ((Reusable.RFloat) curr).floatValue())
            curr = dataStack[dataPtr];
          break;

        case NEW_LIST:
          curr = reuse.getList();
          break;

        case ADD_TO_LIST:
          dataPtr--;
          ((ArrayList) dataStack[dataPtr]).add (curr);
          curr = dataStack[dataPtr];
          break;

        case COMPLETE:
          int compInt = ((Resource) curr).completeTime();
          curr = ((compInt == Integer.MIN_VALUE) ?
                  data.get ("start_time") : reuse.getInteger (compInt));
          break;

        default:
          throw new RuntimeException ("Unknown command " + commands[cmdPtr]);

      }
    }
    return curr;
  }

}
