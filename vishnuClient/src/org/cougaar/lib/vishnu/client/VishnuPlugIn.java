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
package org.cougaar.lib.vishnu.client;

import org.cougaar.domain.glm.ldm.Constants;

import org.cougaar.lib.callback.UTILAssetCallback;
import org.cougaar.lib.callback.UTILAssetListener;
import org.cougaar.lib.filter.UTILBufferingPlugInAdapter;
import org.cougaar.lib.param.ParamException;
import org.cougaar.lib.util.UTILAllocate;
import org.cougaar.lib.util.UTILExpand;
import org.cougaar.lib.util.UTILPreference;
import org.cougaar.lib.util.UTILPrepPhrase;
import org.cougaar.lib.util.UTILRuntimeException;

import org.cougaar.domain.planning.ldm.asset.Asset;

import org.cougaar.domain.planning.ldm.plan.AllocationResultAggregator;
import org.cougaar.domain.planning.ldm.plan.Expansion;
import org.cougaar.domain.planning.ldm.plan.NewTask;
import org.cougaar.domain.planning.ldm.plan.PlanElement;
import org.cougaar.domain.planning.ldm.plan.PrepositionalPhrase;
import org.cougaar.domain.planning.ldm.plan.Role;
import org.cougaar.domain.planning.ldm.plan.Task;
import org.cougaar.domain.planning.ldm.plan.Workflow;

import org.cougaar.core.society.UniqueObject;

import org.cougaar.util.StringKey;
import org.cougaar.util.UnaryPredicate;
import org.cougaar.util.TimeSpan;

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
import java.util.Comparator;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;
import java.util.TreeSet;
import java.util.Vector;

import org.apache.xerces.dom.DocumentImpl;
import org.apache.xerces.parsers.DOMParser;
import org.apache.xerces.parsers.SAXParser;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import org.cougaar.lib.vishnu.server.Assignment;
import org.cougaar.lib.vishnu.server.Resource;
import org.cougaar.lib.vishnu.server.Scheduler;
import org.cougaar.lib.vishnu.server.SchedulingData;
import org.cougaar.lib.vishnu.server.MultitaskAssignment;
import org.cougaar.lib.vishnu.server.TimeOps;

import org.cougaar.lib.vishnu.client.VishnuComm;
import org.cougaar.lib.vishnu.client.VishnuDomUtil;

/**
 * <pre>
 * ALP-Vishnu bridge.
 *
 * Base class for interacting with the Vishnu scheduler.
 *
 * Abstract because it does not define :
 *  - createThreadCallback
 * each of which is defined in the allocator, aggregator, and expander 
 * subclasses.
 *
 * </pre>
 * <!--
 * (When printed, any longer line will wrap...)
 *345678901234567890123456789012345678901234567890123456789012345678901234567890
 *       1         2         3         4         5         6         7         8
 * -->
 */
public abstract class VishnuPlugIn 
  extends UTILBufferingPlugInAdapter 
  implements UTILAssetListener, DirectResultListener {

  //  private static final int INITIAL_INTERNAL_BUFFER_SIZE = 16384; //2097152; // 2 M
  
  /**
   * Here all the various runtime parameters get set.  See documentation for details.
   */
  public void localSetup() {     
    super.localSetup();

	String hostName;
	
    try {hostName = getMyParams().getStringParam("hostName");}    
    catch(Exception e) {hostName = "dante.bbn.com";}

    try {runInternal = 
		   getMyParams().getBooleanParam("runInternal");}    
    catch(Exception e) {runInternal = false;}

    try {runDirectly = 
		   getMyParams().getBooleanParam("runDirectly");}    
    catch(Exception e) {runDirectly = false;}

    try {incrementalScheduling = 
		   getMyParams().getBooleanParam("incrementalScheduling");}    
    catch(Exception e) {incrementalScheduling = false;}

    try {alwaysClearDatabase = 
		   getMyParams().getBooleanParam("alwaysClearDatabase");}    
    catch(Exception e) {alwaysClearDatabase = true;}

    // Don't clear database on each send if scheduling incrementally
    if (incrementalScheduling) alwaysClearDatabase = false;

    try {showTiming = 
		   getMyParams().getBooleanParam("showTiming");}    
    catch(Exception e) {  showTiming = true; }
	
	try {makeSetupAndWrapupTasks = 
		   getMyParams().getBooleanParam("makeSetupAndWrapupTasks");}    
	catch(Exception e) {makeSetupAndWrapupTasks = true;}

	try {useStoredFormat = getMyParams().getBooleanParam("useStoredFormat");}    
	catch(Exception e) {  useStoredFormat = false;	}

	try {stopOnFailure = 
		   getMyParams().getBooleanParam("stopOnFailure");}    
	catch(Exception e) {stopOnFailure = false;}

	// how many of the input tasks to use as templates when producing the 
	// OBJECT FORMAT for tasks
	try {firstTemplateTasks = getMyParams().getIntParam("firstTemplateTasks");}    
	catch(Exception e) {firstTemplateTasks = 2;}

	domUtil = createVishnuDomUtil ();
	comm    = createVishnuComm ();
	xmlProcessor = createXMLProcessor ();
	config  = createVishnuConfig ();

	// helpful for debugging connection configuration problems
	if (runInternal) {
	  if (runDirectly) {
		System.out.print (getName () + " - will run direct translation internal Vishnu Scheduler.");
		mode = createDirectMode ();
	  }
	  else {
		System.out.print (getName () + " - will run internal Vishnu Scheduler.");
		resultHandler = createXMLResultHandler ();
		mode = createInternalMode ();
	  }
	  if (incrementalScheduling)
		System.out.print (" - incrementally - ");
	}
	else {
	  System.out.print (getName () + " - will try to connect to Vishnu Web Server : " + 
						hostName + ".");
	  resultHandler = createXMLResultHandler ();
	  mode = createExternalMode ();
	}
	if (useStoredFormat)
	  System.out.println (" Will send stored object format.");
	else
	  System.out.println ("");
  }

  protected VishnuDomUtil createVishnuDomUtil () { 
	return new VishnuDomUtil (getMyParams(), getName(), getConfigFinder()); 
  }
  protected VishnuComm    createVishnuComm    () { 
	return new VishnuComm    (getMyParams(), getName(), getClusterName(), domUtil, runInternal); 
  }
  protected XMLProcessor  createXMLProcessor  () { 
	if (myExtraOutput)
	  System.out.println (getName () + ".createXMLProcessor - creating vanilla xml processor.");
	return new XMLProcessor (getMyParams(), getName(), getClusterName(), domUtil, comm, getConfigFinder()); 
  }

  public XMLizer getDataXMLizer () {
	return xmlProcessor.getDataXMLizer();
  }

  protected VishnuConfig createVishnuConfig () { 
	return new VishnuConfig  (getMyParams(), getName(), getClusterName()); 
  }

  protected SchedulerLifecycle createExternalMode () {
	return new ExternalMode (this, comm, xmlProcessor, domUtil, config, resultHandler, getMyParams ());
  }

  protected SchedulerLifecycle createInternalMode () {
	return new InternalMode (this, comm, xmlProcessor, domUtil, config, resultHandler, getMyParams ());
  }

  protected SchedulerLifecycle createDirectMode () {
	return new DirectMode (this, comm, xmlProcessor, domUtil, config, getMyParams ());
  }

  protected XMLResultHandler createXMLResultHandler () {
	return new XMLResultHandler (this, comm, xmlProcessor, domUtil, config, getMyParams ());
  }

  public boolean getRunDirectly () {
	return runDirectly;
  }

   /****************************************************************
	** Setup Filters...
	**/

   public void setupFilters () {
	 super.setupFilters ();

	 if (myExtraOutput)
	   System.out.println (getName () + " : Filtering for generic Assets...");

	 addFilter (myAssetCallback    = createAssetCallback    ());
   }

   /**
	* Is the task interesting to the plugin?  This is the inner-most part of <br> 
	* the predicate.                                                         <br>
	* By default, it ignores tasks produced from this plugin                 <br>                    
	* If you redefine this, it's good to call this using super.
	*
	* @param t - the task begin checked
	*/
   public boolean interestingTask (Task t) { 
	 PrepositionalPhrase pp = UTILPrepPhrase.getPrepNamed (t, "VISHNU"); 
	 if (pp != null && ((String) pp.getIndirectObject()).equals (getClassName(this)))
	   return false;
	 return true;
   }

   public void handleIllFormedTask (Task t) {}

   protected UTILAssetCallback getAssetCallback    () { return myAssetCallback; }

   /**
	* Standard Asset callback
	*
	* @see org.cougaar.lib.callback.UTILPhysicalAssetCallback
	* @see org.cougaar.lib.callback.UTILNotOrganizationCallback
	*/
   protected UTILAssetCallback createAssetCallback () { 
	 return new UTILAssetCallback  (this); 
   } 

   /**
	* <pre>
	* Implemented for UTILAssetListener
	*
	* OVERRIDE to see which assets you
	* think are interesting
	* </pre>
	* @param a asset to check for notification
	* @return boolean true if asset is interesting
	*/
   public boolean interestingAsset(Asset a) {
	 return true;
   }

   /**
	* <pre>
	* Place to handle new assets.
	*
	* Does nothing by default - reports new assets when myExtraOutput set.
	*
	* </pre>
	* @param newAssets new assets found in the container
	*/
   public void handleNewAssets(Enumeration newAssets) {
	 for (; newAssets.hasMoreElements (); ){
	   Object asset = newAssets.nextElement ();
	   myNewAssets.add (asset);
	 }
	 if (myExtraOutput)
	   System.out.println (getName () + ".handleNewAssets - got " + myNewAssets.size ());
   }

   /**
	* <pre>
	* Place to handle changed assets.
	*
	* Does nothing by default - reports changed assets when myExtraOutput set.
	*
	* </pre>
	* @param newAssets changed assets found in the container
	*/
   public void handleChangedAssets(Enumeration changedAssets) {
	 for (; changedAssets.hasMoreElements (); ){
	   Object asset = changedAssets.nextElement ();
	   myChangedAssets.add (asset);
	 }
	 if (myExtraOutput)
	   System.out.println (getName () + ".handleChangedAssets - got " + myChangedAssets.size () + 
						   " changed assets.");
   }

  public Collection getChangedAssets () {
	return myChangedAssets;
  }

  public void clearChangedAssets () {
	myChangedAssets.clear ();
  }
  
   /**
	* <pre>
	* Place to handle rescinded tasks.
	*
	* Sends XML to unfreeze the task assignment and delete it.
	*
	* </pre>
	* @param newAssets changed assets found in the container
	*/
   protected void handleRemovedTasks(Enumeration removedTasks) {
	 mode.handleRemovedTasks (removedTasks);
   }

   /**
	* <pre>
	* Deal with the tasks that we have accumulated.
	* 
	* Does, in order: 
	* 1) Sends the problem's object format, if it hasn't already been sent.
	* 2) Records tasks so can unfreeze them later.
	* 3) Sends the data (obtained from tasks and assets)
	* 4) Starts the scheduler
	* 5) Waits for a result
	* 
	* </pre>
	*
	* @param tasks the tasks to handle
	*/
   public void processTasks (List tasks) {
	 total += tasks.size();
	 System.out.println (getName () + ".processTasks - received " + 
						 tasks.size () + " tasks, " + total + " total so far.");

	 Date start = new Date();

	 mode.setupScheduler ();

	 if (useStoredFormat) {
	   // only generate the document once
	   if (objectFormatDoc == null)
		 objectFormatDoc = prepareStoredObjectFormat (tasks);
	   if (!sentFormatAlready) {
		 comm.serializeAndPostProblem (objectFormatDoc);
		 mode.initializeWithFormat ();
	   }
	 } else {
	   if (!sentFormatAlready)
		 prepareObjectFormat (tasks);
	 }
	   
	 sentFormatAlready = incrementalScheduling || !runInternal;

	 setUIDToObjectMap (tasks, myTaskUIDtoObject);

	 if (myExtraOutput)
	   System.out.println (getName () + ".processTasks - sending " + 
						   myTaskUIDtoObject.values ().size () + " tasks.");

	 int numTasks = myTaskUIDtoObject.values ().size ();
	 Date dataStart = new Date();

	 prepareData (tasks, objectFormatDoc);

	 if (showTiming) {
	   domUtil.reportTime (" - Vishnu completed data XML processing in ", dataStart);
	   domUtil.reportTime (" - Vishnu completed XML processing in ", start);
	 }

	 waitForAnswer ();

	 if (showTiming)
	   domUtil.reportTime (" - Vishnu did " + numTasks + " tasks in ", start);
   }


  protected void prepareObjectFormat (List tasks) {
	Date start = new Date();

	// The problem format, as opposed to the data, is not cleared on the <CLEARDATABASE>
	// call.  Hence, there is no need to resend the format even when not doing incremental
	// scheduling.  The only time the problem format needs to be resent is when running
	// internally.  
	if (myExtraOutput)
	  System.out.println (getName () + ".prepareObjectFormat - discovering object format introspectively.");

	List assetClassName = new ArrayList(); // just a way of returning a second return value from function
	Collection formatTemplates = config.getAssetTemplatesForTasks(tasks, assetClassName, getAllAssets());
	String singleAssetClassName = (String) assetClassName.get(0);

	formatTemplates.addAll (config.getTemplateTasks(tasks, firstTemplateTasks));

	if (myExtraOutput) {
	  System.out.println (getName () + ".processTasks - " + formatTemplates.size() + " unique assets : ");
	  for (Iterator iter = formatTemplates.iterator (); iter.hasNext(); )
		System.out.print ("\t" + iter.next().getClass ());
	  System.out.println ("");
	}

	Map myNameToDescrip = sendFormat (formatTemplates, singleAssetClassName);
	((ExternalMode)mode).setNameToDescrip (myNameToDescrip);
	((ExternalMode)mode).setSingleAssetClassName (singleAssetClassName);
	
	// only create data xmlizer once -- remembers references to globals throughout its lifetime
	xmlProcessor.createDataXMLizer (myNameToDescrip, singleAssetClassName);

	if (showTiming)
	  domUtil.reportTime (" - Vishnu completed format XML processing in ", start);
  }

   /** 
	* Like VishnuPlugIn.prepareObjectFormat                           <p>
	*
	* Send the file called <Cluster>.dff.xml as the default object format 
	* for the problem.                                                     <br>
	* Does NOT discover the object format from sampling the tasks.         <p>
	* 
	* This file can also be indicated by setting the parameter <code>defaultFormat</code>.
	*
	* @param ignoredTasks does NOT use the input tasks to discover format
	**/
   protected Document prepareStoredObjectFormat (List ignoredTasks) {
	 Date start = new Date();

	 Document formatDoc = null;

	 try {
	   xmlProcessor.createDataXMLizer (null, null);

	   String defaultFormat = config.getNeededFile ("defaultFormat", ".dff.xml");

	   if (myExtraOutput)
		 System.out.println (getName () + ".prepareStoredObjectFormat - sending format file " + defaultFormat);

	   DOMParser parser = new DOMParser ();
	   InputStream inputStream = getConfigFinder().open(defaultFormat);
	   parser.parse (new InputSource(inputStream));
	   formatDoc = parser.getDocument ();
	   Element formatDocRoot = formatDoc.getDocumentElement ();
	   formatDocRoot.setAttribute ("name", comm.getProblem());

	   attachAssociatedFiles (formatDoc); // attach vsh.xml, ga.xml, odf.xml files

	   if (showTiming)
		 domUtil.reportTime (" - Vishnu completed format XML processing in ", start);
	 } catch (Exception e) {
	   System.out.println (getName () + ".prepareStoredObjectFormat - ERROR with file " + e.getMessage());
	 }

	 return formatDoc;
   }

   /**
	* Tasks a list of tasks and object format document and sends the data to
	* the scheduler.  If incremental scheduling, appends assets to the 
	* list of data if they haven't been sent before.  Otherwise if not 
	* in incremental mode, always sends assets.<p>
	*
	* Handles direct mode and normal mode differently.  In direct mode,
	* calls prepareVishnuObjects to populate <tt>vishnuTasks</tt> and 
	* <tt>vishnuResources</tt> lists with Vishnu objects.  Also sends
	* header with the time window information, and any other data to scheduler
	* via the internal buffer. <p>
	*
	* @see #prepareVishnuObjects
	* @see #sendDataToVishnu
	* @param stuffToSend - initially the list of tasks to send to scheduler
	* @param objectFormatDoc - optional object format used by data xmlizers
	*  to determine types for fields when running directly
	*/
  protected void prepareData (List stuffToSend, Document objectFormatDoc) {
	Collection allAssets = getAllAssets();
	if (myExtraOutput)
	  System.out.println (getName () + ".prepareData - sending " + 
						  allAssets.size () + " assets.");

	stuffToSend.addAll (allAssets);

	setUIDToObjectMap (allAssets, myAssetUIDtoObject);

	if (myExtraExtraOutput) {
	  for (Iterator iter = stuffToSend.iterator (); iter.hasNext (); ) {
		Object obj = iter.next ();

		System.out.println (getName () + ".prepareData sending stuff " + 
							((UniqueObject) obj).getUID ());
	  }
	}

	// Send problem data to vishnu
	mode.prepareData (stuffToSend, objectFormatDoc);
  }

  protected void waitForAnswer () {
	mode.run ();

	handleImpossibleTasks (getTasks ());
	clearTasks ();
  }

  protected void setUIDToObjectMap (Collection objects, Map UIDtoObject) {
	for (Iterator iter = objects.iterator (); iter.hasNext ();) {
	  UniqueObject obj = (UniqueObject) iter.next ();
	  StringKey key = new StringKey (obj.getUID().toString());
	  if (!UIDtoObject.containsKey (key)) {
		UIDtoObject.put (key, obj);
		// System.out.println("setUIDToObjectMap: added " + key + " = " + obj + " to map");
	  }
	}
  }

  /**
   * If you're not in incremental mode, send all assets. <br>
   * Otherwise, only send those that have come in on the subscription add list.
   *
   * @return Collection of assets to send to Vishnu
   */
  protected Collection getAllAssets() {
	Collection collection = getAssetCallback().getSubscription ().getCollection();

	if (!incrementalScheduling)
	  return collection;
	else {
	  Set newAssetsCopy = new HashSet (myNewAssets);
	  myNewAssets.clear ();
	  return newAssetsCopy;
	}
  }

  /**
   * <pre>
   * send the dataformat section of the problem to the postdata
   * URL.
   *
   * This will define the structure of input tasks and resources,
   * as well as the scheduling specs and the ga parameters.
   *
   * Each of the items in the template collection will be translated
   * into an xml OBJECTFORMAT tag.
   *
   * </pre>
   * @param templates -- a collection of all the template resources 
   *                     and a template task.
   * @return map of the object types to their object descriptions
   */
  protected Map sendFormat (Collection templates, String assetClassName) {
	if (myExtraOutput)
	  System.out.println (getName () + ".sendFormat, resource " + assetClassName);
    Map nameInfo = null;
	Date start = new Date ();
	
	List returnedMap = new ArrayList();
	  
	Document problemFormatDoc = 
	  xmlProcessor.getFormatDocWithoutDuplicates (templates, assetClassName, returnedMap);
	nameInfo = (Map) returnedMap.get (0);

	if (showTiming)
	  domUtil.reportTime (" - Vishnu completed format XML transform in ", start);

	attachAssociatedFiles (problemFormatDoc);

	// send to postdata URL
	comm.serializeAndPostProblem (problemFormatDoc);

    return nameInfo;
  }

  /** 
   * - attach global object format file 
   * - attach specs file 
   * - attach ga parameters file 
   **/
  protected void attachAssociatedFiles (Document problemFormatDoc) {
	// append any global other data object formats 
	appendGlobalDataFormat (problemFormatDoc);

	// append the scheduling specs
	String specsFile = config.getSpecsFile();

	if (myExtraOutput)
	  System.out.println (getName () + ".sendFormat - appending " + 
						  specsFile + " vishnu specs xml file");

	domUtil.appendDoc (problemFormatDoc, specsFile);

      // append the ga specs
	specsFile = config.getGASpecsFile(); 

	if (myExtraOutput)
	  System.out.println (getName () + ".sendFormat - appending " + 
						  specsFile + " vishnu ga specs xml file");

	domUtil.appendDoc (problemFormatDoc, specsFile);
  }
  
  protected void appendGlobalDataFormat (Document problemFormatDoc) {
	String otherDataFormat = config.getOtherDataFormat();
	try {
	  if (getConfigFinder ().open (otherDataFormat) != null) {
		if (myExtraOutput)
		  System.out.println (getName () + ".sendFormat -  appending " + 
							  otherDataFormat + " other data format file");

		Element dataFormatNode = (Element)
		  problemFormatDoc.getElementsByTagName ("DATAFORMAT").item(0);
		
		domUtil.appendDoc (problemFormatDoc, dataFormatNode, otherDataFormat);
	  }
	} catch (FileNotFoundException fnf) {
	  if (myExtraOutput)
		System.out.println (getName () + 
							".appendGlobalDataFormat - could not find optional file : " + 
							otherDataFormat );
    } catch (Exception ioe) {
      System.out.println (getName() + ".appendGlobalDataFormat - Exception " + ioe.getMessage());
      ioe.printStackTrace ();
    }
  }
  
  /** 
   * Creates lists of Vishnu objects. <p>
   *
   * Does NOTHING by default.
   *
   * @param tasksAndResources - Cougaar tasks and resources to translate
   * @param vishnuTasks - list to add Vishnu tasks to 
   * @param vishnuResources - list to add Vishnu resources to 
   * @param objectFormat - contains field type info necessary to create fields on Vishnu objects
   * @param timeOps - time object used when making Vishnu dates
   */
  public void prepareVishnuObjects (List tasksAndResources, Collection changedAsssets,
									List vishnuTasks, List vishnuResources, List changedVishnuResources,
									Document objectFormat, TimeOps timeOps) { 
	System.err.println (getName ()+ ".prepareVishnuObjects - ERROR - don't run directly if you haven't defined this method.");
  }


  public int getNumTasks () {
	return myTaskUIDtoObject.size();
  }

  public void clearTasks () {
	myTaskUIDtoObject.clear();
  }

  public Task getTaskForKey (StringKey key) {
	return (Task)  myTaskUIDtoObject.get (key);
  }

  public void removeTask (StringKey key) {
	myTaskUIDtoObject.remove (key);
  }
  
  public Collection getTasks () {
	return myTaskUIDtoObject.values();
  }

  public int getNumAssets () {
	return myAssetUIDtoObject.size();
  }

  public Asset getAssetForKey (StringKey key) {
	return (Asset)  myAssetUIDtoObject.get (key);
  }

  /**
   * Given a collection of impossible tasks, make failed dispositions for each.
   *
   * @param impossibleTasks -- tasks that the scheduler couldn't figure out 
   *                           what to do with
   */
  protected void handleImpossibleTasks (Collection impossibleTasks) {
	if (!impossibleTasks.isEmpty ())
	  System.out.println (getName () + 
						  ".handleImpossibleTasks - failing " + 
						  impossibleTasks.size () + 
						  " tasks.");

	for (Iterator iter = impossibleTasks.iterator (); iter.hasNext ();) {
	  publishAdd (UTILAllocate.makeFailedDisposition (this, ldmf, 
													  (Task) iter.next ()));
	}

	if (stopOnFailure && !impossibleTasks.isEmpty()) {
	  System.out.println (getName() + ".handleImpossibleTasks - stopping on failure!");
	  System.exit (-1);
	}
  }

  /** 
   * define in subclass -- create an allocation 
   *
   * The parameters are what got returned from the vishnu scheduler.
   *
   * @param task  task that was assigned to asset
   * @param asset asset handling task
   * @param start of main task
   * @param end   of main task
   * @param setupStart start of setup task
   * @param wrapupEnd end of wrapup task
   */
  public void handleAssignment (Task task, Asset asset, 
								Date start, Date end, Date setupStart, Date wrapupEnd) {}

  /** 
   * define in subclass -- create an aggregation
   *
   * The parameters are what got returned from the vishnu scheduler.
   *
   * @param tasks  tasks to be aggregated together and assigned to asset
   * @param asset asset handling task
   * @param start of main task
   * @param end   of main task
   * @param setupStart start of setup task
   * @param wrapupEnd end of wrapup task
   */
  public void handleMultiAssignment (Vector tasks, Asset asset, 
									 Date start, Date end, Date setupStart, Date wrapupEnd) {}

  /** must use a special allocation result aggregator that does NOT include the transit (setup, wrapup) tasks
   * in it's time calculations.
   */
  protected AllocationResultAggregator skipTransitARA = new VishnuAllocationResultAggregator ();

  /**
   * Make expansion of mptask that attached between one and three subtasks <p>
   *
   * May attach setup and wrapup tasks, if there are specs defined for them and <br>
   * if the <code>makeSetupAndWrapupTasks</code> boolean parameter is set. <p>
   * 
   * The parameters are what got returned from the vishnu scheduler.
   * @param task  task that was assigned to asset
   * @param asset asset handling task
   * @param start of main task
   * @param end   of main task
   * @param setupStart start of setup task
   * @param wrapupEnd end of wrapup task
   */
  protected List makeSetupWrapupExpansion (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
    if (myExtraOutput)
	  System.out.println (getName () + ".makeSetupWrapupExpansion : " + 
			" assigning " + task.getUID() + 
			"\nto " + asset.getUID () +
			" from " + start + 
			" to " + end);

	if (setupStart.after (start))
	  System.err.println (getName () + ".makeSetupWrapupExpansion : ERROR, assigned setupStart - " + setupStart + " after start " + start + 
						  " for task " + task);
	if (start.after (end))
	  System.err.println (getName () + ".makeSetupWrapupExpansion : ERROR, assigned start - " + start + " after end " + end + 
						  " for task " + task);
	if (end.after (wrapupEnd))
	  System.err.println (getName () + ".makeSetupWrapupExpansion : ERROR, assigned end - " + end + " after wrapupEnd " + wrapupEnd + 
						  " for task " + task);
	  
    boolean wantConfidence = false;
    
	// if true, the estimated alloc result has a medium confidence 
    try { wantConfidence = getMyParams().getBooleanParam ("wantMediumConfidenceOnExpansion"); }
    catch (Exception e) {}

	Vector subtasks = new Vector ();
	
	subtasks.add (createMainTask (task, asset, start, end, setupStart, wrapupEnd));

	if (makeSetupAndWrapupTasks) {
	  if (setupStart.getTime() < start.getTime()) {
		if (myExtraOutput)
		  System.out.println (getName () + ".makeSetupWrapupExpansion : making setup task for " + task.getUID());
		subtasks.add (createSetupTask (task, asset, start, end, setupStart, wrapupEnd));
	  }

	  if (wrapupEnd.getTime() > end.getTime()) {
		if (myExtraOutput)
		  System.out.println (getName () + ".makeSetupWrapupExpansion : making wrapup task for " + task.getUID());
		subtasks.add (createWrapupTask (task, asset, start, end, setupStart, wrapupEnd));
	  }
	}

    publishSubtasks (wantConfidence, task, subtasks);
	
	return subtasks;
  }

  /** 
   * <pre>
   * create first and possibly only subtask of MPTask
   * 
   * Time preferences have 
   *  1) the start time = earliest arrival = start of main task
   *  2) the best arrival time = latest arrival = end of main task
   *
   * Attaches WITH prep that shows which asset was used
   *
   * </pre>
   **/
  protected Task createMainTask (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
	NewTask mainTask = (NewTask) UTILExpand.makeSubTask (ldmf, task, task.getDirectObject(), task.getSource());
	mainTask.setPrepositionalPhrases (getPrepPhrases (task, asset).elements());
	mainTask.setPreferences (getPreferences (task, start, start, end, end).elements());
	if (myExtraOutput) System.out.println (getName () + ".createMainTask : made main task : " + mainTask.getUID());
	return mainTask;
  }

  /** 
   * <pre>
   * create setup task that goes before main subtask
   * 
   * Time preferences have 
   *  1) the start time = earliest arrival = setup start
   *  2) the best arrival time = latest arrival = start of main task
   *
   * Attaches WITH prep that shows which asset was used
   *
   * </pre>
   **/
  protected Task createSetupTask (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
	NewTask setupTask = (NewTask) UTILExpand.makeSubTask (ldmf, task, task.getDirectObject(), task.getSource());
	setupTask.setVerb (Constants.Verb.Transit);
	setupTask.setPrepositionalPhrases (getPrepPhrases (task, asset).elements());
	setupTask.setPreferences (getPreferences (task, setupStart, setupStart, start, start).elements());
	if (myExtraOutput) System.out.println (getName () + ".createSetupTask : made setup task : " + setupTask.getUID());
	return setupTask;
  }

  /** 
   * <pre>
   * create wrapup task that goes after main subtask
   * 
   * Time preferences have 
   *  1) the start time = earliest arrival = end of main task
   *  2) the best arrival time = latest arrival = end of wrapup
   *
   * Attaches WITH prep that shows which asset was used
   *
   * </pre>
   **/
  protected Task createWrapupTask (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
	NewTask wrapupTask = (NewTask) UTILExpand.makeSubTask (ldmf, task, task.getDirectObject(), task.getSource());
	wrapupTask.setVerb (Constants.Verb.Transit);
	wrapupTask.setPrepositionalPhrases (getPrepPhrases (task, asset).elements());
	wrapupTask.setPreferences (getPreferences(task, end, end, wrapupEnd, wrapupEnd).elements());
	if (myExtraOutput) System.out.println (getName () + ".createWrapupTask : made wrapup task : " + wrapupTask.getUID());
	return wrapupTask;
  }

  /**
   * Adjust preferences so that the start time preference is the assigned 
   * start time, and the end time preference has a best date that is the 
   * assigned end time.  The early and late dates of the end time preference
   * are the same as the first parent task. (This isn't very important, as the
   * downstream allocator should just allocate to the start and best times.)
   * 
   * @param a - the asset associated with the MPTask
   * @param g - parent task list
   * @param start - the date for the START_TIME preference
   * @param end - the best date for the END_TIME preference
   * @return Vector - list of preferences for the MPTask
   */
  protected Vector getPreferences (Task parentTask, Date readyAt, Date earliest, Date best, Date latest) { 
    Vector prefs = UTILAllocate.enumToVector(parentTask.getPreferences());
	prefs = UTILPreference.replacePreference (prefs, UTILPreference.makeStartDatePreference (ldmf, readyAt));
	prefs = UTILPreference.replacePreference (prefs, 
											  UTILPreference.makeEndDatePreference (ldmf, 
																					earliest,
																					best,
																					latest));
	return prefs;
  }

  /** 
   * This method Expands the given Task.
   * @param t the task to be expanded.
   * @param subtasks the expanded subtasks
   */

  public void publishSubtasks (boolean wantConfidence, Task t, List subtasks) {
    if (myExtraOutput){
      System.out.println(getName() + ".handleTask: Subtask(s) created for task :" + 
						 t.getUID());
    }

    Workflow wf = UTILExpand.makeWorkflow (ldmf, subtasks, skipTransitARA, t);

    Expansion exp = null;
    if(wantConfidence){
      exp = UTILExpand.makeExpansionWithConfidence (ldmf, wf);
    }
    else{
      exp = UTILExpand.makeExpansion (ldmf, wf);
    }

    if (myExtraOutput){
      System.out.println(getName () + ".handleTask: Expansion created. (" +
			 exp.getUID() + ")");
    }
    
    for (Iterator i = subtasks.iterator (); i.hasNext ();) {
      publishAdd (i.next());
    }
    publishAdd(exp);

    if (myExtraOutput){
      System.out.println(getName() + ".handleTask: Expansion published. Workflow has " + 
						 UTILAllocate.enumToList(exp.getWorkflow ().getTasks()).size () + " subtasks." );
    }

  }

  /**
   * <pre>
   * Defines how the task holds the asset for the task->asset association.
   *
   * Critical, because the allocator downstream will probably look for this prep and
   * pluck the asset off to make the allocation or use it in some way.
   *
   * </pre>
   * @param a - asset to attach to task
   * @param g - parent tasks
   * @return the original set of prep phrases from the first parent task PLUS the WITH
   *         prep with the asset
   */
  protected Vector getPrepPhrases(Task parentTask, Asset a) {
    Vector preps = new Vector (UTILAllocate.enumToVector(parentTask.getPrepositionalPhrases()));
	if (!UTILPrepPhrase.hasPrepNamed (parentTask, Constants.Preposition.WITH))
	  preps.addElement(UTILPrepPhrase.makePrepositionalPhrase(ldmf, 
															  Constants.Preposition.WITH, 
															  a));

    preps.addElement(UTILPrepPhrase.makePrepositionalPhrase(ldmf, 
															"VISHNU", getClassName(this)));
	return preps;
  }

  protected int total = 0;
  protected boolean runInternal = true;
  protected boolean incrementalScheduling = false;

  protected UTILAssetCallback myAssetCallback;
  protected int firstTemplateTasks;
  protected boolean sentFormatAlready = false;

  protected Map myTaskUIDtoObject = new HashMap ();
  protected Map myAssetUIDtoObject = new HashMap ();

  protected boolean alwaysClearDatabase = false;
  protected boolean showTiming = true;

  protected boolean makeSetupAndWrapupTasks = true;
  protected boolean useStoredFormat = false;
  protected boolean stopOnFailure = false;
  protected boolean runDirectly = false;

  protected Document objectFormatDoc;
  protected Set myNewAssets = new HashSet ();
  protected Set myChangedAssets = new HashSet ();

  // helper objects
  protected VishnuComm comm;
  protected VishnuDomUtil domUtil;
  protected XMLProcessor xmlProcessor;
  protected VishnuConfig config;

  protected SchedulerLifecycle mode;
  protected XMLResultHandler resultHandler;
}


