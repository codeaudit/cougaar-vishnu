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

import org.cougaar.glm.ldm.plan.GeolocLocation;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.Schedule;
import org.cougaar.planning.ldm.plan.RoleSchedule;
import org.cougaar.planning.ldm.plan.PlanElement;
import org.cougaar.util.TimeSpan;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Collection;
import java.util.Iterator;
import java.util.Calendar;
import java.util.Date;

/**
 * Fills in DOM document nodes given Cougaar Objects.
 *
 */
public class XMLDataHelper implements DataHelper {
  /** 
   * Sets up endOfWorld variable -- used in createRoleScheduleListField 
   * 
   * @see #createRoleScheduleListField
   */
  public XMLDataHelper () {
	final Calendar calendar = Calendar.getInstance();
	calendar.set(2100,1,1);
	endOfWorld = calendar.getTime();
  }
  
  /** set the document that is being created */
  public void setDoc (Document doc) {
	this.doc = doc;
  }
  
  /** 
   * Translates Asset role schedule into equivalent Vishnu XML. <p>
   *
   * TimeSpans(PlanElements) in the role schedule get translated into Vishnu intervals.
   *
   * @param object - the DOM Element to add the <code>name</code> list field to 
   * @param name   - the name of the list field
   * @param asset  - the asset with the role schedule
   */
  public void createRoleScheduleListField (Object object, String name, Asset asset) {
	RoleSchedule unavail = asset.getRoleSchedule ();

	Element field = doc.createElement("FIELD");
	field.setAttribute ("name",  name);
	((Element)object).appendChild (field);
	Element list = doc.createElement("LIST");
	field.appendChild (list);

	createScheduleFields (unavail.getEncapsulatedRoleSchedule(0, endOfWorld.getTime()),
						  list,
						  true);
  }

  public void createAvailableScheduleListField (Object object, String name, Asset asset) {
	Element field = doc.createElement("FIELD");
	field.setAttribute ("name",  name);
	((Element)object).appendChild (field);
	Element list = doc.createElement("LIST");
	field.appendChild (list);

	Schedule availSchedule = asset.getRoleSchedule().getAvailableSchedule ();
	Collection coll = availSchedule.getEncapsulatedScheduleElements (0,endOfWorld.getTime());
	if (coll.isEmpty ())
	  System.out.println("XMLDataHelper -- availSchedule is empty");

	createScheduleFields (availSchedule.getEncapsulatedScheduleElements (0,endOfWorld.getTime()), 
						  list, 
						  false);
  }

  protected void createScheduleFields (Collection schedule, Element list, boolean isRole) {
	for (Iterator iter = schedule.iterator (); iter.hasNext();) {
	  TimeSpan span = (TimeSpan) iter.next ();

	  Element value = doc.createElement("VALUE");
	  list.appendChild (value);

	  Element interval = doc.createElement("OBJECT");
	  interval.setAttribute ("type", "interval");
	  value.appendChild (interval);

	  createField (interval, "interval", "start", format.format (new Date(span.getStartTime())));
	  createField (interval, "interval", "end",   format.format (new Date(span.getEndTime())));
	  if (isRole)
		createField (interval, "interval", "label1", "" +((PlanElement)span).getTask().getVerb());
	}
  }

  /** 
   * Translate a Cougaar GeolocLocation into the equivalent DOM structure.
   *
   * Adds a latlong object to the parent object, and adds the geoloc
   * to the parent.
   *
   * @param parent - the Element to add the <code>parentFieldName</code> geoloc field to 
   * @param parentFieldName - the base name of the geoloc field
   * @param loc - the Cougaar GeolocLocation to translate into a DOM structure
   */
  public void createGeoloc (Object parent, String parentFieldName, GeolocLocation loc) {
	Object geolocObject = createObject (parent, "geoloc");
	createField(geolocObject, "geoloc", "geolocCode", loc.getGeolocCode ());
	Object field = createField (geolocObject, "geoloc", "latlong");
	Object latlongObject = createObject (field, "latlong");

	createField(latlongObject, "latlong", "latitude",
				"" + loc.getLatitude ().getDegrees());
	createField(latlongObject, "latlong", "longitude",
				"" + loc.getLongitude ().getDegrees());
  }

  /** 
   * create a DOM Element of type <code>type</code> 
   *
   * @param parent - Element to attach this new Element to
   * @param type   - type of the new OBJECT Element
   */
  public Object createObject (Object parent, String type) {
	Element elem = doc.createElement("OBJECT");
	elem.setAttribute ("type",  type);
	((Element)parent).appendChild (elem);
	return elem;
  }

  /** 
   * add a field on <code>parent</code> 
   *
   * @param parentType - ignored, important in DirectDataHelper
   */
  public Object createField (Object parent, String parentType, String name) {
	Element elem = doc.createElement("FIELD");
	elem.setAttribute ("name",  name);
	((Element)parent).appendChild (elem);
	return elem;
  }

  /** create field as name-value pair */ 
  protected Object createFieldPair (String name, String value) {
	Element elem = doc.createElement("FIELD");
	elem.setAttribute ("name",  name);
	elem.setAttribute ("value", value);
	return elem;
  }

  /** 
   * Generic field creation  <p>
   *
   * adds a field as name-value pair to <code>parent</code> 
   *
   * @see #createFieldPair
   * @param parent SchObject object to add the field to
   * @param parentType - ignored, important in DirectDataHelper
   * @param name field name
   * @param value field's value
   */
  public void createField (Object parent, String parentType, String name, String value) {
	((Element)parent).appendChild ((Element) createFieldPair(name, value));
  }

  /** 
   * shortcut to create a date field on <code>parent</code> <p>
   *
   * Translates date into string.
   */
  public void createDateField (Object parent, String name, Date date) {
	try {
	  createField (parent, "", name, format.format(date));
	} catch (Exception e) {}
  }

  /** shortcut to create a boolean field on <code>parent</code> */
  public void createBooleanField (Object parent, String name, boolean value) {
	createField (parent, "", name, value ? "true" : "false");
  }

  /** shortcut to create a float field on <code>parent</code> */
  public void createFloatField (Object parent, String name, float value) {
	createField (parent, "", name, "" + value);
  }

  protected Document doc;
  protected Date endOfWorld;
  private final SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
}

