// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/SchedulingSpecs.java,v 1.14 2001-07-20 14:24:46 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import java.util.Date;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Arrays;
import java.awt.Color;

/**
 * Stores and executes the different components of the scheduling
 * semantics.
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class SchedulingSpecs {

  public static final int MULTITASKING_NONE = 0;
  public static final int MULTITASKING_GROUPED = 1;
  public static final int MULTITASKING_UNGROUPED = 2;
  public static final int MULTITASKING_IGNORING_TIME = 3;

  private boolean minimizing;
  private int multitasking;
  private ArrayList allExpressions = new ArrayList();
  private ResultProducer optimizationCriterion;
  private ResultProducer deltaCriterion;
  private CacheByTaskResource bestTimeCache;
  private ResultProducer capabilityConstraint;
  private CacheByTaskResource taskDurationCache;
  private ResultProducer setupDuration;
  private ResultProducer wrapupDuration;
  private ResultProducer prerequisites;
  private CacheByTaskResource taskUnavailableTimesCache;
  private ResultProducer resourceUnavailableTimes;
  private ResultProducer capacityContributions;
  private ResultProducer capacityThresholds;
  private ResultProducer groupable;
  private ResultProducer linked;
  private ResultProducer linkTimeDiff;
  private ResultProducer taskText;
  private ResultProducer groupedText;
  private ResultProducer activityText;
  private ArrayList colorTests = new ArrayList();
  private HashMap cachedCapableResources = null;
  private HashMap data = null;
  private ArrayList operators = new ArrayList();
  private Reusable reuse = new Reusable();
  private TimeOps timeOps;
  private static boolean debug = 
    ("true".equals (System.getProperty ("vishnu.debug")));
  private static boolean timing = 
    ("true".equals (System.getProperty ("vishnu.timing")));

  public SchedulingSpecs (TimeOps timeOps) {
    this.timeOps = timeOps;
  }    

  public void initializeData (SchedulingData sdata) {
    data = sdata.getGlobals();
    data.put ("start_time", new Reusable.RInteger (sdata.getStartTime()));
    data.put ("end_time", new Reusable.RInteger (sdata.getEndTime()));
    if (debug)
      System.out.println ("SchedulingSpecs.initializeData - Start time=" + 
			  data.get ("start_time") + " end " +
                          data.get ("end_time"));
    data.put ("tasks", new ArrayList (Arrays.asList (sdata.getTasks())));
    data.put ("resources",
              new ArrayList (Arrays.asList (sdata.getResources())));
    for (int i = 0; i < operators.size(); i++)
      ((Operator) operators.get(i)).setData (sdata, reuse, timeOps);
  }

  public HashMap allObjectAccesses () {
    HashMap list = new HashMap();
    for (int i = 0; i < allExpressions.size(); i++) {
      Object o = allExpressions.get(i);
      if (o instanceof Operator)
        ((Operator) o).objectAccesses (list);
    }
    return list;
  }

  public final TimeOps getTimeOps() {
    return timeOps;
  }

  public boolean isMinimizing() {
    return minimizing;
  }

  public int getMultitasking() {
    return multitasking;
  }

  public float evaluate () {
    if (optimizationCriterion == null)
      return 0.0f;
    Reusable.RFloat f = (Reusable.RFloat)
      optimizationCriterion.getResult (data);
    reuse.resetObjects();
    if (f == null)
      return 0.0f;
    return f.floatValue();
  }

  public float evaluateSingleAssignment (Task task, Resource resource) {
    if (deltaCriterion == null)
      return 0.0f;
    data.put ("task", task);
    data.put ("resource", resource);
    Reusable.RFloat f = (Reusable.RFloat) deltaCriterion.getResult (data);
    data.remove ("task");
    data.remove ("resource");
    reuse.resetObjects();
    if (f == null)
      return 0.0f;
    return f.floatValue();
  }

  public int bestTime (Task task, Resource resource,
                       int duration, boolean schedChanged) {
    if (bestTimeCache == null)
      return Integer.MIN_VALUE;
    data.put ("duration", new Reusable.RFloat ((float) duration));
    Reusable.RInteger i = (Reusable.RInteger)
      bestTimeCache.getResult (task, resource, schedChanged);
    data.remove ("duration");
    reuse.resetObjects();
    if (i == null)
      return Integer.MIN_VALUE;
    return i.intValue();
  }

  public Resource[] capableResources (Task task, SchedulingData sdata) {
    if (cachedCapableResources == null) {
      Task[] tasks = sdata.getTasks();
      Resource[] resources = sdata.getResources();
      
      if (debug)
	System.out.println ("SchedulingSpecs.capableResources - " + 
                            tasks.length + " tasks " + resources.length + 
			    " resources");

      cachedCapableResources = new HashMap();
      for (int i = 0; i < tasks.length; i++) {
        ArrayList capable = new ArrayList();
        for (int j = 0; j < resources.length; j++) {
          if (isCapable (tasks[i], resources[j])) {
            capable.add (resources[j]);
	    if (debug)
	      System.out.println ("SchedulingSpecs.capableResources - " +
                                  resources[j] + "(" + j + " of " +
                                  resources.length + ")" +
				  " is capable of doing " + tasks[i]);
	  } else {
	    if (debug)
	      System.out.println ("SchedulingSpecs.capableResources - " +
                                  resources[j] + "(" + j + " of " +
                                  resources.length + ")" +
				  " is NOT capable of doing " + tasks[i]);
	  }
        }
        Resource[] arr = new Resource [capable.size()];
        cachedCapableResources.put (tasks[i].getKey(), capable.toArray (arr));
      }
    }
    return (Resource[]) cachedCapableResources.get (task.getKey());
  }

  public boolean isCapable (Task task, Resource resource) {
    if (capabilityConstraint == null)
      return true;
    data.put ("task", task);
    data.put ("resource", resource);
    Boolean b = (Boolean) capabilityConstraint.getResult (data);
    data.remove ("task");
    data.remove ("resource");
    reuse.resetObjects();
    if (b == null)
      return true;
    return b.booleanValue();
  }

  public boolean ignoringTime() {
    return (((taskDurationCache == null) &&
             (setupDuration == null) &&
             (wrapupDuration == null) &&
             (taskUnavailableTimesCache == null)) ||
            (multitasking == MULTITASKING_IGNORING_TIME));
  }

  public int taskDuration (Task task, Resource resource,
                           boolean schedChanged) {
    if (taskDurationCache == null)
      return 0;
    Reusable.RFloat f = (Reusable.RFloat)
      taskDurationCache.getResult (task, resource, schedChanged);
    reuse.resetObjects();
    if (f == null)
      return 0;
    if (debug)
      System.out.println ("SchedulingSpecs.taskDuration " +
                          f.floatValue()/3600.0f + " hrs.");
	
    return f.intValue();
  }

  int sdVisits = 0;
  long sdTotaltime = 0;
  int wdVisits = 0;
  long wdTotaltime = 0;

  public void reportTiming () { 
    if (timing) {
      System.out.println ("wrapup # called " + wdVisits +
                          " times " + wdTotaltime + " milliseconds");
      System.out.println ("setup # called " + sdVisits +
                          " times " + sdTotaltime + " milliseconds");
    }
  }

  public int setupDuration (Task task, Task previous, Resource resource) {
    if (setupDuration == null)
      return 0;
    Date start = null;
    if (timing) {
      start = new Date();
      sdVisits++;
    }
    data.put ("task", task);
    data.put ("previous", previous);
    data.put ("resource", resource);
    Reusable.RFloat f = (Reusable.RFloat) setupDuration.getResult (data);
    data.remove ("task");
    data.remove ("resource");
    data.remove ("previous");
    if (timing)
      sdTotaltime += new Date().getTime () - start.getTime();
    reuse.resetObjects();
    if (f == null)
      return 0;
    return f.intValue();
  }

  public int wrapupDuration (Task task, Task next, Resource resource) {
    if (wrapupDuration == null)
      return 0;
    Date start = null;
    if (timing) {
      start = new Date();
      wdVisits++;
    }
    data.put ("task", task);
    data.put ("next", next);
    data.put ("resource", resource);
    Reusable.RFloat f = (Reusable.RFloat) wrapupDuration.getResult (data);
    data.remove ("task");
    data.remove ("resource");
    data.remove ("next");
    if (timing)
      wdTotaltime += new Date().getTime () - start.getTime();
    reuse.resetObjects();
    if (f == null)
      return 0;
    return f.intValue();
  }

  public Task[] prerequisites (Task task, SchedulingData sd) {
    if (prerequisites == null)
      return new Task[0];
    data.put ("task", task);
    ArrayList ids = (ArrayList) prerequisites.getResult (data);
    data.remove ("task");
    reuse.resetObjects();
    if (ids == null)
      return new Task[0];
    Task[] tasks = new Task [ids.size()];
    for (int i = 0; i < ids.size(); i++) {
      tasks[i] = sd.getTask ((String) ids.get(i));
      if (tasks[i] == null)
        throw new RuntimeException
          ("Prerequisite not found<br>\nPrerequiste " + ids.get(i) +
           " does not exist for task " + task.getKey());
    }
    return tasks;
  }

  private final int findInsertPosition (TimeBlock[] blocks, int start) {
    for (int j = 0; j < blocks.length; j++)
      if (start <= blocks[j].getEndTime())
        return j;
    return blocks.length;
  }

  private final int findNumOverlapping (TimeBlock[] blocks, int end,
                                        int startIndex) {
    for (int j = startIndex; j < blocks.length; j++)
      if (end < blocks[j].getStartTime())
        return j - startIndex;
    return blocks.length - startIndex;
  }

  private final TimeBlock[] combine (int start, int end, TimeBlock[] blocks,
                                     int insert, int overlap) {
    if (start >= end)
      return blocks;
    if (overlap != 0) {
      if (blocks[insert].getStartTime() < start)
        start = blocks[insert].getStartTime();
      if (blocks[insert + overlap - 1].getEndTime() > end)
        end = blocks[insert + overlap - 1].getEndTime();
    }
    TimeBlock[] newBlocks = new TimeBlock [blocks.length + 1 - overlap];
    System.arraycopy (blocks, 0, newBlocks, 0, insert);
    newBlocks [insert] = new TimeBlock (start, end, timeOps);
    System.arraycopy (blocks, insert + overlap, newBlocks, insert + 1,
                      newBlocks.length - insert - 1);
    return newBlocks;
  }

  private TimeBlock[] combine2 (int start, int end, TimeBlock[] blocks,
                                int insert, int overlap, String color,
                                String text) {
    if (start >= end)
      return blocks;
    int num = 1;
    TimeBlock pre = null, post = null;
    if (overlap != 0) {
      if (blocks[insert].getStartTime() < start) {
        num++;
        pre = new TimeBlock (blocks[insert].getStartTime(), start,
                             timeOps, blocks[insert].getColor(),
                             blocks[insert].getText());
      }
      if (blocks[insert + overlap - 1].getEndTime() > end) {
        num++;
        post = new TimeBlock (end,
                              blocks[insert + overlap - 1].getStartTime(),
                              timeOps,
                              blocks[insert + overlap - 1].getColor(),
                              blocks[insert + overlap - 1].getText());

      }
    }
    TimeBlock[] newBlocks = new TimeBlock [blocks.length + num - overlap];
    System.arraycopy (blocks, 0, newBlocks, 0, insert);
    int pos = insert;
    if (pre != null)
      newBlocks [pos++] = pre;
    newBlocks [pos++] = new TimeBlock (start, end, timeOps, color, text);
    if (post != null)
      newBlocks [pos++] = post;
    System.arraycopy (blocks, insert + overlap, newBlocks, insert + num,
                      newBlocks.length - insert - num);
    return newBlocks;
  }

  public final boolean alwaysCompact() {
    return ((taskUnavailableTimesCache == null) &&
            (resourceUnavailableTimes == null) &&
            (bestTimeCache == null) &&
            (multitasking == MULTITASKING_NONE)  &&
            (linked == null));
  }

  public TimeBlock[] taskUnavailableTimes (Task task, Task[] prereqs,
                                           int startTime, int endTime,
                                           Resource resource,
                                           int duration,
                                           boolean schedChanged) {
    TimeBlock[] blocks = {new TimeBlock (Integer.MIN_VALUE,
                                         startTime, timeOps),
                          new TimeBlock (endTime, Integer.MAX_VALUE,
                                         timeOps)};
    if (taskUnavailableTimesCache == null)
      return blocks;
    data.put ("prerequisites", new ArrayList (Arrays.asList (prereqs)));
    data.put ("duration", new Reusable.RFloat ((float) duration));
    Object obj = taskUnavailableTimesCache.getResult (task, resource,
                                                      schedChanged);
    data.remove ("prerequisites");
    data.remove ("duration");
    reuse.resetObjects();
    if (obj == null)
      return blocks;
    ArrayList list = (ArrayList) obj;

    for (int i = 0; i < list.size(); i++) {
      SchObject interval = (SchObject) list.get(i);
      int start = ((Reusable.RInteger) interval.getField ("start")).intValue();
      int end = ((Reusable.RInteger) interval.getField ("end")).intValue();
      int insert = findInsertPosition (blocks, start);
      int overlap = findNumOverlapping (blocks, end, insert);
      blocks = combine (start, end, blocks, insert, overlap);
    }

    return blocks;
  }

  public TimeBlock[] resourceUnavailableTimes (Resource resource) {
    TimeBlock[] blocks = new TimeBlock[0];
    if (resourceUnavailableTimes == null)
      return blocks;
    data.put ("resource", resource);
    Object obj = resourceUnavailableTimes.getResult (data);
    data.remove ("resource");
    reuse.resetObjects();
    if (obj == null)
      return blocks;
    ArrayList list = (ArrayList) obj;
    for (int i = 0; i < list.size(); i++) {
      SchObject interval = (SchObject) list.get(i);
      int start = ((Reusable.RInteger) interval.getField ("start")).intValue();
      int end = ((Reusable.RInteger) interval.getField ("end")).intValue();
      String color = getColor (interval);
      String text = activityText (interval);
      int insert = findInsertPosition (blocks, start);
      int overlap = findNumOverlapping (blocks, end, insert);
      blocks = combine2 (start, end, blocks, insert, overlap, color, text);
    }
    return blocks;
  }

  public float[] capacityContributions (Task task) {
    if (capacityContributions == null)
      return new float[0];
    data.put ("task", task);
    Object o = capacityContributions.getResult (data);
    data.remove ("task");
    reuse.resetObjects();
    if (o == null)
      return new float[0];
    if (o instanceof Reusable.RFloat)
      return new float[] {((Reusable.RFloat) o).floatValue()};
    ArrayList l = (ArrayList) o;
    float[] f = new float [l.size()];
    for (int i = 0; i < f.length; i++)
      f[i] = ((Reusable.RFloat) l.get(i)).floatValue();
    return f;
  }

  public float[] capacityThresholds (Resource resource) {
    if (capacityThresholds == null)
      return new float[0];
    data.put ("resource", resource);
    Object o = capacityThresholds.getResult (data);
    data.remove ("resource");
    reuse.resetObjects();
    if (o == null)
      return new float[0];
    if (o instanceof Reusable.RFloat)
      return new float[] {((Reusable.RFloat) o).floatValue()};
    ArrayList l = (ArrayList) o;
    float[] f = new float [l.size()];
    for (int i = 0; i < f.length; i++)
      f[i] = ((Reusable.RFloat) l.get(i)).floatValue();
    return f;
  }

  public boolean areGroupable (Task task1, Task task2) {
    if (groupable == null)
      return true;
    data.put ("task1", task1);
    data.put ("task2", task2);
    Boolean b = (Boolean) groupable.getResult (data);
    data.remove ("task1");
    data.remove ("task2");
    reuse.resetObjects();
    if (b == null)
      return true;
    return b.booleanValue();
  }

  public boolean hasGroupableSpec () {	return groupable != null;  }
  
  public boolean areLinks() {
    return linked != null;
  }

  public boolean areLinked (Task task1, Task task2) {
    if (linked == null)
      return false;
    data.put ("task1", task1);
    data.put ("task2", task2);
    Boolean b = (Boolean) linked.getResult (data);
    data.remove ("task1");
    data.remove ("task2");
    reuse.resetObjects();
    if (b == null)
      return false;
    return b.booleanValue();
  }

  public float linkTimeDiff (Task task1, Task task2) {
    if (linkTimeDiff == null)
      return 0.0f;
    data.put ("task1", task1);
    data.put ("task2", task2);
    Reusable.RFloat f = (Reusable.RFloat) linkTimeDiff.getResult (data);
    data.remove ("task1");
    data.remove ("task2");
    reuse.resetObjects();
    if (f == null)
      return 0.0f;
    return f.floatValue();
  }

  public static String stringForObject (Object o) {
    if (o == null)
      return "";
    if (o instanceof ArrayList) {
      ArrayList l = (ArrayList) o;
      StringBuffer text = new StringBuffer (100);
      text.append ("{");
      boolean first = true;
      for (int i = 0; i < l.size(); i++) {
        if (! first)
          text.append (", ");
        first = false;
        text.append (stringForObject (l.get(i)));
      }
      text.append ("}");
      return text.toString();
    }
    if ((! (o instanceof Reusable.RFloat)) ||
        (((Reusable.RFloat) o).floatValue() % 1.0f != 0.0f))
      return o.toString();
    return (new Integer (((Reusable.RFloat) o).intValue())).toString();
  }

  public String taskText (Task task) {
    if (taskText == null)
      return "";
    data.put ("task", task);
    Object o = taskText.getResult (data);
    data.remove ("task");
    reuse.resetObjects();
    return stringForObject (o);
  }

  public String groupedText (Task[] tasks) {
    if (groupedText == null)
      return "";
    ArrayList al = new ArrayList (Arrays.asList (tasks));
    data.put ("tasks", al);
    Object o = groupedText.getResult (data);
    data.remove ("tasks");
    reuse.resetObjects();
    return stringForObject (o);
  }

  public String activityText (SchObject interval) {
    if (activityText == null)
      return "";
    data.put ("interval", interval);
    Object o =  activityText.getResult (data);
    data.remove ("interval");
    reuse.resetObjects();
    return stringForObject (o);
  }

  public String getColor (Object obj) {
    int objType = -1;
    if (obj instanceof Task)
      objType = ColorTest.TASK;
    else if (obj instanceof SchObject)
      objType = ColorTest.ACTIVITY;
    else
      objType = ColorTest.GROUPED;
    for (int i = 0; i < colorTests.size(); i++) {
      ColorTest test = (ColorTest) colorTests.get(i);
      if (test.passesTest (obj, objType))
        return test.getColor();
    }
    return "gray";
  }

  public DefaultHandler getXMLHandler() {
    return new SpecsHandler();
  }

  private class ColorTest {

    public static final int TASK = 0;
    public static final int GROUPED = 1;
    public static final int ACTIVITY = 2;

    private String color;
    private int objType = -1;
    private ResultProducer test;

    ColorTest (String color, String objType) {
      this.color = color;
      if (objType.equals ("task"))
        this.objType = TASK;
      else if (objType.equals ("grouped"))
        this.objType = GROUPED;
      else if (objType.equals ("activity"))
        this.objType = ACTIVITY;
    }

    void setTest (ResultProducer test)  { this.test = test; }

    String getColor()  { return color; }

    boolean passesTest (Object obj, int objType) {
      if (this.objType != objType)
        return false;
      if (objType == TASK)
        data.put ("task", obj);
      else if (objType == ACTIVITY)
        data.put ("interval", obj);
      else if (objType == GROUPED)
        data.put ("tasks", new ArrayList (Arrays.asList ((Task[]) obj)));
      Boolean b = (Boolean) test.getResult (data);
      if (objType == TASK)
        data.remove ("task");
      else if (objType == ACTIVITY)
        data.remove ("interval");
      else if (objType == GROUPED)
        data.remove ("tasks");
      reuse.resetObjects();
      if (b == null)
        return false;
      return b.booleanValue();
    }
  }


  // usable by specs that have task and resource as the variables
  // and are computed before making the assignment
  private class CacheByTaskResource {
    private static final int TASK = 0;
    private static final int TASKRESOURCE = 1;
    private static final int TASKSCHEDULE = 2;
    private static final int ALL = 3;

    private int dependencies;
    private HashMap byTask = new HashMap();
    private Object object;   // value from last time
    private ResultProducer rp;

    public CacheByTaskResource (ResultProducer rp) {
      this.rp = rp;
      boolean resourceDependent =
        (rp.containsVariable ("resource") ||
         rp.containsVariable ("duration"));
      boolean scheduleDependent =
        (rp instanceof Operator) && ((Operator) rp).scheduleDependent();
      if (resourceDependent && scheduleDependent)
        dependencies = ALL;
      else if (resourceDependent)
        dependencies = TASKRESOURCE;
      else if (scheduleDependent)
        dependencies = TASKSCHEDULE;
      else
        dependencies = TASK;
    }

    public Object getResult (Task task, Resource resource,
                             boolean schedChanged) {
      switch (dependencies) {
      case TASK:
        if (! schedChanged)
          return object;
        object = byTask.get (task);
        if (object != null)
          return object;
        break;
      case TASKRESOURCE:
        HashMap hm = (HashMap) byTask.get (task);
        if (hm == null) {
          hm = new HashMap();
          byTask.put (task, hm);
        } else {
          object = hm.get (resource);
          if (object != null)
            return object;
        }
        break;
      case TASKSCHEDULE:
        if (! schedChanged)
          return object;
      }
      data.put ("task", task);
      data.put ("resource", resource);
      object = rp.getResult (data);
      if (dependencies != ALL) {
        if (object instanceof Reusable.RFloat)
          object = ((Reusable.RFloat) object).copy();
        else if (object instanceof ArrayList)
          object = ((ArrayList) object).clone();
        else if (object instanceof Reusable.RInteger)
          object = ((Reusable.RInteger) object).copy();
        else if (object instanceof Boolean)
          object = new Boolean (((Boolean) object).booleanValue());
      }
      data.remove ("task");
      data.remove ("resource");
      switch (dependencies) {
      case TASK:
        byTask.put (task, object);
        break;
      case TASKRESOURCE:
        HashMap hm = (HashMap) byTask.get (task);
        hm.put (resource, object);
      }
      return object;
    }
  }


  /** Parses the XML representation of the specs */
  private class SpecsHandler extends DefaultHandler {

    private FastStack stack = new FastStack();
    private ResultProducer rp;

    public void startElement (String uri, String local, String name,
                              Attributes atts) throws SAXException {
      if (debug && !name.equals ("LITERAL") && !name.equals ("OPERATOR"))
        System.out.println ("SchedulingSpecs.startElement - " + name);

      if (name.equals ("LITERAL")) {
        if (debug)
          System.out.println ("SchedulingSpecs.startElement - Literal " + 
                              atts.getValue ("value"));
		
        stack.push (new Literal (atts.getValue ("value"),
                                 atts.getValue ("type"),
                                 atts.getValue ("datatype"),
                                 timeOps));
      }
	  
      else if (name.equals ("OPERATOR")) {
        if (debug)
          System.out.println ("SchedulingSpecs.startElement - Operator " + 
                              atts.getValue ("operation"));

        Operator op = new Operator (atts.getValue ("operation"));
        if (! op.legalOperation())
          throw new SAXException ("Illegal operation " +
                                  atts.getValue ("operation"));
        stack.push (op);
        operators.add (op);
      }
      else if (name.equals ("COLORTEST"))
        colorTests.add (new ColorTest (atts.getValue ("color"),
                                       atts.getValue ("obj_type")));
      else if (name.equals ("SPECS")) {
        String dir = atts.getValue ("direction");
        minimizing = (dir == null) || dir.equals ("minimize");
        String mt = atts.getValue ("multitasking");
        if ((mt == null) || mt.equals ("none"))
          multitasking = MULTITASKING_NONE;
        else if (mt.equals ("grouped"))
          multitasking = MULTITASKING_GROUPED;
        else if (mt.equals ("ungrouped"))
          multitasking = MULTITASKING_UNGROUPED;
        else if (mt.equals ("ignoring_time"))
          multitasking = MULTITASKING_IGNORING_TIME;
      }
      else if ((! name.equals ("SPECS")) &&
               (! name.equals ("OPTCRITERION")) &&
               (! name.equals ("DELTACRITERION")) &&
               (! name.equals ("BESTTIME")) &&
               (! name.equals ("TASKDURATION")) &&
               (! name.equals ("SETUPDURATION")) &&
               (! name.equals ("WRAPUPDURATION")) &&
               (! name.equals ("PREREQUISITES")) &&
               (! name.equals ("TASKUNAVAIL")) &&
               (! name.equals ("RESOURCEUNAVAIL")) &&
               (! name.equals ("CAPACITYCONTRIB")) &&
               (! name.equals ("CAPACITYTHRESH")) &&
               (! name.equals ("GROUPABLE")) &&
               (! name.equals ("LINKED")) &&
               (! name.equals ("LINKTIMEDIFF")) &&
               (! name.equals ("TASKTEXT")) &&
               (! name.equals ("GROUPEDTEXT")) &&
               (! name.equals ("ACTIVITYTEXT")) &&
               (! name.equals ("COLORTESTS")) &&
               (! name.equals ("CAPABILITY")))
        System.out.println ("Unknown tag in scheduling specs: " + name);
    }

    public void endElement (String uri, String local,
                            String name) throws SAXException {
      if (debug && !name.equals ("LITERAL") && !name.equals ("OPERATOR"))
        System.out.println ("SchedulingSpecs.endElement - " + name);
	  
      if (name.equals ("CAPABILITY"))
        capabilityConstraint = rp;
      else if (name.equals ("OPTCRITERION"))
        optimizationCriterion = rp;
      else if (name.equals ("DELTACRITERION"))
        deltaCriterion = rp;
      else if (name.equals ("BESTTIME"))
        bestTimeCache = new CacheByTaskResource (rp);
      else if (name.equals ("TASKDURATION"))
        taskDurationCache = new CacheByTaskResource (rp);
      else if (name.equals ("SETUPDURATION"))
        setupDuration = rp;
      else if (name.equals ("WRAPUPDURATION"))
        wrapupDuration = rp;
      else if (name.equals ("TASKUNAVAIL"))
        taskUnavailableTimesCache = new CacheByTaskResource (rp);
      else if (name.equals ("RESOURCEUNAVAIL"))
        resourceUnavailableTimes = rp;
      else if (name.equals ("CAPACITYCONTRIB"))
        capacityContributions = rp;
      else if (name.equals ("CAPACITYTHRESH"))
        capacityThresholds = rp;
      else if (name.equals ("GROUPABLE"))
        groupable = rp;
      else if (name.equals ("LINKED"))
        linked = rp;
      else if (name.equals ("LINKTIMEDIFF"))
        linkTimeDiff = rp;
      else if (name.equals ("TASKTEXT"))
        taskText = rp;
      else if (name.equals ("GROUPEDTEXT"))
        groupedText = rp;
      else if (name.equals ("ACTIVITYTEXT"))
        activityText = rp;
      else if (name.equals ("PREREQUISITES"))
        prerequisites = rp;
      else if (name.equals ("COLORTEST"))
        ((ColorTest) colorTests.get (colorTests.size() - 1)).setTest (rp);
      else if (name.equals ("LITERAL") || name.equals ("OPERATOR")) {
        rp = (ResultProducer) stack.pop();
        if (name.equals ("OPERATOR") &&
            (! ((Operator) rp).argTypesLegal()))
          throw new SAXException ("Illegal argument types for operator " +
                                  ((Operator) rp).getName());
        if (!stack.empty())
          ((Operator) stack.peek()).addArgument (rp);
        else
          allExpressions.add (rp);
      }
    }
  }

}
