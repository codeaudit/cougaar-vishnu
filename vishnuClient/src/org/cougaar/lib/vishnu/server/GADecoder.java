// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/GADecoder.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Interface for any class that turns chromosomes into schedules
 *
 * Copyright (C) 2000 BBN Technologies
 */

public interface GADecoder {

  public void generateAssignments (Chromosome c, SchedulingData sd,
                                   SchedulingSpecs ss);

  public void setParms (String parms);

}
