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

import org.cougaar.domain.planning.ldm.measure.Latitude;
import org.cougaar.domain.planning.ldm.measure.Longitude;
import org.cougaar.domain.planning.ldm.plan.Schedule;
import org.cougaar.domain.planning.ldm.plan.RoleSchedule;
import org.cougaar.domain.planning.ldm.plan.ScheduleElement;

import org.cougaar.core.util.PropertyNameValue;
import org.cougaar.util.TimeSpan;
import org.cougaar.core.society.UID;
import org.cougaar.core.society.UniqueObject;

import java.util.*;
import java.text.SimpleDateFormat;
import java.lang.NumberFormatException;
import org.apache.xerces.dom.DocumentImpl;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import org.cougaar.lib.vishnu.client.XMLProcessor.ObjectDescrip;

/**
 * Create XML document in the Vishnu Data format, directly from ALP objects.
 * <p>
 * Create and return xml for first class log plan objects.
 * <p>
 * Element name is extracted from object class, by taking the
 * last field of the object class, and dropping a trailing "Impl",
 * if it exists.
 */

public class DataXMLize extends FormatXMLize {
  protected Class roleScheduleImplClass;
  protected Class uniqueObjectClass;
  protected Map nameToDescrip;
  protected String resourceName;
  protected Map globalToNode = new HashMap ();  // global object -> DOM node mapping
  protected Set globalsToSend = new HashSet (); // globals to send with this batch of objects
  protected Map globalToName = new HashMap ();  // global object -> global name mapping
  protected Map classToInstances = new HashMap ();

  public DataXMLize (boolean debug) {
	super (false);
	try {
	  roleScheduleImplClass = Class.forName ("org.cougaar.domain.planning.ldm.plan.RoleScheduleImpl");
	  uniqueObjectClass = Class.forName ("org.cougaar.core.society.UniqueObject");
	} catch (ClassNotFoundException cnfe) {}
	this.debug = debug;
  }

  public void setNameToDescrip (Map nameToDescrip) {
	this.nameToDescrip = nameToDescrip;
  }

  public void setResourceName (String resourceName) {
	this.resourceName = resourceName;
  }
  
  int numAddNodes = 0;
  protected boolean printedDataWarning = false;

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

  protected void addNodes(
      Document doc, Object obj, 
      Element parentElement, 
      int searchDepth,
	  Collection createdNodes) {
    if (obj == null) {
      return;
    }

	if (ignoreClass (obj.getClass())) {
	  if (debug) System.out.println ("----> ignored " + obj.getClass ());
	  return;
	}

	if (debug) {
	  if (unique.containsKey (obj))
		unique.put (obj, new Integer (((Integer)unique.get(obj)).intValue() +1));
	  else
		unique.put (obj, new Integer (1));
	}

	//System.out.println ("DataXMLize.addNodes - Search depth " + searchDepth);
	if (debug && ((numAddNodes++ % 100) == 0))
	  System.out.println ("addNodes called " + numAddNodes + " times");
	
	String parentType = parentElement.getAttribute("type");
	if (debug) 
	  System.out.println ("parentType - " + parentType);
	ObjectDescrip od = (ObjectDescrip) nameToDescrip.get (parentType.toLowerCase());
	if (od == null && !printedDataWarning && !parentType.toLowerCase().startsWith("string")) {
	  printWarning  (parentType);
	  printedDataWarning = true;
	}
	  
    if (searchDepth <= 0) {
	  generateElementReachedMaxDepth (doc, parentElement, obj, od);
      return;
    }

	Map listProps = new HashMap ();
    List propertyNameValues = getProperties (obj, listProps);
	//	System.out.println ("getProps for parentType - " + parentType + " listProps = " + listProps);
	
	if (listProps.isEmpty ())
	  noListProcessProperties (propertyNameValues,
							   doc,
							   parentElement, searchDepth, od, createdNodes);
	else {
	  // add the nodes for the properties and values
	  boolean foundDateAspect = false;
	  PropertyNameValue [] currentLatLong = new PropertyNameValue [2];
	
	  for (int i = 0; i < propertyNameValues.size();) {
		PropertyNameValue pnv = 
		  (PropertyNameValue) propertyNameValues.get(i);
		if (checkForLatLong (doc, parentElement, pnv, currentLatLong)) {
		  i++;
		  continue;
		}
	  
		foundDateAspect = checkForDateAspect (pnv, foundDateAspect);
	  
		boolean isFirst = false;
		Integer numListElems = (Integer) listProps.get (pnv.name);
		//	  System.out.println ("for " + pnv.name + " numListElems = " + numListElems);
	  
		boolean isList = (numListElems != null);
		if (isList) {
		  //System.out.println ("found list for " + pnv.name + " with " + numListElems + " elems.");
		
		  isFirst = true;
		  Element field = createField (doc, pnv.name, pnv.value, true, od);
		  parentElement.appendChild (field);
		  Element list = createList (doc);
		  field.appendChild (list);
		  for (int j = 0; j < numListElems.intValue(); j++) {
			Element value = createValue (doc);
			list.appendChild (value);
			pnv = (PropertyNameValue) propertyNameValues.get(i++);
			generateNonLeaf (doc, value, pnv.name, pnv.value, 
							 searchDepth, isList, isFirst, od, createdNodes);
			if (value.getFirstChild () != null) {
			  Element objectNode = (Element) value.getFirstChild ().getFirstChild ();
			  value.removeChild (value.getFirstChild ());
			  if (objectNode != null)
				value.appendChild (objectNode);
			}
			isFirst = false;
		  }
		}
		else {
		  generateElem (doc, parentElement, pnv.name, pnv.value, 
						searchDepth, isList, isFirst, od, createdNodes);
		  i++;
		}
	  }
	}
	
  }

  protected void printWarning (String parentType) {
	System.out.println ("\n-----------------------------------------------\n" + 
						"DataXMLize.addNodes - descrip was null for " + parentType.toLowerCase() + "." +
						"\nThis means that the default code in VishnuPlugIn.getTemplateTasks, which only\n" +
						"looks at the first few tasks to define the problem format should be subclassed, or the\n" +
						"firstTemplateTasks parameter increased to close to the number of tasks expected.\n" +
						"(It's OK if it's larger than the number of tasks.)\n" +
						"Basically what this means is that many different kinds of tasks are being sent to Vishnu\n" +
						"and when the task format is being created, more tasks have to be sampled to generate a\n" +
						"a format that represents all these different tasks.  For more info, call Gordon Vidaver\n" +
						"at BBN - 617 873 3558 or email gvidaver@bbn.com.\n" +
						"-----------------------------------------------");
  }

  protected void noListProcessProperties (List propertyNameValues,
										  Document doc,
										  Element parentElement, 
										  int searchDepth, 
										  ObjectDescrip od,
										  Collection createdNodes) {
	boolean foundDateAspect = false;
	PropertyNameValue [] currentLatLong = new PropertyNameValue [2];
    for (int i = 0; i < propertyNameValues.size();) {
      PropertyNameValue pnv = 
        (PropertyNameValue) propertyNameValues.get(i);
	  if (checkForLatLong (doc, parentElement, pnv, currentLatLong)) {
		i++;
		continue;
	  }
	  
	  foundDateAspect = checkForDateAspect (pnv, foundDateAspect);
	  
	  generateElem (doc, parentElement, pnv.name, pnv.value, 
					searchDepth, false, false, od, createdNodes);
	  i++;
    }
  }

  protected void generateElem (Document doc, Element parentElement, 
							   String propertyName, Object propertyValue,
							   int searchDepth,
							   boolean isList, boolean isFirst,
							   ObjectDescrip od,
							   Collection createdNodes) {
	// check if this should be a leaf
	boolean isLeaf = !isList &&
	  (stringClass.isInstance (propertyValue) ||
	   classClass.isInstance  (propertyValue));

	if (isLeaf) 
	  generateLeaf    (doc, parentElement, propertyName, propertyValue, od);
	else {
	  generateNonLeaf (doc, parentElement, propertyName, propertyValue, 
					   searchDepth, isList, isFirst, od,
					   createdNodes);
	}
  }

  /** subclass to generate different tag */
  protected Element createRootNode (Document doc,
									String tag,
									boolean isTask,
									boolean isResource,
									Object obj,
									String resourceClassName) {
	return createObject(doc, tag, obj, isTask, isResource);
  }

  /**
   * Already seen this object or reached maximum depth. 
   * Write the UID if possible, otherwise write the "toString".
   */
  protected void generateElementReachedMaxDepth (Document doc, Element parentElement, 
												 Object obj, 
												 ObjectDescrip od) {
	if (debug)
	  System.out.println("Object traversed already/max depth: " + 
						 obj.getClass().toString() + " " + obj);
	if (isUniqueObject (obj)) {
	  Element item = createField (doc, "UID", "string(40)", false, od);
	  if (debug) 
		System.out.println ("maxDepth - " + "UID" + " - " + "string(40)");

	  parentElement.appendChild(item);
	} else {
	  parentElement.appendChild(createField(doc, obj.toString(), obj, false, od));
	  if (debug) 
		System.out.println ("maxDepth - " + obj);
	}
  }

  protected boolean checkForLatLong (Document doc, Element parentElem, 
									 PropertyNameValue pnv, 
									 PropertyNameValue [] currentLatLong) {
	boolean skip = false;
	
	if (pnv.name.charAt(0) == 'l') {
	  if (pnv.name.equals ("latitude")) {
		currentLatLong[0] = pnv;
		skip = true;
	  }
	  else if (pnv.name.equals ("longitude")) {
		currentLatLong[1] = pnv;
		skip = true;
	  }
	}

	if (currentLatLong[0] != null && currentLatLong[1] != null) {
	  Element latlong = createLatlong (doc, 
									   "" + ((Latitude) currentLatLong[0].value).getDegrees  (), 
									   "" + ((Longitude)currentLatLong[1].value).getDegrees ());
	  parentElem.appendChild (latlong);
	}
	return skip;
  }
  
  protected void generateLeaf (Document doc, Element parentElement, 
							   String propertyName, Object propertyValue,
							   ObjectDescrip od) {
	Element item = createField(doc, propertyName, propertyValue, false, od);
	parentElement.appendChild(item);
	
	if (debug) 
	  System.out.println ("isLeaf - field " + propertyName + " - " + propertyValue +
						  " to parent " + parentElement.getTagName());
  }
  
  /**
   * <pre>
   * Create a <FIELD> with an <OBJECT> underneath it.
   *
   * The object that is the OBJECT is propertyValue.
   *
   * Keeps track of global objects, and sets the field values to properly reference them.
   * 
   * Ignores longitude objects since they are handled with latitudes.
   * Also skips creating an object tag for dates, latitudes, longitudes, and uids.
   * Object tags are created for non globals and for the first instance of a global.
   * Role Schedules get interval tags added to them.
   *
   * Globals get entered into two maps : one mapping object to DOM node, and one
   * mapping object to the global's name.  Also, a class to instance map maps
   * types to instances, so we can rename the globals properly.  I.e. the fifth
   * TypeIdentificationPG becomes TypeIdentificationPG5.
   *
   * Subsequent encounters of the same object generate a value tag with that global's
   * name.
   *
   * Recurses on propertyValue using addNodes.
   * </pre>
   * @see #addNodes
   * @param doc the document to add nodes to
   * @param parentElement append new nodes here
   * @param propertyName classname of the propertyValue object
   * @param propertyValue object that we're translating into XML
   * @param searchDepth how deep in the tree we can still go
   * @param isList is the object part of a list - IGNORED (used in Format)
   * @param isFirst is the object the first elem in a list - IGNORED (used in Format)
   * @param od object description - structure of object created in format xmlize,
   *  used in field renaming
   * @param od createdNodes - IGNORED
   */
  protected void generateNonLeaf (Document doc, Element parentElement, 
								  String propertyName, Object propertyValue,
								  int searchDepth,
								  boolean isList, boolean isFirst,
								  ObjectDescrip od,
								  Collection createdNodes) {
	// this removes the class name following the $ for Locked classes
	int index = propertyName.indexOf('$');
	if (index > 0) {
	  propertyName = propertyName.substring(0, index);
	}

	Element fieldNode = null;
	if (!ignoreObject (propertyValue)) {
	  fieldNode = createField(doc, propertyName, propertyValue, true, od);
	  parentElement.appendChild(fieldNode);
	}

	if (debug) 
	  System.out.println ("DataXMLize.nonLeaf - " + propertyName + " - " + propertyValue);
	if (!skipObject (propertyValue)) {
	  boolean isGlobal = isGlobal(propertyValue);
	  boolean seenGlobalBefore = false;
	  boolean removedObjectNode = false;
	  if (isGlobal) {
		seenGlobalBefore = globalToNode.containsKey (propertyValue);
		if (debug) 
		  System.out.println ("DataXMLize.nonLeaf - " + propertyValue + " is global");
		if (debug && seenGlobalBefore)
		  System.out.println ("DataXMLize.nonLeaf - " + propertyValue + " saw before.  Skipping.");
	  }
	  Element objectNode = null;
	  if (!isGlobal || !seenGlobalBefore) {
		objectNode = createObject(doc, propertyName, propertyValue, false, false);
		fieldNode.appendChild (objectNode);
		if (debug) 
		  System.out.println ("DataXMLize.nonLeaf - adding object to field.");
		removedObjectNode = false;
		addNodes(doc, propertyValue, objectNode, (searchDepth-1), createdNodes);

		// check to see if it's a role schedule, in which case, we need to append plan elem info
		// yes, this is a hack -- we remove the needless roleSchedule field and the scheduleElements
		// these are useless
		if (roleScheduleImplClass.isInstance(propertyValue)) {
		  if (debug) 
			System.out.println ("DataXMLize.nonLeaf - found role schedule");
		  removeChildNamed (objectNode, "roleSchedule");
		  removeChildNamed (objectNode, "scheduleElements");
		  removeChildNamed (objectNode, "availableSchedule");
		  objectNode.appendChild(createIntervalNamed ("scheduleElements",  doc, (Schedule) propertyValue));
		  objectNode.appendChild(createIntervalNamed ("availableSchedule", doc, ((RoleSchedule) propertyValue).getAvailableSchedule()));
		}
		// if there are no fields in the object
		if (objectNode.getChildNodes().getLength() == 0) {
		  fieldNode.removeChild (objectNode);
		  parentElement.removeChild (fieldNode);
		  if (debug) 
			System.out.println ("DataXMLize : nonLeaf - REMOVING - " + propertyName + " - " + propertyValue);
		  removedObjectNode = true;
		}
	  }
	 
	  if (isGlobal) {
		if (!removedObjectNode && !seenGlobalBefore) {
		  fieldNode.removeChild (objectNode);

		  if (debug) 
			System.out.println ("DataXMLize.nonLeaf - mapping " + propertyValue.getClass () + " to " + objectNode);

		  // store the node for later
		  globalToNode.put (propertyValue, objectNode);
		  globalsToSend.add (propertyValue);
		  
		  // get the type
		  String typeName = getTypeName (propertyValue, true);
		  List instances = (List) classToInstances.get (typeName);
		  if (instances == null)
			classToInstances.put (typeName, instances = new ArrayList ());
		  if (instances.contains (propertyValue))
			System.out.println ("DataXMLize.nonLeaf - Huh? found second occurence of instance?");
		  else 
			instances.add (propertyValue);
	  
		  String name = (instances.size () > 1) ? typeName + instances.indexOf (propertyValue) : typeName;
		  if (debug) System.out.println ("DataXMLize.nonLeaf - " + propertyValue.getClass () +  " " +
										 instances.size () + " instances, " + 
										 " name " + name);

		  // store the object's global name
		  globalToName.put (propertyValue, name);
		  fieldNode.setAttribute("value", name);
		}
		else
		  fieldNode.setAttribute("value", (String) globalToName.get(propertyValue));
	  }
	}
  }
  
  /**
   * <pre>
   * Converts a collection of ALP objects into a Vishnu Data DOM document
   * Format is :
   * <PROBLEM>
   *   <DATA>
   *     <WINDOW starttime=xxx endtime=yyy>
   *     <NEWOBJECTS>
   *       <OBJECT>
   *       </OBJECT>
   *       ...
   *
   * Where each <OBJECT> tag corresponds to each item.
   * </pre>
   * @param items collection of items to translate
   * @return result document
   */
  protected synchronized Document createDoc (Collection items, String assetClassName) {
      Document doc = new DocumentImpl(); 
      Element root = doc.createElement("PROBLEM");
	doc.appendChild (root);
	Element df   = doc.createElement("DATA");
	root.appendChild(df);
	Element window = doc.createElement("WINDOW");
	window.setAttribute ("starttime", "2000-01-01 00:00:00");
	window.setAttribute ("endtime",   "2002-01-01 00:00:00");
	df.appendChild (window);
	
	Element newobjects = doc.createElement("NEWOBJECTS");
	df.appendChild (newobjects);
	
    Element element   = null;
	Date start = new Date();
    for (Iterator iter = items.iterator(); iter.hasNext ();) {
      Collection nodes = getPlanObjectXMLNodes (iter.next(), doc, RECURSION_DEPTH, assetClassName);
	  for (Iterator iter2 = nodes.iterator(); iter2.hasNext ();)
		newobjects.appendChild ((Element) iter2.next());
    }
	if (debug)  
	  reportTime ("DataXMLize.createDoc - did addNodes in ", start);

	if (debug) {
	  int i = 0;
	  for (Iterator iter = unique.keySet().iterator(); iter.hasNext (); ){
		Object obj = iter.next();
		System.out.println ("" + i++ + " - " + obj.getClass () + " - " + unique.get (obj) + " - " + 
							((obj instanceof org.cougaar.domain.planning.ldm.asset.PropertyGroup) ? " PG " : ""));
	  }
	}

	// only send those globals not sent since last set
	for (Iterator iter = globalsToSend.iterator(); iter.hasNext (); ){
	  Object global = iter.next();
	  Element globalElem = doc.createElement("GLOBAL");
	  String globalName = (String) globalToName.get (global);
	  if (debug) 
		System.out.println ("DataXMLize - global " + global.getClass () + " name " + globalName);

	  globalElem.setAttribute ("name", globalName);
	  Element node = (Element) globalToNode.get(global);
	  if (node == null) 
		System.out.println ("no node for global?");

	  globalElem.appendChild (node);
	  newobjects.appendChild (globalElem);
	}

	globalsToSend.clear ();
	
	return doc;
  }

  protected Element createObject (Document doc, String name, Object theObj, boolean isTask, boolean isResource) {
    Element elem = doc.createElement("OBJECT");
	String cn;
	
	if (isResource) {
	  cn = resourceName;

	  if (debug)
		System.out.println ("DataXMLize.createObject - Using resource name " + resourceName);
	}
	else {
	  cn = theObj.getClass ().toString();
	  cn = cn.substring (cn.lastIndexOf ('.') + 1);
	  cn = cn.substring (cn.lastIndexOf ('$') + 1);
	}

	elem.setAttribute ("type", (isTask) ? name : cn);

	return elem;
  }

  private static final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

  /**
   * <pre>
   *
   * Creates an element, field, of the form:
   * <FIELD name=xxx> OR
   * <FIELD name=xxx value=yyy>
   *                                                                      </pre><p>
   * Uses the type of <code>theObj</code> to format the value properly.         <p>
   *
   * Renames the field with the <code>od</code> ObjectDescrip.  This           <br>
   * object holds the mapping of oldname to newname.  It is created in the     <br>
   * VishnuPlugIn.  The general problem that some fields can have multiple <br>
   * types of objects, and each needs a distinct name.
   *
   * @see org.cougaar.lib.vishnu.client.VishnuPlugIn#removeDuplicates
   * @param doc needed to create new elements
   * @param name the name of the field
   * @param theObj the value for the field
   * @param hasObject is there an object inside of this field
   * @param od ObjectDescrip, used to figure out how to rename the field
   * @return the field element that is created
   */
  protected Element createField (Document doc,
								 String name,
								 Object theObj,
								 boolean hasObject,
								 ObjectDescrip od) {
    Element elem = doc.createElement("FIELD");
	Set nameTypePairs = null;

	if (od == null)
	  elem.setAttribute ("name", name);
	else
	  nameTypePairs = od.getNameTypePairs (name);

	if (nameTypePairs != null) {
	  String typeName = getTypeName (theObj, hasObject);
	  if (debug) 
		System.out.println ("type " + typeName + " hasObject = " + hasObject);
	  for (Iterator iter = nameTypePairs.iterator (); iter.hasNext(); ) {
		String [] nameTypePair = (String []) iter.next ();
		if (typeName.equals (nameTypePair[1]) || 
			((typeName.charAt(0) == 's') &&
			 (typeName.startsWith ("string(") && nameTypePair[1].startsWith("string(")))) {
		  name = nameTypePair[0];
		  if (debug) 
			System.out.println ("\tFOUND MATCH! new name " + name);
		  break;
		}
	  }
	}
	elem.setAttribute ("name", name);
		
	if (dateClass.isInstance(theObj)) {
	  try {
		String dateAsString = format.format ((Date) theObj);
		elem.setAttribute ("value", dateAsString);
	  } catch (NumberFormatException nfe) {}
	}
	else if (uniqueObjectClass.isInstance(theObj)) {
	  UniqueObject unique = (UniqueObject) theObj;
	  UID uniqueUID = unique.getUID ();
	  String UIDString = "ERROR_novalue";
	  try {
		UIDString = uniqueUID.getUID ();
	  } catch (NullPointerException npe) {
		System.out.println ("DataXMLize - null pointer on " + unique + 
							" - no UID set?");
	  }

	  if (UIDString.indexOf ('<') != -1)
		UIDString = UIDString.replace('<','_');
	  if (UIDString.indexOf ('>') != -1)
		UIDString = UIDString.replace('>','_');

	  elem.setAttribute ("value", UIDString);
	}
	else if (UIDClass.isInstance(theObj)) {
	  elem.setAttribute ("value", ((UID) theObj).getUID ());
	}
	else if (isPrimitiveFloat(theObj.getClass()))
	  elem.setAttribute ("value", getValueOfPrimitiveFloat (theObj));
	else if (!hasObject) {
	  String valueString = theObj.toString();
	  if (valueString.indexOf ('\"') != -1) {
		valueString = valueString.replace('\"','\'');
	  }
	  if (valueString.indexOf ('&') != -1) {
		valueString = valueString.replace('&','+');
	  }
	  if (valueString.indexOf ('<') != -1)
		valueString = valueString.replace('<','_');
	  if (valueString.indexOf ('>') != -1)
		valueString = valueString.replace('>','_');

	  elem.setAttribute ("value", valueString);
	}

	return elem;
  }

  protected String getTypeName (Object theObj, boolean hasObject) {
	if (dateClass.isInstance(theObj))
	  return dateString;
	if (hasObject) {
	  String cn = theObj.getClass ().toString();
	  cn = cn.substring (cn.lastIndexOf ('.') + 1);
	  cn = cn.substring (cn.lastIndexOf ('$') + 1);
	  return cn;
	} else
	  return getTypeFor (theObj);
  }
  
  protected Element createLatlong (Document doc,
								   String latitude,
								   String longitude) {
    Element elem = doc.createElement("FIELD");
	elem.setAttribute ("name", "latitude");
    Element obj = doc.createElement("OBJECT");
	obj.setAttribute ("type", "latlong");
	elem.appendChild (obj);
    Element field = doc.createElement("FIELD");
	field.setAttribute ("name", "latitude");
	field.setAttribute ("value", latitude);
	obj.appendChild (field);
    field = doc.createElement("FIELD");
	field.setAttribute ("name", "longitude");
	field.setAttribute ("value", longitude);
	obj.appendChild (field);

	return elem;
  }

  /** 
   * need to have special code to add plan element intervals to role schedule data, since
   * bean properties don't include them
   */
  protected Element createIntervalNamed (String name, Document doc, Schedule rs) {
    Element fieldElem = doc.createElement("FIELD");
	fieldElem.setAttribute ("name", name);
    Element listTag = createList (doc);
	fieldElem.appendChild (listTag);

	// Must get a copy first, even though I know there will be no concurrent modification
	try {
	  List copy = new ArrayList (rs);
	
	  for (Iterator iter = copy.iterator (); iter.hasNext (); ) {
		TimeSpan elem = (TimeSpan) iter.next ();
		Element value = createValue (doc);
		listTag.appendChild (value);
		value.appendChild (createLittleInterval (doc, 
												 new Date (elem.getStartTime ()),
												 new Date (elem.getEndTime   ())));
	  }
	} catch (Exception e) {}
	finally {
	  return fieldElem;
	}
  }
  
  protected Element createLittleInterval (Document doc, Date start, Date end) {
	Element obj = doc.createElement("OBJECT");
	obj.setAttribute ("type", "interval");

	Element field = doc.createElement("FIELD");
	field.setAttribute ("name", "start");
	field.setAttribute ("value", format.format (start));
	obj.appendChild (field);

	field = doc.createElement("FIELD");
	field.setAttribute ("name", "end");
	field.setAttribute ("value", format.format (end));
	obj.appendChild (field);

	return obj;
  }

  protected Element createList (Document doc) {
    Element elem = doc.createElement("LIST");
	return elem;
  }

  protected Element createValue (Document doc) {
    Element elem = doc.createElement("VALUE");
	return elem;
  }
  
  private boolean debug = false;
}
