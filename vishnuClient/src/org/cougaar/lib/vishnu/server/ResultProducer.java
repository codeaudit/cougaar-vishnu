// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/ResultProducer.java,v 1.3 2001-04-12 17:50:31 dmontana Exp $

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

public interface ResultProducer {

  public Object getResult (Map data);

  public String getResultType();

  public String toXML();

  public boolean containsVariable (String name);

}
