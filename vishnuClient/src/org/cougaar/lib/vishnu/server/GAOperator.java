// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/GAOperator.java,v 1.2 2001-04-06 18:50:31 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Interface for any class generating a child from one or more parents
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public interface GAOperator {

  public int numParents();

  public Chromosome generateChild (Chromosome[] parents);

  public void setParms (String parms);

}
