// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/OrderedCrossover.java,v 1.2 2001-04-06 18:50:31 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Crossover operator for ordered chromosome
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public class OrderedCrossover implements GAOperator {

  public int numParents()  { return 2; }

  public Chromosome generateChild (Chromosome[] parents) {
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

    return new StringOfIntegers (newValues);
  }

  public void setParms (String parms) {
  }

}
