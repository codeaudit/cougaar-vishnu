/*
 * <copyright>
 *  
 *  Copyright 2003-2004 BBNT Solutions, LLC
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
package org.cougaar.lib.vishnu.client;

import org.cougaar.lib.param.ParamMap;
import org.cougaar.util.log.Logger;
import org.w3c.dom.Document;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

/** 
 * External mode.  
 * <p>
 * Talks to a web server to orchestrate scheduling.
 */
public class ExternalMode extends PluginHelper implements SchedulerLifecycle {
  public ExternalMode (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
		       VishnuDomUtil domUtil, VishnuConfig config, ResultHandler resultHandler, 
		       ParamMap myParamTable, Logger logger) {
    super (parent, comm, xmlProcessor, domUtil, config, myParamTable, logger);
    this.resultHandler = resultHandler;
    localSetup ();
  }

  /** sets local parameters */
  protected void localSetup () {
    super.localSetup ();

    try {sendDataChunkSize = getMyParams().getIntParam("sendDataChunkSize");}    
    catch(Exception e) {sendDataChunkSize = 100;}

    try {alwaysClearDatabase = 
	   getMyParams().getBooleanParam("alwaysClearDatabase");}    
    catch(Exception e) {alwaysClearDatabase = true;}

    try {incrementalScheduling = 
	   getMyParams().getBooleanParam("incrementalScheduling");}    
    catch(Exception e) {incrementalScheduling = false;}

    // Don't clear database on each send if scheduling incrementally
    if (incrementalScheduling) alwaysClearDatabase = false;
  }

  /** 
   * Implemented for SchedulerLifecycle -- already done in VishnuPlugin.prepareObjectFormat 
   * so does nothing.
   * 
   * @see VishnuPlugin#prepareObjectFormat
   */
  public void initializeWithFormat () {}

  /** just calls sendDataToVishnu */
  public void prepareData (List stuffToSend, Document objectFormatDoc) {
    sendDataToVishnu (stuffToSend, 
		      myNameToDescrip, 
		      alwaysClearDatabase,
		      false, // send assets as NEWOBJECTS
		      singleAssetClassName);
  }

  /**
   * Send the data section of the problem to the postdata URL.<p>
   *
   * Chunks data into <code>sendDataChunkSize</code> chunks of tasks.<p>
   *
   * Handles sending changed objects.
   *
   * @param tasks -- a collection of all the tasks and resources 
   * @param nameToDescrip - Maping of names to newnames on fields, objects
   * @param clearDatabase - send clear database command to Vishnu
   * @param sendingChangedObjects -- controls whether assets will be sent
   *                                 inside of <CHANGEDOBJECT> tags
   */
  protected void sendDataToVishnu (List tasks, 
				   Map nameToDescrip, 
				   boolean clearDatabase, 
				   boolean sendingChangedObjects,
				   String assetClassName) {
    int totalSent  = 0;

    XMLizer dataXMLizer = xmlProcessor.getDataXMLizer ();
	
    if (logger.isInfoEnabled()) 
      logger.info (getName () + ".sendDataToVishnu - Num tasks/assets before adding changed " + tasks.size ());
    tasks.addAll (parent.getChangedAssets());
    if (logger.isInfoEnabled()) 
      logger.info (getName () + ".sendDataToVishnu - Num tasks/assets after adding changed  " + tasks.size ());
    int totalTasks = tasks.size ();
	
    while (totalSent < totalTasks) {
      int toIndex = totalSent+sendDataChunkSize;
      if (toIndex > totalTasks)
	toIndex = totalTasks;
	  
      Collection chunk = new ArrayList (tasks.subList (totalSent, toIndex));

      if (logger.isInfoEnabled())
	logger.info (getName () + ".sendDataToVishnu, from " + totalSent + " to " + toIndex);
	  
      Document docToSend = 
	xmlProcessor.prepareDocument (chunk, parent.getChangedAssets(), dataXMLizer, clearDatabase, sendingChangedObjects, assetClassName);

      serializeAndPostDoc (docToSend);

      if (clearDatabase) clearDatabase = false; // flip bit after first one
      totalSent += sendDataChunkSize;
    }
    parent.clearChangedAssets ();

    sendOtherData ();
  }

  /** ask VishnuComm to serialize and post the data 
   * @see org.cougaar.lib.vishnu.client.VishnuComm#serializeAndPostData
   */
  protected void serializeAndPostDoc (Document doc) {
    comm.serializeAndPostData (doc);
  }
  
  /** 
   * Send other data, if it hasn't already been sent 
   * @see org.cougaar.lib.vishnu.client.VishnuComm#serializeAndPostData
   */
  protected void sendOtherData () {
    if (!sentOtherDataAlready && xmlProcessor.otherDataFileExists(config.getOtherData()))
      comm.serializeAndPostData (xmlProcessor.getOtherDataDoc (config.getOtherData ()));

    if (incrementalScheduling)
      sentOtherDataAlready = true;
  }
  
  /** scheduler is created as a separate process by whoever sets up Vishnu system */
  public void setupScheduler () {}
  
  /**
   * Place to handle rescinded tasks.
   *
   * Sends XML to unfreeze the task assignment and delete it.
   * @param removedTasks changed assets found in the container
   */
  public void handleRemovedTasks(Enumeration removedTasks) {
    if (incrementalScheduling) {
      Document docToSend = xmlProcessor.prepareRescind(removedTasks, parent.getTaskName());
      comm.serializeAndPostData (docToSend);
    }
  }

  public void unfreezeTasks(Collection tasks) {
    if (incrementalScheduling) {
      Document docToSend = xmlProcessor.prepareUnfreeze(tasks);
      comm.serializeAndPostData (docToSend);
    }
  }

  public Collection getTaskKeys () { 
    logger.error ("ExternalMode.getTaskKeys - not implemented.");
    return null; 
  } 

  /** 
   * Run externally.  
   * <p>
   * Trigger the start of scheduling and wait until it's finished.  
   * @see #waitTillFinished
   */
  public void run () {
    comm.startScheduling ();

    if (!waitTillFinished ())
      showTimedOutMessage ();
  }

  /** wait until the scheduler is done.  Parse the answer if there was one. */
  protected boolean waitTillFinished () {
    Date start = new Date();
	
    boolean gotAnswer = comm.waitTillFinished ();

    if (!alwaysClearDatabase) {
      comm.serializeAndPostData (xmlProcessor.prepareFreezeAll ());
    }

    if (showTiming)
      domUtil.reportTime (" - Vishnu received answer, was waiting for ", start);

    if (gotAnswer)
      ((XMLResultHandler)resultHandler).parseAnswer();

    return gotAnswer;
  }

  /** timed out waiting for scheduler to do its job */
  private void showTimedOutMessage () {
    logger.error (getName () + ".processTasks -- ERROR -- " + 
		  "Timed out waiting for scheduler to finish.\n" +
		  "Is there a scheduler running?\n" + 
		  "See vishnu/scripts/runScheduler in the vishnu distribution.\n" +
		  "It's good to set the machines property to include only\n" + 
		  "those machines you are running from, or else the scheduler\n" +
		  "could process any job posted by anyone to the web server.\n" +
		  "For more information, contact gvidaver@bbn.com or dmontana@bbn.com");
  }

  /** used by sendDataToVishnu */
  public void setNameToDescrip (Map map) {
    myNameToDescrip = map;
  }

  /** used by sendDataToVishnu */
  public void setSingleAssetClassName (String name) {
    singleAssetClassName = name;
  }

  /** name of this object */
  protected String getName () { return "ExternalMode"; }
  
  /** queries the scheduler to get a full specification of the problem
   *   (including specs, logic, gaspecs, objects, assignments, etc)
   *
   * placeholder in external mode (for now)
   */
  public String dumpToXML() {
      return "";
  }

  Map myNameToDescrip;
  String singleAssetClassName;
  boolean alwaysClearDatabase;
  protected int sendDataChunkSize;
  ResultHandler resultHandler;
  protected boolean incrementalScheduling;
  protected boolean sentOtherDataAlready = false;
}
