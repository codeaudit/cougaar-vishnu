// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/GAOperator.java,v 1.4 2001-07-29 21:34:43 gvidaver Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Interface for any class generating a child from one or more parents
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public interface GAOperator {

  public int numParents();

  public Chromosome generateChild (Chromosome[] parents, SchedulingData data);

  public void setParms (String parms);

}
