// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/ExecutionStack.java,v 1.1 2001-08-15 18:21:50 dmontana Exp $

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
  public static final int JUMP = 202;
  public static final int JUMPNULL = 203;
  public static final int JUMPIF = 4;
  public static final int JUMPIFNOT = 224;
  public static final int ITER_INIT = 214;
  public static final int ITER_START = 215;
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
  public static final int ABS = 80;
  public static final int MOD = 81;
  public static final int MAX_FLT = 18;
  public static final int MIN_FLT = 19;
  public static final int MAX_INT = 318;
  public static final int MIN_INT = 319;
  public static final int ADD_TO_LIST = 20;
  public static final int NEW_LIST = 211;
  public static final int NEW_FLT = 212;
  public static final int NEW_INT = 312;
  public static final int CMP_EXTREME = 313;
  public static final int APPEND_LIST = 21;
  public static final int APPEND_STRING = 22;
  public static final int PREPTIME = 237;
  public static final int BUSYTIME = 238;
  public static final int COMPLETE = 23;
  public static final int TASKSFOR = 230;
  public static final int RESOURCEFOR = 233;
  public static final int TASKSTARTTIME = 231;
  public static final int TASKENDTIME = 232;
  public static final int TASKSETUPTIME = 234;
  public static final int TASKWRAPUPTIME = 235;
  public static final int GROUPFOR = 236;
  public static final int INTERVAL = 240;
  public static final int XY_COORD = 241;
  public static final int LATLONG = 242;
  public static final int DIST_XY = 243;
  public static final int DIST_LL = 244;

  private static final float EARTH_RADIUS = 3437.75f; // nmi
  private static final float DEGREES_TO_RADIANS = (3.1415927f / 180.0f);

  private ArrayList tempCommands = new ArrayList();
  private int[] commands;
  private ArrayList tempArgs1 = new ArrayList();
  private Object[] args1;
  private ArrayList tempArgs2 = new ArrayList();
  private int[] args2;

  private Object[] dataStack = new Object[40];
  private int dataPtr = 0;
  private int[] ctrStack = new int[12];
  private int ctrPtr = 0;

  private Reusable reuse;
  private TimeOps timeOps;
  private Object curr;


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

  private final boolean notNull() {
    if (curr == null)
      return false;
    if (dataStack[dataPtr] != null)
      return true;
    curr = null;
    return false;
  }

  public Object getResult (Map data) {
    curr = null;
    int cmdPtr = -1;
    int num;
    Assignment a;
    SchObject so;

    while (++cmdPtr < commands.length) {
      switch (commands[cmdPtr]) {

        case PUSH:
          dataStack [dataPtr++] = curr;
          break;

        case VARIABLE:
          curr = data.get (args1[cmdPtr]);
          break;

        case CONSTANT:
          curr = args1[cmdPtr];
          break;

        case GET:
          if (curr != null)
            curr = ((SchObject) curr).getField ((String) args1[cmdPtr]);
          break;

        case JUMP:
          cmdPtr = args2[cmdPtr];
          break;

        case JUMPNULL:
          if (curr == null)
            cmdPtr = args2[cmdPtr];
          break;

        case JUMPIF:
          if ((curr != null) && ((Boolean) curr).booleanValue())
            cmdPtr = args2[cmdPtr];
          break;

        case JUMPIFNOT:
          if ((curr != null) && (! ((Boolean) curr).booleanValue()))
            cmdPtr = args2[cmdPtr];
          break;

        case EQ:
          dataPtr--;
          if (curr != null)
            curr = curr.equals (dataStack[dataPtr]) ? TRUE : FALSE;
          break;

        case NE:
          dataPtr--;
          if (curr != null)
            curr = curr.equals (dataStack[dataPtr]) ? FALSE : TRUE;
          break;

        case LT_FLT:
          dataPtr--;
          if (notNull())
            curr = (((Reusable.RFloat) dataStack[dataPtr]).floatValue() <
                    ((Reusable.RFloat) curr).floatValue() ?
                    TRUE : FALSE);
          break;

        case LT_INT:
          dataPtr--;
          if (notNull())
            curr = (((Reusable.RInteger) dataStack[dataPtr]).intValue() <
                    ((Reusable.RInteger) curr).intValue() ?
                    TRUE : FALSE);
          break;

        case GT_FLT:
          dataPtr--;
          if (notNull())
            curr = (((Reusable.RFloat) dataStack[dataPtr]).floatValue() >
                    ((Reusable.RFloat) curr).floatValue() ?
                    TRUE : FALSE);
          break;

        case GT_INT:
          dataPtr--;
          if (notNull())
            curr = (((Reusable.RInteger) dataStack[dataPtr]).intValue() >
                    ((Reusable.RInteger) curr).intValue() ?
                    TRUE : FALSE);
          break;

        case LE_FLT:
          dataPtr--;
          if (notNull())
            curr = (((Reusable.RFloat) dataStack[dataPtr]).floatValue() <=
                    ((Reusable.RFloat) curr).floatValue() ?
                    TRUE : FALSE);
          break;

        case LE_INT:
          dataPtr--;
          if (notNull())
            curr = (((Reusable.RInteger) dataStack[dataPtr]).intValue() <=
                    ((Reusable.RInteger) curr).intValue() ?
                    TRUE : FALSE);
          break;

        case GE_FLT:
          dataPtr--;
          if (notNull())
            curr = (((Reusable.RFloat) dataStack[dataPtr]).floatValue() >=
                    ((Reusable.RFloat) curr).floatValue() ?
                    TRUE : FALSE);
          break;

        case GE_INT:
          dataPtr--;
          if (notNull())
            curr = (((Reusable.RInteger) dataStack[dataPtr]).intValue() >=
                    ((Reusable.RInteger) curr).intValue() ?
                    TRUE : FALSE);
          break;

        case NOT:
          if (curr != null)
            curr = ((Boolean) curr).booleanValue() ? FALSE : TRUE;
          break;

        case PLUS_INT_FLT:
          dataPtr--;
          if (notNull())
            curr = reuse.getInteger
              (((Reusable.RInteger) dataStack[dataPtr]).intValue() +
               ((int) ((Reusable.RFloat) curr).floatValue()));
          break;

        case PLUS_FLT_INT:
          dataPtr--;
          if (notNull())
            curr = reuse.getInteger
              (((int) ((Reusable.RFloat) dataStack[dataPtr]).floatValue()) +
               ((Reusable.RInteger) curr).intValue());
          break;

        case PLUS_FLT_FLT:
          dataPtr--;
          if (notNull())
            curr = reuse.getFloat
              (((Reusable.RFloat) dataStack[dataPtr]).floatValue() +
               ((Reusable.RFloat) curr).floatValue());
          break;

        case MINUS_INT_FLT:
          dataPtr--;
          if (notNull())
            curr = reuse.getInteger
              (((Reusable.RInteger) dataStack[dataPtr]).intValue() -
               ((int) ((Reusable.RFloat) curr).floatValue()));
          break;

        case MINUS_FLT_FLT:
          dataPtr--;
          if (notNull())
            curr = reuse.getFloat
              (((Reusable.RFloat) dataStack[dataPtr]).floatValue() -
               ((Reusable.RFloat) curr).floatValue());
          break;

        case MINUS_INT_INT:
          dataPtr--;
          if (notNull())
            curr = reuse.getFloat
              ((float) (((Reusable.RInteger) dataStack[dataPtr]).intValue() -
                        ((Reusable.RInteger) curr).intValue()));
          break;

        case TIMES:
          dataPtr--;
          if (notNull())
            curr = reuse.getFloat
              (((Reusable.RFloat) dataStack[dataPtr]).floatValue() *
               ((Reusable.RFloat) curr).floatValue());
          break;

        case DIVIDE:
          dataPtr--;
          if (notNull())
            curr = reuse.getFloat
              (((Reusable.RFloat) dataStack[dataPtr]).floatValue() /
               ((Reusable.RFloat) curr).floatValue());
          break;

        case MOD:
          dataPtr--;
          if (notNull())
            curr = reuse.getFloat
              (((Reusable.RFloat) dataStack[dataPtr]).floatValue() %
               ((Reusable.RFloat) curr).floatValue());
          break;

        case ABS:
          if (notNull())
            curr = reuse.getFloat
              (Math.abs (((Reusable.RFloat) curr).floatValue()));
          break;

        case MAX_FLT:
          dataPtr--;
          if (notNull())
            if (((Reusable.RFloat) dataStack[dataPtr]).floatValue() >
                ((Reusable.RFloat) curr).floatValue())
              curr = dataStack[dataPtr];
          break;

        case MIN_FLT:
          dataPtr--;
          if (notNull())
            if (((Reusable.RFloat) dataStack[dataPtr]).floatValue() <
                ((Reusable.RFloat) curr).floatValue())
              curr = dataStack[dataPtr];
          break;

        case MAX_INT:
          dataPtr--;
          if (notNull())
            if (((Reusable.RInteger) dataStack[dataPtr]).intValue() >
                ((Reusable.RInteger) curr).intValue())
              curr = dataStack[dataPtr];
          break;

        case MIN_INT:
          dataPtr--;
          if (notNull())
            if (((Reusable.RInteger) dataStack[dataPtr]).intValue() <
                ((Reusable.RInteger) curr).intValue())
              curr = dataStack[dataPtr];
          break;

        case ITER_INIT:
          dataStack[dataPtr++] = curr;
          ctrStack[ctrPtr++] = 0;
          ctrStack[ctrPtr++] = ((ArrayList) curr).size();
          break;

        case ITER_START:
          int acc = ctrStack[ctrPtr-2];
          if (acc == 0)
            dataStack[dataPtr++] = curr;
          if (acc >= ctrStack[ctrPtr-1]) {
            cmdPtr = args2[cmdPtr];
            ctrPtr -= 2;
            dataPtr -= 2;
            curr = dataStack[dataPtr+1];
            data.remove (args1[cmdPtr]);
            break;
          }
          data.put (args1[cmdPtr],
               ((ArrayList) dataStack[dataPtr-2]).get(ctrStack[ctrPtr-2]++));
          break;

        case NEW_LIST:
          curr = reuse.getList();
          break;

        case NEW_FLT:
          switch (args2[cmdPtr]) {
            case -1:  curr = reuse.getFloat (Float.MIN_VALUE); break;
            case 0:  curr = reuse.getFloat (0.0f); break;
            case 1:  curr = reuse.getFloat (Float.MAX_VALUE); break;
          }
          break;

        case NEW_INT:
          switch (args2[cmdPtr]) {
            case -1:  curr = reuse.getInteger (Integer.MIN_VALUE); break;
            case 1:  curr = reuse.getInteger (Integer.MAX_VALUE); break;
          }
          break;

        case CMP_EXTREME:
          if (args1[cmdPtr].equals ("number")) {
            if (((Reusable.RFloat) curr).floatValue() ==
                (args2[cmdPtr] == 1 ? Float.MAX_VALUE : Float.MIN_VALUE))
              curr = null;
          } else {
            if (((Reusable.RInteger) curr).intValue() ==
                (args2[cmdPtr] == 1 ? Integer.MAX_VALUE : Integer.MIN_VALUE))
              curr = null;
          }
          break;

        case ADD_TO_LIST:
          if (curr != null)
            ((ArrayList) dataStack[dataPtr-1]).add (curr);
          break;

        case COMPLETE:
          if (curr == null)
            break;
          int compInt = ((Resource) curr).completeTime();
          curr = ((compInt == Integer.MIN_VALUE) ?
                  data.get ("start_time") : reuse.getInteger (compInt));
          break;

        case PREPTIME:
          if (curr != null)
            curr = reuse.getFloat (((Resource) curr).prepTime());
          break;

        case TASKSTARTTIME:
          if (curr == null)
            break;
          a = ((Task) curr).getAssignment();
          if (a != null)
            curr = reuse.getInteger (a.getTaskStartTime());

        case TASKENDTIME:
          if (curr == null)
            break;
          a = ((Task) curr).getAssignment();
          if (a != null)
            curr = reuse.getInteger (a.getTaskEndTime());
          break;

        case TASKSETUPTIME:
          if (curr == null)
            break;
          a = ((Task) curr).getAssignment();
          if (a != null)
            curr = reuse.getInteger (a.getStartTime());
          break;

        case TASKWRAPUPTIME:
          if (curr == null)
            break;
          a = ((Task) curr).getAssignment();
          if (a != null)
            curr = reuse.getInteger (a.getEndTime());
          break;

        case RESOURCEFOR:
          if (curr == null)
            break;
          a = ((Task) curr).getAssignment();
          if (a != null)
            curr = a.getResource();
          break;

        case GROUPFOR:
          if (curr == null)
            break;
          a = ((Task) curr).getAssignment();
          if (a != null)
            curr = a.getResource().getGroup (reuse.getList(), (Task) curr);
          break;

        case INTERVAL:
          dataPtr -= args2[cmdPtr];
          if (! notNull())
            break;
          so = new SchObject (timeOps);
          so.addField ("start", "", ((Reusable.RInteger) curr).copy(),
                       false, false);
          so.addField ("end", "",
                       ((Reusable.RInteger) dataStack[dataPtr]).copy(),
                       false, false);
          if (args2[cmdPtr] > 1)
            so.addField ("label1", "string",
                         ((Reusable.RInteger) dataStack[dataPtr+1]).copy(),
                         false, false);
          if (args2[cmdPtr] > 2)
            so.addField ("label2", "string",
                         ((Reusable.RInteger) dataStack[dataPtr+2]).copy(),
                         false, false);
          curr = so;
          break;

        case LATLONG:
          dataPtr--;
          if (! notNull())
            break;
          so = new SchObject (timeOps);
          so.addField ("latitude", "", ((Reusable.RFloat) curr).copy(),
                       false, false);
          so.addField ("longitude", "",
                       ((Reusable.RFloat) dataStack[dataPtr]).copy(),
                       false, false);
          curr = so;
          break;

        case DIST_XY:
          dataPtr--;
          if (! notNull())
            break;
          SchObject so1 = (SchObject) curr;
          SchObject so2 = (SchObject) dataStack[dataPtr];
          float xdiff = (((Reusable.RFloat) so1.getField("x")).floatValue() -
                         ((Reusable.RFloat) so2.getField("x")).floatValue());
          float ydiff = (((Reusable.RFloat) so1.getField("y")).floatValue() -
                         ((Reusable.RFloat) so2.getField("y")).floatValue());
          double dist = Math.sqrt ((double) (xdiff * xdiff + ydiff * ydiff));
          curr = reuse.getFloat ((float) dist);
          break;

        case DIST_LL:
          dataPtr--;
          if (! notNull())
            break;
          SchObject so3 = (SchObject) curr;
          SchObject so4 = (SchObject) dataStack[dataPtr];
          float lat1 = (((Reusable.RFloat) so3.getField ("latitude")).
                        floatValue() * DEGREES_TO_RADIANS);
          float lat2 = (((Reusable.RFloat) so4.getField ("latitude")).
                        floatValue() * DEGREES_TO_RADIANS);
          float dlong = (((Reusable.RFloat) so3.getField ("longitude")).
                         floatValue() -
                         ((Reusable.RFloat) so4.getField ("longitude")).
                         floatValue()) * DEGREES_TO_RADIANS;
          double rads =
            Math.acos (Math.sin ((double) lat1) * Math.sin ((double) lat2) +
                       Math.cos ((double) lat1) * Math.cos ((double) lat2) *
                       Math.cos ((double) dlong));
          curr = reuse.getFloat (EARTH_RADIUS * (float) rads);
          break;

        default:
          throw new RuntimeException ("Unknown command " + commands[cmdPtr]);

      }
    }
    return curr;
  }

}
