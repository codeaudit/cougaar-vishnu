package org.cougaar.lib.vishnu.server;

import org.apache.xerces.parsers.SAXParser;
import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
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
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class Scheduler {

  private long waitInterval = 1000;
  private String problem;
  private String probNumber;
  private SchedulingData data = null;
  private SchedulingSpecs specs = null;
  private GeneticAlgorithm ga = null;
  private TimeOps timeOps;
  private SAXParser parser;

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
  private static boolean validatingInternalParser = 
    ("true".equals (System.getProperty ("vishnu.Scheduler.validatingInternalParser", "false")));

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
        try {
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
          Date start = new Date();
          error = readProblem();
          if (error != null)
            throw error;
          specs.initializeData (data);
          data.initialize (specs);
          if (debug)
            reportTime ("Read problem and initialized in ", start);

          canceled = false;
          start = new Date();
          canceled = ga.execute (data, specs);
          if (canceled)
            System.out.println ("Canceled " + problem);
          if (debug) {
            reportTime ("GA finished, ran in ", start);
            specs.reportTiming ();
          }

          start = new Date();
          if (! canceled) {
            writeSchedule();
            if (debug) reportTime ("\tWrote schedule in ", start);
            Date two = new Date();
            writeCapacities();
            if (debug) reportTime ("\tWrote capacities in ", two);
            Date three = new Date();
            writeCapabilities();
            if (debug) reportTime ("\tWrote capabilities in ", three);
          }
          if (debug) reportTime
            ("Wrote schedule, capacities, and capabilities in ", start);
          ackProblem (100, null);
          reportTime ("Finished scheduling " + 
                      (data.getTasks ().length -
                       data.getFrozenTasks ().length) + 
                      " new, " + data.getFrozenTasks ().length + 
                      " frozen tasks against " + data.getResources().length + 
                      " resources at " + new Date() +
                      ". It took ", grandStart);
        } catch (Exception e) {
          ackProblem (100, e);
          System.out.println ("Aborted scheduling, message is: " +
                              e.getMessage());
          e.printStackTrace();
          try { Thread.sleep (waitInterval); } catch (Exception eee) {}
        }
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
    long millis = diff - (min*60000l) - (sec*1000l);
	
	String mString = "";
	
	if (millis < 10)
	  mString = "00";
	else if (millis < 100)
	  mString = "0";

    System.out.println  (prefix + min + ":" + ((sec < 10) ? "0":"") + sec + 			 
						 ":" + mString + millis);
  }

  /** Write all the XML representation of assignments to a URL */
  private void writeSchedule() {
    Map args = getArgs();
    String str = getXMLAssignments (false, true);
    if (showAssignments)
      System.out.println ("Scheduler.writeSchedule - " + str);

    args.put ("data", str);
    ClientComms.postToURL (args, "postassignments.php");
  }

  /** Compute the XML representation of assignments */
  public String getXMLAssignments (boolean internal, boolean reportFrozen) {
    Date start = null;
    if (debug) start = new Date ();
    Task[] tasks = data.getTasks();
    StringBuffer text = new StringBuffer (tasks.length * 200);
    text.append ("<?xml version='1.0'?>\n<ASSIGNMENTS>\n");
    boolean isEndTime = data.getEndTime() != Integer.MAX_VALUE;
    int maxTime = isEndTime ? data.getEndTime() : data.getStartTime();
    if ((! internal) || (! assignmentsMultitask())) {
      for (int i = 0; i < tasks.length; i++) {
        Assignment assign = tasks[i].getAssignment();
        if ((assign != null) && (reportFrozen || (! assign.getFrozen()))) {
          assign.setColor (specs.getColor (tasks[i], SchedulingSpecs.TASK));
          assign.setText (specs.taskText (tasks[i]));
          if (specs.doSetupColor())
            assign.setSetupColor
              (specs.getColor (tasks[i], SchedulingSpecs.SETUP));
          if (specs.doWrapupColor())
            assign.setWrapupColor
              (specs.getColor (tasks[i], SchedulingSpecs.WRAPUP));
          text.append (assign).append ("\n");
          if ((! isEndTime) && (maxTime < assign.getEndTime()))
            maxTime = assign.getEndTime();
        }
      }
    }
    if (debug) reportTime ("\t\tWrote tasks in ", start);
    if (debug) start = new Date ();
    Resource[] resources = data.getResources();
    for (int i = 0; i < resources.length; i++) {
      TimeBlock[] activities = resources[i].getActivities();
      for (int j = 0; j < activities.length; j++)
        if (updateActivity (activities[j], maxTime))
          text.append
            (activities[j].activityString (resources[i])).append ("\n");
      if ((! internal) || assignmentsMultitask()) {
        MultitaskAssignment[] multi = resources[i].getMultitaskAssignments();
        for (int j = 0; j < multi.length; j++) {
          if (updateActivity (multi[j], maxTime)) {
            Task[] t = multi[j].getTasks();
            multi[j].setColor
              (specs.getColor (t, SchedulingSpecs.GROUPED_TASKS));
            multi[j].setText (specs.groupedText (t));
            if (specs.doSetupColor())
              multi[j].setSetupColor
                (specs.getColor (t, SchedulingSpecs.GROUPED_SETUP));
            if (specs.doWrapupColor())
              multi[j].setWrapupColor
                (specs.getColor (t, SchedulingSpecs.GROUPED_WRAPUP));
            text.append (multi[j].xmlString (reportFrozen)).append ("\n");
          }
        }
      }
    }
    text.append ("</ASSIGNMENTS>\n");
    if (debug) reportTime ("\t\tWrote resources in ", start);
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


  private void writeCapabilities() {
    Task[] tasks = data.getTasks();
    StringBuffer text =
      new StringBuffer (tasks.length * data.getResources().length * 20);
    text.append ("<?xml version='1.0'?>\n<CAPABILITIES>\n");
    for (int i = 0; i < tasks.length; i++) {
      if (! tasks[i].isFrozen()) {
        Resource[] resources = specs.capableResources (tasks[i], data);
        for (int j = 0; j < resources.length; j++)
          text.append ("<CAPABILITY task=\"" + tasks[i].getKey() +
                       "\" resource=\"" + resources[j].getKey() + "\" />\n");
      }
    }
    text.append ("</CAPABILITIES>\n");
    if (showAssignments)
      System.out.println ("Scheduler.writeCapabilities - " + text);

    Map args = getArgs();
    args.put ("data", text.toString());
    ClientComms.postToURL (args, "postcapabilities.php");
  }


  private boolean updateActivity (TimeBlock act, int maxTime) {
//    if (act.getStartTime() >= maxTime)
//      return false;
//    if (act.getEndTime() > maxTime)
//      act.setEndTime (maxTime);
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

  private Exception readProblem() {
    setupObjects();
    Map args = getArgs();
//    StringBuffer text = new StringBuffer (2048);
//    Map accesses = specs.allObjectAccesses();
//    Iterator iter = accesses.keySet().iterator();
//    while (iter.hasNext()) {
//      String type = (String) iter.next();
//      HashSet set = (HashSet) accesses.get (type);
//      text.append (type);
//      Iterator iter2 = set.iterator();
//      while (iter2.hasNext())
//        text.append (":").append (iter2.next());
//      text.append (";");
//    }
//    args.put ("fields", text.toString());
    return ClientComms.readXML (args, "getproblem.php",
                                new ProblemHandler());
  }

  private void setupObjects() {
    timeOps = new TimeOps();
    specs = new SchedulingSpecs (timeOps);
    ga = new GeneticAlgorithm (this);
    data = new SchedulingData (timeOps);
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


  /*
   * Functions for running the scheduler internal to a process
   */

  public SchedulingData getSchedulingData() {
    return data;
  }

  public TimeOps getTimeOps() {
    return timeOps;
  }

  public boolean assignmentsMultitask() {
    return specs.getMultitasking() == SchedulingSpecs.MULTITASKING_GROUPED;
  }

  public ArrayList getAssignments() {
    ArrayList assigns = new ArrayList();
    if (! assignmentsMultitask()) {
      Task[] tasks = data.getTasks();
      for (int i = 0; i < tasks.length; i++) {
        Assignment assign = tasks[i].getAssignment();
        if (assign != null)
          assigns.add (assign);
      }
    } else {
      Resource[] resources = data.getResources();
      for (int i = 0; i < resources.length; i++) {
        MultitaskAssignment[] multi = resources[i].getMultitaskAssignments();
        for (int j = 0; j < multi.length; j++)
          assigns.add (multi[j]);
      }
    }
    return assigns;
  }

  /** if internal scheduling (direct object or XML), call this first
   * @param problem XML representation of the problem description
   * @param initialize true if this problem is new, false if modifying
   *        existing problem
   */
  public void setupInternal (String problem, boolean initialize) {
    try {
      if (initialize)
        setupInternalObjects ();
      Date start = null;
      if (reportTiming) start = new Date ();
      parser.parse (new InputSource (new StringReader (problem)));
      if (reportTiming)
        reportTime ("Scheduler.setupInternal - scheduler " +
                    "read data in ", start);
    } catch (Exception e) {
      System.err.println ("Scheduler.setupInternal - ERROR, got <" + e.getMessage() + "> reading this XML :\n" + 
						  problem);
      e.printStackTrace();
    }
  }

  /** 
   * sets up Scheduler -- after this is called can add tasks, resources, etc.
   * either directly or from parsing XML.
   **/
  public void setupInternalObjects () {
    setupObjects();
    parser = new SAXParser();
    parser.setContentHandler (new ProblemHandler());
    try {
      parser.setFeature("http://xml.org/sax/features/validation",
                        validatingInternalParser);
    } catch (SAXException sax) {
      System.err.println (sax.getMessage());
      sax.printStackTrace();
    }
  }

  /** if using direct object input (without XML), call this after
   * first calling setupInternal and then putting in the data;
   * if using regular internal scheduling, call right after setupInternal */
  public void scheduleInternal() {
    Date start = null;
    specs.initializeData (data);
    data.initialize (specs);
    if (reportTiming) start = new Date ();
    ga.execute (data, specs);
    if (reportTiming)
      reportTime ("Scheduler.runInternalToProcess - ga ran in ", start);
  }

  public void clearCaches () { specs.clearCaches (); }

  /**
   * Does the whole internal scheduling process
   * @param problem XML representation of the problem/data
   * @param initialize true if this problem is new, false if continuing
   *        existing problem
   */
  public String runInternalToProcess (String problem, boolean initialize,
                                      boolean reportFrozen) {
    setupInternal (problem, initialize);
    scheduleInternal();
    return getXMLAssignments (true, reportFrozen);
  }

  public String runInternalToProcess (String problem) {
    return runInternalToProcess (problem, true, false);
  }


  private class ProblemHandler extends DefaultHandler {
    DefaultHandler dataHandler = data.getXMLHandler();
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
