/*
 * <copyright>
 *  Copyright 1997-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR licence agreement.
 * </copyright>
 */

package org.cougaar.lib.vishnu.client;

import java.util.Collection;
import org.w3c.dom.Document;

/**
 * Create XML document in the Vishnu Data format, directly from ALP objects.
 * <p>
 * Create and return xml for first class log plan objects.
 * <p>
 * Element name is extracted from object class, by taking the
 * last field of the object class, and dropping a trailing "Impl",
 * if it exists.
 */

public interface XMLizer {
  Document createDoc (Collection items, String assetClassName);
}
