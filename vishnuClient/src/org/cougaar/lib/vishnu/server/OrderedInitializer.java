// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/OrderedInitializer.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

import java.util.ArrayList;

/**
 * Generates random orderings
 *
 * Copyright (C) 2000 BBN Technologies
 */

public class OrderedInitializer implements GAInitializer {

  public Chromosome generateIndividual (int num, SchedulingData data) {
    int size = data.getUnfrozenTasks().length;
    int[] ordering = new int [size];
    ArrayList remaining = new ArrayList (size);
    for (int i = 0; i < size; i++)
      remaining.add (new Integer (i));
    for (int i = 0; i < size; i++) {
      int pick = GeneticAlgorithm.getRandomInt (remaining.size());
      ordering[i] = ((Integer) remaining.get (pick)).intValue();
      remaining.remove (pick);
    }
    return new StringOfIntegers (ordering);
  }

  public void setParms (String parms) {
  }

}
