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

import org.cougaar.domain.planning.ldm.asset.Asset;

import org.cougaar.lib.vishnu.server.Resource;
import org.cougaar.lib.vishnu.server.SchObject;
import org.cougaar.lib.vishnu.server.TimeOps;

import org.cougaar.domain.glm.ldm.plan.GeolocLocation;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Map;
import java.util.Set;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Calendar;
import java.util.Date;

import org.cougaar.domain.planning.ldm.plan.RoleSchedule;
import org.cougaar.domain.planning.ldm.plan.PlanElement;
import org.cougaar.util.TimeSpan;

/**
 * Fills in the fields of Vishnu objects sent to the Vishnu Scheduler. <p>
 *
 * Scans the format document to determine the types of each field of data.
 * This is necessary with direct translation because when a field is added
 * its attributes must be set.  These are : <p>
 *
 * - datatype     - the field type                                      <p>
 * - is_subobject - is the field's type a primitive or a subobject      <p>
 * - is_key       - is this field the key field for the object          <p>
 * - is_list      - is this field a list                                <p>
 * 
 */
public class DirectDataHelper implements DataHelper {

  /** 
   * Sets up the endOfWorld time, used in createRoleScheduleListField.
   *
   * @see #createRoleScheduleListField
   * @param formatDoc - the object format document
   * @param timeOps - the Time Operation object used whenever dates are created
   */
  public DirectDataHelper (Document formatDoc, TimeOps timeOps) {
	Calendar calendar = Calendar.getInstance();
	calendar.set(2100,1,1);
	endOfWorld = calendar.getTime();

	this.timeOps = timeOps;

	scanFormatDoc (formatDoc);
  }
  
  /** 
   * Scans the format document to determine the types of each field of data. 
   * 
   * Stores this information in the <code>objects</code> map. 
   * @param formatDoc the object format document
   */
  protected void scanFormatDoc (Document formatDoc) {
	NodeList objectFormats = formatDoc.getElementsByTagName ("OBJECTFORMAT");
	for (int i = 0; i < objectFormats.getLength(); i++) {
	  Element objectFormat = (Element) objectFormats.item(i);
	  NodeList fieldFormats = objectFormat.getElementsByTagName ("FIELDFORMAT");

	  ObjectInfo objectInfo;
	  
	  objects.put (objectFormat.getAttribute ("name"), objectInfo = new ObjectInfo ());

	  if (debug)
		System.out.println ("DirectDataHelper.ctor - " +objectFormat.getAttribute ("name"));
	  
	  for (int j = 0; j < fieldFormats.getLength(); j++) {
		Element field = (Element) fieldFormats.item(j);


		String name = field.getAttribute ("name");
		String type = field.getAttribute ("datatype");
		String sub  = field.getAttribute ("is_subobject");
		String key  = field.getAttribute ("is_key");
		String list = field.getAttribute ("is_list");

		if (debug)
		  System.out.println ("DirectDataHelper.ctor - field " +name);

		objectInfo.nameToType.put (name, type);
		if (sub.equals ("true"))
		  objectInfo.subObjects.add (type);
		if (key.equals ("true"))
		  objectInfo.keys.add (name);
		if (list.equals ("true"))
		  objectInfo.lists.add (name);
	  }
	}
  }

  /** 
   * Translate an asset's role schedule into a list of Vishnu intervals
   *
   * The interval has a start and end time and the verb of plan element in the role schedule.
   *
   * @param object - the SchObject to add the <code>name</code> list field to 
   * @param name   - the name of the list field
   * @param asset  - the asset with the role schedule
   */
  public void createRoleScheduleListField (Object object, String name, Asset asset) {
	RoleSchedule unavail = asset.getRoleSchedule ();
	SchObject resource = (SchObject)object;

	resource.addListField (name);

	for (Iterator iter = unavail.getEncapsulatedRoleSchedule(0, endOfWorld.getTime()).iterator (); iter.hasNext();) {
	  TimeSpan span = (TimeSpan) iter.next ();
	  SchObject interval = new SchObject (timeOps);

	  interval.addDateMillis ("start",  span.getStartTime());
	  interval.addDateMillis ("end",    span.getEndTime());
	  interval.addField ("label1", "string", ((PlanElement)span).getTask().getVerb().toString(), false, false);

      resource.addField (name, "interval", interval, false, true);
	}
  }

  /** 
   * Translate a Cougaar GeolocLocation into the equivalent Vishnu structure.
   *
   * The field names here are all "parentFieldName".name, e.g.
   * from.geolocCode.
   * 
   * Adds a latlong SchObject to the parent object, and adds the geoloc
   * to the parent.
   *
   * @param parent - the SchObject to add the <code>parentFieldName</code> geoloc field to 
   * @param parentFieldName - the base name of the geoloc field
   * @param loc - the Cougaar GeolocLocation to translate into a Vishnu structure
   */
  public void createGeoloc (Object parent, String parentFieldName, GeolocLocation loc) {
	StringBuffer sb = new StringBuffer ();
	sb.append (parentFieldName);
	sb.append ('.');
	sb.append ("geolocCode");
	SchObject objectParent = (SchObject) parent;

	objectParent.addField (sb.toString (), "string", loc.getGeolocCode(), false, false);

	SchObject latlong = new SchObject (timeOps);
	float latDegrees = (float) loc.getLatitude  ().getDegrees();
	float lonDegrees = (float) loc.getLongitude ().getDegrees();
	
	// fill in the fields on the predefined type
	latlong.addFloat ("latitude",  latDegrees);
	latlong.addFloat ("longitude", lonDegrees);

	StringBuffer baseNameBuffer = new StringBuffer ();
	baseNameBuffer.append (parentFieldName);
	baseNameBuffer.append ('.');
	baseNameBuffer.append ("latlong");
	String baseName = baseNameBuffer.toString ();
	
	// fill in the fields on the root task/resource
	objectParent.addField (baseName, "latlong", latlong, false, false);

	baseNameBuffer.append ('.');

	StringBuffer longitudeBuffer = new StringBuffer (baseNameBuffer.toString());
	baseNameBuffer.append  ("latitude");
	longitudeBuffer.append ("longitude");
	
	// e.g. base name = from.latlong.latitude
	objectParent.addFloat (baseNameBuffer.toString (), latDegrees);
	// e.g. base name = from.latlong.longitude
	objectParent.addFloat (longitudeBuffer.toString(), lonDegrees);
  }

  /** 
   * create a vanilla Vishnu object 
   *
   * @param parent - ignored here
   * @param type - ignored here
   */
  public Object createObject (Object parent, String type) {
	return new SchObject (timeOps);
  }

  /** 
   * shortcut to create a date field on <code>parent</code> 
   */
  public void createDateField (Object parent, String name, Date date) {
	if (debug)
	  System.out.println ("DirectDataHelper.createDateField - " +
						  " name " + name +
						  " value " + date);

	((SchObject) parent).addDate (name, date);
  }

  /** shortcut to create a boolean field on <code>parent</code> */
  public void createBooleanField (Object parent, String name, boolean value) {
	if (debug)
	  System.out.println ("DirectDataHelper.createBooleanField - " +
						  " name " + name +
						  " value " + value);

	((SchObject) parent).addBoolean (name, value);
  }

  /** shortcut to create a float field on <code>parent</code> */
  public void createFloatField (Object parent, String name, float value) {
	if (debug)
	  System.out.println ("DirectDataHelper.createFloatField - " +
						  " name " + name +
						  " value " + value);

	((SchObject) parent).addFloat (name, value);
  }

  /** not used in this helper */
  public Object createField (Object parent, String name) {
	return null;
  }

  /** not used in this helper */
  public Object createFieldPair (String name, String value) {
	System.err.println ("huh? don't call me");
	return null;
  }
  
  /** not used in this helper */
  public Object createField (Object parent, String name, String value) {
	System.err.println ("huh? don't call me");
	return null;
  }

  /** 
   * Generic field creation  <p>
   *
   * Given the parentType and the name of the field, looks up the other 
   * field attributes in the <code>objects</code> map, using the isKey, isList,
   * and getType methods. <p>
   *
   * This map is set in scanFormatDoc. 
   *
   * @see #scanFormatDoc
   * @see #objects
   * @param parent SchObject object to add the field to
   * @param parentType type of the SchObject
   * @param name field name
   * @param value field's value
   */
  public void createField (Object parent, String parentType, String name, String value) {
	boolean isKey  = isKey   (parentType, name);
	boolean isList = isList  (parentType, name);
	String  type   = getType (parentType, name);
	
	if (debug)
	  System.out.println ("DirectDataHelper.createField - " +
						  " parentType " + parentType +
						  " name " + name +
						  " type " + type +
						  " value " + value +
						  " key " + isKey +
						  " list " + isList);

	((SchObject) parent).addField (name, type, value, isKey, isList);
  }

  /** 
   * In all of these methods (isKey, isList, isSub, getType), <br>
   * if a type is not found in the objects map, it may        <br>
   * be because it's a predefined type.                       <p>
   *
   * This should never happen, though.
   */
  protected boolean isKey (String parentType, String name) {
	ObjectInfo oi = (ObjectInfo) objects.get (parentType);
	if (oi == null) {
	  if (!isPredefined(parentType))
		System.err.println ("DirectDataHelper.isKey - ERROR - missing parent type " + parentType);
	  return false;
	}
	
	return oi.keys.contains (name);
  }

  protected boolean isList (String parentType, String name) {
	ObjectInfo oi = (ObjectInfo) objects.get (parentType);
	if (oi == null) {
	  if (!isPredefined(parentType))
		System.err.println ("DirectDataHelper.isList - ERROR - missing parent type " + parentType);
	  return false;
	}
	return oi.lists.contains (name);
  }

  protected boolean isSub (String parentType, String name) {
	ObjectInfo oi = (ObjectInfo) objects.get (parentType);
	if (oi == null) {
	  if (!isPredefined(parentType))
		System.err.println ("DirectDataHelper.isSub - ERROR - missing parent type " + parentType);
	  return false;
	}
	return oi.subObjects.contains (name);
  }

  protected String getType (String parentType, String name) {
	ObjectInfo oi = (ObjectInfo) objects.get (parentType);
	if (oi == null) {
	  if (!isPredefined(parentType))
		System.err.println ("DirectDataHelper.getType - ERROR - missing parent type " + parentType);
	  return parentType;// probably wrong...
	}
	return (String) oi.nameToType.get (name);
  }

  protected boolean isPredefined (String type) {
	return type.equals ("interval") ||
	  type.equals ("xy_coord") ||
	  type.equals ("latlong") ||
	  type.equals ("matrix");
  }
  
  /** 
   * Holds object format info about objects, used in generic createField method 
   * 
   * @see #createField
   */
  protected class ObjectInfo {
	public Map nameToType = new HashMap ();
	public Set subObjects = new HashSet ();
	public Set keys = new HashSet ();
	public Set lists = new HashSet ();
  }

  /** reference to TimeOps object, used whenever a date is created */
  protected TimeOps timeOps;

  /** the object format document */
  //  protected Document formatDoc;

  /** holds Vishnu object attributes per type */
  protected Map objects = new HashMap ();

  /** used in createRoleScheduleListField */
  protected Date endOfWorld;

  boolean debug = false;
}



