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
import org.cougaar.planning.ldm.plan.LatLonPoint;
import org.cougaar.planning.ldm.plan.NamedPosition;

import java.util.Date;

/**
 * Defines interface for a data helper that can either produce XML or
 * Vishnu objects.  The interface is neutral to either.
 */
public interface DataHelper {
  /** 
   * Add a field on <code>parent</code>, but don't set the value. <br>
   * The value is set by using createObject. 
   *
   * @param parent Element/SchObject object to add the field to
   * @param parentType type of the parent SchObject/Element
   * @param name field name
   * @see #createObject
   */
  Object createField (Object parent, String parentType, String name);

  /** 
   * Create an object (DOM Element/Vishnu SchObject) of type <code>type</code> 
   *
   * @param parent - Element/Object to attach this new Element/Object to
   * @param type   - type of the new OBJECT Element/Object
   */
  Object createObject (Object parent, String type);

  /** 
   * Generic field creation <p>
   *
   * Attach the field to either an XML Element or Vishnu Object. <p>
   * 
   * Given the parentType and the name of the field, may look up the other 
   * field attributes.
   *
   * @param parent Element/SchObject object to add the field to
   * @param parentType type of the parent SchObject/Element
   * @param name field name
   * @param value field value
   */
  void createField (Object parent, String parentType, String name, String value);

  Object startList (Object object, String name);
  void addListValue (Object parent, String fieldName, String type, Object toAppend);

  /** shortcut to create a date field on <code>parent</code> */
  void createDateField    (Object parent, String name, Date date);

  /** shortcut to create a boolean field on <code>parent</code> */
  void createBooleanField (Object parent, String name, boolean val);

  /** shortcut to create a float field on <code>parent</code> */
  void createFloatField   (Object parent, String name, float val);

  /** Adds a latlong object to the parent object, and adds the geoloc object to the parent. */
  void createGeoloc (Object parent, String parentFieldName, NamedPosition loc);

  /** Adds a latlong object to the parent object */
  void createLatLon (Object parent, String parentFieldName, LatLonPoint loc);

  /** 
   * Translate TimeSpans(PlanElements) in the role schedule into 
   * Vishnu intervals
   */
  void createRoleScheduleListField (Object object, String name, Asset asset);
  /** 
   * Translate TimeSpans(PlanElements) in the available schedule into 
   * Vishnu intervals
   */
  void createAvailableScheduleListField (Object object, String name, Asset asset);
}

