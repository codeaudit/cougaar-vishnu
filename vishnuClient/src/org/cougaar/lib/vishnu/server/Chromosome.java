// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Chromosome.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Base class for the chromosome for the genetic algorithm.  The
 * particular implementation must extend this class.
 *
 * Copyright (C) 2000 BBN Technologies
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
