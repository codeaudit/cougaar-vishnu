// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/OrderedMutation.java,v 1.1 2001-08-15 18:21:56 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * This is the mutation operator for ordered chromosome.
 * It selects a subset of the positions and randomly shuffles them.
 * The size of the subset is a random number with a uniform distribution
 * between 2 and (maxToSwitch * size).
 * Change the value of the single parameter maxToSwitch in order to control
 * how large a mutation on average it creates.
 * (Note: we generally have found setting it to its maximum value of 1
 * to work best.)
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OrderedMutation implements GAOperator {

  private float maxToSwitch = 1.0f;

  public int numParents()  { return 1; }

  public Chromosome generateChild (Chromosome[] parents, SchedulingData data) {
    StringOfIntegers parent = (StringOfIntegers) parents[0];
    int size = parent.getValues().length;

    // special case to survive really small test data sets
    if (size < 2)
      return new StringOfIntegers (parent.getValues());

    // select points and order
    int maxNum = (int) (maxToSwitch * size);
    boolean changed = false;
    int num = 0;
    int[] selected = null;
    while (! changed) {
      num = ((maxNum <= 2) ? 2 :
             (GeneticAlgorithm.getRandomInt (maxNum - 1) + 2));
      selected = new int [num];
      ArrayList notSelected = new ArrayList (size);
      for (int i = 0; i < size; i++)
        notSelected.add (new Integer (i));
      for (int i = 0; i < num; i++) {
        int pos = GeneticAlgorithm.getRandomInt (notSelected.size());
        selected[i] = ((Integer) notSelected.get(pos)).intValue();
        if ((i != 0) && (selected[i] < selected[i - 1]))
          changed = true;
        notSelected.remove (pos);
      }
    }

    // do switch
    int[] ordered = new int [num];
    System.arraycopy (selected, 0, ordered, 0, num);
    Arrays.sort (ordered);
    int[] newValues = new int [size];
    System.arraycopy (parent.getValues(), 0, newValues, 0, size);
    for (int i = 0; i < num; i++)
      newValues [ordered[i]] = parent.getValues() [selected[i]];

    return initializer.reorder (newValues, data);
  }

  public void setParms (String parms) {
    maxToSwitch = (Float.valueOf (parms)).floatValue();
  }

  OrderedInitializer initializer = new OrderedInitializer ();
}