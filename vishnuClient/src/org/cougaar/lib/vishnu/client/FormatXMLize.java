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

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.HashSet;
import java.util.Set;

import org.apache.xerces.dom.DocumentImpl;

import org.cougaar.core.util.UID;
import org.cougaar.core.util.UniqueObject;
import org.cougaar.core.util.PropertyNameValue;

import org.cougaar.util.log.Logger;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

/**
 * Create XML document in the Vishnu ObjectFormat format, 
 * directly from ALP objects.
 * <p>
 * Create and return xml for first class log plan objects.
 * <p>
 * Element name is extracted from object class, by taking the
 * last field of the object class, and dropping a trailing "Impl",
 * if it exists.
 */

public class FormatXMLize extends BaseXMLize implements XMLizer {
  protected Class collectionClass;
  protected Class enumerationClass;
  protected Class dateClass;
  protected Class latitudeClass;
  protected Class longitudeClass;
  protected Class UIDClass;
  protected String numberString ="number";
  protected String booleanString="boolean";
  protected String dateString="datetime";
  protected String latitudeString="latlong";

  // controls how deep down the object hierarchy to go
  protected final int RECURSION_DEPTH=9;
  
  public FormatXMLize (Logger logger) {
    super (logger);
    try {
      collectionClass = Class.forName ("java.util.Collection");
      dateClass = Class.forName ("java.util.Date");
      latitudeClass = Class.forName ("org.cougaar.planning.ldm.measure.Latitude");
      longitudeClass = Class.forName ("org.cougaar.planning.ldm.measure.Longitude");
      UIDClass = Class.forName ("org.cougaar.core.util.UID");
      enumerationClass = Class.forName ("java.util.Enumeration");
    } catch (ClassNotFoundException cnfe) {}
  }

  /** 
   * <b>Recursively</b> introspect and add nodes to the XML document.
   * <p>
   * Keeps a Set of objects (as these can be circular) and stops 
   * when it tries to introspect over an object a second time.
   * <p>
   * Also keeps a depth counter, decrements for each call to addNodes, 
   * and stops when the counter is zero.  Use Integer.MAX_VALUE to 
   * indicate an unlimited search.
   */

  Map unique = new HashMap ();
  Set globals = new HashSet ();
  public Map getUnique () { return unique; }

  protected void addNodes(
			  Document doc, Object obj, 
			  Element parentElement, 
			  int searchDepth, 
			  Collection createdNodes) {
    if (obj == null) {
      return;
    }

    if (logger.isDebugEnabled()) {
      if (obj instanceof org.cougaar.planning.ldm.asset.PropertyGroup) {
	if (unique.containsKey (obj))
	  unique.put (obj, new Integer (((Integer)unique.get(obj)).intValue() +1));
	else
	  unique.put (obj, new Integer (1));
      }
    }
	  
    if (logger.isDebugEnabled())
      logger.debug ("addNodes - class " + obj.getClass ());
	
    if (ignoreClass (obj.getClass())) {
      if (logger.isDebugEnabled()) logger.debug ("----> ignored!");
      return;
    }

    //	debug ("Search depth " + searchDepth);
    if (searchDepth <= 0) {
      generateElementReachedMaxDepth (doc, parentElement, obj);
      return;
    }

    Map listProps = new HashMap ();
    List propertyNameValues = getProperties (obj, listProps);

    boolean foundDateAspect = false;
	
    // add the nodes for the properties and values
    for (int i = 0; i < propertyNameValues.size();) {
      PropertyNameValue pnv = 
        (PropertyNameValue) propertyNameValues.get(i);
      foundDateAspect = checkForDateAspect (pnv, foundDateAspect);

      boolean isFirst = false;
      Integer numListElems = (Integer) listProps.get (pnv.name);
      boolean isList = (numListElems != null);

      if (isList) {
	isFirst = true;
	for (int j = 0; j < numListElems.intValue(); j++) {
	  pnv = (PropertyNameValue) propertyNameValues.get(i++);
	  generateElem (doc, parentElement, pnv.name, pnv.value, 
			searchDepth, isList, isFirst, 
			createdNodes);
	  isFirst = false;
	}
      }
      else {
	generateElem (doc, parentElement, pnv.name, pnv.value, 
		      searchDepth, isList, isFirst, 
		      createdNodes);
	i++;
      }
    }
  }

  protected boolean checkForDateAspect (PropertyNameValue pnv,
					boolean foundDateAspect) {
    if (foundDateAspect && pnv.name.charAt(0) == 'v') {
      if (pnv.name.equals ("value")) {
	double millis = Double.parseDouble ((String) pnv.value);
	pnv.value = new Date ((long) millis);
      }
    }
    else if (pnv.name.charAt(0) == 'a') {
      if (pnv.name.equals ("aspectType")) {
	String value = (String) pnv.value;
	char first = value.charAt (0);
	if ((first == '0') ||
	    ((first == '1') && (value.length () == 1))  || 
	    ((first == '1') && (value.charAt (1) == '.' || 
				value.charAt (1) == '3')))
	  foundDateAspect = true;
      }
    }
    return foundDateAspect;
  }

  /** subclass to generate different tag */
  protected Element createRootNode (Document doc,
				    String tag,
				    boolean isTask,
				    boolean isResource,
				    Object obj,
				    String resourceClassName) {
    return createObjectFormat(doc, tag, isTask, isResource, obj, resourceClassName);
  }

  /**
   * Already seen this object or reached maximum depth. 
   * Write the UID if possible, otherwise write the "toString".
   */
  protected void generateElementReachedMaxDepth (Document doc, Element parentElement, 
						 Object obj) {
    if (logger.isDebugEnabled())
      logger.debug("Object traversed already/max depth: " + 
		   obj.getClass().toString() + " " + obj);
    if (isUniqueObject (obj)) {
      Element item = createFieldFormat (doc, "UID", "string", false, false);
      if (logger.isDebugEnabled()) 
	logger.debug ("maxDepth - " + "UID" + " - " + "string");

      parentElement.appendChild(item);
    } else {
      parentElement.appendChild(createFieldFormat(doc, getTypeFor(obj), obj, false, false));
      if (logger.isDebugEnabled()) 
	logger.debug ("maxDepth - " + obj);
    }
  }

  protected void generateLeaf (Document doc, Element parentElement, 
			       String propertyName, Object propertyValue) {
    Element item = createFieldFormat(doc, propertyName, propertyValue, false, false);

    parentElement.appendChild(item);

    // only set keys on tasks and resources
    correctKey (parentElement, item);
	
    if (logger.isDebugEnabled()) 
      logger.debug ("isLeaf - " + propertyName + " - " + propertyValue);
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
    boolean skip = skipObject (propertyValue);
		
    Element fieldNode = null;
		
    if (logger.isDebugEnabled() && !((isList && isFirst) || !isList)) 
      logger.debug ("skipping field format for - " + propertyName + " - " + propertyValue);

    if (!ignoreObject(propertyValue) && ((isList && isFirst) || !isList)) {
      fieldNode = createFieldFormat(doc, propertyName, propertyValue, isList, !skip);
      parentElement.appendChild(fieldNode);
      // only set keys on tasks and resources
      correctKey (parentElement, fieldNode);
      if (logger.isDebugEnabled()) 
	logger.debug ("nonLeaf - " + propertyName + " - " + propertyValue);
    }

    if (!skip) {
      if (propertyValue instanceof org.cougaar.planning.ldm.asset.PropertyGroup) {
	if (globals.contains (propertyValue)) {
	  return;
	}
      }
	  
      Element item = createObjectFormat(doc, propertyName, false, false, propertyValue, 
					null);
      createdNodes.add (item);
      // recurse!

      addNodes(doc, propertyValue, item, (searchDepth-1), createdNodes);
      if (item.getChildNodes().getLength() == 0) {
	//		createdNodes.remove (item);
	//		parentElement.removeChild (fieldNode);
	if (logger.isDebugEnabled()) 
	  logger.debug ("nonLeaf - REMOVING? - " + propertyName + " - " + propertyValue);

      }
      if ((propertyName.charAt(0) == 'r') && propertyName.equals ("roleSchedule")) {
	removeChildNamed (item, "scheduleElements");
	removeChildNamed (item, "availableSchedule");

	addIntervalNamed    ("scheduleElements", doc, item);
	addIntervalNamed    ("availableSchedule", doc, item);
      }

      globals.add (propertyValue);
    }
  }

  protected void removeChildNamed (Element roleScheduleImpl, String childName){
    NodeList children = roleScheduleImpl.getChildNodes ();
    for (int i = 0; i < children.getLength (); i++) {
      Element child = (Element) children.item (i);
      if (child.getAttribute("name").equals (childName)) {
	if (logger.isDebugEnabled()) logger.debug ("found " + childName + ", removing.");
		
	roleScheduleImpl.removeChild (child);
	break;
      }
    }
  }

  /** all property groups become globals, except for item id pg */
  protected boolean isGlobal (Object obj) {
    boolean isPropertyGroup = (obj instanceof org.cougaar.planning.ldm.asset.PropertyGroup);
    boolean isItemIDPropertyGroup = (obj instanceof org.cougaar.planning.ldm.asset.ItemIdentificationPG);
    //	boolean isPrepPhrase = (obj instanceof org.cougaar.planning.ldm.plan.PrepositionalPhrase);
    boolean isGlobal = isPropertyGroup && !isItemIDPropertyGroup; // || isPrepPhrase;
    return isGlobal;
  }
  
  protected void correctKey (Element parentElement, Element item) {
    // only set keys on tasks and resources
    if ((parentElement.getAttribute ("is_task").charAt (0) == 'f') &&
	(parentElement.getAttribute ("is_resource").charAt (0) == 'f') && 
	(item.getAttribute ("is_key").charAt (0) == 't')) {
      if (logger.isDebugEnabled()) 
	logger.debug ("correctKey - CORRECTING key");
      item.setAttribute ("is_key", "false");
    }
	
    if (logger.isDebugEnabled()) {
      boolean allFalse = parentElement.getAttribute ("is_task").charAt (0) == 'f' &
	parentElement.getAttribute ("is_resource").charAt (0) == 'f' &
	item.getAttribute ("is_key").charAt (0) == 'f';
      if (!allFalse)
	logger.debug ("generateLeaf - parent task " + parentElement.getAttribute ("is_task").charAt (0) +
	       " resource " + parentElement.getAttribute ("is_resource").charAt (0) +
	       " item key " + item.getAttribute ("is_key").charAt (0));
    }
  }

  /** 
   * need to have special code to add plan element intervals to role schedule format, since
   * bean properties don't include them
   */
  protected void addScheduleElements (Document doc, Element item) {
    addIntervalNamed ("scheduleElements", doc, item);
  }

  protected void addIntervalNamed (String name, Document doc, Element item) {
    Element elem = doc.createElement("FIELDFORMAT");
    elem.setAttribute ("name", name);
    elem.setAttribute ("is_subobject", "true");
    elem.setAttribute ("is_list", "true");
    elem.setAttribute ("is_key", "false");
    elem.setAttribute ("datatype", "interval");
    item.appendChild(elem);
  }
  
  /** 
   * implemented for XMLizer interface <p>
   *
   * creates an DOM Document out of the collection of items passed in, <br>
   * with the name of the resource class.
   **/
  public Document createDoc (Collection items, Collection ignoredChangedItems, String assetClassName) {
    Document doc = new DocumentImpl(); 
    Element root = doc.createElement("PROBLEM");
    doc.appendChild (root);
    Element df   = doc.createElement("DATAFORMAT");
    root.appendChild(df);

    Element element   = null;
    for (Iterator iter = items.iterator(); iter.hasNext ();) {
      Collection nodes = getPlanObjectXMLNodes (iter.next(), doc, RECURSION_DEPTH, assetClassName);
      for (Iterator iter2 = nodes.iterator(); iter2.hasNext ();)
	df.appendChild ((Element) iter2.next());
    }

    if (logger.isDebugEnabled()) {
      int i = 0;
      for (Iterator iter = unique.keySet().iterator(); iter.hasNext (); ){
	Object thing = iter.next ();
	logger.debug ("" + i++ + " - " + thing.getClass () + " - " + unique.get (thing));
      }
    }
    return doc;
  }
  
  protected Element createObjectFormat (Document doc,
					String name,
					boolean isTask,
					boolean isResource,
					Object theObj,
					String resourceClassName) {
    Element elem = doc.createElement("OBJECTFORMAT");
    elem.setAttribute ("is_task",     (isTask) ? "true" : "false");
    elem.setAttribute ("is_resource", (isResource) ? "true" : "false");
    String cn;

    if (isResource)
      cn = resourceClassName;
    else {
      cn = "" + theObj.getClass ();
      cn = cn.substring (cn.lastIndexOf ('.') + 1);
      cn = cn.substring (cn.lastIndexOf ('$') + 1);
    }
	
    elem.setAttribute ("name", (isTask) ? name : cn);
  
    return elem;
  }

  protected Element createFieldFormat (Document doc,
				       String name,
				       Object theObj,
				       boolean isList,
				       boolean isSubobject) {
    Element elem = doc.createElement("FIELDFORMAT");
    elem.setAttribute ("name", name);
    boolean isKey = isKey(theObj);
	
    elem.setAttribute ("is_subobject", 
		       ((isSubobject && !isKey) || (latitudeClass.isInstance(theObj))) ? "true" : "false");
    String cn = "" + theObj.getClass ();
    if (isSubobject) {
      cn = cn.substring (cn.lastIndexOf ('.') + 1);
      cn = cn.substring (cn.lastIndexOf ('$') + 1);
      elem.setAttribute ("datatype", cn);
    } else
      elem.setAttribute ("datatype", getTypeFor (theObj));
    elem.setAttribute ("is_list", (isList) ? "true" : "false");
    elem.setAttribute ("is_key",  (isKey  (theObj)) ? "true" : "false");

    // if it's a global set it's attr
    if (isGlobal(theObj)) {
      elem.setAttribute ("is_globalptr", "true");
      elem.setAttribute ("is_subobject", "false");
    }

    if (logger.isDebugEnabled() && isList (theObj) && !isList)
      logger.debug ("WARNING - disaggrement over " + name + " - " + name.getClass());
	
    return elem;
  }
  
  protected boolean isList (Object theObj) {
    return collectionClass.isInstance (theObj) ||
      theObj.getClass().isArray() ||
      enumerationClass.isInstance (theObj);
  }
  
  protected String getTypeFor (Object theObj) {
    if (numberClass.isInstance(theObj))
      return numberString;
    if (dateClass.isInstance(theObj))
      return dateString;
    if (latitudeClass.isInstance(theObj))
      return latitudeString;
    if (booleanClass.isInstance(theObj))
      return booleanString;

    String objAsString = theObj.toString ();

    if (objAsString.length () == 0)
      return "string";

    char firstChar = objAsString.charAt (0);
	
    if (((firstChar == 't') || (firstChar == 'f')) &&
	(objAsString.equals ("true") || objAsString.equals ("false"))) {
      //	  if (logger.isDebugEnabled())
      //		logger.debug ("got here - " + objAsString + " but not boolean - " + theObj.getClass ());
      return booleanString;
    }

    if (Character.isDigit(firstChar)) {
      boolean isNumber=false;
      try {
	Integer.parseInt (objAsString);
	isNumber = true;
      } catch (NumberFormatException nfe) {}

      try {
	Double.parseDouble (objAsString);
	isNumber = true;
      } catch (NumberFormatException nfe) {}
      if (isNumber) {
	//		if (logger.isDebugEnabled())
	//		  logger.debug ("got here - " + objAsString + " but not number - " + theObj.getClass ());
	return numberString;
      }
    }

    if (firstChar == 'I' || firstChar == '-') {
      if (objAsString.equals ("Infinity"))
	return numberString;
      else if (objAsString.equals ("-Infinity"))
	return numberString;
    }

    return "string";
  }
  
  protected boolean skipObject (Object theObj) {
    return (dateClass.isInstance(theObj) ||
	    latitudeClass.isInstance(theObj) ||
	    longitudeClass.isInstance(theObj) ||
	    UIDClass.isInstance(theObj));
  }

  protected boolean ignoreObject (Object theObj) {
    return longitudeClass.isInstance(theObj);
  }

  protected boolean isKey (Object theObj) {
    return UIDClass.isInstance(theObj);
  }
}
