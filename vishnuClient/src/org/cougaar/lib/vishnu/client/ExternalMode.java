package org.cougaar.lib.vishnu.client;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.StringReader;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.xerces.dom.DocumentImpl;
import org.apache.xerces.parsers.DOMParser;
import org.apache.xerces.parsers.SAXParser;

import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.lib.param.ParamMap;
import org.cougaar.lib.vishnu.server.Scheduler;
import org.cougaar.util.StringKey;

import org.w3c.dom.Document;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/** 
 * External mode.  
 * <p>
 * Talks to a web server to orchestrate scheduling.
 */
public class ExternalMode extends PluginHelper implements SchedulerLifecycle {
  public ExternalMode (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
					   VishnuDomUtil domUtil, VishnuConfig config, ResultHandler resultHandler, 
					   ParamMap myParamTable) {
	super (parent, comm, xmlProcessor, domUtil, config, myParamTable);
	this.resultHandler = resultHandler;
	localSetup ();
  }

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
   * </pre>
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
	
	if (myExtraOutput) 
	  System.out.println (getName () + ".sendDataToVishnu - Num tasks/assets before adding changed " + tasks.size ());
	tasks.addAll (parent.getChangedAssets());
	if (myExtraOutput) 
	  System.out.println (getName () + ".sendDataToVishnu - Num tasks/assets after adding changed  " + tasks.size ());
	int totalTasks = tasks.size ();
	
	while (totalSent < totalTasks) {
	  int toIndex = totalSent+sendDataChunkSize;
	  if (toIndex > totalTasks)
		toIndex = totalTasks;
	  
	  Collection chunk = new ArrayList (tasks.subList (totalSent, toIndex));

	  if (myExtraOutput)
		System.out.println (getName () + ".sendDataToVishnu, from " + totalSent + " to " + toIndex);
	  
	  Document docToSend = 
		xmlProcessor.prepareDocument (chunk, parent.getChangedAssets(), dataXMLizer, clearDatabase, sendingChangedObjects, assetClassName);

	  serializeAndPostDoc (docToSend);

	  if (clearDatabase) clearDatabase = false; // flip bit after first one
	  totalSent += sendDataChunkSize;
	}
	parent.clearChangedAssets ();

	sendOtherData ();
  }

  protected void serializeAndPostDoc (Document doc) {
	comm.serializeAndPostData (doc);
  }
  
  /** send other data, if it hasn't already been sent */
  protected void sendOtherData () {
	if (!sentOtherDataAlready && xmlProcessor.otherDataFileExists(config.getOtherData()))
	  comm.serializeAndPostData (xmlProcessor.getOtherDataDoc (config.getOtherData ()));

	if (incrementalScheduling)
	  sentOtherDataAlready = true;
  }
  
  /** scheduler is created as a separate process by whoever sets up Vishnu system */
  public void setupScheduler () {}
  
  /**
	* <pre>
	* Place to handle rescinded tasks.
	*
	* Sends XML to unfreeze the task assignment and delete it.
	*
	* </pre>
	* @param newAssets changed assets found in the container
	*/
  public void handleRemovedTasks(Enumeration removedTasks) {
	if (incrementalScheduling) {
	  Document docToSend = xmlProcessor.prepareRescind(removedTasks);
	  comm.serializeAndPostData (docToSend);
	}
  }

   /** 
	* Run externally.  
	* <p>
	* Trigger the start of scheduling and wait until it's finished.  
	* @see @waitTillFinished
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
	System.out.println (getName () + ".processTasks -- ERROR -- " + 
						"Timed out waiting for scheduler to finish.\n" +
						"Is there a scheduler running?\n" + 
						"See vishnu/scripts/runScheduler in the vishnu distribution.\n" +
						"It's good to set the machines property to include only\n" + 
						"those machines you are running from, or else the scheduler\n" +
						"could process any job posted by anyone to the web server.\n" +
						"For more information, contact gvidaver@bbn.com or dmontana@bbn.com");
  }

  public void setNameToDescrip (Map map) {
	myNameToDescrip = map;
  }

  public void setSingleAssetClassName (String name) {
	singleAssetClassName = name;
  }

  protected String getName () { return "ExternalMode"; }
  
  Map myNameToDescrip;
  String singleAssetClassName;
  boolean alwaysClearDatabase;
  protected int sendDataChunkSize;
  ResultHandler resultHandler;
  boolean incrementalScheduling;
  protected boolean sentOtherDataAlready = false;
}
