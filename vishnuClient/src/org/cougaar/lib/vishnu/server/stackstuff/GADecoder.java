// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/GADecoder.java,v 1.1 2001-08-15 18:21:51 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Interface for any class that turns chromosomes into schedules
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public interface GADecoder {

  public void generateAssignments (Chromosome c, SchedulingData sd,
                                   SchedulingSpecs ss, boolean explain);

  public void setParms (String parms);

}
