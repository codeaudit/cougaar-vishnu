// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Chromosome.java,v 1.3 2001-04-12 17:50:30 dmontana Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Base class for the chromosome for the genetic algorithm.  The
 * particular implementation must extend this class.
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
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
