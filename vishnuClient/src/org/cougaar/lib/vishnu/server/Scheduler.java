// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Scheduler.java,v 1.11 2001-04-06 18:50:32 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import org.apache.xerces.parsers.SAXParser;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.SAXException;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

/**
 * This is the main class for the reconfigurable scheduler.
 *
 * The scheduler can run in two different modes.
 * The primary mode is as a separate process.  In this mode, the
 * scheduler pings a URL at regular intervals to see if there are
 * any problems that need solving.  If so, it picks one of the
 * problems and tells a URL which it has picked, reads all the data
 * specifying the problem from URLs, executes the genetic algorithm,
 * and writes the assignments of the best schedule back to another URL.
 *
 * In a second mode, the scheduler runs as part of another Java process.
 * Invoking the method runInternalToProcess makes it execute and
 * return the assignments as a string.
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public class Scheduler {

  private long waitInterval = 5000;
  private String problem;
  private String probNumber;
  private SchedulingData data = null;
  private SchedulingSpecs specs = null;
  private GeneticAlgorithm ga = null;
  private TimeOps timeOps;

  private static boolean debug = 
    ("true".equals (System.getProperty ("vishnu.Scheduler.debug")));
  private static String onlyTheseProblems = 
    System.getProperty ("vishnu.Scheduler.problems");
  private static String onlyTheseMachines = 
    System.getProperty ("vishnu.Scheduler.machines");
  private static boolean showAssignments = 
    ("true".equals (System.getProperty ("vishnu.Scheduler.showAssignments")));
  private static boolean reportTiming = 
    ("true".equals (System.getProperty ("vishnu.Scheduler.reportTiming")));

  private Set allowedProblems = new HashSet ();
  private Set allowedMachines = new HashSet ();
  private List ignoredProblems = null;
  
  public Scheduler () {
    if (onlyTheseProblems != null && onlyTheseProblems.length() > 1) {
      getNames (allowedProblems, onlyTheseProblems);
      System.out.println ("Scheduler will only process these problems: " +
                          allowedProblems);
    }
    else if (onlyTheseMachines != null && onlyTheseMachines.length() > 1) {
      getNames (allowedMachines, onlyTheseMachines);
      System.out.println ("Scheduler will only process problems from " +
                          "these machines: " + allowedMachines);
    }

    String waitIntervalProp = null;
    try {
      waitIntervalProp = 
        System.getProperty ("vishnu.Scheduler.waitInterval");
      if (waitIntervalProp != null)
        waitInterval = Long.parseLong (waitIntervalProp);
    } catch (NumberFormatException nfe) {
      System.out.println ("Scheduler.Scheduler - expecting a long for "+ 
                          "waitInterval, but got " + waitIntervalProp);	  
    }
  }

  protected void getNames (Set nameSet, String names) {
    StringTokenizer st = new StringTokenizer(names, ",");
    while (st.hasMoreTokens()) {
      String name = st.nextToken();
      nameSet.add (name.trim());
    }
  }

  private void run() {
    ClientComms.initialize();
    System.out.println ("Scheduler ready to schedule problems posted to " +
                        ClientComms.getHost());
    while (true) {
      Exception error = getProblem();
      if ((error != null) || (problem == null)) {
        releaseLock();
        try { Thread.sleep (waitInterval); } catch (Exception e) {}
      } else {
        Date grandStart = new Date ();
        System.out.println ("Starting to schedule " + problem +
                            " at " + grandStart);
        boolean canceled = ackProblem (1, null);
        releaseLock();
        if (canceled) {
          System.out.println ("Canceled " + problem);
          problem = null;
          continue;
        }
        if (debug) System.out.println ("Did ack.");
        timeOps = new TimeOps();
        Date start = new Date();
        error = readSpecs();
        if (debug && (error == null)) System.out.println ("Read specs.");

        if (error == null)
          error = readData();
        if (debug && (error == null))
          reportTime ("Scheduler read data in ", start);

        start = new Date();
        if (error == null) {
          specs.initializeData (data);
          data.initialize (specs);
          error = setupGA();
        }
        if (debug && (error == null)) reportTime ("Set up ga in ", start);

        canceled = false;
        if (error == null)
          try {
            start = new Date();
            canceled = ga.execute (data, specs);
            if (canceled)
              System.out.println ("Canceled " + problem);
          } catch (Exception e) {
            System.err.println (e.getMessage());
            e.printStackTrace();
            error = e;
          }
        if (debug && (error == null))
          reportTime ("GA finished, ran in ", start);
        if (debug)
          specs.reportTiming ();

        start = new Date();
        if ((error == null) && (! canceled)) {
          writeSchedule();
	  writeCapacities();
        }
        if (debug && (error == null)) reportTime ("Wrote schedule in ", start);
        ackProblem (100, error);
        if (error == null)
          reportTime ("Finished scheduling at " + new Date() +
                      ", it took ", grandStart);
        else
          System.out.println ("Aborted scheduling, message is: " +
                              error.getMessage());
        problem = null;
      }
    }
  }

  protected void reportTime (String prefix, Date start) 
  {
    Runtime rt = Runtime.getRuntime ();
    Date end = new Date ();
    long diff = end.getTime () - start.getTime ();
    long min  = diff/60000l;
    long sec  = (diff - (min*60000l))/1000l;
    System.out.println  (prefix + min + ":" + ((sec < 10) ? "0":"") + sec + 
			 " free "  + (rt.freeMemory  ()/(1024*1024)) + "M" +
			 " total " + (rt.totalMemory ()/(1024*1024)) + "M");
  }

  /** Write all the XML representation of assignments to a URL */
  private void writeSchedule() {
    Map args = getArgs();
    String str = textForSchedule();
    if (showAssignments)
      System.out.println ("Scheduler.writeSchedule - " + str);

    args.put ("data", str);
    ClientComms.postToURL (args, "postassignments.php");
  }

  /** Compute the XML representation of assignments */
  private String textForSchedule () {
    Task[] tasks = data.getTasks();
    StringBuffer text = new StringBuffer (tasks.length * 200);
    text.append ("<?xml version='1.0'?>\n<SCHEDULE>\n");
    boolean isEndTime = data.getEndTime() != Integer.MAX_VALUE;
    int maxTime = isEndTime ? data.getEndTime() : data.getStartTime();
    for (int i = 0; i < tasks.length; i++) {
      Assignment assign = tasks[i].getAssignment();
      if (assign != null) {
        assign.setColor (specs.getColor (tasks[i]));
        assign.setText (specs.taskText (tasks[i]));
        text.append (assign).append ("\n");
        if ((! isEndTime) && (maxTime < assign.getEndTime()))
          maxTime = assign.getEndTime();
      }
    }
    Resource[] resources = data.getResources();
    for (int i = 0; i < resources.length; i++) {
      TimeBlock[] activities = resources[i].getActivities();
      for (int j = 0; j < activities.length; j++)
        if (updateActivity (activities[j], maxTime))
          text.append
            (activities[j].activityString (resources[i])).append ("\n");
      MultitaskAssignment[] multi = resources[i].getMultitaskAssignments();
      for (int j = 0; j < multi.length; j++)
        if (updateActivity (multi[j], maxTime)) {
          multi[j].setColor (specs.getColor (multi[j].getTasks()));
          multi[j].setText (specs.groupedText (multi[j].getTasks()));
          text.append (multi[j]).append ("\n");
        }
    }
    text.append ("</SCHEDULE>\n");
    return text.toString();
  }


  private void writeCapacities() {
    Map capacities = (Map) data.getCapacities();

    Map args = getArgs();
    StringBuffer text = new StringBuffer (capacities.size() * 60);
    text.append ("<?xml version='1.0'?>\n<CAPACITIES>\n");

    Set entries = capacities.entrySet(); 
    for (Iterator i = entries.iterator(); i.hasNext();) {
       Map.Entry entry = (Map.Entry) i.next();
       text.append ("<CAPACITY ID=\"").append (entry.getKey()).append
         ("\" value=\"").append
           (((Float) entry.getValue()).floatValue()).append ("\" />\n");
    }
    text.append ("</CAPACITIES>\n");
    if (showAssignments)
      System.out.println ("Scheduler.writeCapacities - " + text);

    args.put ("data", text.toString());
    ClientComms.postToURL (args, "postcapacities.php");
  }


  private boolean updateActivity (TimeBlock act, int maxTime) {
    if (act.getStartTime() >= maxTime)
      return false;
    if (act.getEndTime() > maxTime)
      act.setEndTime (maxTime);
    return true;
  }

  private Exception getProblem() {
    ignoredProblems = new ArrayList ();
    Exception excep = ClientComms.readXML (ClientComms.defaultArgs(),
                                           "currentrequest.php",
                                           new CurrentRequestHandler());
    if (debug && !ignoredProblems.isEmpty())
      System.out.println ("Scheduler - CurrentRequestHandler : " + 
                          "ignoring request for " + ignoredProblems);
    return excep;
  }


  private void releaseLock() {
    Map args = ClientComms.defaultArgs();
    ClientComms.postToURL (args, "releaselock.php");
  }

  /** returns true if canceled */
  boolean ackProblem (int percentComplete, Exception error) {
    Map args = getArgs();
    args.put ("percent_complete", new Integer (percentComplete));
    args.put ("number", probNumber);
    if (error != null) {
      args.put ("message", error.toString());
      StringWriter sw = new StringWriter();
      PrintWriter pw = new PrintWriter (sw, true);
      error.printStackTrace (pw);
      args.put ("trace", sw.toString());
    }
    String str = ClientComms.postToURL (args, "ackrequest.php");
    return str.indexOf ("canceled") != -1;
  }

  private Exception readData() {
    Map args = getArgs();
    StringBuffer text = new StringBuffer (2048);
    Map accesses = specs.allObjectAccesses();
    Iterator iter = accesses.keySet().iterator();
    while (iter.hasNext()) {
      String type = (String) iter.next();
      HashSet set = (HashSet) accesses.get (type);
      text.append (type);
      Iterator iter2 = set.iterator();
      while (iter2.hasNext())
        text.append (":").append (iter2.next());
      text.append (";");
    }
    args.put ("fields", text.toString());

    data = new SchedulingData (timeOps);
    return ClientComms.readXML (args, "data.php", data.getXMLHandler());
  }

  private Exception readSpecs() {
    specs = new SchedulingSpecs (timeOps);
    return ClientComms.readXML (getArgs(), "specs.php", specs.getXMLHandler());
  }

  private Exception setupGA() {
    ga = new GeneticAlgorithm (this);
    return ClientComms.readXML (getArgs(), "gaparms.php", ga.getXMLHandler());
  }

  private Map getArgs() {
    Map args = ClientComms.defaultArgs();
    args.put ("problem", problem);
    return args;
  }


  private class CurrentRequestHandler extends DefaultHandler {
    public void startElement (String uri, String local,
                              String name, Attributes atts) {
      if (name.equals ("PROBLEM") && doableProblem (atts.getValue("name"))) {
        problem = atts.getValue ("name");
        probNumber = atts.getValue ("number");
      }
      else if (atts.getValue("name") != null) {
        ignoredProblems.add (atts.getValue("name"));
      }
    }

    /**
     * <pre>
     * true if the properties are set up so the scheduler will accept the
     * the problem.  If the properties are not set, the scheduler will
     * try to do all problems.
     *
     * Looks for both allowed machines and specific allowed problem names
     * 
     * alp-107 becomes alp_107
     * </pre>
     * @return true if <code>problemName</code> is acceptable
     */
    protected boolean doableProblem (String problemName) {
      boolean match = false;
      for (Iterator iter = allowedMachines.iterator (); iter.hasNext(); ) {
        String machine = (String) iter.next ();
        machine = machine.replace ('-', '_'); 
        if (problemName.endsWith (machine)) {
          match = true;
          break;
        }
      }
      return ((allowedProblems.isEmpty () && allowedMachines.isEmpty ()) || 
              allowedProblems.contains(problemName) || match);
    }
  }


  /**
   * The function called to run the scheduler internal to a process
   * @param problem XML representation of the problem description
   * @return XML representation of all the assignments
   */
  public String runInternalToProcess (String problem) {
    try {
      timeOps = new TimeOps();
      specs = new SchedulingSpecs (timeOps);
      ga = new GeneticAlgorithm (this);
      data = new SchedulingData (timeOps);
      SAXParser parser = new SAXParser();
      parser.setContentHandler (new InternalRequestHandler());

      Date start = null;
      if (reportTiming) start = new Date ();
      parser.parse (new InputSource (new StringReader (problem)));
      if (reportTiming)
        reportTime ("Scheduler.runInternalToProcess - scheduler " +
                    "read data in ", start);

      if (reportTiming) start = new Date ();
      specs.initializeData (data);
      data.initialize (specs);
      if (reportTiming)
        reportTime ("Scheduler.runInternalToProcess - initialized " +
                    "data in ", start);
      if (reportTiming) start = new Date ();
      ga.execute (data, specs);
      if (reportTiming)
        reportTime ("Scheduler.runInternalToProcess - ga ran in ", start);
      Task[] tasks = data.getTasks();
      StringBuffer text = new StringBuffer (tasks.length * 150);
      text.append ("<?xml version='1.0'?>\n<ASSIGNMENTS>\n");
      if (specs.getMultitasking() != SchedulingSpecs.MULTITASKING_GROUPED) {
        for (int i = 0; i < tasks.length; i++) {
          Assignment assign = tasks[i].getAssignment();
          if (assign != null) {
            text.append ("<ASSIGNMENT task=\"");
            text.append (assign.getTask().getKey());
            text.append ("\" resource=\"");
            sharedTaskText (text, assign);
            text.append ("\" />\n");
          }
        }
      }
      else {
        Resource[] resources = data.getResources();
        for (int i = 0; i < resources.length; i++) {
          MultitaskAssignment[] multi = resources[i].getMultitaskAssignments();
          for (int j = 0; j < multi.length; j++) {
            text.append ("<MULTITASK resource=\"");
            sharedTaskText (text, multi[j]);
            text.append ("\" >\n");
            Task[] tasks2 = multi[j].getTasks();
            for (int k = 0; k < tasks2.length; k++) {
              text.append ("<TASK task=\"");
              text.append (tasks2[k].getKey());
              text.append ("\" />\n");
            }
            text.append ("</MULTITASK>\n");
          }
        }
      }
      text.append ("</ASSIGNMENTS>\n");
      return text.toString();
    } catch (Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
    return null;
  }

  private void sharedTaskText (StringBuffer text, Assignment assign) {
    text.append (assign.getResource().getKey());
    text.append ("\" start=\"");
    text.append (timeOps.timeToString (assign.getTaskStartTime()));
    text.append ("\" end=\"");
    text.append (timeOps.timeToString (assign.getTaskEndTime()));
    text.append ("\" setup=\"");
    text.append (timeOps.timeToString (assign.getStartTime()));
    text.append ("\" wrapup=\"");
    text.append (timeOps.timeToString (assign.getEndTime()));
  }

  private class InternalRequestHandler extends DefaultHandler {
    DefaultHandler dataHandler = data.getInternalXMLHandler();
    DefaultHandler specsHandler = specs.getXMLHandler();
    boolean handlingSpecs = false;
    DefaultHandler gaHandler = ga.getXMLHandler();
    boolean handlingGa = false;

    public void startElement (String uri, String local, String name,
                              Attributes atts) throws SAXException {
      if (handlingSpecs)
        specsHandler.startElement (uri, local, name, atts);
      else if (handlingGa)
        gaHandler.startElement (uri, local, name, atts);
      else if (name.equals ("SPECS")) {
        handlingSpecs = true;
        specsHandler.startElement (uri, local, name, atts);
      }
      else if (name.equals ("GAPARMS")) {
        handlingGa = true;
        gaHandler.startElement (uri, local, name, atts);
      }
      else dataHandler.startElement (uri, local, name, atts);
    }

    public void endElement (String uri, String local,
                            String name) throws SAXException {
      if (name.equals ("SPECS"))
        handlingSpecs = false;
      else if (name.equals ("GAPARMS"))
        handlingGa = false;
      else if (handlingSpecs)
        specsHandler.endElement (uri, local, name);
      else if (handlingGa)
        gaHandler.endElement (uri, local, name);
      else dataHandler.endElement (uri, local, name);
    }
  }


  public static void main (String[] args) {
    Scheduler s = new Scheduler();
    s.run();
  }

}
