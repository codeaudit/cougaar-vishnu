// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/ResultProducer.java,v 1.2 2001-04-06 18:50:32 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.Map;

/**
 * Allows nodes in parse tree (Operator and Literal) to be treated
 * uniformly
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public interface ResultProducer {

  public Object getResult (Map data);

  public String getResultType();

  public String toXML();

  public boolean containsVariable (String name);

}
