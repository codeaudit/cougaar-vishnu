// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/GAInitializer.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Interface for any class that generates member of an initial GA population
 *
 * Copyright (C) 2000 BBN Technologies
 */

public interface GAInitializer {

  public Chromosome generateIndividual (int num, SchedulingData data);

  public void setParms (String parms);

}
