// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/SchedulingData.java,v 1.35 2001-08-23 21:22:21 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import java.util.HashMap;
import java.util.TreeSet;
import java.util.ArrayList;
import java.util.Stack;
import java.util.Comparator;

/**
 * Holds scheduling data for the generic scheduler.
 *
 * Note that the WINDOW tag has the effect of setting the base time
 * for all subsequent times.  That is, all times after that will be
 * in relation to the starttime.  So, perhaps unexpectedly, no matter
 * what WINDOW's starttime is set to, getStartTime will always return 0,
 * it seems.
 * (Note from DJM: this is true only if the WINDOW tag is before
 * the rest of the data.  The first time of any kind sets the base time.)
 *
 * Supports nested lists and objects.
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class SchedulingData {

  private HashMap tasks = new HashMap();
  private TreeSet frozenTasks = new TreeSet (new Comparator()
                 { public int compare (Object o1, Object o2) {
                   Task t1 = (Task) o1;
                   Task t2 = (Task) o2;
                   int i1 = t1.getAssignment().getTaskStartTime();
                   int i2 = t2.getAssignment().getTaskStartTime();
                   int diff = i1 - i2;
                   if (diff != 0)
                     return diff;
                   i1 = o1.hashCode();
                   i2 = o2.hashCode();
                   diff = i1 - i2;
                   if (diff != 0)
                     return diff;
                   return t1.getKey().hashCode() - t2.getKey().hashCode();
                 }});
  private HashMap linkedToFrozenTasks;
  private ArrayList primaryTasks = new ArrayList();
  private HashMap resources = new HashMap();
  private HashMap capacities;
  private HashMap globals = new HashMap (11);
  private HashMap globalTypes = new HashMap (11);
  private ArrayList linkedGroups;
  private HashMap linkedGroupMap;
  private HashMap primaryLinks;
  private int startTime;
  private int endTime = Integer.MAX_VALUE;
  private TimeOps timeOps;

  public static boolean debug = 
    ("true".equals (System.getProperty ("vishnu.debug")));
  private static boolean throwExceptionOnMissingField =
    ("true".equals (System.getProperty ("vishnu.SchedulingData.throwExceptionOnMissingField", "false")));
  
  public SchedulingData (TimeOps timeOps) {
    this.timeOps = timeOps;
  }

  public TimeOps getTimeOps () {
	return timeOps;
  }
  
  public int getStartTime() {
    return startTime;
  }

  public int getEndTime() {
    return endTime;
  }

  public Task getTask (String key) {
    return (Task) tasks.get (key);
  }

  public void addTask (Task task) {
    Object key = task.getKey();
    tasks.put (key, task);
    primaryTasks.add (task);
  }

  public void removeTask (String key) {
    Task task = getTask (key);
    tasks.remove (key);
    primaryTasks.remove (task);
    frozenTasks.remove (task);
  }

  public void replaceTask (Task task) {
    Task old = getTask (task.getKey());
    Assignment a = old.getAssignment();
    task.setAssignment (a);
    removeTask (task.getKey());
    addTask (task);
    if (a.getFrozen()) {
      frozenTasks.remove (old);
      frozenTasks.add (task);
    }
  }

  public void freezeTask (String task, String res, String start, String end) {
    Task t = getTask (task);
    if (t == null) {
      System.out.println ("Trying to freeze unknown task " + task);
      return;
    }
    Assignment a = t.getAssignment();
    Resource r = (res != null) ? getResource (res) :
                 ((a != null) ? a.getResource() : null);
    int s = (start != null) ? timeOps.stringToTime (start) :
            ((a != null) ? a.getTaskStartTime() : Integer.MAX_VALUE);
    int e = (end != null) ? timeOps.stringToTime (end) :
            ((a != null) ? a.getTaskEndTime() : Integer.MIN_VALUE);
    if ((r == null) || (s == Integer.MAX_VALUE) || (e == Integer.MIN_VALUE)) {
      System.out.println ("Missing data for freezing task " + task);
      return;
    }
    primaryTasks.remove (t);
    t.setAssignment (new Assignment (t, r, s, s, e, e, true, timeOps));
    frozenTasks.add (t); 
  }

  public void unfreezeTask (String key) {
    Task task = getTask (key);
    if (task == null) {
      System.out.println ("Unknown task to unfreeze: " + key);
      return;
    }
    primaryTasks.add (task);
    frozenTasks.remove (task);
  }

  public final Task[] getTasks() {
    Task[] arr = new Task [tasks.size()];
    return (Task[]) tasks.values().toArray (arr);
  }

  public final Task[] getFrozenTasks() {
    Task[] arr = new Task [frozenTasks.size()];
    return (Task[]) frozenTasks.toArray (arr);
  }

  public final boolean isFrozen (Task task) {
    if (task == null)
      return false;
    Assignment a = task.getAssignment();
    return ((a != null) && (a.getFrozen()));
  }

  /** Tasks that actually are represented in chromosome; this is all
   *  tasks that are not frozen and that are either not linked or are
   *  the representative task in a set of linked tasks */
  public final Task[] getPrimaryTasks() {
    Task[] arr = new Task [primaryTasks.size()];
    return (Task[]) primaryTasks.toArray (arr);
  }

  public final HashMap getLinkedToFrozenTasks () {
    return linkedToFrozenTasks;
  }

  public int cachedLinkTimeDiff (Task task1, Task task2) {
    HashMap group = (HashMap) linkedGroupMap.get (task1);
    float f1 = ((Float) group.get (task1)).floatValue();
    Float f2 = (Float) group.get (task2);
    return (f2 == null) ? 0 : (int) (f1 - f2.floatValue());
  }

  public static final Task[] emptyTaskArray = new Task[0];

  public Task[] getLinkedTasks (Task task) {
    HashMap group = (HashMap) linkedGroupMap.get (task);
    if (group == null)
      return emptyTaskArray;
    Task[] arr = new Task [group.size() - 1];
    int i = 0;
    java.util.Iterator iter = group.keySet().iterator();
    while (iter.hasNext()) {
      Task o = (Task) iter.next();
      if (o != task)
        arr[i++] = o;
    }
    return arr;
  }

  public Task getPrimaryLink (Task task) {
    return (Task) primaryLinks.get (task);
  }

  public Resource getResource (String key) {
    return (Resource) resources.get (key);
  }

  public void addResource (Resource r) {
    resources.put (r.getKey(), r);
  }

  public void removeResource (String key) {
    resources.remove (key);
    Task[] ft = getFrozenTasks();
    for (int i = 0; i < ft.length; i++) {
      Assignment a = ft[i].getAssignment();
      if ((a != null) && (a.getResource().getKey().equals (key)))
        unfreezeTask (ft[i].getKey());
    }
  }

  public void replaceResource (Resource r) {
    resources.remove (r.getKey());
    Task[] ft = getFrozenTasks();
    for (int i = 0; i < ft.length; i++) {
      Assignment a = ft[i].getAssignment();
      if ((a != null) && (a.getResource().getKey().equals (r.getKey())))
        a.setResource (r);
    }
    addResource (r);
  }

  public Resource[] getResources() {
    Resource[] arr = new Resource [resources.size()];
    return (Resource[]) resources.values().toArray (arr);
  }

  public HashMap getCapacities() {
    return capacities;
  }

  public HashMap getGlobals() {
    return (HashMap) globals.clone();
  }

  public void addGlobal (String name, String type, SchObject obj) {
    globals.put (name, obj);
    globalTypes.put (name, type);
  }

  public void removeGlobal (String name) {
    globals.remove (name);
    globalTypes.remove (name);
  }

  public String typeForGlobal (String global) {
    return (String) globalTypes.get (global);
  }

  public void clearAssignments() {
    Task[] tasks = getTasks();
    for (int i = 0; i < tasks.length; i++) {
      Assignment a = tasks[i].getAssignment();
      if (a != null) {
        if (! a.getFrozen())
          tasks[i].setAssignment (null);
        a.getResource().removeAssignment (a.getTask().getKey(), false);
      }
    }
    Resource[] resources = getResources();
    for (int i = 0; i < resources.length; i++) {
      resources[i].clearSchedule();
      resources[i].resetCapacitiesUsed();
      resources[i].resetMultitaskContrib();
    }
  }

  public void initialize (SchedulingSpecs specs) {
    Task[] tasks = getTasks();
    for (int i = 0; i < tasks.length; i++) {
      if (! isFrozen (tasks[i]))
        tasks[i].setAssignment (null);
      tasks[i].setFrozenBlock (null);
    }
    Resource[] resources = getResources();
    for (int i = 0; i < resources.length; i++)
      resources[i].initialize();
    capacities = new HashMap();
    linkedToFrozenTasks = new HashMap();
    linkedGroups = new ArrayList();
    linkedGroupMap = new HashMap();
    primaryLinks = new HashMap();
    createActivities (specs);
    initializeCapacities (specs);
    computePrerequisites (specs);
    if (specs.areLinks()) {
      computeLinks (specs);
      computeLinkedToFrozen();
      computePrimaryLinked (specs);
    }
  }

  public void createActivities (SchedulingSpecs specs) {
    Resource[] r = getResources();
    for (int i = 0; i < r.length; i++)
      r[i].setActivities (specs.resourceUnavailableTimes (r[i]));
  }

  public void initializeCapacities (SchedulingSpecs specs) {
    Resource[] r = getResources();
    for (int i = 0; i < r.length; i++) {
      float[] caps = specs.capacityThresholds (r[i]);
      r[i].setCapacities (caps);
      if (caps.length > 0) {
        float cap = caps[0];
        capacities.put(r[i].getKey(), new Float(cap));
      }
    }

    Task[] t = getTasks();
    for (int i = 0; i < t.length; i++)
      t[i].setCapacityContribs (specs.capacityContributions (t[i]));
  }

  public void computePrerequisites (SchedulingSpecs specs) {
    Task[] t = getTasks();
    for (int i = 0; i < t.length; i++)
      t[i].setPrerequisites (specs.prerequisites (t[i], this));
  }

  public void computeLinks (SchedulingSpecs specs) {
    Task[] t = getTasks();
    for (int i = 0; i < t.length; i++)
      for (int j = 0; j < t.length; j++)
        if (i != j)
          if (specs.areLinked (t[i], t[j])) {
            HashMap gi = (HashMap) linkedGroupMap.get (t[i]);
            HashMap gj = (HashMap) linkedGroupMap.get (t[j]);
            float timeDiff = specs.linkTimeDiff (t[i], t[j]);
            if ((gi != null) && (gj != null)) {
              if (gi != gj) {
                linkedGroups.remove (gj);
                java.util.Iterator iter = gj.keySet().iterator();
                while (iter.hasNext()) {
                  Object o = iter.next();
                  float f = ((Float) gj.get (o)).floatValue();
                  gi.put (o, new Float (f + timeDiff));
                  linkedGroupMap.put (o, gi);
                }
              }
            }
            else if (gi != null) {
              float f = ((Float) gi.get (t[i])).floatValue();
              gi.put (t[j], new Float (f + timeDiff));
              linkedGroupMap.put (t[j], gi);
            }
            else if (gj != null) {
              float f = ((Float) gj.get (t[j])).floatValue();
              gj.put (t[i], new Float (f - timeDiff));
              linkedGroupMap.put (t[i], gj);
            }
            else {
              HashMap group = new HashMap (11);
              group.put (t[i], new Float (0.0f));
              group.put (t[j], new Float (timeDiff));
              linkedGroups.add (group);
              linkedGroupMap.put (t[i], group);
              linkedGroupMap.put (t[j], group);
            }
          }
  }

  private void computeLinkedToFrozen() {
    for (int i = 0; i < primaryTasks.size(); i++) {
      Object task = primaryTasks.get (i);
      HashMap group = (HashMap) linkedGroupMap.get (task);
      if (group == null)
        continue;
      java.util.Iterator iter = group.keySet().iterator();
      while (iter.hasNext()) {
        Task task2 = (Task) iter.next();
        if (isFrozen (task2)) {
          linkedToFrozenTasks.put (task, task2);
          primaryTasks.remove (task);
          break;
        }
      }
    }
  }

  private void computePrimaryLinked (SchedulingSpecs specs) {
    for (int i = 0; i < linkedGroups.size(); i++) {
      HashMap group = (HashMap) linkedGroups.get(i);
      Task primaryTask = (Task) group.keySet().iterator().next();
      if (primaryTasks.contains (primaryTask)) {
        java.util.Iterator iter = group.keySet().iterator();
        while (iter.hasNext()) {
          Task task = (Task) iter.next();
          Resource[] resources = specs.capableResources (task, this);
          if ((resources.length > 0) &&
              (specs.bestTime (task, resources[0], 0, true) !=
               Integer.MIN_VALUE)) {
            primaryTask = task;
            break;
          }
          java.util.Iterator iter2 = group.keySet().iterator();
          boolean found = false;
          while (iter2.hasNext()) {
            Task task2 = (Task) iter2.next();
            if ((task != task2) &&
                specs.areLinked (task2, task)) {
              found = true;
              break;
            }
          }
          if (! found)
            primaryTask = task;
        }
        iter = group.keySet().iterator();
        while (iter.hasNext()) {
          Task task = (Task) iter.next();
          if (primaryTask != task) {
            primaryTasks.remove (task);
            primaryLinks.put (task, primaryTask);
          }
        }
      }
    }
  }

  public DefaultHandler getXMLHandler() {
    return new DataHandler();
  }

  /**
   * Now supports nested lists, nested objects.
   */
  private class DataHandler extends DefaultHandler {

    private String globalName = null;
    private String prefix = "";
    private FastStack prefixes = new FastStack();
    private SchObject predefined = null;
    private ArrayList predefinedTypes = new ArrayList();
    private SchObject object = null;
    private FastStack objects = new FastStack();
    private String objectType = null;
    private FastStack objectTypes = new FastStack();
    private HashMap formats = new HashMap();
    private HashMap currentFormat = new HashMap();
    private String taskObject = null;
    private String resourceObject = null;
    private String taskKey = null;
    private String resourceKey = null;
    private String fieldname;
    private ListFormat listFormat = null;
    private FastStack listFormats = new FastStack();
    private boolean doingNew = false;
    private boolean doingChanged = false;
    private boolean doingDeleted = false;

    private class FieldFormat {
      public String datatype;
      public boolean is_key;
      public boolean is_subobject;
      public boolean is_list;
      public FieldFormat (String datatype, boolean is_key,
                          boolean is_subobject, boolean is_list) {
        this.datatype = datatype;
        this.is_key = is_key;
        this.is_subobject = is_subobject;
        this.is_list = is_list;
      }
    }

    private class ListFormat {
      public String name;
      public String type;
      public boolean hasObjects;
      public SchObject object;
    }

    public DataHandler() {
      super();
      FieldFormat numberFF = new FieldFormat ("number", false, false, false);
      FieldFormat stringFF = new FieldFormat ("string", false, false, false);
      FieldFormat dateFF = new FieldFormat ("datetime", false, false, false);
      FieldFormat listFF = new FieldFormat ("number", false, false, true);
      HashMap latlongFormat = new HashMap();
      latlongFormat.put ("latitude", numberFF);
      latlongFormat.put ("longitude", numberFF);
      formats.put ("latlong", latlongFormat);
      predefinedTypes.add ("latlong");
      HashMap xycoordFormat = new HashMap();
      xycoordFormat.put ("x", numberFF);
      xycoordFormat.put ("y", numberFF);
      formats.put ("xy_coord", xycoordFormat);
      predefinedTypes.add ("xy_coord");
      HashMap matrixFormat = new HashMap();
      matrixFormat.put ("numrows", numberFF);
      matrixFormat.put ("numcols", numberFF);
      matrixFormat.put ("values", listFF);
      formats.put ("matrix", matrixFormat);
      predefinedTypes.add ("matrix");
      HashMap intervalFormat = new HashMap();
      intervalFormat.put ("start", dateFF);
      intervalFormat.put ("end", dateFF);
      intervalFormat.put ("label1", stringFF);
      intervalFormat.put ("label2", stringFF);
      formats.put ("interval", intervalFormat);
      predefinedTypes.add ("interval");
    }
    
    public void startElement (String uri, String local,
                              String name, Attributes atts) {
      if (name.equals ("FIELD")) {
        fieldname = atts.getValue ("name");
        FieldFormat ff = (FieldFormat)
          ((HashMap) formats.get (objectType)).get (fieldname);
        if (ff == null) {
          if (throwExceptionOnMissingField) {
            throw new RuntimeException ("Undefined field named " +
                                        fieldname + " for object type " +
                                        objectType);
          }
          else {
            if (debug)
              System.out.println ("SchedulingData.startElement - NOTE : " +
                                  "found undefined field " + fieldname +
                                  " for object type " + objectType +
                                  ". Ignoring.");
            prefixes.push (prefix);
            return;
          }
        }

        prefixes.push (prefix);
        if (ff.is_list) {
          listFormats.push (listFormat);
          listFormat = new ListFormat();
          listFormat.name = prefix + fieldname;
          listFormat.type = ff.datatype;
          listFormat.hasObjects = ff.is_subobject;
          listFormat.object = object;
          object.addListField (listFormat.name);
          objects.push (object);
          object = null;
          prefix = "";
        }
        else if (ff.is_subobject) {
          prefix = prefix + fieldname + ".";
        }
        else {
          object.addField (prefix + fieldname, ff.datatype,
                           atts.getValue ("value"), ff.is_key, false);
          if (ff.is_key && (object instanceof Task)) {
            if (doingDeleted)
              removeTask (((Task) object).getKey());
            else if (doingChanged)
              replaceTask ((Task) object);
            else if (doingNew)
              addTask ((Task) object);
          }
          if (ff.is_key && (object instanceof Resource)) {
            if (doingDeleted)
              removeResource (((Resource) object).getKey());
            else if (doingChanged)
              replaceResource ((Resource) object);
            else if (doingNew)
              addResource ((Resource) object);
          }
          if (predefined != null)
            predefined.addField (fieldname, ff.datatype,
                                 atts.getValue ("value"), false, false);
        }
      }
      else if (name.equals ("OBJECT")) {
        objectTypes.push (objectType);
        objectType = atts.getValue ("type");
        if ((object != null) && predefinedTypes.contains (objectType)) {
          predefined = new SchObject (timeOps);
          object.addField (((String) prefixes.peek()) + fieldname,
                           objectType, predefined, false, false);
        }
        objects.push (object);
        if (objectType.equals (taskObject))
          object = new Task (timeOps);
        else if (objectType.equals (resourceObject))
          object = new Resource (timeOps);
        else if (object == null) {
          object = new SchObject (timeOps);
          if (listFormat != null) {
            listFormat.object.addField (listFormat.name, listFormat.type,
                                        object, false, true);
          }
        }
        if (globalName != null) {
          if (doingDeleted || doingChanged)
            removeGlobal (globalName);
          if (doingNew || doingChanged)
            addGlobal (globalName, objectType, object);
          globalName = null;
        }
      }
      else if (name.equals ("VALUE")) {
        if (listFormat != null) {
          if (! listFormat.hasObjects) {
            listFormat.object.addField (listFormat.name, listFormat.type,
                                        atts.getValue ("value"), false, true);
          }
        }
        else if (debug)
          System.out.println ("SchedulingData.startElement - expecting " +
                              "listFormat to be set when hit VALUE tag.");
      }
      else if (name.equals ("FIELDFORMAT")) {
        FieldFormat ff = new FieldFormat
          (atts.getValue ("datatype"),
           atts.getValue ("is_key").equals ("true"),
           atts.getValue ("is_subobject").equals ("true"),
           atts.getValue ("is_list").equals ("true"));
        if (ff.datatype.startsWith ("string"))
          ff.datatype = "string";
        currentFormat.put (atts.getValue ("name"), ff);
      }
      else if (name.equals ("OBJECTFORMAT")) {
        currentFormat = new HashMap();
        formats.put (atts.getValue ("name"), currentFormat);
        if ((taskObject == null) &&
            atts.getValue ("is_task").equals ("true"))
          taskObject = atts.getValue ("name");
        if ((resourceObject == null) &&
            atts.getValue ("is_resource").equals ("true"))
          resourceObject = atts.getValue ("name");
      }
      else if (name.equals ("GLOBAL")) {
        globalName = atts.getValue ("name");
      }
      else if (name.equals ("WINDOW")) {
        startTime = timeOps.stringToTime (atts.getValue ("starttime"));
        if (atts.getValue ("endtime") != null)
          endTime = timeOps.stringToTime (atts.getValue ("endtime"));
      }
      else if (name.equals ("NEWOBJECTS")) {
        doingNew = true;
      }
      else if (name.equals ("CHANGEDOBJECTS")) {
        doingChanged = true;
      }
      else if (name.equals ("DELETEDOBJECTS")) {
        doingDeleted = true;
      }
      else if (name.equals ("CLEARDATABASE")) {
        Task[] tasks = getTasks();
        for (int i = 0; i < tasks.length; i++)
          removeTask (tasks[i].getKey());
        Resource[] resources = getResources();
        for (int i = 0; i < resources.length; i++)
          removeResource (resources[i].getKey());
        globals.clear();
        globalTypes.clear();
      }
      else if (name.equals ("FREEZE")) {
        freezeTask (atts.getValue ("task"), atts.getValue ("resource"),
                    atts.getValue ("start"), atts.getValue ("end"));
      }
      else if (name.equals ("UNFREEZE")) {
        unfreezeTask (atts.getValue ("task"));
      }
      else if (name.equals ("FREEZEALL")) {
        Task[] tasks = getTasks();
        for (int i = 0; i < tasks.length; i++)
          freezeTask (tasks[i].getKey(), null, null, null);
      }
      else if (name.equals ("UNFREEZEALL")) {
        Task[] tasks = getTasks();
        for (int i = 0; i < tasks.length; i++)
          unfreezeTask (tasks[i].getKey());
      }
    }

    public void endElement (String uri, String local, String name) {
      if (name.equals ("FIELD")) {
        prefix = (String) prefixes.pop();
      }
      else if (name.equals ("OBJECT")) {
        objectType = (String) objectTypes.pop();
        object = (SchObject) objects.pop();
        predefined = null;
      }
      else if (name.equals ("VALUE")) {
      }
      else if (name.equals ("LIST")) {
        listFormat = (ListFormat) listFormats.pop();
        object = (SchObject) objects.pop();
      }
      else if (name.equals ("GLOBAL")) {
        globalName = null;
      }
      else if (name.equals ("NEWOBJECTS")) {
        doingNew = false;
      }
      else if (name.equals ("CHANGEDOBJECTS")) {
        doingChanged = false;
      }
      else if (name.equals ("DELETEDOBJECTS")) {
        doingDeleted = false;
      }
    }
  }
}
