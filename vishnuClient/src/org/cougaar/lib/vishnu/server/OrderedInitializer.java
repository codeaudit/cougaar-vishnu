// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/OrderedInitializer.java,v 1.3 2001-04-06 18:50:31 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.ArrayList;

/**
 * Generates random orderings
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
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
