// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OrderedInitializer.java,v 1.1 2001-08-15 18:21:55 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.ArrayList;

/**
 * Generates random orderings
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OrderedInitializer implements GAInitializer {

  public Chromosome generateIndividual (int num, SchedulingData data) {
    int size = data.getPrimaryTasks().length;
    ArrayList remaining = new ArrayList (size);
    ArrayList initial = new ArrayList (size);
    for (int i = 0; i < size; i++)
      remaining.add (new Integer (i));
    for (int i = 0; i < size; i++) {
      int pick = GeneticAlgorithm.getRandomInt (remaining.size());
      initial.add (remaining.get (pick));
      remaining.remove (pick);
    }
    return reorder (initial, data);
  }

  public void setParms (String parms) {
  }

  public StringOfIntegers reorder (int[] original, SchedulingData data) {
    ArrayList al = new ArrayList (original.length);
    for (int i = 0; i < original.length; i++)
      al.add (new Integer (original [i]));
    return reorder (al, data);
  }

  public StringOfIntegers reorder (ArrayList original, SchedulingData data) {
    Task[] tasks = data.getPrimaryTasks();
    int[] ordering = new int [tasks.length];
    java.util.HashSet selected = new java.util.HashSet();
    for (int i = 0; i < ordering.length; i++) {
      for (int j = 0; j < original.size(); j++) {
        int index = ((Integer) original.get (j)).intValue();
        Task task = tasks [index];
        Task[] prereqs = task.getPrerequisites ();
        boolean cont = false;
        for (int k = 0; k < prereqs.length; k++) {
          if ((! selected.contains (prereqs[k])) &&
              (! data.isFrozen (prereqs[k])) &&
              (! selected.contains (data.getPrimaryLink (prereqs[k]))) &&
              (! data.isFrozen (data.getPrimaryLink (prereqs[k])))) {
            cont = true;
            break;
          }
        }
        if (cont)
          continue;
        ordering[i] = index;
        original.remove (j);
        selected.add (task);
        break;
      }
      if ((original.size() + i + 1) != ordering.length)
        throw new RuntimeException
          ("Dependency Loop<br>\nTry looking at the way you " +
           "have your prerequisites set up");
    }
    return new StringOfIntegers (ordering);
  }

}
