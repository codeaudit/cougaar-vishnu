/*
 * <copyright>
 *  Copyright 2001 BBNT Solutions, LLC
 *  under sponsorship of the Defense Advanced Research Projects Agency (DARPA).
 * 
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the Cougaar Open Source License as published by
 *  DARPA on the Cougaar Open Source Website (www.cougaar.org).
 * 
 *  THE COUGAAR SOFTWARE AND ANY DERIVATIVE SUPPLIED BY LICENSOR IS
 *  PROVIDED 'AS IS' WITHOUT WARRANTIES OF ANY KIND, WHETHER EXPRESS OR
 *  IMPLIED, INCLUDING (BUT NOT LIMITED TO) ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND WITHOUT
 *  ANY WARRANTIES AS TO NON-INFRINGEMENT.  IN NO EVENT SHALL COPYRIGHT
 *  HOLDER BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT OR CONSEQUENTIAL
 *  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE OF DATA OR PROFITS,
 *  TORTIOUS CONDUCT, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *  PERFORMANCE OF THE COUGAAR SOFTWARE.
 * </copyright>
 */

import java.io.*;
import org.cougaar.lib.vishnu.server.*;
import java.util.ArrayList;

public class JobshopDirect {

  public static void main (String[] args2) {
    try {
      // initial data
      RandomAccessFile f = new RandomAccessFile ("testdirect.vsh", "r");
      byte[] b = new byte [(int) f.length()];
      f.read (b, 0, b.length);
      Scheduler sched = new Scheduler();

      // Call setupInternal before adding the data
      sched.setupInternal (new String(b));

      // These are things created by the scheduler during setup that
      // are needed for direct object writing.
      TimeOps timeOps = sched.getTimeOps();
      SchedulingData data = sched.getSchedulingData();

      // There are three basic types of top-level data to add: tasks,
      // resources and globals.  These are of class Task, Resource, and
      // SchObject respectively.  There are methods addTask, addResource,
      // and addGlobal for each of these.  For globals, you need to
      // specify both the name and object type.
      data.addTask (makeTask (timeOps, "welding 1", "300.00", "true",
                              "false", "false", new String[] {"cutting 1"}));
      data.addTask (makeTask (timeOps, "welding 2", "240.00", "true",
                              "false", "false", new String[0]));
      data.addTask (makeTask (timeOps, "cutting 1", "840.00", "false",
                              "true", "false", new String[0]));
      data.addTask (makeTask (timeOps, "painting 1", "540.00", "false",
                              "false", "true", new String[0]));
      data.addTask (makeTask (timeOps, "painting 2", "360.00", "false",
                              "false", "true",
                              new String[] {"welding 1", "welding 2"}));
      data.addResource (makeResource (timeOps, "machine 1", "true", "true",
                                      "false", "10.0", "20.0",
                                      new SchObject[0]));
      // If a list contains objects, then each element of the list must
      // be created with a new SchObject and then added.
      SchObject i1 = makeInterval (timeOps, "2000-05-15 09:05:00",
                              "2000-05-15 09:10:00", "unplanned", "Jam");
      SchObject i2 = makeInterval (timeOps, "2000-05-15 09:50:00",
                              "2000-05-15 10:00:00", "planned", "Repair");
      data.addResource (makeResource (timeOps, "machine 2", "false", "false",
                                      "true", "20.0", "-10.0",
                                      new SchObject[] {i1, i2}));
      data.addGlobal ("test", "interval",
                      makeInterval (timeOps, "2000-05-15 09:05:00",
                              "2000-05-15 09:10:00", "unplanned", "Jam"));

      // Call scheduleInternal after adding all the data
      sched.scheduleInternal();

      // This shows how to extract the assignments after scheduling.
      // When sched.assignmentsMultitask() is true, the assignments
      // will actually be MultitaskAssignment objects instead.
      ArrayList assigns = sched.getAssignments();
      for (int i = 0; i < assigns.size(); i++) {
        Assignment assign = (Assignment) assigns.get(i);
        System.out.println
          ("Assignment: task = " + assign.getTask().getKey() +
           " resource = " + assign.getResource().getKey() +
           " setup = " + timeOps.timeToString (assign.getStartTime()) +
           " wrapup = " + timeOps.timeToString (assign.getEndTime()) +
           " start = " + timeOps.timeToString (assign.getTaskStartTime()) +
           " end = " + timeOps.timeToString (assign.getTaskEndTime()));
      }
      System.out.println ("finished initial");
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
  }

  private static Task makeTask (TimeOps to, String id, String dur,
                                String qweld, String qcut,
                                String qpaint, String[] prec) {
    Task task = new Task (to);
    // Values of fields are added to an object using addField.
    // Note that the fourth argument is true for id because it is the
    // key, and the fifth argument is false because it is not a list.
    task.addField ("id", "string", id, true, false);
    task.addField ("duration_in_seconds", "number", dur, false, false);
    // Note that subobjects that are not part of a list get flattened
    // out.  The field name is field1.field2.***.fieldn, where these
    // are the field names from the different levels of subobjects.
    task.addField ("quals_required.welding", "boolean", qweld,
                   false, false);
    task.addField ("quals_required.cutting", "boolean", qcut,
                   false, false);
    task.addField ("quals_required.painting", "boolean", qpaint,
                   false, false);
    // For fields that are lists, first call addListField to set up
    // the list.  Then, call addField with the final argument true for
    // each element of the list.
    task.addListField ("preceeding_tasks");
    for (int i = 0; i < prec.length; i++)
      task.addField ("preceeding_tasks", "string", prec[i], false, true);
    return task; 
  }

  private static Resource makeResource
    (TimeOps to, String id, String qweld, String qcut, String qpaint,
     String locx, String locy, SchObject[] intervals) {
    Resource r = new Resource (to);
    r.addField ("id", "string", id, true, false);
    r.addField ("quals.welding", "boolean", qweld, false, false);
    r.addField ("quals.cutting", "boolean", qcut, false, false);
    r.addField ("quals.painting", "boolean", qpaint, false, false);
    // Note that the object in the location field is both added
    // to that field, as well as having its fields added.
    // This is the correct way to handle all objects of predefined
    // types (interval, xy_coord, latlong, matrix) when they are
    // subobjects.
    // The reason for this is that it is possible to access either
    // the whole object or its fields in formulas.
    SchObject loc = new SchObject (to);
    loc.addField ("x", "number", locx, false, false);
    loc.addField ("y", "number", locy, false, false);
    r.addField ("location", "xy_coord", loc, false, false);
    r.addField ("location.x", "number", locx, false, false);
    r.addField ("location.y", "number", locy, false, false);
    r.addListField ("maintenance");
    for (int i = 0; i < intervals.length; i++)
      r.addField ("maintenance", "interval", intervals[i], false, true);
    return r;
  }

  private static SchObject makeInterval (TimeOps to, String t1, String t2,
                                         String l1, String l2) {
    SchObject obj = new SchObject (to);
    obj.addField ("start", "datetime", t1, false, false);
    obj.addField ("end", "datetime", t2, false, false);
    obj.addField ("label1", "string", l1, false, false);
    obj.addField ("label2", "string", l2, false, false);
    return obj;
  }

}
