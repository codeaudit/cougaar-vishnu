/*
 * <copyright>
 *  Copyright 1997-2001 BBNT Solutions, LLC
 *  under sponsorship of the Defense Advanced Research Projects Agency (DARPA).
 * 
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the Cougaar Open Source License as published by
 *  DARPA on the Cougaar Open Source Website (www.cougaar.org).
 * 
 *  THE COUGAAR SOFTWARE AND ANY DERIVATIVE SUPPLIED BY LICENSOR IS
 *  PROVIDED 'AS IS' WITHOUT WARRANTIES OF ANY KIND, WHETHER EXPRESS OR
 *  IMPLIED, INCLUDING (BUT NOT LIMITED TO) ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND WITHOUT
 *  ANY WARRANTIES AS TO NON-INFRINGEMENT.  IN NO EVENT SHALL COPYRIGHT
 *  HOLDER BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT OR CONSEQUENTIAL
 *  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE OF DATA OR PROFITS,
 *  TORTIOUS CONDUCT, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *  PERFORMANCE OF THE COUGAAR SOFTWARE.
 * </copyright>
 */


package org.cougaar.lib.vishnu.client;

import org.cougaar.core.society.UniqueObject;

import java.util.Collection;
import java.util.Set;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 * Create and return xml for first class log plan objects.
 * <p>
 * Element name is extracted from object class, by taking the
 * last field of the object class, and dropping a trailing "Impl",
 * if it exists.
 */

public class ALPXMLize extends BaseXMLize {
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
	if (debug)
	  System.out.println("Object traversed already/max depth: " + 
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
	if (debug) 
	  System.out.println ("isLeaf - " + propertyName + " - " + propertyValue);
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
  static ALPXMLize instance = new ALPXMLize ();
  
  public static ALPXMLize getInstance () {
	return instance;
  }

  private boolean debug = false;
}







