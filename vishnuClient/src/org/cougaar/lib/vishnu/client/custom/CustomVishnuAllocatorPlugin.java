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

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.cougaar.glm.ldm.asset.GLMAsset;
import org.cougaar.planning.ldm.asset.Asset;

import org.cougaar.lib.vishnu.client.VishnuAllocatorPlugin;
import org.cougaar.lib.vishnu.client.XMLizer;
import org.cougaar.lib.vishnu.client.XMLProcessor;
import org.cougaar.lib.vishnu.server.TimeOps;

import org.w3c.dom.Document;

/**
 * Uses CustomDataXMLize to create Vishnu objects either directly or through XML.
 */
public class CustomVishnuAllocatorPlugin extends VishnuAllocatorPlugin {

  /** 
   * Overrides VishnuPlugin.createXMLProcessor                           <p>
   *
   * Use a different data xmlizer to create the data xml stream to send to vishnu,<br>
   * specifically, TranscomDataXMLize.
   * 
   */
  protected XMLProcessor createXMLProcessor  () { 
    if (isInfoEnabled())
      debug (getName () + ".createXMLProcessor - creating TRANSCOM xml processor.");

    return new XMLProcessor (getMyParams(), getName(), getClusterName(), domUtil, comm, getConfigFinder(), logger, logger, logger) {
	public void createDataXMLizer (Map nameToDescrip, String assetClassName) {
	  if (isInfoEnabled())
	    info (this.getName() + ".createDataXMLizer - setting data xmlizer.");
		  
	  setDataXMLizer(createXMLizer(getRunDirectly()));
	}
      }; 
  }

  /** 
   * Create a CustomDataXMLize XMLizer 
   * @see CustomDataXMLize
   */
  protected XMLizer createXMLizer (boolean direct) {
    return new CustomDataXMLize (direct, logger);
  }

  /** 
   * Creates lists of Vishnu objects.  
   *
   * @param tasksAndResources - Cougaar tasks and resources to translate
   * @param vishnuTasks - list to add Vishnu tasks to 
   * @param vishnuResources - list to add Vishnu resources to 
   * @param objectFormat - contains field type info necessary to create fields on Vishnu objects
   * @param timeOps - time object used when making Vishnu dates
   */
  public void prepareVishnuObjects (List alpObjects, Collection changed, 
				    List vishnuTasks, List vishnuResources, 
				    List changedVishnuResources,
				    Document formatDoc, TimeOps timeOps) { 
    DirectTranslator dt = (DirectTranslator) getDataXMLizer ();
    ((CustomDataXMLize) dt).setFormatDoc (formatDoc, timeOps);
    dt.createVishnuObjects (alpObjects, changed, vishnuTasks, vishnuResources, changedVishnuResources);
  }

  /** 
   * Highest confidence if physical asset, medium confidence if an organization.<p>
   * 
   * Used by handleAssignment to figure out confidence of allocation. <p>
   *
   * @see org.cougaar.lib.vishnu.client.VishnuAllocatorPlugin#handleAssignment
   * @param asset to test whether physical asset -- its doing the work in the allocation
   */
  protected double getConfidence (Asset asset) {
    return ((GLMAsset) asset).hasPhysicalPG () ? 
      allocHelper.HIGHEST_CONFIDENCE : allocHelper.MEDIUM_CONFIDENCE;
  }
}
