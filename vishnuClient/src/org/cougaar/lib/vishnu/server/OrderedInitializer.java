// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/OrderedInitializer.java,v 1.4 2001-04-12 17:50:30 dmontana Exp $

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
