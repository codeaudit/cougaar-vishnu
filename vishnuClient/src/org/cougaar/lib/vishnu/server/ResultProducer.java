// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/ResultProducer.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

import java.util.Map;

/**
 * Allows nodes in parse tree (Operator and Literal) to be treated
 * uniformly
 *
 * Copyright (C) 2000 BBN Technologies
 */

public interface ResultProducer {

  public Object getResult (Map data);

  public String getResultType();

  public String toXML();

  public boolean containsVariable (String name);

}
