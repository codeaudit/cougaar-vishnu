/*
 * <copyright>
 *  Copyright 2001-2003 BBNT Solutions, LLC
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

import org.cougaar.planning.ldm.asset.Asset;
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

  /** shortcut to create a date field on <code>parent</code> */
  void createDateField    (Object parent, String name, Date date);

  /** shortcut to create a boolean field on <code>parent</code> */
  void createBooleanField (Object parent, String name, boolean val);

  /** shortcut to create a float field on <code>parent</code> */
  void createFloatField   (Object parent, String name, float val);

  /** Adds a latlong object to the parent object, and adds the geoloc object to the parent. */
  void createGeoloc (Object parent, String parentFieldName, GeolocLocation loc);

  /** 
   * Translate TimeSpans(PlanElements) in the role schedule into 
   * Vishnu intervals (see the link for more info). 
   * @see <a href="http://www.cougaar.org/projects/vishnu/fulldoc.html#predefined">Vishnu interval definition</a> 
   */
  void createRoleScheduleListField (Object object, String name, Asset asset);
  /** 
   * Translate TimeSpans(PlanElements) in the available schedule into 
   * Vishnu intervals (see the link for more info). 
   * @see <a href="http://www.cougaar.org/projects/vishnu/fulldoc.html#predefined">Vishnu interval definition</a> 
   */
  void createAvailableScheduleListField (Object object, String name, Asset asset);
}

