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

import org.cougaar.domain.glm.ldm.asset.GLMAsset;
import org.cougaar.domain.planning.ldm.asset.Asset;

import org.cougaar.lib.util.UTILAllocate;

import org.cougaar.lib.vishnu.client.VishnuAggregatorPlugIn;
import org.cougaar.lib.vishnu.client.XMLizer;
import org.cougaar.lib.vishnu.client.XMLProcessor;
import org.cougaar.lib.vishnu.server.TimeOps;

import org.w3c.dom.Document;

/**
 * Uses CustomDataXMLize to create Vishnu objects either directly or through XML. <p>
 *
 * Data translation process left to the writer of XMLizer created in <tt>createXMLizer</tt>.
 *
 */
public class CustomVishnuAggregatorPlugIn extends VishnuAggregatorPlugIn {

  /** 
   * Overrides VishnuPlugIn.createXMLProcessor                           <p>
   *
   * Use a different data xmlizer to create the data xml stream to send to vishnu,<br>
   * specifically, TranscomDataXMLize.
   * 
   * @see org.cougaar.pkg.glmtrans.plugins.TranscomDataXMLize#createDoc
   */
  protected XMLProcessor createXMLProcessor  () { 
    if (myExtraOutput)
      System.out.println (getName () + ".createXMLProcessor - creating TRANSCOM xml processor.");

	return new XMLProcessor (getMyParams(), getName(), getClusterName(), domUtil, comm, getConfigFinder()) {
		public void createDataXMLizer (Map nameToDescrip, String assetClassName) {
		  if (getExtraOutput())
			System.out.println (this.getName() + ".createDataXMLizer - setting data xmlizer.");
		  
		  setDataXMLizer(createXMLizer(getRunDirectly()));
		}
	  }; 
  }

  /** override to use a different XMLizer */
  protected XMLizer createXMLizer (boolean direct) {
	return new CustomDataXMLize (direct);
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
  protected void prepareVishnuObjects (List alpObjects, Collection changed, 
									   List vishnuTasks, List vishnuResources, 
									   List changedVishnuResources,
									   Document formatDoc, TimeOps timeOps) { 
	DirectTranslator dt = (DirectTranslator) getDataXMLizer ();
	((CustomDataXMLize) dt).setFormatDoc (formatDoc, timeOps);
	dt.createVishnuObjects (alpObjects, changed, vishnuTasks, vishnuResources, changedVishnuResources);
  }
}
