package org.cougaar.lib.vishnu.server;

/**
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public interface FastStack {
  boolean empty();
  /** this peek is 10% faster than Stack.peek */
  Object peek();

  /** this pop is nearly twice as fast as Stack.pop */
  Object pop();
  Object push(Object item);
  int search(Object o);
}
