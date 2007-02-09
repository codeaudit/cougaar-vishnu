/*
 * <copyright>
 *  
 *  Copyright 2001-2004 BBNT Solutions, LLC
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
package org.cougaar.lib.vishnu.client.custom;

import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.PlanElement;
import org.cougaar.planning.ldm.plan.RoleSchedule;
import org.cougaar.planning.ldm.plan.Schedule;
import org.cougaar.planning.ldm.plan.NamedPosition;
import org.cougaar.planning.ldm.plan.LatLonPoint;
import org.cougaar.util.TimeSpan;
import org.cougaar.util.log.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;

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
  public XMLDataHelper (Logger logger) {
    final Calendar calendar = Calendar.getInstance();
    calendar.set(2100,1,1);
    endOfWorld = calendar.getTime();
    this.logger = logger;
  }
  
  /** set the document that is being created */
  public void setDoc (Document doc) {
    this.doc = doc;
  }
  
  /** 
   * Translates Asset role schedule into equivalent Vishnu XML. <p>
   *
   * TimeSpans(PlanElements) in the role schedule get translated into Vishnu intervals.<p>
   *
   * Calls getScheduleFields to do real work.
   * @param object - the DOM Element to add the <code>name</code> list field to 
   * @param name   - the name of the list field
   * @param asset  - the asset with the role schedule
   * @see #createScheduleFields
   * @see org.cougaar.planning.ldm.plan.RoleSchedule
   */
  public void createRoleScheduleListField (Object object, String name, Asset asset) {
    RoleSchedule unavail = asset.getRoleSchedule ();

    Element list = (Element) startList (object, name);

    createScheduleFields (unavail.getEncapsulatedRoleSchedule(0, endOfWorld.getTime()),
			  list,
			  true);
  }

  /** 
   * Translates Asset available schedule into equivalent Vishnu XML. <p>
   *
   * TimeSpans(PlanElements) in the available schedule get translated into Vishnu intervals.<p>
   * Calls getScheduleFields to do real work.
   * @param object - the DOM Element to add the <code>name</code> list field to 
   * @param name   - the name of the list field
   * @param asset  - the asset with the role schedule
   * @see #createScheduleFields
   */
  public void createAvailableScheduleListField (Object object, String name, Asset asset) {
    Element list = (Element) startList (object, name);

    Schedule availSchedule = asset.getRoleSchedule().getAvailableSchedule ();
    if (availSchedule == null) {
      if (logger.isDebugEnabled())
	logger.debug ("No available schedule on asset " + asset);
    } else {
      Collection coll = availSchedule.getEncapsulatedScheduleElements (0,endOfWorld.getTime());
      if (coll.isEmpty ())
	logger.warn("XMLDataHelper -- availSchedule for " + asset + " is empty");

      createScheduleFields (availSchedule.getEncapsulatedScheduleElements (0,endOfWorld.getTime()), 
			    list, 
			    false);
    }
  }

  public Object startList (Object object, String name) {
    Element field = doc.createElement("FIELD");
    field.setAttribute ("name",  name);
    ((Element)object).appendChild (field);
    Element list = doc.createElement("LIST");
    field.appendChild (list);
    return list;
  }

  /** 
   * Walk the schedule and append interval elements to the list element for 
   * each TimeSpan in the schedule.
   *
   * @param schedule TimeSpan Collection from the role schedule or available schedule
   * @param list elem to add interval elements to
   * @param isRole if true, sets the interval label1 to the Verb of the Task of the 
   *        TimeSpan/PlanElement
   * @see org.cougaar.util.TimeSpan
   * @see org.cougaar.planning.ldm.plan.PlanElement
   */
  protected void createScheduleFields (Collection schedule, Element list, boolean isRole) {
    for (Iterator iter = schedule.iterator (); iter.hasNext();) {
      TimeSpan span = (TimeSpan) iter.next ();

      //      Element value = doc.createElement("VALUE");
      //      list.appendChild (value);

      Element interval = doc.createElement("OBJECT");
      interval.setAttribute ("type", "interval");
      //      value.appendChild (interval);
      addListValue (list, "", "", interval);

      createField (interval, "interval", "start", format.format (new Date(span.getStartTime())));
      createField (interval, "interval", "end",   format.format (new Date(span.getEndTime())));
      if (isRole)
	createField (interval, "interval", "label1", "" +((PlanElement)span).getTask().getVerb());
      else
	createField (interval, "interval", "label1", "available_interval");

      createField (interval, "interval", "label2", " ");

    }
  }
  
  public void addListValue (Object parent, String fieldName, String type, Object toAppend) {
    Element value = doc.createElement("VALUE");
    ((Element)parent).appendChild (value);

    value.appendChild ((Element) toAppend);
  }

  /** 
   * Translate a Cougaar GeolocLocation into the equivalent DOM structure. <p>
   *
   * Adds a latlong object to the parent object, and adds the geoloc
   * to the parent.
   *
   * @param parent - the Element to add the <code>parentFieldName</code> geoloc field to 
   * @param parentFieldName - the base name of the geoloc field
   * @param loc - the Cougaar GeolocLocation to translate into a DOM structure
   */
  public void createGeoloc (Object parent, String parentFieldName, NamedPosition loc) {
    Object geolocObject = createObject (parent, "geoloc");
    createField(geolocObject, "geoloc", "geolocCode", loc.getUid ());
    Object field = createField (geolocObject, "geoloc", "latlong");
    Object latlongObject = createObject (field, "latlong");

    createField(latlongObject, "latlong", "latitude",
		"" + loc.getLatitude ().getDegrees());
    createField(latlongObject, "latlong", "longitude",
		"" + loc.getLongitude ().getDegrees());
  }

  public void createLatLon (Object parent, String parentFieldName, LatLonPoint loc) {
    Object field = createField (parent, "latlong", parentFieldName);
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
  Logger logger;
}

