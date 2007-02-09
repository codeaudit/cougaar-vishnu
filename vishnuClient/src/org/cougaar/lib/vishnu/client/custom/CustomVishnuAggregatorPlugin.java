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

import com.bbn.vishnu.scheduling.SchedulingData;
import org.cougaar.lib.vishnu.client.VishnuAggregatorPlugin;
import org.cougaar.lib.vishnu.client.XMLProcessor;
import org.cougaar.lib.vishnu.client.XMLizer;
import org.w3c.dom.Document;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Uses CustomDataXMLize to create Vishnu objects either directly or through XML. <p>
 *
 * Data translation process left to the writer of XMLizer created in <tt>createXMLizer</tt>.
 *
 */
public class CustomVishnuAggregatorPlugin extends VishnuAggregatorPlugin {

  /** 
   * Overrides VishnuPlugin.createXMLProcessor                           <p>
   *
   * Use a different data xmlizer to create the data xml stream to send to vishnu,<br>
   * specifically, TranscomDataXMLize.
   * 
   */
  protected XMLProcessor createXMLProcessor  () { 
    if (isDebugEnabled())
      debug (getName () + ".createXMLProcessor - creating TRANSCOM xml processor.");

    return new XMLProcessor (getMyParams(), getName(), getClusterName(), domUtil, comm, getConfigFinder(), logger, logger, logger) {
	public void createDataXMLizer (Map nameToDescrip, String assetClassName) {
	  if (isDebugEnabled())
	    debug (this.getName() + ".createDataXMLizer - setting data xmlizer.");
		  
	  setDataXMLizer(createXMLizer(getRunDirectly()));
	}
      }; 
  }

  /** override to use a different XMLizer */
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
				    Document formatDoc, SchedulingData schedData) { 
    DirectTranslator dt = (DirectTranslator) getDataXMLizer ();
    ((CustomDataXMLize) dt).setFormatDoc (formatDoc, schedData);
    dt.createVishnuObjects (alpObjects, changed, vishnuTasks, vishnuResources, changedVishnuResources);
  }
}
