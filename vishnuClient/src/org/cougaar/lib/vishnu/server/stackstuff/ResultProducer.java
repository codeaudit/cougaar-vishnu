// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/ResultProducer.java,v 1.1 2001-08-15 18:21:56 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.Map;

/**
 * Allows nodes in parse tree (Operator and Literal) to be treated
 * uniformly
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public abstract class ResultProducer {

  public abstract void addToStack (ExecutionStack stack);

  public abstract String getResultType();

  public abstract String toXML();

  public abstract boolean containsVariable (String name);

  private ExecutionStack stack = null;

  protected SchedulingData sdata;
  protected Reusable reuse;
  protected TimeOps timeOps;

  public final void setData (SchedulingData sdata, Reusable reuse,
                             TimeOps timeOps) {
    this.sdata = sdata;
    this.reuse = reuse;
    this.timeOps = timeOps;
  }

  public final Object getResult (Map data) {
    if (stack == null) {
      stack = new ExecutionStack (reuse, timeOps);
      addToStack (stack);
      stack.convertToArrays();
    }
    return stack.getResult (data);
  }

  public final int numStackCommands() {
    ExecutionStack stack = new ExecutionStack (reuse, timeOps);
    addToStack (stack);
    return stack.currentSize();
  }

}
