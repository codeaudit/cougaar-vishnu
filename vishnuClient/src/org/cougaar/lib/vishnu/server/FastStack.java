package org.cougaar.lib.vishnu.server;

public interface FastStack {
  boolean empty();
  /** this peek is 10% faster than Stack.peek */
  Object peek();

  /** this pop is nearly twice as fast as Stack.pop */
  Object pop();
  Object push(Object item);
  int search(Object o);
}
