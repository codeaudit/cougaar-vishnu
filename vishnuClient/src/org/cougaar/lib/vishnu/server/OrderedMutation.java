// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/OrderedMutation.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * Mutation operator for ordered chromosome
 *
 * Copyright (C) 2000 BBN Technologies
 */

public class OrderedMutation implements GAOperator {

  private float maxToSwitch = 0.0f;

  public int numParents()  { return 1; }

  public Chromosome generateChild (Chromosome[] parents) {
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

    return new StringOfIntegers (newValues);
  }

  public void setParms (String parms) {
    maxToSwitch = (Float.valueOf (parms)).floatValue();
  }

}
