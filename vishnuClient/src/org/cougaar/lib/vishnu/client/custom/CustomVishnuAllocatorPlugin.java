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

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.cougaar.glm.ldm.asset.GLMAsset;
import org.cougaar.planning.ldm.asset.Asset;

import org.cougaar.lib.vishnu.client.VishnuAllocatorPlugin;
import org.cougaar.lib.vishnu.client.XMLizer;
import org.cougaar.lib.vishnu.client.XMLProcessor;
import com.bbn.vishnu.scheduling.SchedulingData;

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
   * @param schedData - scheduling data object used when making Vishnu dates
   */
  public void prepareVishnuObjects (List alpObjects, Collection changed, 
				    List vishnuTasks, List vishnuResources, 
				    List changedVishnuResources,
				    Document formatDoc, SchedulingData schedData) { 
    DirectTranslator dt = (DirectTranslator) getDataXMLizer ();
    ((CustomDataXMLize) dt).setFormatDoc (formatDoc, schedData);
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
