// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/StringOfIntegers.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

/**
 * Chromosome that consists of a fixed number of integer values.
 * It can be used either for ordered representations or standard
 * string representations.
 *
 * Copyright (C) 2000 BBN Technologies
 */

public class StringOfIntegers extends Chromosome {

  private int[] values;

  public StringOfIntegers (int[] values) {
    this.values = values;
  }

  public int[] getValues()  { return values; }

  public String chromToString() {
    String str = "(";
    for (int i = 0; i < values.length; i++)
      str = str + " " + values[i];
    return str + " )";
  }

  public boolean chromEquals (Chromosome c) {
    StringOfIntegers other = (StringOfIntegers) c;
    if (values.length != other.values.length)
      return false;
    for (int i = 0; i < values.length; i++) {
      if (values[i] != other.values[i])
        return false;
    }
    return true;
  }

  public int chromHashCode() {
    int total = 0;
    for (int i = 0; i < values.length; i++)
      total += values[i] * i;
    return total;
  }

}
