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

import org.cougaar.domain.glm.ldm.plan.GeolocLocation;

import org.cougaar.domain.planning.ldm.asset.Asset;
import java.util.Date;

/**
 * Defines interface for a data helper that can either produce XML or
 * Vishnu objects.  The interface is neutral to either.
 */
public interface DataHelper {
  Object createObject (Object parent, String type);
  Object createField (Object parent, String parentType, String name);
  void createField (Object parent, String parentType, String name, String value);
  void createDateField    (Object parent, String name, Date date);
  void createBooleanField (Object parent, String name, boolean val);
  void createFloatField   (Object parent, String name, float val);
  void createGeoloc (Object parent, String parentFieldName, GeolocLocation loc);
  void createRoleScheduleListField (Object object, String name, Asset asset);
}

