// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OrderedDecoder.java,v 1.1 2001-08-15 18:21:55 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;

/**
 * Generates a schedule from an ordered chromosome using a greedy
 * optimization algorithm
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OrderedDecoder implements GADecoder {

  private static boolean timing = 
    ("true".equals (System.getProperty ("vishnu.timing")));

  boolean ignoringTime;
  boolean multitask;
  boolean grouped;
  TimeOps timeOps;

  public void generateAssignments (Chromosome chrom, SchedulingData data,
                                   SchedulingSpecs specs, boolean explain) {
    timeOps = specs.getTimeOps();
    Resource[] r = data.getResources();
    ignoringTime = specs.ignoringTime();
    multitask = ((! ignoringTime) &&
                 (specs.getMultitasking() ==
                  SchedulingSpecs.MULTITASKING_UNGROUPED));
    grouped = ((! ignoringTime) &&
                 (specs.getMultitasking() ==
                  SchedulingSpecs.MULTITASKING_GROUPED));
    for (int i = 0; i < r.length; i++)
      r[i].resetSumOfDeltas();
    assignFrozen (data, specs);  // put in frozen assignments first

    Task[] tasks2 = data.getPrimaryTasks();
    ArrayList tasks = new ArrayList (tasks2.length);
    for (int i = 0; i < tasks2.length; i++)
      tasks.add (tasks2 [((StringOfIntegers) chrom).getValues()[i]]);
    // Take one task at a time off the list of tasks and schedule it.
    // Always take the one nearest the front of the list that is ready
    // to be scheduled (i.e., is not waiting for prerequisites).
    while (tasks.size() > 0) {
      for (int i = 0; i < tasks.size(); i++) {
        Task task = (Task) tasks.get(i);
        Task[] prereqs = task.getPrerequisites ();
        boolean readyButUnable = false;
        for (int j = 0; j < prereqs.length; j++) {
          if ((prereqs[j] != null) && (prereqs[j].getAssignment() == null)) {
            readyButUnable = true;  // if prereq unassigned, same for current
            break;
          }
        }
        if (readyButUnable) {
          tasks.remove (i);
          if (explain)
            System.out.println ("Task " + task.getKey() + " not " +
                 "scheduled because prerequisites not all scheduled");
          break;
        }
        Resource[] resources = specs.capableResources (task, data);
        Task[] linked = data.getLinkedTasks (task);
        if (resources.length == 0) {
          if (explain)
            System.out.println ("Task " + task.getKey() + " not " +
                 "scheduled because there were no capable resources");
        }
        // if only one capable resource, just do assignment
        else if (resources.length == 1) {
          if (! resources[0].enoughCapacity (task.getCapacityContribs())) {
            if (explain)
              System.out.println ("Task " + task.getKey() + " not " +
                 "scheduled on resource " + resources[0].getKey() +
                 " because there was not enough capacity");
          }
          else if (makeAssignment (task, resources[0], prereqs,
                               specs, data, true, true, linked) == null) {
            if (explain)
              System.out.println ("Task " + task.getKey() + " not " +
                 "scheduled on resource " + resources[0].getKey() +
                 " because there was no available time");
          }
          else {
            float delta = specs.evaluateSingleAssignment (task, resources[0]);
            if (delta != 0.0f)
              resources[0].addDelta (delta);
          }
        }
        // if more than one capable resource, look for best resource
        // make temporary assignment to each resource and use delta
        // evaluation to figure out which is best
        else if (resources.length > 1) {
          Resource bestResource = null;
          float bestDelta = 0.0f;
          boolean computeUnavail = true;
          for (int j = 0; j < resources.length; j++) {
            Resource resource = resources[j];
            if (! resource.enoughCapacity (task.getCapacityContribs())) {
              if (explain)
                System.out.println ("Task " + task.getKey() + " not " +
                   "scheduled on resource " + resource.getKey() +
                   " because there was not enough capacity");
              continue;
            }
            Resource.Block b =
              makeAssignment (task, resource, prereqs, specs,
                              data, false, computeUnavail, linked);
            computeUnavail = false;
            if (b == null) {
              if (explain)
                System.out.println ("Task " + task.getKey() + " not " +
                   "scheduled on resource " + resource.getKey() +
                   " because there was no available time");
              continue;
            }
            float delta = specs.evaluateSingleAssignment (task, resource);
            if ((bestResource == null) ||
                (specs.isMinimizing() && (delta < bestDelta)) ||
                ((! specs.isMinimizing()) && (delta > bestDelta))) {
              bestResource = resource;
              bestDelta = delta;
            }
            removeAssignment (task, resource, b);
          }
          if (bestResource != null) {
            makeAssignment (task, bestResource, prereqs, specs, data,
                            true, false, linked);
            if (bestDelta != 0.0f)
              bestResource.addDelta (bestDelta);
          }
        }
        tasks.remove (i);
        break;
      }
    }
  }

  private void removeAssignment (Task task, Resource resource,
                                 Resource.Block block) {
    task.setAssignment (null);
    resource.removeAssignment (task.getKey(),
                               ! (ignoringTime || multitask || grouped));
    if (block.preAssignment != null)
      block.preAssignment.setEndTime (block.preWrapup);
    if (block.postAssignment != null)
      block.postAssignment.setStartTime (block.postSetup);
  }

  int visits = 0;
  long totaltime = 0;

  public void reportTiming () { 
    if (timing)
      System.out.println ("unavail # called " + visits + " times " +
                          totaltime + " milliseconds");
  }
  

  /** Find the best time for the assignment, and make the assignment
   *  at that time.  If the best time is not the earliest time, then
   *  try looking both backwards and forwards from best time; otherwise,
   *  just look forwards.  Look for first available block of time.
   *  If looking in two directions, use delta criterion to determine
   *  which is better.
   */
  private Resource.Block makeAssignment (Task task, Resource resource,
                                  Task[] prereqs, SchedulingSpecs specs,
                                  SchedulingData data, boolean doUpdates,
                                  boolean firstResource, Task[] linked) {
    Resource.Block block = null;
    if (! ignoringTime) {
      int dur = specs.taskDuration (task, resource, firstResource);
      int bestTime = specs.bestTime (task, resource, dur, firstResource);
      TimeBlock[] unavail;
	  
      if (timing) {
        visits++;
        Date start = new Date ();
        unavail = specs.taskUnavailableTimes
              (task, prereqs, data.getStartTime(), data.getEndTime(),
               resource, dur, firstResource);
        totaltime += new Date().getTime () - start.getTime();
      } else {
        unavail = specs.taskUnavailableTimes
              (task, prereqs, data.getStartTime(), data.getEndTime(),
               resource, dur, firstResource);
      }

      block = resource.earliestAvailableBlock (task, dur, unavail, specs,
                                               multitask, grouped, bestTime,
                                               data.getStartTime(),
                                               linked, data);
      if (bestTime > data.getStartTime()) {
        Resource.Block block2 =
          resource.latestAvailableBlock (task, dur, unavail, specs,
                                         multitask, grouped, bestTime + dur,
                                         data.getEndTime(), linked, data);
        if (block == null)
          block = block2;
        else if ((block2 != null) &&
                 (block.start != block2.start)) {
          Resource.Block b =
            makeAssignment2 (task, resource, block, false, false);
          float d1 = specs.evaluateSingleAssignment (task, resource);
          removeAssignment (task, resource, b);
          b = makeAssignment2 (task, resource, block2, false, false);
          float d2 = specs.evaluateSingleAssignment (task, resource);
          removeAssignment (task, resource, b);
          if (specs.isMinimizing() ^
              ((d1 < d2) || ((d1 == d2) && ((block.start - bestTime) <
                                            (bestTime - block2.start)))))
            block = block2;
        }
      }
      if (block == null)
        return null;
    }
    Resource.Block ret =
      makeAssignment2 (task, resource, block, doUpdates, false);
    if (doUpdates) {
      for (int j = 0; j < linked.length; j++) {
        int timeDiff = data.cachedLinkTimeDiff (task, linked[j]);
        assignAtTime (linked[j], block.start - timeDiff, data, specs);
      }
    }
    return ignoringTime ? EmptyBlock : ret;
  }

  private static final Resource.Block EmptyBlock = new Resource.Block();

  private Resource.Block makeAssignment2 (Task task, Resource resource,
                                          Resource.Block block,
                                          boolean doUpdates, boolean frozen) {
    Resource.Block ret = null;
    if (block != null) {
      ret = new Resource.Block();
      ret.preAssignment = block.preAssignment;
      ret.postAssignment = block.postAssignment;
      if (ret.preAssignment != null) {
        ret.preWrapup = ret.preAssignment.getEndTime();
        block.preAssignment.setEndTime (block.preWrapup);
      }
      if (ret.postAssignment != null) {
        ret.postSetup = ret.postAssignment.getStartTime();
        block.postAssignment.setStartTime (block.postSetup);
      }
    }

    Assignment a = (ignoringTime ?
                    new Assignment (task, resource, 0, 0, 0, 0,
                                    frozen, timeOps) :
                    new Assignment (task, resource, block.setup, block.start,
                                    block.end, block.wrapup, frozen, timeOps));
    task.setAssignment (a);
    resource.addAssignment (a, ! (ignoringTime || multitask || grouped),
                            grouped && (block.groupedAssignment == null));
    if (doUpdates) {
      if (multitask)
        resource.addMultitaskContribs (a);
      else if (grouped)
        resource.addGroupedContrib (a, block.groupedAssignment);
      else
        resource.addCapacityContribs (task.getCapacityContribs());
    }

    return ret;
  }

  private void assignFrozen (SchedulingData data, SchedulingSpecs specs) {
    Task[] frozen = data.getFrozenTasks();
    for (int i = 0; i < frozen.length; i++)
      frozen[i].setAssignment (data.getFrozenAssignment (frozen[i]));
    Arrays.sort (frozen, new Comparator()
                 { public int compare (Object o1, Object o2) {
                   int t1 = ((Task) o1).getAssignment().getStartTime();
                   int t2 = ((Task) o2).getAssignment().getStartTime();
                   return t1 - t2;
                 }});
    for (int i = 0; i < frozen.length; i++) {
      Assignment a = frozen[i].getAssignment();
      makeAssignment2 (frozen[i], a.getResource(),
                       a.getResource().getFixedBlock
                       (frozen[i], a.getStartTime(), a.getEndTime(),
                        grouped, multitask || ignoringTime, specs),
                       true, true);
    }

    HashMap linked = data.getLinkedToFrozenTasks();
    java.util.Iterator iter = linked.keySet().iterator();
    while (iter.hasNext()) {
      Task task = (Task) iter.next();
      Task task2 = (Task) linked.get (task);
      int start = (task2.getAssignment().getTaskStartTime() + 
                   data.cachedLinkTimeDiff (task, task2));
      int start2 = findEarliestTime (task, start, data, specs,
                                     multitask, grouped);
      if (start == start2)
        assignAtTime (task, start, data, specs);
    }
  }

  public static int findEarliestTime (Task task, int notBefore,
                                      SchedulingData data,
                                      SchedulingSpecs specs,
                                      boolean multitask, boolean grouped) {
    Resource[] resources = specs.capableResources (task, data);
    Task[] prereqs = new Task[0];
    int bestTime = Integer.MAX_VALUE;
    for (int i = 0; i < resources.length; i++) {
      Resource resource = resources[i];
      int dur = specs.taskDuration (task, resource, i == 0);
      TimeBlock[] unavail = specs.taskUnavailableTimes
        (task, prereqs, data.getStartTime(), data.getEndTime(),
         resource, dur, i == 0);
      Resource.Block block = resource.earliestAvailableBlock
        (task, dur, unavail, specs, multitask, grouped,
         notBefore, data.getStartTime(), SchedulingData.emptyTaskArray, data);
      if (block.start < bestTime)
        bestTime = block.start;
    }
    return bestTime;
  }

  public static int findLatestTime (Task task, int notAfter,
                                    SchedulingData data,
                                    SchedulingSpecs specs,
                                    boolean multitask, boolean grouped) {
    Resource[] resources = specs.capableResources (task, data);
    Task[] prereqs = new Task[0];
    int bestTime = Integer.MIN_VALUE;
    for (int i = 0; i < resources.length; i++) {
      Resource resource = resources[i];
      int dur = specs.taskDuration (task, resource, i == 0);
      TimeBlock[] unavail = specs.taskUnavailableTimes
        (task, prereqs, data.getStartTime(), data.getEndTime(),
         resource, dur, i == 0);
      Resource.Block block = resource.latestAvailableBlock
        (task, dur, unavail, specs, multitask, grouped, notAfter,
         data.getEndTime(), SchedulingData.emptyTaskArray, data);
      if (block.end > bestTime)
        bestTime = block.end;
    }
    return bestTime;
  }

  private void assignAtTime (Task task, int time,
                             SchedulingData data, SchedulingSpecs specs) {
    Resource[] resources = specs.capableResources (task, data);
    Task[] prereqs = new Task[0];
    Resource bestResource = null;
    float bestDelta = 0.0f;
    Resource.Block bestBlock = null;
    for (int i = 0; i < resources.length; i++) {
      Resource resource = resources[i];
      int dur = specs.taskDuration (task, resource, i == 0);
      TimeBlock[] unavail = specs.taskUnavailableTimes
        (task, prereqs, data.getStartTime(), data.getEndTime(),
         resource, dur, i == 0);
      Resource.Block block = resource.earliestAvailableBlock
        (task, dur, unavail, specs, multitask, grouped,
         time, data.getStartTime(), SchedulingData.emptyTaskArray, data);
      if (block.start == time) {
        Resource.Block b =
          makeAssignment2 (task, resource, block, false, false);
        float delta = specs.evaluateSingleAssignment (task, resource);
        if ((bestResource == null) ||
            (specs.isMinimizing() && (delta < bestDelta)) ||
            ((! specs.isMinimizing()) && (delta > bestDelta))) {
          bestResource = resource;
          bestDelta = delta;
          bestBlock = block;
        }
        removeAssignment (task, resource, b);
      }
    }
    if (bestResource != null)
      makeAssignment2 (task, bestResource, bestBlock, true, false);
  }

  public void setParms (String parms) {
  }

}
