/*
 * <copyright>
 *  Copyright 1997-2000 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR licence agreement.
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
      item.appendChild(doc.createTextNode(((UniqueObject)obj).getUID().getUID()));
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
  static XMLize instance = new XMLize ();
  
  public static XMLize getInstance () {
	return instance;
  }

  private boolean debug = false;
}







