/*
 * <copyright>
 *  Copyright 2001 BBNT Solutions, LLC
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
package org.cougaar.lib.vishnu.client.custom;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.OutputStream;

import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.xerces.dom.DocumentImpl;

import org.cougaar.domain.glm.ldm.asset.GLMAsset;
import org.cougaar.domain.glm.ldm.plan.GeolocLocation;
import org.cougaar.domain.glm.util.GLMPrepPhrase;
import org.cougaar.domain.planning.ldm.asset.AggregateAsset;
import org.cougaar.domain.planning.ldm.asset.Asset;
import org.cougaar.domain.planning.ldm.plan.Task;

import org.cougaar.lib.util.UTILPreference;
import org.cougaar.lib.vishnu.client.XMLizer;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;

import org.cougaar.lib.vishnu.server.Resource;
import org.cougaar.lib.vishnu.server.SchObject;
import org.cougaar.lib.vishnu.server.TimeOps;

/**
 * Create either an XML document in the Vishnu Data format or Vishnu objects from ALP objects. <p>
 * 
 * <p>
 */
public class CustomDataXMLize implements XMLizer, DirectTranslator {
  /** 
   * Chooses whether to use an XMLDataHelper or a DirectDataHelper depending on the setting of 
   * <code>direct</code>.
   *
   * @param direct - do direct Cougaar->Vishnu Object translation, no XML
   */
  public CustomDataXMLize (/** VishnuComm comm, */ boolean direct) {
	//	this.comm = comm;
	this.direct = direct;

	if (!direct)
	  dataHelper = new XMLDataHelper ();
  }

  /** 
   * Called from prepareVishnuObjects, creates DirectDataHelper 
   *
   * @see CustomVishnuAllocatorPlugIn#prepareVishnuObjects
   * @param formatDoc - given to DirectDataHelper, so that it can figure out field attributes
   * @param timeOps - allows creation of Vishnu date fields
   */
  public void setFormatDoc (Document formatDoc, TimeOps timeOps) {
	this.timeOps = timeOps;
	dataHelper = new DirectDataHelper (formatDoc, timeOps);
  }
  
  /** 
   * Create an XML document from the set of input tasks and resources. <p>
   *
   * Called by XMLProcessor.getDataDoc, used in the preparing of the data document. <p>
   *
   * @see org.cougaar.lib.vishnu.client.XMLProcessor#getDataDoc
   * @param items to translate into XML
   * @param ignoredAssetClassName - ignored
   **/
  public Document createDoc (Collection items, String ignoredAssetClassName) {
	doc = new DocumentImpl();
	((XMLDataHelper)dataHelper).setDoc (doc);
	
	Element newobjects = createHeader(doc);
	
	if (debug)
	  System.out.println ("TranscomDataXMLize.createDoc - got " + items.size () + " items.");
	if (minorDebug)
	  System.out.println ("TranscomDataXMLize.createDoc - initially, NEWOBJECTS tag has " + 
						  newobjects.getChildNodes().getLength() + " children.");
	
    for (Iterator iter = items.iterator(); iter.hasNext ();) {
	  Object taskOrAsset = iter.next ();
	  Element object = doc.createElement("OBJECT");

	  if (taskOrAsset instanceof Asset) {
		if (processAsset (object, taskOrAsset)) {
		  newobjects.appendChild (object);
		} 
		else if (debug)
		  System.out.println ("TranscomDataXMLize.createDoc - ignoring asset " + taskOrAsset);
	  }
	  else { // it's a task
		if (processTask (object, taskOrAsset)) {
		  newobjects.appendChild (object);
		} 
		else if (debug)
		  System.out.println ("TranscomDataXMLize.createDoc - ignoring task " + taskOrAsset);
	  }
	}

	if (debug)
	  System.out.println ("TranscomDataXMLize.createDoc - sending " + 
						  newobjects.getChildNodes().getLength() + " NEWOBJECTS.");

	if (writeXMLToFile) {
	  String fileName = "Transcom_data_" + numFilesWritten++ + ".xml";
	  System.out.println ("TranscomDataXMLize.createDoc - Writing document to file " + fileName);
	  try {
		FileOutputStream temp = new FileOutputStream (fileName);
		writeDocToStream (doc, temp);
	  } 
	  catch (FileNotFoundException fnfe) { /* never happen */ }
	  catch (IOException ioe) { /* never happen */ }
	}

	return doc;
  }

  /** serialize doc to stream */
  protected void writeDocToStream (Document doc, OutputStream os) {
    OutputFormat of = new OutputFormat (doc, "UTF-8", true);
	of.setLineWidth (150);
	
	XMLSerializer serializer = new XMLSerializer (os, of);

    try {
      serializer.serialize (doc);
    } catch (IOException ioe) {System.out.println ("Exception " + ioe);}
  }

  /** 
   * Populate <tt>vishnuTasks/Resources</tt> lists from Cougaar <tt>items</tt>. <p>
   *
   * Calls both processTask and processAsset
   * 
   * @see #processTask
   * @see #processAsset
   */
  public void createVishnuObjects (List items, List vishnuTasks, List vishnuResources) {
	
    for (Iterator iter = items.iterator(); iter.hasNext ();) {
	  Object taskOrAsset = iter.next ();
	  
	  if (taskOrAsset instanceof Asset) {
		Object vishnuObject = new Resource(timeOps);
		if (processAsset (vishnuObject, taskOrAsset)) {
		  vishnuResources.add (vishnuObject);
		} 
		else if (debug)
		  System.out.println ("TranscomDirect.createVishnuObjects - ignoring asset " + taskOrAsset);
	  }
	  else { // it's a task
		Object vishnuObject = new org.cougaar.lib.vishnu.server.Task(timeOps);
		if (processTask (vishnuObject, taskOrAsset)) {
		  vishnuTasks.add (vishnuObject);
		} 
		else if (debug)
		  System.out.println ("TranscomDirect.createVishnuObjects - ignoring task " + taskOrAsset);
	  }
	}
  }

  /** 
   * Attach standard header - problem, data, window, and newobjects tags. <p>
   *
   * @param doc to add header to
   * @return the new objects tag to attach all the new objects to
   */
  protected Element createHeader (Document doc) {
	Element root = doc.createElement("PROBLEM");
	doc.appendChild (root);

	Element data   = doc.createElement("DATA");
	root.appendChild(data);
	Element window = doc.createElement("WINDOW");
	window.setAttribute ("starttime", "2000-01-01 00:00:00");
	window.setAttribute ("endtime",   "2002-01-01 00:00:00");
	data.appendChild (window);
	
	Element newobjects = doc.createElement("NEWOBJECTS");
	data.appendChild (newobjects);
	
	return newobjects;
  }
  
  /** 
   * Create XML for asset, subclass to add fields
   * 
   * @param object node representing asset
   * @param taskOrAsset asset being translated
   * @return true if should add object to list of new objects
   */
  protected boolean processAsset (Object object, Object taskOrAsset) {
	setType (object, "Asset");
	return true;
  }

  /** if not doing direct translation, set the type of the Element */
  protected void setType (Object object, String type) {
	if (!direct)
	  ((Element)object).setAttribute ("type", type);
  }
  
  /** set the type, name, and id of the object */
  protected String setName (String parentType, Object object, Asset asset) {
	String type = getAssetType(asset);
	String name = getAssetName(asset);

	dataHelper.createField(object, parentType, "id", asset.getUID().toString());
	dataHelper.createField(object, parentType, "type", type);
	dataHelper.createField(object, parentType, "name", name);

	if (debug)
	  System.out.println ("TranscomDataXMLize.processAsset - asset " + asset.getUID() + 
						  " type " + type + " name " + name);
	
	return type;
  }
  
  /** 
   * Create XML for task, subclass to add fields
   * 
   * @param object node representing task
   * @param taskOrAsset task being translated
   * @return true if should add object to list of new objects
   */
  protected boolean processTask (Object object, Object taskOrAsset) {
	Task task = (Task) taskOrAsset;
	String taskName = getTaskName (); 

	setType (object, taskName);

	dataHelper.createField(object, taskName, "id", task.getUID().toString());

	return true;
  }

  /** Transport by default -- override to use a different name for the task */
  protected String getTaskName () {
	return "Transport";
  }

  /** 
   * Get the name of the asset <p>
   * 
   * This will be the item PG's item id.  But if this is null, then it will
   * be the type PG nomenclature + identification.
   *
   * @param asset to get name from
   * @return the name
   */
  protected String getAssetName (Asset asset) {
	String name = "";

	try {
	  name = //asset.getItemIdentificationPG().getNomenclature() + "-" +
		asset.getItemIdentificationPG().getItemIdentification();
	} catch (Exception e) {
	  System.err.println ("TranscomDataXMLize.createDoc - ERROR - no item id pg on " + asset);
	}
		
	if (name == null || name.length () == 0) {
	  try {
		name = asset.getTypeIdentificationPG().getNomenclature() + "-" +
		  asset.getTypeIdentificationPG().getTypeIdentification(); 
	  } catch (Exception e) {
		System.err.println ("TranscomDataXMLize.createDoc - ERROR - no type id pg on " + asset);
	  }
	}

	return fixName(name);
  }

  /** 
   * Get the type of the asset <p>
   *
   * If the type PG nomenclature is null, use the type identification.
   * @param asset to get name from
   * @return the type
   */
  protected String getAssetType (Asset asset) {
	String name = "";

	try {
	  name = asset.getTypeIdentificationPG().getNomenclature();
	} catch (Exception e) {
	  System.err.println ("TranscomDataXMLize.createDoc - ERROR - no type id pg on " + asset);
	}

	if (name == null) {
	  try {
		name = asset.getTypeIdentificationPG().getTypeIdentification();
	  } catch (Exception e) {
		System.err.println ("TranscomDataXMLize.createDoc - ERROR - no type id pg on " + asset);
	  }
	}
	if (name == null) name = "";
	
	return fixName(name);
  }

  /** remove XML tags from name -- confuses parsing... */
  protected String fixName (String name) {
	if (name.indexOf ('<') != -1)
	  name = name.replace('<','_');
	if (name.indexOf ('>') != -1)
	  name = name.replace('>','_');

	return name;
  }

  /** document that is created, if producing XML = not direct mode */
  protected Document doc;

  protected TimeOps timeOps;
  protected boolean direct = false;
  /** the data helper -- comes in two flavors : XML and direct translation */
  protected DataHelper dataHelper;
  /** used to form file names when writing XML to a file */
  protected static int numFilesWritten;
  /** write XML that's posted to a file */
  protected boolean writeXMLToFile = false;

  boolean debug = false;
  boolean minorDebug = false;
}
