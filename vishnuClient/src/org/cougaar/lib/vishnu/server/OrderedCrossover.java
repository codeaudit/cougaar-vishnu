// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/OrderedCrossover.java,v 1.5 2001-07-29 21:34:43 gvidaver Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Crossover operator for ordered chromosome
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class OrderedCrossover implements GAOperator {

  public int numParents()  { return 2; }

  public Chromosome generateChild (Chromosome[] parents, SchedulingData data) {
    StringOfIntegers parent1 = (StringOfIntegers) parents[0];
    StringOfIntegers parent2 = (StringOfIntegers) parents[1];
    int[] newValues = new int [parent1.getValues().length];
    boolean[] already_in = new boolean [parent1.getValues().length];

    /** pick positions from parent2 and impose them */
    for (int i = 0; i < newValues.length; i++) {
      boolean second = GeneticAlgorithm.getRandomFloat() < 0.5;
      already_in [parent2.getValues()[i]] = second;
      newValues[i] = second ? parent2.getValues()[i] : -1;
    }

    /** fill in from parent1 */
    int j = 0;
    for (int i = 0; i < newValues.length; i++) {
      if (! already_in [parent1.getValues()[i]]) {
        while (newValues[j] != -1)
          j++;
        newValues[j] = parent1.getValues()[i];
      }
    }

    return initializer.reorder (newValues, data);
  }

  public void setParms (String parms) {
  }

  OrderedInitializer initializer = new OrderedInitializer ();
}
