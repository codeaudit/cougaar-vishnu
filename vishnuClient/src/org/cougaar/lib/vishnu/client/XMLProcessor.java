package org.cougaar.lib.vishnu.client;

import java.io.IOException;
import java.io.FileNotFoundException;
import java.text.SimpleDateFormat;

import java.util.Collection;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Stack;
import java.util.TreeSet;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.apache.xerces.dom.DocumentImpl;

import org.cougaar.lib.vishnu.client.VishnuComm;
import org.cougaar.lib.vishnu.client.VishnuDomUtil;

import org.cougaar.lib.param.ParamMap;
import org.cougaar.util.ConfigFinder;

/**
 * <pre>
 * ALP-Vishnu bridge.
 *
 * Base class for interacting with the Vishnu scheduler.
 *
 * Abstract because it does not define :
 *  - createThreadCallback
 * each of which is defined in the allocator, aggregator, and expander 
 * subclasses.
 *
 * </pre>
 * <!--
 * (When printed, any longer line will wrap...)
 *345678901234567890123456789012345678901234567890123456789012345678901234567890
 *       1         2         3         4         5         6         7         8
 * -->
 */
public class XMLProcessor {

  private static final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
  private static String SEPARATOR = "_";

  public XMLProcessor (ParamMap myParamTable,
					   String name, 
					   String clusterName,
					   VishnuDomUtil domUtil,
					   VishnuComm comm,
					   ConfigFinder configFinder) {
	this.myParamTable = myParamTable;
	
	localSetup ();
	this.name = name;
	this.clusterName = clusterName;
	this.configFinder = configFinder;
	this.domUtil = domUtil;
	this.comm = comm;
  }
  
  protected ParamMap   getMyParams    () { return myParamTable; }
  protected String     getName        () { return name;         }
  protected String     getClusterName () { return clusterName;  }
  
  /**
   * Here all the various runtime parameters get set.  See documentation for details.
   */
  public void localSetup() {     
    try {myExtraOutput = getMyParams().getBooleanParam("ExtraOutput");}    
    catch(Exception e) {myExtraOutput = false;}

    try {myExtraExtraOutput = getMyParams().getBooleanParam("ExtraExtraOutput");}    
    catch(Exception e) {myExtraExtraOutput = false;}

    try {showDataXML = getMyParams().getBooleanParam("showDataXML");}    
    catch(Exception e) {showDataXML = false;}

    try {debugFormatXMLizer = 
		   getMyParams().getBooleanParam("debugFormatXMLizer");}
    catch(Exception e) {debugFormatXMLizer = false;}

    try {debugDataXMLizer = 
		   getMyParams().getBooleanParam("debugDataXMLizer");}    
    catch(Exception e) {debugDataXMLizer = false;}

	// controls the time period that Vishnu uses - assumes world starts at this time
	// has large effect on scaling of gantt chart displays
    try {vishnuEpochStartTime = 
		   getMyParams().getStringParam("vishnuEpochStartTime");}    
    catch(Exception e) {vishnuEpochStartTime = "2000-01-01 00:00:00";}

	// controls the time period that Vishnu uses - assumes world ends at this time
	// has large effect on scaling of gantt chart displays
    try {vishnuEpochEndTime = 
		   getMyParams().getStringParam("vishnuEpochEndTime");}    
    catch(Exception e) {vishnuEpochEndTime = "2002-01-01 00:00:00";}
  }

  public void createDataXMLizer (Map nameToDescrip, String assetClassName) {
	setDataXMLizer (new DataXMLize (debugDataXMLizer));
	((DataXMLize)dataXMLizer).setNameToDescrip (nameToDescrip);
	((DataXMLize)dataXMLizer).setResourceName  (assetClassName);
  }

  protected void setDataXMLizer (XMLizer xmlizer) {
	dataXMLizer = xmlizer;
  }
  
  public XMLizer getDataXMLizer () {
	if (dataXMLizer == null)
	  System.err.println ("XMLProcessor.getDataXMLizer - ERROR - dataxmlizer not set!");
	
	return dataXMLizer;
  }
  
  /** uses formatXMLizer to generate XML for Vishnu */
  protected Document getFormatDoc (Collection taskAndAssets, String assetClassName) {
	FormatXMLize formatXMLizer = new FormatXMLize (debugFormatXMLizer);
    return formatXMLizer.createDoc (taskAndAssets, assetClassName);
  }

  /** 
   * Uses dataXMLizer to generate XML for Vishnu 
   *
   * Passes nameToDescrip Map to dataXMLizer so can rename fields to be unique.
   *
   * @param taskAndAssets what to send
   * @param nameToDescrip mapping of object type to object description (field names, etc.)
   */
  protected Document getDataDoc (Collection taskAndAssets, XMLizer dataXMLizer, String assetClassName) {
	return dataXMLizer.createDoc (taskAndAssets, assetClassName);
  }

  public Document getFormatDocWithoutDuplicates (Collection templates, String assetClassName, List returnedMap) {
	Document problemFormatDoc = getFormatDoc (templates, assetClassName);

	if (showFormatXML)
	  System.out.println (domUtil.getDocAsString(problemFormatDoc));
	  
	// must remove duplicate OBJECTFORMATS
      
	Node root = problemFormatDoc.getDocumentElement ();
	if (myExtraOutput)
	  System.out.println (getName () + "- root " + ((Element)root).getTagName () + 
						  " has " + root.getChildNodes().getLength()+ " children");
	  
	NodeList nlist = root.getChildNodes();
	Node dataformat = nlist.item(0);  // assumes first child is dataformat

	if (myExtraOutput)
	  System.out.println (getName () + "- dataformat " + ((Element)dataformat).getTagName () + 
						  " has " + dataformat.getChildNodes().getLength()+ " children");

	Map nameInfo = removeDuplicates (dataformat, problemFormatDoc);

	// label the problem with the name of the problem
	((Element)root).setAttribute ("NAME", comm.getProblem());

	if (myExtraOutput)
	  System.out.println (getName () + ".sendFormat - problem is " + comm.getProblem());

	returnedMap.add (nameInfo);
	
	return problemFormatDoc;
  }
  
  /**
   * <pre>
   * Looks at all the object format nodes in the document
   * and removes duplicates (two object formats with the same name and 
   * same fields).
   * 
   * Object formats that have the same name but with different fields are 
   * renamed to make them distinct.
   *
   * addFieldsForDifferentTypes adds fields to refer to the new
   * unique names, and setObjectNames renames the object formats.
   * 
   * The returned maps are needed for the object data phase, so we
   * can figure out what the unique type should be for a data object
   * with an ambiguous type.
   *
   * </pre>
   * @param root - where to start in document
   * @param doc - doc to remove the duplicates from
   * @return Map [] containing two maps - name to object description
   *         and name to node
   */ 
  protected Map removeDuplicates (Node root, Document doc) {
    Set children = new HashSet ();

    NodeList nlist = root.getChildNodes();

    Map nameToNodes   = new HashMap ();
    Map nameToDescrip = new HashMap ();

	Set potentialDuplicates = new HashSet ();
	
    for (int i = 0; i < nlist.getLength(); i++) {
      Node child = nlist.item (i);
      String attr = 
		child.getAttributes().getNamedItem ("name").getNodeValue().toLowerCase();
      
      boolean duplicate = false;
      List nodes = (List) nameToNodes.get (attr);
      if (nodes == null)
		nameToNodes.put (attr, (nodes = new ArrayList()));
      nodes.add (child);

	  if (nodes.size () > 1)
		potentialDuplicates.add (attr);
	  
      ObjectDescrip descrip = (ObjectDescrip) nameToDescrip.get (attr);
      if (descrip == null) {
		if (myExtraExtraOutput)
		  System.out.println ("creating object descrip for - " + attr);

		descrip = new ObjectDescrip ();
		nameToDescrip.put (attr, descrip);
      }
      descrip.addFields (child);
    }

	processObjectFormats (root, nameToNodes, potentialDuplicates, new DuplicateProcessor ());
	processObjectFormats (root, nameToNodes, potentialDuplicates, new MergeProcessor ());
	
    addFieldsForDifferentTypes (root, doc, nameToNodes, nameToDescrip);

	// possibly unnecessary
	processObjectFormats (root, nameToNodes, potentialDuplicates, new MergeProcessor ());
	processObjectFormats (root, nameToNodes, potentialDuplicates, new DuplicateProcessor ());

    return nameToDescrip;
  }

  /**
   * <pre>
   * Given a set of potential duplicate types, removes those that are duplicates
   * from the set of DOM Node OBJECTFORMATs sent to Vishnu.
   * </pre>
   * Removes duplicate OBJECTFORMATs from <code>root</code>.
   * <pre>
   * 
   * If there is only one remaining Node for a type in potentialDuplicates, the type
   * is removed from the list of potential duplicates.
   *
   * First finds those nodes that should be removed and then removes them in a separate 
   * step.
   * </pre>
   * @param potentialDuplicates set of type names of potential duplicates
   * @param nameToNodes list of DOM Nodes for type 
   * @param root DATAFORMAT tag which is the parent of all OBJECTFORMATs
   */
  protected void processObjectFormats (Node root, Map nameToNodes, Set potentialDuplicates, 
									   FormatProcessor formatProcessor) {
    Set toRemove = new HashSet ();
	Set dupsToRemove = new HashSet ();
    for (Iterator iter = potentialDuplicates.iterator (); iter.hasNext(); ){
      String type = (String) iter.next();
	  
	  if (myExtraExtraOutput)
		System.out.println (getName() + ".pruneObjectFormat - type " + type);
	  
	  List nodesForType = (List) nameToNodes.get (type);
	  List copyOfNodesForType = new ArrayList (nodesForType);
	  if (myExtraExtraOutput)
		System.out.println ("nodes for type " + nodesForType);

	  Set nameToNodeToRemove = new HashSet ();
	  for (Iterator iter2 = copyOfNodesForType.iterator (); iter2.hasNext(); ){
		Node objectFormat = (Node) iter2.next();
		formatProcessor.examineObjectFormat (objectFormat, nodesForType, iter2, toRemove);
	  }
	  if (nodesForType.size () == 1) {
		if (myExtraExtraOutput)
		  System.out.println ("\tremoving " + type);
		dupsToRemove.add (type);
	  }
    }
	if (myExtraExtraOutput)
	  System.out.println (getName() + ".pruneObjectFormat - removing " + 
						  dupsToRemove + " from " + potentialDuplicates);
	potentialDuplicates.removeAll (dupsToRemove);
	if (myExtraExtraOutput)
	  System.out.println (getName () + ".pruneObjectFormat - " + 
						  potentialDuplicates.size () + " potential dups remain.");

    for (Iterator iter = toRemove.iterator (); iter.hasNext (); )
      root.removeChild ((Node) iter.next ());
  }
  
  class FormatProcessor {
	protected void examineObjectFormat (Node objectFormat, List nodesForType, Iterator iter, Set toRemove) {};
  }
  
  class MergeProcessor extends FormatProcessor {
	protected void examineObjectFormat (Node objectFormat, List nodesForType, Iterator iter, Set toRemove) {
	  mergeNode (objectFormat, nodesForType, iter);
	}
  }
  
  class DuplicateProcessor extends FormatProcessor {
	protected void examineObjectFormat (Node objectFormat, List nodesForType, Iterator iter, Set toRemove) {
	  if (duplicateNode (objectFormat, nodesForType)) {
		if (myExtraExtraOutput)
		  System.out.println ("\tfound dup");
		toRemove.add (objectFormat);
	  }
	}
  }

  /**
   * <pre>
   * Checks to see if first is an object format that has already been
   * seen when iterating over the document.
   * 
   * Duplicates can be subsets -- i.e. have some subset of the fields
   * of another object with this name.
   *
   * NOTE : if <code>first</code> is a duplicate of another of the Nodes in 
   * <code>nodes</code>, first is removed from the nodes list.
   *  
   * If something is a resource, it should not be seen as a duplicate of
   * another object that is not a resource!
   *
   * </pre>
   * @param first - the node itself
   * @param nameToNodes - hash that records name -> object format node mappings
   * @return true if it's a duplicate of one already seen
   */
  protected boolean duplicateNode (Node first, List nodes) {
    if (nodes.size () == 1)
      return false; // if no others to compare against, it's not a duplicate

    NodeList firstChildNodes  = first.getChildNodes ();

    for (int i = 0; i < nodes.size (); i++) {
      Node other = (Node) nodes.get (i);
      if (first == other)
		continue;  // ignore self to tell if duplicate

      NodeList otherChildNodes = other.getChildNodes ();

	  if (firstChildNodes.getLength () > otherChildNodes.getLength ())
	  	continue; // can't be a subset if more fields

	  // create name->type mapping for other node
      Map otherFieldToType = new HashMap ();

      for (int k = 0; k < otherChildNodes.getLength (); k++) {
		String field = otherChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		String type  = otherChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();
		otherFieldToType.put (field, type);
      }

      boolean allFound = true;
      // go through fields of node we're checking
      for (int k = 0; k < firstChildNodes.getLength (); k++) {
		String firstChildName = 
		  firstChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		String otherType = (String) otherFieldToType.get (firstChildName);

		if (otherType == null) {
		  allFound = false;
		  break;
		}
		else {
		  String firstChildType = 
			firstChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();

		  if (!firstChildType.equals (otherType)) {
			allFound = false;
			break;
		  }
		}
      }
	  
      // we found all the fields of the first node in the fields of another ->
      // it's a subset node...
      if (allFound) {
		if (myExtraExtraOutput) {
		  String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
		  System.out.println ("VishnuPlugIn.duplicateNode - Found a duplicate " + first.getNodeName () + " " + name);
		}
		setResourceAttributes (first, other);
		
		nodes.remove (first);
		return true;
      }
    }
    return false;
  }

  protected void mergeNode (Node first, List nodes, Iterator nodeListIter) {
	if (myExtraOutput) {
	  String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
	  System.out.println (getName() + ".mergeNode - examining " + first.getNodeName () + " " + name);
	}

    if (nodes.size () == 1)
      return; // if no others to compare against, it's not a duplicate

    NodeList firstChildNodes  = first.getChildNodes ();

	Map firstFieldToType = new HashMap ();

	for (int k = 0; k < firstChildNodes.getLength (); k++) {
	  String firstChildName = 
		firstChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
	  String type  = 
		firstChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();
	  firstFieldToType.put (firstChildName, type);
	}
	
    for (int i = 0; i < nodes.size (); i++) {
      Node other = (Node) nodes.get (i);
      if (first == other)
		continue;  // ignore self to tell if duplicate

      NodeList otherChildNodes = other.getChildNodes ();

	  //	  if (firstChildNodes.getLength () > otherChildNodes.getLength ())
	  //	  	continue; // can't be a subset if more fields

	  // create name->type mapping for other node
      Map otherFieldToType = new HashMap ();
	  Map otherNameToNode  = new HashMap ();

	  boolean hasTypeCollision = false;
      for (int k = 0; k < otherChildNodes.getLength (); k++) {
		String field = otherChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		String type  = otherChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();
		if (myExtraOutput)
		  System.out.println (getName() + ".mergeNodes - other field " + field + " - type " + type);
		
		if (firstFieldToType.containsKey(field) &&
			!firstFieldToType.get(field).equals (type)) {
		  if (myExtraOutput)
			System.out.println (getName() + ".mergeNodes - found type collision at " + field + " - " + 
								firstFieldToType.get(field) + " vs " + type);
		  hasTypeCollision=true;
		  break;
		}
		
		otherFieldToType.put (field, type);
		otherNameToNode.put  (field, otherChildNodes.item (k));
      }

	  if (hasTypeCollision) continue; // can't merge

	  Map namesInOther = new HashMap (otherFieldToType);
	  namesInOther.entrySet().removeAll (firstFieldToType.entrySet());
	  
	  for (Iterator iter = namesInOther.keySet ().iterator(); iter.hasNext();) {
		Object fieldName = iter.next();
		Node otherNode = (Node) otherNameToNode.get (fieldName);
		// add new fields
		first.appendChild (otherNode);
		firstFieldToType.put (fieldName, namesInOther.get(fieldName));
	  }

	  if (myExtraOutput) {
		String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
		System.out.println (getName() + ".mergeNode - Found a mergable node " + first.getNodeName () + " " + name);
	  }
	  setResourceAttributes (first, other);
		
	  nodeListIter.remove ();
	}
  }

  protected void setResourceAttributes (Node first, Node other) {
	boolean thisIsResource = 
	  first.getAttributes().getNamedItem ("is_resource").getNodeValue().equals("true");
	boolean otherIsNotResource = 
	  other.getAttributes().getNamedItem ("is_resource").getNodeValue().equals("false");
	if (thisIsResource && otherIsNotResource) {
	  if (myExtraExtraOutput) {
		String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
		System.out.println (getName() + ".mergeNode - Found a mergable node - setting resource attribute for duplicate " + name);
	  }
		  
	  other.getAttributes().getNamedItem ("is_resource").setNodeValue("true");

	  // set is_key attribute on other object format
      NodeList otherChildNodes = other.getChildNodes ();
	  for (int k = 0; k < otherChildNodes.getLength (); k++) {
		String field = otherChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		if (field.equals("UID")) {
		  otherChildNodes.item (k).getAttributes().getNamedItem ("is_key").setNodeValue("true");
		  break;
		}
	  }
	}
  }
  
  /**
   * <pre>
   * Add new fields
   *
   * Where there was :
   * FIELDFORMAT datatype="indirectObject" ... is_subobject="true" name="indirectObject"
   *
   * now have :
   *
   * FIELDFORMAT datatype="indirectObject_0" ... is_subobject="true" name="indirectObject_0"
   * FIELDFORMAT datatype="indirectObject_1" ... is_subobject="true" name="indirectObject_1"
   * FIELDFORMAT datatype="string(128)"      ... is_subobject="true" name="indirectObject_2"
   * 
   * for as many duplicates as there are in the nameToNode map.
   *
   * nameToDescrip is used to lookup the object description for a type.  Then for each
   * field in the object description, if there is more than one known type for that field, 
   * adds new fields with unique names for each type.
   *
   * nameToDescrip is created in removeDuplicates
   *
   * </pre>
   * @see #removeDuplicates
   * @param root - of the document
   * @param doc - needed so can manufacture new nodes (fields), gets altered through addition of
   *              new fields
   * @param nameToNodes   -- per field name, holds all the different possible object formats
   * @param nameToDescrip -- contents are altered to record new name->type pairs
   */
  protected void addFieldsForDifferentTypes (Node root, Document doc, Map nameToNodes, Map nameToDescrip) {
    NodeList nlist = root.getChildNodes();

    Map nodeToNewFields = new HashMap ();
    Map nodeToRemoveFields = new HashMap ();

    for (int i = 0; i < nlist.getLength(); i++) {
      Node objectFormat = nlist.item (i);
      NodeList objectFormatNodeList = objectFormat.getChildNodes ();
      Set fieldsToAdd = new TreeSet (new Comparator () {
		  public int compare (Object o1, Object o2) {
			String n1 = ((Node) o1).getAttributes().getNamedItem("name").getNodeValue();
			String n2 = ((Node) o2).getAttributes().getNamedItem("name").getNodeValue();
			return n1.compareTo (n2);
		  }
		});
	  Set fieldsToRemove = new HashSet ();
      nodeToNewFields.put    (objectFormat, fieldsToAdd);
      nodeToRemoveFields.put (objectFormat, fieldsToRemove);

      String name = objectFormat.getAttributes().getNamedItem ("name").getNodeValue().toLowerCase();
      ObjectDescrip descrip = (ObjectDescrip) nameToDescrip.get (name);

	  if (myExtraOutput)
		System.out.println (getName () + ".addFieldsForDifferentTypes - " + 
							name + " has " + 
							objectFormatNodeList.getLength() + " children");
	  
      for (int j = 0; j < objectFormatNodeList.getLength(); j++) {
		Node fieldFormat = objectFormatNodeList.item (j);
		String fieldName = fieldFormat.getAttributes().getNamedItem("name").getNodeValue();
		String datatype  = fieldFormat.getAttributes().getNamedItem("datatype").getNodeValue();
		if (myExtraOutput)
		  System.out.println (getName () + ".addFieldsForDifferentTypes - " + datatype + "-" + fieldName);

		if (descrip == null) {
		  System.out.println (getName () + ".addFieldsForDifferentTypes - huh? no " + name);
		  continue;
		}

		Set knownTypes = descrip.typesForField (fieldName);

		int distinctNames=0;
		
		if (knownTypes.size () > 1) {
		  fieldsToRemove.add (fieldFormat);
		  if (myExtraOutput)
			System.out.println (getName () + ".addFieldsForDifferentTypes - will remove " + 
								fieldName + "-" + 
								datatype);
		  for (Iterator iter = knownTypes.iterator (); iter.hasNext();) {
			String newtype = (String) iter.next();
			/*			if (newtype.equals (datatype) ||
				(newtype.startsWith ("string(") && (datatype.startsWith ("string(")))) {
			  if (myExtraOutput)
				System.out.println (getName () + ".addFieldsForDifferentTypes - skipping field " + 
									newtype + "-" + 
									name);
			  continue;
			}
			*/

			Node clone = domUtil.createClone(fieldFormat, doc);
			String newname = fieldName + SEPARATOR + distinctNames++;
		  
			descrip.addNewNameType (fieldName, newname, newtype);

			clone.getAttributes().getNamedItem("name").setNodeValue(newname);
			clone.getAttributes().getNamedItem("datatype").setNodeValue(newtype);
			clone.getAttributes().getNamedItem("is_subobject").setNodeValue(isObject(newtype) ? "true" : "false");
			boolean result = fieldsToAdd.add (clone);
			if (myExtraOutput && result)
			  System.out.println (getName () + ".addFieldsForDifferentTypes - storing new field " + 
								  newtype + "-" + 
								  newname);
		  }
		}
      }
    }

    // go through each OBJECTFORMAT node and add any new fields
    for (Iterator iter = nodeToNewFields.keySet().iterator (); iter.hasNext ();) {
      Node objectFormatNode = (Node) iter.next ();
      Set removeFields = (Set) nodeToRemoveFields.get (objectFormatNode);
	  for (Iterator iter2 = removeFields.iterator (); iter2.hasNext ();)
		objectFormatNode.removeChild ((Node)iter2.next());

      Set newFields = (Set) nodeToNewFields.get (objectFormatNode);
      
      if (!newFields.isEmpty ()) {
		for (Iterator iter2 = newFields.iterator (); iter2.hasNext ();) {
		  Node newNode = (Node) iter2.next ();
		  if (myExtraOutput) {
			String type = newNode.getAttributes().getNamedItem("datatype").getNodeValue();
			String name = newNode.getAttributes().getNamedItem("name").getNodeValue();

			String ofName = 
			  objectFormatNode.getAttributes().getNamedItem("name").getNodeValue();
			System.out.println (getName () + ".addFieldsForDifferentTypes - to node " + 
								objectFormatNode.getNodeName () + "/" + 
								ofName + " adding new field " +
								newNode.getNodeName () + " - " +
								type + " : " + 
								name);
		  }

		  objectFormatNode.appendChild (newNode);
		}
      }
    }
  }

  /** check type and see if it is not a primitive = object */
    protected boolean isObject (String type) {
      return (!type.equals ("number") &&
	      !type.equals ("datetime") &&
	      !type.equals ("latlong") &&
	      !type.equals ("boolean") &&
	      !type.startsWith ("string") &&
	      !type.equals ("list") &&
	      !type.equals ("interval") &&
	      !type.equals ("matrix"));
    }

  public Document prepareDocument (Collection tasks, 
								   XMLizer dataXMLizer,
								   boolean clearDatabase, 
								   boolean sendingChangedObjects,
								   String assetClassName,
								   boolean sentOtherDataAlready,
								   String otherDataFile) {
	Document dataDoc = getDataDoc (tasks, dataXMLizer, assetClassName);
	  
	if (showDataXML)
	  System.out.println (domUtil.getDocAsString(dataDoc));

	Node dataNode = setDocHeader (dataDoc, clearDatabase);

	postProcessData (dataDoc, dataNode, sendingChangedObjects, sentOtherDataAlready, otherDataFile);
	  
	return dataDoc;
  }
  
  protected Node setDocHeader (Document dataDoc, boolean clearDatabase) {
	Node root = dataDoc.getDocumentElement ();
	((Element)root).setAttribute ("NAME", comm.getProblem ());
	
	Node dataNode   = root.getFirstChild ();
	Node windowNode = dataNode.getFirstChild ();

	((Element)windowNode).setAttribute ("starttime", vishnuEpochStartTime);
	((Element)windowNode).setAttribute ("endtime",   vishnuEpochEndTime);

	NodeList nlist = dataNode.getChildNodes ();

	if (clearDatabase)
	  root.getFirstChild().insertBefore (dataDoc.createElement("CLEARDATABASE"),
										 root.getFirstChild ().getFirstChild ());

	return dataNode;
  }

  protected boolean postProcessData (Document dataDoc,
									 Node dataNode, boolean sendingChangedObjects,
									 boolean sentOtherDataAlready,
									 String otherDataFile) {
	NodeList nlist = dataNode.getChildNodes ();
	boolean sentOtherData = false;
	
	for (int i = 0; i < nlist.getLength(); i++) {
	  if (nlist.item (i).getNodeName ().equals ("NEWOBJECTS")) {
		Node newobject = nlist.item (i);
		NodeList objects = newobject.getChildNodes ();

		if (!sentOtherDataAlready) {
		  appendOtherData (dataDoc, (Element) newobject, otherDataFile);
		  sentOtherData = true;
		}

		if (sendingChangedObjects) {
		  String was = newobject.getNodeName ();
		  Node changedObjects = dataDoc.createElement("CHANGEDOBJECTS");
		  dataNode.insertBefore(changedObjects, newobject);
		  dataNode.removeChild (newobject);
		  for (int j =  0; j < objects.getLength (); j++)
			changedObjects.appendChild (objects.item (j));
		}

		break; // we're only interested in the NEWOBJECTS tag
	  }
	}
	
	return sentOtherData;
  }

  /**
   * <pre>
   * Append any global other data
   * 
   * Global data is optional, so if it can't find the file specified
   * (for instance a default odd file) nothing will happen.
   * </pre>
   */
  protected void appendOtherData (Document dataDoc, Element placeToAdd, String otherData) {
	try {
	  if (configFinder.open (otherData) != null) {
	  if (myExtraOutput)
		  System.out.println (getName () + " appending " + 
							  otherData + " other data file");

		domUtil.appendChildrenToDoc (dataDoc, 
							 placeToAdd, // NEWOBJECTS tag
							 otherData);
	  }
	} catch (FileNotFoundException fnf) {
	  if (myExtraOutput)
		System.out.println (getName () + ".appendOtherData could not find optional file : " + otherData);
	} catch (IOException ioe) {
	  System.out.println (getName () + ".appendOtherData - got io exception " +
						  ioe);
	}
  }
  
  /**
   * OK - horrible hack -- for allocators, need givenPE, since
   * query won't work within same transaction cycle.
   */
  /*
  protected void handleRoleSchedule (Node field, PlanElement givenPE) {
	if (myExtraOutput)
	  System.out.println (getName () + ".handleRoleSchedule - found role schedule.");
	
	Node list = field.getFirstChild ();
	NodeList values = list.getChildNodes ();
	
	for (int i = 0; i < values.getLength(); i++) {
	  Node value = (Node) values.item (i);
	  Node object = value.getFirstChild ();
	  Node startField = object.getFirstChild ();
	  Node endField = object.getLastChild ();
	  
	  final String uid = 
		startField.getAttributes().getNamedItem ("value").getNodeValue();
	  if (myExtraOutput) 
		System.out.println ("Looking for UID " + uid);

	  Collection results;
	  
	  if (givenPE != null) {
		results = new HashSet ();
		results.add (givenPE);
	  }
	  else
		results = query (new UnaryPredicate () {
			public boolean execute (Object obj) {
			  if (obj instanceof PlanElement) {
				//System.out.println ("\t found PE with uid <" + ((PlanElement) obj).getUID () + ">");
				return ((PlanElement) obj).getUID ().equals (uid);
			  }
			
			  return false;
			}
		  });

	  if (results.iterator ().hasNext ()) {
		TimeSpan ts = (TimeSpan) results.iterator ().next ();
	  
		String startString = format.format (new Date (ts.getStartTime ()));
		String endString   = format.format (new Date (ts.getEndTime ()));
	  
		startField.getAttributes().getNamedItem ("value").setNodeValue(startString);
		endField.getAttributes().getNamedItem ("value").setNodeValue(endString);
	  }
	  else
		System.out.println (getName () + ".handleRoleSchedule : ERROR - could not find plan element UID " + 
							uid);
		
	}
  }
  */
  
  public Document prepareFreezeAll () {
	Document doc = new DocumentImpl ();
    Element newRoot = doc.createElement("PROBLEM");
	newRoot.setAttribute ("NAME", comm.getProblem ());
    doc.appendChild(newRoot);
	
	Element freeze = doc.createElement("FREEZEALL");
	newRoot.appendChild (freeze);

	return doc;
  }

  public class ObjectDescrip {
    Map fields = new HashMap ();
    Map newNames = new HashMap ();

	boolean debug = false;
	
    public void addFields (Node node) {
      NodeList nlist = node.getChildNodes();

      for (int i = 0; i < nlist.getLength(); i++) {
		Node field = nlist.item (i);

		String name = field.getAttributes().getNamedItem ("name").getNodeValue();
		String type = field.getAttributes().getNamedItem ("datatype").getNodeValue();
	
		addField (name, type);
      }
    }

    public void addField (String name, String type) {
      Set namedFields = (Set) fields.get (name);

      if (namedFields == null) {
		namedFields = new TreeSet ();
		fields.put (name, namedFields);
      }

      if (!namedFields.contains (type)) {
		namedFields.add (type);
		if (debug && namedFields.size () > 1)
		  System.out.println ("\tfield " + name + 
							  " now " + namedFields);
      }
    }

    public void addNewNameType (String oldname, String newname, String newtype) {
      Set nameTypePairs = (Set) newNames.get (oldname);

      if (nameTypePairs == null) {
		nameTypePairs = new HashSet ();
		newNames.put (oldname, nameTypePairs);
      }
	  if (debug)
		System.out.println ("OD.addNewNameType - for oldname " + oldname + 
							" adding newname " + newname + 
							" newtype " + newtype);
	  
      nameTypePairs.add (new String [] { newname, newtype });
    }

    public Set getNameTypePairs (String oldname) {
      return (Set) newNames.get (oldname);
    }

    public Set typesForField (String name) {
      return (Set) fields.get (name);
    }
    
    public Map getFields () { return fields; }
  }

  protected boolean showFormatXML = false;
  protected boolean showDataXML = false;
  protected boolean debugFormatXMLizer = false;
  protected boolean debugDataXMLizer = false;
  protected String name;
  protected String clusterName;
  protected VishnuComm comm;
  protected VishnuDomUtil domUtil;
  protected ParamMap myParamTable;
  protected boolean myExtraOutput;
  protected boolean myExtraExtraOutput;
  protected String vishnuEpochStartTime;
  protected String vishnuEpochEndTime;
  protected XMLizer dataXMLizer;
  
  ConfigFinder configFinder;
}

