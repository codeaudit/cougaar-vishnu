// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Resource.java,v 1.9 2001-04-12 17:50:31 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.TreeSet;
import java.util.SortedSet;
import java.util.Comparator;
import java.util.Iterator;

/**
 * A resource object
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class Resource extends SchObject {

  private HashMap assignments = new HashMap (5);
  private TimeBlock[] activities = new TimeBlock[0];
  private TreeSet schedule = new TreeSet (new TimeBlockComparator());
  private float[] capacities;
  private float[] capacitiesUsed = null;
  private float sumOfDeltas;
  private boolean hasMultitaskContrib = false;
  private Assignment lastAssignment;
  private boolean lastNewGroup;

  public Resource (TimeOps timeOps) {
    super (timeOps);
  }

  public void addAssignment (Assignment a, boolean putInSchedule,
                             boolean willBeNewGroup) {
    lastAssignment = a;
    lastNewGroup = willBeNewGroup;
    assignments.put (a.getTask().getKey(), a);
    if (putInSchedule)
      schedule.add (a);
  }

  public void addMultitaskContribs (Assignment a) {
    lastAssignment = null;
    hasMultitaskContrib = true;
    float[] contribs = a.getTask().getCapacityContribs();
    ArrayList overlap = getOverlappingBlocks (a);
    for (int i = 0; i < overlap.size(); i++)
      schedule.remove (overlap.get(i));
    int start = a.getStartTime();
    for (int i = 0; i < overlap.size(); i++) {
      MultitaskAssignment ma = (MultitaskAssignment) overlap.get(i);
      if (start < ma.getStartTime()) {
        schedule.add (new MultitaskAssignment
                      (new Task[] {a.getTask()}, this, contribs, start,
                       start, ma.getStartTime(), ma.getStartTime(), timeOps));
        start = ma.getStartTime();
      }
      if (start > ma.getStartTime()) {
        schedule.add (new MultitaskAssignment
                      (ma.getTasks(), this, ma.getCapacities(),
                       ma.getStartTime(),ma.getStartTime(),
                       start, start, timeOps));
      }
      int end = ((ma.getEndTime() < a.getEndTime()) ?
                 ma.getEndTime() : a.getEndTime());
      Task[] tasks = new Task [ma.getTasks().length + 1];
      System.arraycopy (ma.getTasks(), 0, tasks, 0, ma.getTasks().length);
      tasks [tasks.length - 1] = a.getTask();
      float[] caps = new float [ma.getCapacities().length];
      for (int j = 0; j < caps.length; j++)
        caps[j] = ma.getCapacities()[j] + contribs[j];
      schedule.add (new MultitaskAssignment (tasks, this, caps, start,
                                             start, end, end, timeOps));
      start = end;
      if (start < ma.getEndTime()) {
        schedule.add (new MultitaskAssignment
                      (ma.getTasks(), this, ma.getCapacities(), start,
                       start, ma.getEndTime(), ma.getEndTime(), timeOps));
      }
    }
    if (start < a.getEndTime())
      schedule.add (new MultitaskAssignment
                    (new Task[] {a.getTask()}, this, contribs,
                     start, start, a.getEndTime(), a.getEndTime(), timeOps));
  }

  public void resetMultitaskContrib () {
    if (hasMultitaskContrib)
      schedule = new TreeSet (new TimeBlockComparator());
    hasMultitaskContrib = false;
  }

  public void addGroupedContrib (Assignment a, MultitaskAssignment ma) {
    if (ma != null)
      ma.addTask (a.getTask());
    else
      schedule.add (new MultitaskAssignment
                    (new Task[] {a.getTask()}, this,
                     a.getTask().getCapacityContribs(), a.getStartTime(),
                     a.getTaskStartTime(), a.getTaskEndTime(),
                     a.getEndTime(), timeOps));
  }

  public void removeAssignment (String taskKey, boolean wasInSchedule) {
    lastNewGroup = false;
    lastAssignment = null;
    if (wasInSchedule)
      schedule.remove (assignments.get (taskKey));
    assignments.remove (taskKey);
  }

  public void clearSchedule() {
    ArrayList al = new ArrayList (schedule);
    for (int i = 0; i < al.size(); i++) {
      Object o = al.get(i);
      if (o instanceof Assignment)
        schedule.remove (o);
    }
  }

  public Assignment getAssignment (String taskKey) {
    return (Assignment) assignments.get (taskKey);
  }

  public Assignment[] getAssignments() {
    Assignment[] arr = new Assignment [assignments.size()];
    return (Assignment[]) assignments.values().toArray (arr);
  }

  public MultitaskAssignment[] getMultitaskAssignments() {
    ArrayList al = new ArrayList();
    Iterator iter = schedule.iterator();
    while (iter.hasNext()) {
      Object o = iter.next();
      if (o instanceof MultitaskAssignment)
        al.add (o);
    }
    return (MultitaskAssignment[])
      al.toArray (new MultitaskAssignment [al.size()]);
  }

  public void setActivities (TimeBlock[] activities) {
    this.activities = activities;
    for (int i = 0; i < activities.length; i++)
      schedule.add (activities[i]);
  }

  public TimeBlock[] getActivities()  { return activities; }

  public void setCapacities (float[] c)  { capacities = c; }

  public float[] getCapacities()  { return capacities; }

  public void addCapacityContribs (float[] contribs) {
    int len = Math.min (capacitiesUsed.length, contribs.length);
    for (int i = 0; i < len; i++)
      capacitiesUsed[i] += contribs[i];
  }

  public void resetCapacitiesUsed() {
    if (capacitiesUsed == null)
      capacitiesUsed = new float [capacities.length];
    for (int i = 0; i < capacitiesUsed.length; i++)
      capacitiesUsed[i] = 0.0f;
  }

  public boolean enoughCapacity (float[] contribs) {
    if (contribs.length > capacitiesUsed.length)
      return false;
    for (int i = 0; i < contribs.length; i++)
      if (capacitiesUsed[i] + contribs[i] > capacities[i])
        return false;
    return true;
  }

  public void resetSumOfDeltas()  { sumOfDeltas = 0.0f; }

  public void addDelta (float delta)  { sumOfDeltas += delta; }

  public float getSumOfDeltas()  { return sumOfDeltas; }

  public float busyTime (int start, int end) {
    Assignment[] a = getAssignments();
    int total = 0;
    for (int i = 0; i < a.length; i++) {
      int start2 = a[i].getTaskStartTime();
      int end2 = a[i].getTaskEndTime();
      int t1 = (start < start2) ? start2 : start;
      int t2 = (end > end2) ? end2 : end;
      if (t1 < t2)
        total += t2 - t1;
    }
    return total;
  }

  public float prepTime () {
    Iterator iter = schedule.iterator();
    int total = 0;
    while (iter.hasNext()) {
      Object o = iter.next();
      if (o instanceof Assignment) {
        Assignment a = (Assignment) o;
        int setup = a.getStartTime();
        int start = a.getTaskStartTime();
        int end = a.getTaskEndTime();
        int wrapup = a.getEndTime();
        total += (start - setup) + (wrapup - end);
      }
    }
    if (lastNewGroup) {
      int setup = lastAssignment.getStartTime();
      int start = lastAssignment.getTaskStartTime();
      int end = lastAssignment.getTaskEndTime();
      int wrapup = lastAssignment.getEndTime();
      total += (start - setup) + (wrapup - end);
    }
    return total;
  }

  public ArrayList getGroup (ArrayList list, Task task) {
    if ((lastAssignment != null) &&
        (lastAssignment.getTask() == task)) {
      list.add (task);
      if (lastNewGroup)
        return list;
    }
    Object o = schedule.tailSet(task.getAssignment()).first();
    if (o instanceof MultitaskAssignment) {
      MultitaskAssignment ma = (MultitaskAssignment) o;
      Task[] tasks = ma.getTasks();
      for (int i = 0; i < tasks.length; i++)
        list.add (tasks[i]);
    }
    return list;
  }


  /** class for returning result of earliestAvailableBlock */
  public static class Block {
    public int setup;
    public int start;
    public int end;
    public int wrapup;
    public int preWrapup;
    public int postSetup;
    public Assignment preAssignment = null;
    public Assignment postAssignment = null;
    public MultitaskAssignment groupedAssignment = null;
  }

  public Block getFixedBlock (Task task, int start, int end,
                              boolean grouped, boolean ignorePrePost,
                              SchedulingSpecs specs) {
    Block block = new Block();
    block.start = start;
    block.end = end;
    block.setup = start;
    block.wrapup = end;
    if (ignorePrePost)
      return block;
    if (grouped) {
      Iterator iter = schedule.iterator();
      while (iter.hasNext()) {
        MultitaskAssignment ma = (MultitaskAssignment) iter.next();
        if ((start >= ma.getTaskStartTime()) &&
            (end <= ma.getTaskEndTime()) &&
            task.groupableWith (ma.getTasks())) {
          block.groupedAssignment = ma;
          return block;
        }
      }
    }
    TimeBlock curr = null, prev = null;
    Iterator iter = schedule.iterator();
    while (iter.hasNext()) {
      curr = (TimeBlock) iter.next();
      if (curr.getStartTime() < start) {
        prev = curr;
        curr = null;
      }
    }
    if ((prev == null) || (! (prev instanceof Assignment)))
      block.setup = start - specs.setupDuration (task, null, this);
    else {
      Assignment a = (Assignment) prev;
      block.setup = start - specs.setupDuration (task, a.getTask(), this);
      block.preWrapup = a.getEndTime() +
        specs.wrapupDuration (a.getTask(), task, this);
      block.preAssignment = a;
    }
    if ((curr == null) || (! (curr instanceof Assignment)))
      block.wrapup = end + specs.wrapupDuration (task, null, this);
    else {
      Assignment a = (Assignment) curr;
      block.wrapup = end + specs.wrapupDuration (task, a.getTask(), this);
      block.postSetup = a.getStartTime() -
        specs.setupDuration (a.getTask(), task, this);
      block.postAssignment = a;
    }
    return block;
  }

  /** Search forward from notEarlierThan for first available block of
   *  time that task can be scheduled.  The set of time blocks unavail
   *  tells when the task is busy. */
  public Block earliestAvailableBlock (Task task, int duration,
                                       TimeBlock[] unavail,
                                       SchedulingSpecs specs,
                                       boolean multitask, boolean grouped,
                                       int notEarlierThan, int startTime,
                                       Task[] linked,
                                       SchedulingData data) {
    if (specs.alwaysCompact())
      return putAtEnd (task, duration, unavail, specs);
    Iterator iter = multitask ? getMultitaskIter (task) : schedule.iterator();
    int[] earliest = {Integer.MIN_VALUE, Integer.MIN_VALUE, 0};
    Block block = new Block();
    TimeBlock curr = null, prev = null;
    if (adjustEarliestInterval (task, unavail, earliest, duration,
                                notEarlierThan, linked, data, specs,
                                multitask, grouped))
      return null;
    while (iter.hasNext()) {
      if (grouped && fitsGroup (task, curr, unavail, duration))
        return makeGroupedBlock (task, duration, curr);
      prev = curr;
      curr = (TimeBlock) iter.next();
      if (prev != null)
        if (adjustEarliestInterval (task, unavail, earliest, duration,
                                    prev.getEndTime(), linked, data, specs,
                                    multitask, grouped))
          return null;
      if (curr.getStartTime() < (earliest[0] + duration))
        continue;
      while (true) {
        fillBlock (task, block, duration, specs, prev, curr, earliest[0],
                   multitask, startTime);
        if ((block.wrapup == Integer.MAX_VALUE) ||
            (block.end <= earliest[1]))
          break;
        if (adjustEarliestInterval (task, unavail, earliest, duration,
                                    block.start, linked, data, specs,
                                    multitask, grouped))
          return null;
      }
      if (block.wrapup <= curr.getStartTime())
        return (block.end < block.start) ? null : block;
    }
    if (grouped && fitsGroup (task, curr, unavail, duration))
      return makeGroupedBlock (task, duration, curr);
    fillBlock (task, block, duration, specs, curr, null, earliest[0],
               multitask, startTime);
    return ((block.end > earliest[1]) ||
            (block.end < block.start)) ? null : block;
  }

  private boolean adjustEarliestInterval (Task task, TimeBlock[] unavail,
                                          int[] interval, int duration,
                                          int earliest, Task[] linked,
                                          SchedulingData data,
                                          SchedulingSpecs specs,
                                          boolean multitask, boolean grouped) {
    while (! adjustEarliest2 (unavail, interval, duration, earliest)) {
      boolean found = false;
      for (int i = 0; i < linked.length; i++) {
        int time = interval[0] - data.cachedLinkTimeDiff (task, linked[i]);
        int time2 = OrderedDecoder.findEarliestTime
          (linked[i], time, data, specs, multitask, grouped);
        if (time != time2) {
          found = true;
          earliest = interval[0] + (time2 - time);
          break;
        }
      }
      if (! found)
        return false;
    }
    return true;
  }

  private boolean adjustEarliest2 (TimeBlock[] unavail, int[] interval,
                                   int duration, int earliest) {
    if (interval[0] > earliest)
      return false;
    for (int j = interval[2]; j < unavail.length; j++) {
      if ((earliest + duration) <= unavail[j].getStartTime()) {
        interval[0] = earliest;
        interval[1] = unavail[j].getStartTime();
        interval[2] = j;
        return false;
      }
      if (unavail[j].getEndTime() > earliest)
        earliest = unavail[j].getEndTime();
    }
    interval[0] = earliest;
    interval[1] = Integer.MAX_VALUE;
    interval[2] = unavail.length;
    return (interval[0] == Integer.MAX_VALUE);
  }

  private void fillBlock (Task task, Block block, int duration,
                          SchedulingSpecs specs, TimeBlock pre,
                          TimeBlock post, int earliest, boolean multitask,
                          int startTime) {
    block.preAssignment = null;
    block.postAssignment = null;
    if (pre != null) {
      if ((post != null) &&
          ((pre.getEndTime() == post.getStartTime()) ||
           ((pre.getEndTime() + duration) > post.getStartTime()))) {
        block.wrapup = Integer.MAX_VALUE;
        return;
      }
      int setup = 0;
      if (multitask || (! (pre instanceof Assignment))) {
        block.preWrapup = pre.getEndTime();
        setup = specs.setupDuration (task, null, this);
      }
      else {
        Assignment a = (Assignment) pre;
        block.preWrapup = a.getTaskEndTime() +
          specs.wrapupDuration (a.getTask(), task, this);
        block.preAssignment = a;
        setup = specs.setupDuration (task, a.getTask(), this);
      }
      block.setup = block.preWrapup;
      block.start = block.preWrapup + setup;
      if (block.start < earliest) {
        block.setup = earliest - setup;
        block.start = earliest;
      }
    }
    else {
      int sd = specs.setupDuration (task, null, this);
      int setup2 = earliest - sd;
      block.setup = (startTime > setup2) ? startTime : setup2;
      block.start = block.setup + sd;
    }
    block.end = block.start + duration;
    if (post == null) {
      block.wrapup = block.end + specs.wrapupDuration (task, null, this);
      return;
    }
    if (multitask || (! (post instanceof Assignment))) {
      block.wrapup = block.end + specs.wrapupDuration (task, null, this);
      block.postSetup = post.getStartTime();
    }
    else {
      Assignment a = (Assignment) post;
      Task t = a.getTask();
      block.wrapup = block.end + specs.wrapupDuration (task, t, this);
      block.postSetup = a.getTaskStartTime() -
        specs.setupDuration (t, task, this);
      block.postAssignment = a;
    }
    if (block.wrapup > block.postSetup)
      block.wrapup = Integer.MAX_VALUE;
  }

  private Block putAtEnd (Task task, int duration, TimeBlock[] unavail,
                          SchedulingSpecs specs) {
    Block block = new Block();
    block.postAssignment = null;
    if (schedule.size() == 0) {
      block.preAssignment = null;
      block.setup = unavail[0].getEndTime();
      block.start = block.setup + specs.setupDuration (task, null, this);
    }
    else {
      block.preAssignment = (Assignment) schedule.last();
      block.preWrapup = block.preAssignment.getTaskEndTime() +
          specs.wrapupDuration (block.preAssignment.getTask(), task, this);
      block.setup = block.preWrapup;
      block.start = block.setup +
        specs.setupDuration (task, block.preAssignment.getTask(), this);
    }
    block.end = block.start + duration;
    block.wrapup = block.end + specs.wrapupDuration (task, null, this);
    return block;
  }

  /** Search backward from notLaterThan for first available block of
   *  time that task can be scheduled.  The set of time blocks unavail
   *  tells when the task is busy. */
  public Block latestAvailableBlock (Task task, int duration,
                                     TimeBlock[] unavail,
                                     SchedulingSpecs specs,
                                     boolean multitask, boolean grouped,
                                     int notLaterThan, int endTime,
                                     Task[] linked, SchedulingData data) {
    Iterator iter = multitask ? getMultitaskIter (task) : schedule.iterator();
    iter = reverseIter (iter);
    int[] latest = {Integer.MAX_VALUE, Integer.MAX_VALUE, unavail.length - 1};
    Block block = new Block();
    TimeBlock curr = null, prev = null;
    if (adjustLatestInterval (task, unavail, latest, duration,
                              notLaterThan, linked, data, specs,
                              multitask, grouped))
      return null;
    while (iter.hasNext()) {
      if (grouped && fitsGroup (task, curr, unavail, duration))
        return makeGroupedBlock (task, duration, curr);
      prev = curr;
      curr = (TimeBlock) iter.next();
      if (prev != null)
        if (adjustLatestInterval (task, unavail, latest, duration,
                                  prev.getStartTime(), linked, data, specs,
                                  multitask, grouped))
          return null;
      if (curr.getEndTime() > (latest[0] - duration))
        continue;
      while (true) {
        fillBlock2 (task, block, duration, specs, prev, curr, latest[0],
                    multitask, endTime);
        if ((block.setup == Integer.MIN_VALUE) ||
            (block.start >= latest[1]))
          break;
        if (adjustLatestInterval (task, unavail, latest, duration,
                                  block.end, linked, data, specs,
                                  multitask, grouped))
          return null;
      }
      if (block.setup >= curr.getEndTime())
        return (block.end < block.start) ? null : block;
    }
    if (grouped && fitsGroup (task, curr, unavail, duration))
      return makeGroupedBlock (task, duration, curr);
    fillBlock2 (task, block, duration, specs, curr, null, latest[0],
                multitask, endTime);
    return ((block.start < latest[1]) ||
            (block.end < block.start)) ? null : block;
  }

  private boolean adjustLatestInterval (Task task, TimeBlock[] unavail,
                                        int[] interval, int duration,
                                        int latest, Task[] linked,
                                        SchedulingData data,
                                        SchedulingSpecs specs,
                                        boolean multitask, boolean grouped) {
    while (! adjustLatest2 (unavail, interval, duration, latest)) {
      boolean found = false;
      for (int i = 0; i < linked.length; i++) {
        int time = interval[0] - data.cachedLinkTimeDiff (task, linked[i]);
        int time2 = OrderedDecoder.findLatestTime
          (linked[i], time, data, specs, multitask, grouped);
        if (time != time2) {
          found = true;
          latest = interval[0] +  (time2 - time);
          break;
        }
      }
      if (! found)
        return false;
    }
    return true;
  }

  private boolean adjustLatest2 (TimeBlock[] unavail, int[] interval,
                                 int duration, int latest) {
    if (interval[0] < latest)
      return false;
    for (int j = interval[2]; j >= 0; j--) {
      if ((latest - duration) >= unavail[j].getEndTime()) {
        interval[0] = latest;
        interval[1] = unavail[j].getEndTime();
        interval[2] = j;
        return false;
      }
      if (unavail[j].getStartTime() < latest)
        latest = unavail[j].getStartTime();
    }
    interval[0] = latest;
    interval[1] = Integer.MIN_VALUE;
    interval[2] = -1;
    return (interval[0] == Integer.MIN_VALUE);
  }

  private void fillBlock2 (Task task, Block block, int duration,
                           SchedulingSpecs specs, TimeBlock pre,
                           TimeBlock post, int latest, boolean multitask,
                           int endTime) {
    block.preAssignment = null;
    block.postAssignment = null;
    if (pre != null) {
      if ((post != null) &&
          ((pre.getStartTime() == post.getEndTime()) ||
           ((pre.getStartTime() - duration) < post.getEndTime()))) {
        block.setup = Integer.MIN_VALUE;
        return;
      }
      int wrapup = 0;
      if (multitask || (! (pre instanceof Assignment))) {
        block.postSetup = pre.getStartTime();
        wrapup = specs.wrapupDuration (task, null, this);
      }
      else {
        Assignment a = (Assignment) pre;
        block.postSetup = a.getTaskStartTime() -
          specs.setupDuration (a.getTask(), task, this);
        block.postAssignment = a;
        wrapup = specs.wrapupDuration (task, a.getTask(), this);
      }
      block.wrapup = block.postSetup;
      block.end = block.postSetup - wrapup;
      if (block.end > latest) {
        block.wrapup = latest + wrapup;
        block.end = latest;
      }
    }
    else {
      int wd = specs.wrapupDuration (task, null, this);
      int wrapup2 = latest + wd;
      block.wrapup = (endTime < wrapup2) ? endTime : wrapup2;
      block.end = block.wrapup - wd;
    }
    block.start = block.end - duration;
    if (post == null) {
      block.setup = block.start - specs.setupDuration (task, null, this);
      return;
    }
    if (multitask || (! (post instanceof Assignment))) {
      block.setup = block.start - specs.setupDuration (task, null, this);
      block.preWrapup = post.getEndTime();
    }
    else {
      Assignment a = (Assignment) post;
      Task t = a.getTask();
      block.setup = block.start - specs.setupDuration (task, t, this);
      block.preWrapup = a.getTaskEndTime() +
        specs.wrapupDuration (t, task, this);
      block.preAssignment = a;
    }
    if (block.setup < block.preWrapup)
      block.setup = Integer.MIN_VALUE;
  }

  private Iterator getMultitaskIter (Task task) {
    ArrayList al = new ArrayList();
    Iterator iter = schedule.iterator();
    while (iter.hasNext()) {
      MultitaskAssignment ma = (MultitaskAssignment) iter.next();
      if (! ma.enoughCapacity (task.getCapacityContribs()))
        al.add (ma);
    }
    return al.iterator();
  }

  private Iterator reverseIter (Iterator iter) {
    ArrayList al = new ArrayList();
    while (iter.hasNext())
      al.add (0, iter.next());
    return al.iterator();
  }

  private ArrayList getOverlappingBlocks (TimeBlock tb) {
    ArrayList al = new ArrayList();
    SortedSet ss = schedule.headSet(tb);
    if (ss.size() > 0) {
      TimeBlock first = (TimeBlock) ss.last();
      if ((first != null) && (first.getEndTime() > tb.getStartTime()))
        al.add (first);
    }
    Iterator rest = schedule.tailSet(tb).iterator();
    while (rest.hasNext()) {
      TimeBlock tb2 = (TimeBlock) rest.next();
      if (tb2.getStartTime() < tb.getEndTime())
        al.add (tb2);
    }
    return al;
  }

  private boolean fitsGroup (Task task, TimeBlock tb, TimeBlock[] unavail,
                             int duration) {
    if ((tb == null) || (! (tb instanceof MultitaskAssignment)))
      return false;
    MultitaskAssignment ma = (MultitaskAssignment) tb;
    if (duration > (ma.getTaskEndTime() - ma.getTaskStartTime()))
      return false;
    if (! ma.enoughCapacity (task.getCapacityContribs()))
      return false;
    for (int i = 0; i < unavail.length; i++) {
      if (unavail[i].getEndTime() <= ma.getTaskStartTime())
        continue;
      if (unavail[i].getStartTime() >= ma.getTaskEndTime())
        break;
      return false;
    }
    return task.groupableWith (ma.getTasks());
  }

  private Block makeGroupedBlock (Task task, int duration, TimeBlock tb) {
    MultitaskAssignment ma = (MultitaskAssignment) tb;
    Block b = new Block();
    b.setup = ma.getStartTime();
    b.start = ma.getTaskStartTime();
    b.end = b.start + duration;
    b.wrapup = ma.getEndTime();
    b.groupedAssignment = ma;
    return b;
  }

  private static class TimeBlockComparator implements Comparator {
    public int compare (Object obj1, Object obj2) {
      int t1 = ((TimeBlock) obj1).getStartTime();
      int t2 = ((TimeBlock) obj2).getStartTime();
      if (t1 < t2)
        return -1;
      if (t1 > t2)
        return 1;
      t1 = ((TimeBlock) obj1).getEndTime();
      t2 = ((TimeBlock) obj2).getEndTime();
      if (t1 < t2)
        return -1;
      if (t1 > t2)
        return 1;
      return 0;
    }
  }

  public String toString () {
    return "Resource : " + super.toString ();
  }

}
