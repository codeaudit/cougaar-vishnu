// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/GADecoder.java,v 1.5 2001-08-09 16:13:36 gvidaver Exp $

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

  /** return true if all tasks were assigned to resources */
  public boolean generateAssignments (Chromosome c, SchedulingData sd,
									  SchedulingSpecs ss, boolean explain);

  public void setParms (String parms);

}
