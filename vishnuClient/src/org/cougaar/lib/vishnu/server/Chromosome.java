// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Chromosome.java,v 1.2 2001-04-06 18:50:31 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Base class for the chromosome for the genetic algorithm.  The
 * particular implementation must extend this class.
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public abstract class Chromosome {

  /** String representation used by toString */
  public abstract String chromToString();

  /** determine whether two chromosomes are equals; for use by equals */
  public abstract boolean chromEquals (Chromosome c);

  /** define hash code */
  public abstract int chromHashCode();

  public String toString()  { return chromToString(); }

  public boolean equals (Object obj) {
    return ((obj instanceof Chromosome) &&
            (chromEquals ((Chromosome) obj)));
  }

  public int hashCode()  { return chromHashCode(); }

}
