// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/GADecoder.java,v 1.2 2001-04-06 18:50:31 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Interface for any class that turns chromosomes into schedules
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public interface GADecoder {

  public void generateAssignments (Chromosome c, SchedulingData sd,
                                   SchedulingSpecs ss);

  public void setParms (String parms);

}
