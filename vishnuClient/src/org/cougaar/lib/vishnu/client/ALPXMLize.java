/*
 * <copyright>
 *  
 *  Copyright 1997-2004 BBNT Solutions, LLC
 *  under sponsorship of the Defense Advanced Research Projects
 *  Agency (DARPA).
 * 
 *  You can redistribute this software and/or modify it under the
 *  terms of the Cougaar Open Source License as published on the
 *  Cougaar Open Source Website (www.cougaar.org).
 * 
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *  
 * </copyright>
 */


package org.cougaar.lib.vishnu.client;

import org.cougaar.core.util.UniqueObject;

import java.util.Collection;
import java.util.Set;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import org.cougaar.util.log.Logger;

/**
 * Create and return xml for first class log plan objects.
 * <p>
 * Element name is extracted from object class, by taking the
 * last field of the object class, and dropping a trailing "Impl",
 * if it exists.
 */

public class ALPXMLize extends BaseXMLize {

  public ALPXMLize (Logger logger) { super (logger); }

  /** subclass to generate different tag */
  protected Element createRootNode (Document doc,
				    String tag,
				    boolean isTask,
				    boolean isResource,
				    Object obj, String resourceClass) {
    return doc.createElement(tag);
  }

  /**
   * Already seen this object or reached maximum depth. 
   * Write the UID if possible, otherwise write the "toString".
   */
  protected void generateElementReachedMaxDepth (Document doc, Element parentElement, 
						 Object obj) {
    if (logger.isInfoEnabled())
      logger.info("Object traversed already/max depth: " + 
		  obj.getClass().toString() + " " + obj);
    if (isUniqueObject (obj)) {
      Element item = doc.createElement("UID");
      item.appendChild(doc.createTextNode(((UniqueObject)obj).getUID().toString()));
      parentElement.appendChild(item);
    } else {
      parentElement.appendChild(doc.createTextNode(obj.toString()));
    }
  }

  protected void generateLeaf (Document doc, Element parentElement, 
			       String propertyName, Object propertyValue) {
    Element item = doc.createElement(propertyName);
    item.appendChild(doc.createTextNode(propertyValue.toString()));
    parentElement.appendChild(item);
    if (logger.isInfoEnabled()) 
      logger.info ("isLeaf - " + propertyName + " - " + propertyValue);
  }
  
  protected void generateNonLeaf (Document doc, Element parentElement, 
				  String propertyName, Object propertyValue,
				  int searchDepth,
				  boolean isList, boolean isFirst,
				  Collection createdNodes) {
    // this removes the class name following the $ for Locked classes
    int index = propertyName.indexOf('$');
    if (index > 0) {
      propertyName = propertyName.substring(0, index);
    }
    Element item = doc.createElement(propertyName);
    parentElement.appendChild(item);

    // recurse
    addNodes(doc, propertyValue, item, (searchDepth-1), createdNodes);
  }

  static Object monitor = new Object ();
  static ALPXMLize instance = null;
  
  public static ALPXMLize getInstance (Logger logger) {
    if (instance == null)
      instance = new ALPXMLize (logger);
    return instance;
  }
}
