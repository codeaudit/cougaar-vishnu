// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/GAOperator.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Interface for any class generating a child from one or more parents
 *
 * Copyright (C) 2000 BBN Technologies
 */

public interface GAOperator {

  public int numParents();

  public Chromosome generateChild (Chromosome[] parents);

  public void setParms (String parms);

}
