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
package org.cougaar.lib.vishnu.client;

import java.io.FileNotFoundException;
import java.io.InputStream;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import org.apache.xerces.parsers.DOMParser;

import org.cougaar.core.util.UniqueObject;

import org.cougaar.glm.ldm.Constants;

import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.AllocationResultAggregator;
import org.cougaar.planning.ldm.plan.Expansion;
import org.cougaar.planning.ldm.plan.NewTask;
import org.cougaar.planning.ldm.plan.PlanElement;
import org.cougaar.planning.ldm.plan.PrepositionalPhrase;
import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.plan.Workflow;

import org.cougaar.lib.callback.UTILAssetCallback;
import org.cougaar.lib.callback.UTILAssetListener;
import org.cougaar.lib.filter.UTILBufferingPluginAdapter;
import org.cougaar.lib.util.*;
import com.bbn.vishnu.scheduling.Scheduler;
import com.bbn.vishnu.scheduling.SchedulingData;

import org.cougaar.util.StringKey;
import org.cougaar.util.UnaryPredicate;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import org.xml.sax.InputSource;

/**
 * <pre>
 * ALP-Vishnu bridge.
 *
 * Base class for interacting with the Vishnu scheduler.
 *
 * There are 3 main dimensions of behavior for this plugin: 
 *  - SchedulerMode (External, Internal, or Direct)         
 *  - Job type      (Batch or Incremental)                  
 *  - Translation   (Automatic or Custom)                   
 *
 * Supports three main scheduler modes : External, Internal, and Direct.  These
 * are classes which implement the SchedulerLifecycle interface.  They
 * orchestrate the steps to use the Vishnu Scheduler.  The VishnuPlugin
 * is a ModeListener and its as a mode listener that the modes communicate
 * with the plugin.
 * 
 * 
 * <b>External</b> mode uses the web server and expects the scheduling to be 
 * done by a separate Vishnu Scheduler process.  All communication is done with 
 * XML.
 * <b>Internal</b> mode uses an internal Vishnu Scheduler process, but 
 * communicates exclusively through XML.
 * <b>Direct</b> mode extends internal mode, but directly translates between
 * Cougaar objects and Vishnu scheduling objects.
 *
 * The results of a scheduling job are handled by a ResultHandler, which
 * can be either an XMLResultHandler, or a DirectResultHandler. Each mode is a
 * ResultListener and communicates with its result handler.
 *
 * Orthogonal to the scheduling modes, the scheduling jobs can be either 
 * batch or incremental.  Batch starts from scratch every time, but 
 * incremental mode maintains scheduler state from previous batches.
 *
 * Further, XML translation can either be automatic or custom.  Automatic
 * mode uses introspection to determine the object format of the problem,
 * whereas custom forces the developer to define it and participate in 
 * the translation process.
 *
 * Abstract because it does not define :
 *  - createThreadCallback
 * each of which is defined in the allocator, aggregator, and expander 
 * subclasses.
 *
 * </pre>
 *
 * @see org.cougaar.lib.filter.UTILBufferingPluginAdapter#createThreadCallback
 * @see org.cougaar.lib.vishnu.client.VishnuAggregatorPlugin#createThreadCallback
 * @see org.cougaar.lib.vishnu.client.VishnuAllocatorPlugin#createThreadCallback
 * @see org.cougaar.lib.vishnu.client.VishnuExpanderPlugin#createThreadCallback
 *
 * <!--
 * (When printed, any longer line will wrap...)
 *345678901234567890123456789012345678901234567890123456789012345678901234567890
 *       1         2         3         4         5         6         7         8
 * -->
 */
public abstract class VishnuPlugin 
  extends UTILBufferingPluginAdapter 
  implements UTILAssetListener, DirectModeListener, ResultListener {

  /**
   * Here all the various runtime parameters get set.  See documentation for details.
   */
  public void localSetup() {     
    super.localSetup();

    String hostName ="";

    try {
      if (getMyParams().hasParam ("hostName"))
	hostName = getMyParams().getStringParam("hostName");    
      else 
	hostName = "dante.bbn.com";

      if (getMyParams().hasParam ("runInternal"))
	runInternal = getMyParams().getBooleanParam("runInternal");    
      else 
	runInternal = false;

      if (getMyParams().hasParam ("runDirectly"))
	runDirectly = 
	  getMyParams().getBooleanParam("runDirectly");    
      else 
	runDirectly = false;

      if (!runInternal) 
	runDirectly = false; // can't run directly if not running internally

      if (getMyParams().hasParam ("incrementalScheduling"))
	incrementalScheduling = 
	  getMyParams().getBooleanParam("incrementalScheduling");    
      else 
	incrementalScheduling = false;

      if (getMyParams().hasParam ("showTiming"))
	showTiming = 
	  getMyParams().getBooleanParam("showTiming");    
      else 
	showTiming = true; 
	
      if (getMyParams().hasParam ("makeSetupAndWrapupTasks"))
	makeSetupAndWrapupTasks = 
	  getMyParams().getBooleanParam("makeSetupAndWrapupTasks");    
      else 
	makeSetupAndWrapupTasks = true;

      if (getMyParams().hasParam ("useStoredFormat"))
	useStoredFormat = getMyParams().getBooleanParam("useStoredFormat");    
      else 
	useStoredFormat = false;	

      if (getMyParams().hasParam ("stopOnFailure"))
	stopOnFailure = 
	  getMyParams().getBooleanParam("stopOnFailure");    
      else 
	stopOnFailure = false;

      // how many of the input tasks to use as templates when producing the 
      // OBJECT FORMAT for tasks
      if (getMyParams().hasParam ("firstTemplateTasks"))
	firstTemplateTasks = getMyParams().getIntParam("firstTemplateTasks");    
      else 
	firstTemplateTasks = 2;

      if (getMyParams().hasParam ("wantMediumConfidenceOnExpansion"))
	wantMediumConfidenceOnExpansion = getMyParams().getBooleanParam ("wantMediumConfidenceOnExpansion");
      else
	wantMediumConfidenceOnExpansion = false;
    } catch (Exception e) {}

    domUtil = createVishnuDomUtil ();
    comm    = createVishnuComm ();
    xmlProcessor = createXMLProcessor ();
    config  = createVishnuConfig ();

    localDidRehydrate = blackboard.didRehydrate ();
	
    // helpful for debugging connection configuration problems
    if (runInternal) {
      if (runDirectly) {
	info (getName () + " - will run direct translation internal Vishnu Scheduler.");
	resultHandler = createDirectResultHandler ();
	mode = createDirectMode ();
      }
      else {
	info (getName () + " - will run internal Vishnu Scheduler.");
	resultHandler = createXMLResultHandler ();
	mode = createInternalMode ();
      }
      if (incrementalScheduling)
	info (" - incrementally - ");
    }
    else {
      info (getName () + " - will try to connect to Vishnu Web Server : " + 
		   hostName + ".");
      resultHandler = createXMLResultHandler ();
      mode = createExternalMode ();
    }
    if (useStoredFormat)
      info (" Will send stored object format.");
  }

  protected VishnuDomUtil createVishnuDomUtil () { 
    return new VishnuDomUtil (getMyParams(), getName(), getConfigFinder(), logger); 
  }
  protected VishnuComm    createVishnuComm    () { 
    return new VishnuComm    (getMyParams(), getName(), getClusterName(), domUtil, runInternal, logger); 
  }
  protected XMLProcessor  createXMLProcessor  () { 
    if (isDebugEnabled())
      debug (getName () + ".createXMLProcessor - creating vanilla xml processor.");
    return new XMLProcessor (getMyParams(), getName(), getClusterName(), domUtil, comm, getConfigFinder(),
			     logger, logger, logger);  // later perhaps divide logger name space
  }

  public XMLizer getDataXMLizer () {
    return xmlProcessor.getDataXMLizer();
  }

  protected VishnuConfig createVishnuConfig () {
    String clusterName = myClusterName; 
    if (didSpawn ())
      clusterName = getOriginalAgentID().getAddress();

    return new VishnuConfig  (getMyParams(), getName(), clusterName, logger); 
  }

  protected SchedulerLifecycle createExternalMode () {
    return new ExternalMode (this, comm, xmlProcessor, domUtil, config, resultHandler, getMyParams (), logger);
  }

  protected SchedulerLifecycle createInternalMode () {
    InternalMode mode = new InternalMode (this, comm, xmlProcessor, domUtil, config, resultHandler, getMyParams (), logger);

    return mode;
  }

  protected SchedulerLifecycle createDirectMode () {
    DirectMode mode = new DirectMode (this, comm, xmlProcessor, domUtil, config, resultHandler, getMyParams (), logger);

    return mode;
  }

  protected XMLResultHandler createXMLResultHandler () {
    return new XMLResultHandler (this, comm, xmlProcessor, domUtil, config, getMyParams (), logger);
  }

  protected DirectResultHandler createDirectResultHandler () {
    return new DirectResultHandler (this, comm, xmlProcessor, domUtil, config, getMyParams (), logger);
  }

  /** anything you added with register, you will be informed about here upon rehydration */
  /*
    protected void rehydrateState (List stuff) {
    if (isInfoEnabled() || true)
    debug (getName () + ".rehydrateState - stuff has " + stuff.size () + " members.");
	
    myTaskUIDtoObject  = (Map) stuff.get (0);
    myAssetUIDtoObject = (Map) stuff.get (0);

    if (stuff.size () > 0) {
    ((InternalMode)mode).setScheduler ((Scheduler) stuff.get(0));
    if (isInfoEnabled() || true)
    debug (getName () + ".rehydrateState - set Scheduler on mode.");
    }
	
    if (isInfoEnabled() || true)
    debug (getName () + ".rehydrateState - myTaskUIDToObject is now " + myTaskUIDtoObject);
    if (isInfoEnabled() || true)
    debug (getName () + ".rehydrateState - myAssetUIDToObject is now " + myAssetUIDtoObject);
    }
  */

  public boolean getRunDirectly () {
    return runDirectly;
  }

  /****************************************************************
   ** Setup Filters...
   **/
  
  /** filter for assets */
  public void setupFilters () {
    super.setupFilters ();

    if (isInfoEnabled())
      debug (getName () + " : Filtering for generic Assets...");

    addFilter (myAssetCallback    = createAssetCallback    ());
  }

  /**
   * Is the task interesting to the plugin?  This is the inner-most part of 
   * the predicate.                                                         <br>
   * By default, it ignores tasks produced from this plugin                 <br>                    
   * If you redefine this, it's good to call this using super.
   *
   * @param t - the task begin checked
   * @see org.cougaar.lib.callback.UTILGenericListener#interestingTask
   */
  public boolean interestingTask (Task t) { 
    PrepositionalPhrase pp = prepHelper.getPrepNamed (t, "VISHNU"); 
    if (pp != null && ((String) pp.getIndirectObject()).equals (getClassName(this)))
      return false;
    return true;
  }

  /** 
   * Implemented for UTILTaskChecker interface.
   * <p>
   * DEFAULT : Don't do anything with ill-formed tasks.
   * 
   * @see org.cougaar.lib.filter.UTILTaskChecker#handleIllFormedTask
   */
  public void handleIllFormedTask (Task t) {}

  /** @return UTILAssetCallback that was previously created and has this plugin as a listener */
  protected UTILAssetCallback getAssetCallback    () { return myAssetCallback; }

  /**
   * Create the standard Asset callback
   *
   * @return UTILAssetCallback that was created and has this plugin as a listener
   */
  protected UTILAssetCallback createAssetCallback () { 
    return new UTILAssetCallback  (this, logger); 
  } 

  /**
   * Implemented for UTILAssetListener
   * <p>
   * OVERRIDE to see which assets you think are interesting.
   * <p>
   * For instance, if you are scheduling trucks/ships/planes, 
   * you'd want to check like this : 
   * <code>
   * return (GLMAsset).hasContainPG ();
   * </code>
   * @param a asset to check 
   * @return boolean true if asset is interesting
   */
  public boolean interestingAsset(Asset a) {
    return true;
  }

  /**
   * Collect new assets into a set to eventually give to scheduler (after translation).
   * @param newAssets new assets found in the container
   */
  public void handleNewAssets(Enumeration newAssets) {
    for (; newAssets.hasMoreElements (); ){
      Object asset = newAssets.nextElement ();
      myNewAssets.add (asset);
    }
    if (isInfoEnabled())
      info (getName () + ".handleNewAssets - got " + myNewAssets.size ());
  }

  /**
   * Place to handle changed assets.
   *
   * Does nothing by default - reports changed assets when isInfoEnabled() set.
   *
   * @param newAssets changed assets found in the container
   */
  public void handleChangedAssets(Enumeration changedAssets) {
    for (; changedAssets.hasMoreElements (); ){
      Object asset = changedAssets.nextElement ();
      myChangedAssets.add (asset);
    }
    if (isInfoEnabled())
      info (getName () + ".handleChangedAssets - got " + myChangedAssets.size () + 
	    " changed assets.");
  }

  /** 
   * Implemented for ModeListener interface 
   * <p>
   * Which assets were changed since they were added as new assets?
   * @return myChangedAssets set of assets on the changed list
   */
  public Collection getChangedAssets () {
    return myChangedAssets;
  }

  /** 
   * Implemented for ModeListener interface 
   * <p>
   * After the scheduler is informed of the changed assets, forget about them.
   */
  public void clearChangedAssets () {
    myChangedAssets.clear ();
  }
  
  /**
   * Place to handle rescinded tasks. <p>
   *
   * Sends XML to unfreeze the task assignment and delete it.  Asks the mode to do this.
   *
   * @param newAssets changed assets found in the container
   * @see org.cougaar.lib.vishnu.client.SchedulerLifecycle#handleRemovedTasks
   */
  protected void handleRemovedTasks(Enumeration removedTasks) {
    if (incrementalScheduling) {
      mode.setupScheduler (); // needed for rescinds after rehydration

      if (useStoredFormat)
      	initializeWithStoredFormat ();// needed for rescinds after rehydration
      
      mode.handleRemovedTasks (removedTasks);
    }
  }

  protected void unfreezeTasks (Collection tasks) {
    if (incrementalScheduling) {
      mode.setupScheduler (); // needed for rescinds after rehydration

      if (useStoredFormat)
      	initializeWithStoredFormat ();// needed for rescinds after rehydration
      
      mode.unfreezeTasks (tasks);
    }
  }

  /**
   * <pre>
   * Heart of the plugin.
   * 
   * Deal with the tasks that we have accumulated.
   * 
   * Does: 
   * 1) Sets up the scheduler
   * 2) Sends the problem's object format, if it hasn't already been sent.
   *    - generated introspectively or from a file
   *    - will keep sending the object format if running in batch mode
   * 3) Prepares and sends the data (obtained from tasks and assets)
   *    - ask the mode to translate the tasks and assets
   * 4) Waits for a result (all in the mode)
   *    - start the scheduler
   *    - wait for a result
   *    - call handleAssignment on each returned assignment
   *    - deal with un-assigned tasks
   *    - clear tasks, ready to start on a new batch
   * 
   * </pre>
   *
   * @param tasks the tasks to handle
   */
  public void processTasks (List tasks) {
    total += tasks.size();
    if (isDebugEnabled())
      debug (getName () + ".processTasks - received " + 
	     tasks.size () + " tasks, " + total + " total so far.");

    Date start = new Date();

    mode.setupScheduler ();

    if (useStoredFormat) {
      // only generate format the document once
      initializeWithStoredFormat ();
    } else {
      if (!sentFormatAlready)
	prepareObjectFormat (tasks);
    }
	
    // send again if in batch mode
    sentFormatAlready = incrementalScheduling;

    // remember these tasks come assignment-time
    setUIDToObjectMap (tasks, myTaskUIDtoObject);

    if (isDebugEnabled())
      debug (getName () + ".processTasks - sending " + 
			  myTaskUIDtoObject.values ().size () + " tasks.");

    int numTasks = getNumTasks ();
    Date dataStart = new Date();

    // translate
    prepareData (tasks, objectFormatDoc);

    if (showTiming) {
      domUtil.reportTime (" - Vishnu completed data XML processing in ", dataStart);
      domUtil.reportTime (" - Vishnu completed XML processing in ", start);
    }

    // run, get answer, make plan elements
    waitForAnswer ();

    if (showTiming)
      domUtil.reportTime (" - Vishnu did " + numTasks + " tasks in ", start);
  }

  /** 
   * little helper method called by processTasks, if using a stored object format  <p>
   *
   * Reads object format if hasn't been yet.  Sends format if it hasn't been sent yet.
   *
   */
  protected void initializeWithStoredFormat () {
    // only generate format the document once
    if (objectFormatDoc == null)
      objectFormatDoc = prepareStoredObjectFormat ();
    if (!sentFormatAlready) {
      comm.serializeAndPostProblem (objectFormatDoc);
      mode.initializeWithFormat ();
    }
  }
  
  /** 
   * Automatically generate object format from Cougaar input tasks (and assets). 
   * <p>
   * Calls VishnuConfig to get representative sample of input tasks and assets to
   * use as the base for automatic translation.  Also gets the class name of the
   * resource asset.
   * <p>
   * Sends the object format and creates a data xmlizer, if needed.
   *
   * @param tasks - tasks to examine
   */
  protected void prepareObjectFormat (List tasks) {
    Date start = new Date();

    // The problem format, as opposed to the data, is not cleared on the <CLEARDATABASE>
    // call.  Hence, there is no need to resend the format even when not doing incremental
    // scheduling.  The only time the problem format needs to be resent is when running
    // internally.  
    if (isInfoEnabled())
      info (getName () + ".prepareObjectFormat - discovering object format introspectively.");

    List assetClassName = new ArrayList(); // just a way of returning a second return value from function
    Collection formatTemplates = config.getAssetTemplatesForTasks(tasks, assetClassName, getAllAssets());
    String singleAssetClassName = (String) assetClassName.get(0);

    formatTemplates.addAll (config.getTemplateTasks(tasks, firstTemplateTasks));

    if (isDebugEnabled()) {
      debug (getName () + ".processObjectFormat - " + formatTemplates.size() + " unique assets : ");
      for (Iterator iter = formatTemplates.iterator (); iter.hasNext(); )
	System.out.print ("\t" + iter.next().getClass ());
      debug ("");
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
   * Like VishnuPlugin.prepareObjectFormat                           <p>
   *
   * Send the file called <Cluster>.dff.xml as the default object format 
   * for the problem.                                                     <br>
   * Does NOT discover the object format from sampling the tasks.         <p>
   * 
   * This file can also be indicated by setting the parameter <code>defaultFormat</code>.
   *
   * @param ignoredTasks does NOT use the input tasks to discover format
   **/
  protected Document prepareStoredObjectFormat () {
    Date start = new Date();

    Document formatDoc = null;

    try {
      xmlProcessor.createDataXMLizer (null, null);

      String defaultFormat = config.getFormatFile ();

      if (isDebugEnabled())
	debug (getName () + ".prepareStoredObjectFormat - sending format file " + defaultFormat);

      DOMParser parser = new DOMParser ();
      InputStream inputStream = getConfigFinder().open(defaultFormat);
      parser.parse (new InputSource(inputStream));
      formatDoc = parser.getDocument ();
      Element formatDocRoot = formatDoc.getDocumentElement ();
      formatDocRoot.setAttribute ("name", comm.getProblem());
      System.out.println ("name is " + comm.getProblem ());

      attachAssociatedFiles (formatDoc); // attach vsh.xml, ga.xml, odf.xml files

      if (showTiming)
	domUtil.reportTime (" - Vishnu completed format XML processing in ", start);
    } catch (Exception e) {
      e.printStackTrace ();
      debug (getName () + ".prepareStoredObjectFormat - ERROR with file " + e.getMessage() + " exception was " + e);
    }

    return formatDoc;
  }

  /**
   * Tasks a list of tasks and the object format document and sends the data 
   * to the scheduler.  If incremental scheduling, appends assets to the 
   * list of data if they haven't been sent before.  Otherwise if not 
   * in incremental mode, always sends assets.<p>
   *
   * @see org.cougaar.lib.vishnu.client.ExternalMode#prepareData
   * @see #prepareVishnuObjects
   * @see org.cougaar.lib.vishnu.client.ExternalMode#sendDataToVishnu
   * @param stuffToSend - initially the list of tasks to send to scheduler
   * @param objectFormatDoc - optional object format used by data xmlizers
   *  to determine types for fields when running directly
   */
  protected void prepareData (List stuffToSend, Document objectFormatDoc) {
    Collection allAssets = getAllAssets();
    if (isDebugEnabled())
      debug (getName () + ".prepareData - sending " + 
	     allAssets.size () + " assets.");

    stuffToSend.addAll (allAssets);

    setUIDToObjectMap (allAssets, myAssetUIDtoObject);

    if (logger.isDebugEnabled()) {
      for (Iterator iter = stuffToSend.iterator (); iter.hasNext (); ) {
	Object obj = iter.next ();

	debug (getName () + ".prepareData sending stuff " + 
			    ((UniqueObject) obj).getUID ());
      }
    }

    // Send problem data to vishnu
    mode.prepareData (stuffToSend, objectFormatDoc);
  }

  /** 
   * Ask the mode to run, which includes handling the assignments.  <p>
   * Deal with un-scheduled tasks, and then forget about them.
   * Any tasks not handled = any which are left in the
   * <code>myTaskUIDtoObject</code> map get sent to <code>handleImpossibleTasks</code>.
   * @see SchedulerLifecycle#run
   * @see ExternalMode#run
   * @see InternalMode#run
   * @see DirectMode#run
   * @see #getTasks
   * @see #handleImpossibleTasks
   * @see #clearTasks
   */
  protected void waitForAnswer () {
    mode.run ();

    handleImpossibleTasks (getTasks ());
    clearTasks ();
  }

  /** 
   * Utility for setting up UID to object map.  Uses StringKeys for speed.
   *
   * @param objects     to add to map 
   * @param UIDtoObject map to populate
   */
  protected void setUIDToObjectMap (Collection objects, Map UIDtoObject) {
    for (Iterator iter = objects.iterator (); iter.hasNext ();) {
      UniqueObject obj = (UniqueObject) iter.next ();
      StringKey key = new StringKey (obj.getUID().toString());
      if (!UIDtoObject.containsKey (key)) {
	UIDtoObject.put (key, obj);
	// debug("setUIDToObjectMap: added " + key + " = " + obj + " to map");
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
    if (!incrementalScheduling)
      return getAssetCallback().getSubscription ().getCollection();

    if (blackboard.didRehydrate () || localDidRehydrate) {
      localDidRehydrate = false;
	  
      if (isDebugEnabled())
	debug(getName() + ".getAllAssets - getting all assets because of rehydration.");

      return getAssetCallback().getSubscription ().getCollection();
    }
    else {
      if (isDebugEnabled())
	debug(getName() + ".getAllAssets - normal mode -- NOT rehydrating.");
    }
	
    Set newAssetsCopy = new HashSet (myNewAssets);
    myNewAssets.clear ();
    return newAssetsCopy;
  }

  /**
   * Send the dataformat section of the problem to the postdata
   * URL.
   *
   * This will define the structure of input tasks and resources,
   * as well as the scheduling specs and the ga parameters.
   *
   * Each of the items in the template collection will be translated
   * into an xml OBJECTFORMAT tag.
   *
   * Attaches associated files.
   *
   * </pre>
   * @param templates -- a collection of all the template resources 
   *                     and a template task.
   * @param assetClassName - used to figure out which asset is to be the Vishnu resource
   * @return map of the object types to their object descriptions
   */
  protected Map sendFormat (Collection templates, String assetClassName) {
    if (isDebugEnabled())
      debug (getName () + ".sendFormat, resource " + assetClassName);
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
    mode.initializeWithFormat ();

    return nameInfo;
  }

  /** 
   * Attaches various files to format document. <p>
   *
   * - attach global object format file         <br>
   * - attach specs file                        <br>
   * - attach ga parameters file                <br>
   * @param problemFormatDoc - document to add to 
   **/
  protected void attachAssociatedFiles (Document problemFormatDoc) {
    // append any global other data object formats 
    appendGlobalDataFormat (problemFormatDoc);

    // append the scheduling specs
    String specsFile = config.getSpecsFile();

    if (isDebugEnabled())
      debug (getName () + ".sendFormat - appending " + 
	     specsFile + " vishnu specs xml file");

    domUtil.appendDoc (problemFormatDoc, specsFile);

    // append the ga specs
    specsFile = config.getGASpecsFile(); 

    if (isDebugEnabled())
      debug (getName () + ".sendFormat - appending " + 
	     specsFile + " vishnu ga specs xml file");

    domUtil.appendDoc (problemFormatDoc, specsFile);
  }

  /** 
   * Talks to VishnuConfig to find out if there is an other data format file. <br>
   * If there is, appends it to problem format doc.  Adds it beneath DATAFORMAT tag.
   * @param problemFormatDoc document to add other data format to
   */
  protected void appendGlobalDataFormat (Document problemFormatDoc) {
    String otherDataFormat = config.getOtherDataFormat();
    try {
      if (getConfigFinder ().open (otherDataFormat) != null) {
	if (isDebugEnabled())
	  debug (getName () + ".sendFormat -  appending " + 
			      otherDataFormat + " other data format file");

	Element dataFormatNode = (Element)
	  problemFormatDoc.getElementsByTagName ("DATAFORMAT").item(0);
		
	domUtil.appendDoc (problemFormatDoc, dataFormatNode, otherDataFormat);
      }
    } catch (FileNotFoundException fnf) {
      if (isInfoEnabled())
	info (getName () + 
	       ".appendGlobalDataFormat - could not find optional file : " + 
	       otherDataFormat );
    } catch (Exception ioe) {
      logger.error (getName() + ".appendGlobalDataFormat - Exception " + ioe.getMessage(), ioe);
    }
  }
  
  /** 
   * Creates lists of Vishnu objects.
   * <p>
   * Complains that you need to define this method by default.
   * <p>
   * Implemented for DirectResultListener interface.
   *
   * @param tasksAndResources - Cougaar tasks and resources to translate
   * @param changedAssets - list of changed Cougaar assets
   * @param vishnuTasks - list to add Vishnu tasks to 
   * @param vishnuResources - list to add Vishnu resources to 
   * @param changedVishnuResources - list of changed Vishnu resources
   * @param timeOps - time object used when making Vishnu dates
   */
  public void prepareVishnuObjects (List tasksAndResources, Collection changedAssets,
				    List vishnuTasks, List vishnuResources, List changedVishnuResources,
				    Document objectFormat, SchedulingData schedData) { 
    error (getName ()+ ".prepareVishnuObjects - ERROR - don't run directly if you haven't defined this method.");
  }


  /** implemented for ModeListener interface */
  public int getNumTasks () {
    return myTaskUIDtoObject.size();
  }

  /** called by waitForAnswer -- we don't have to remember taskUID-to-object mappings after answer is returned */
  protected void clearTasks () {
    myTaskUIDtoObject.clear();
  }

  /** 
   * Used when XML assignment information is returned to find matching resource asset <p>
   *
   * implemented for ResultListener interface 
   */
  public Task getTaskForKey (StringKey key) {
    Task task = (Task)  myTaskUIDtoObject.get (key);
    return task;
  }

  /** implemented for ResultListener interface */
  public void removeTask (StringKey key) {
    myTaskUIDtoObject.remove (key);
  }
  
  /** implemented for ModeListener interface */
  public Collection getTasks () {
    return myTaskUIDtoObject.values();
  }

  /** implemented for ModeListener interface */
  public int getNumAssets () {
    return myAssetUIDtoObject.size();
  }

  /** implemented for ModeListener interface */
  public String getTaskName() { return "Transport"; }

  /** 
   * Used when XML assignment information is returned to find matching resource asset <p>
   *
   * implemented for ResultListener interface 
   */
  public Asset getAssetForKey (StringKey key) {
    Asset asset = (Asset)  myAssetUIDtoObject.get (key);

    return asset;
  }

  /*
    protected UniqueObject findUniqueObject (final StringKey uid) {
    Thread.dumpStack ();
	
    Collection stuff = blackboard.query (new UnaryPredicate () {
    public boolean execute (Object obj) {
    boolean isUnique = (obj instanceof UniqueObject);
    if (!isUnique) return false;

    boolean match = ((UniqueObject) obj).getUID ().toString().equals (uid.toString());

    debug (getName () + ".findUniqueObject - Comparing uid " +
    ((UniqueObject) obj).getUID ().toString() + " with key " + uid + 
    ((match) ? " MATCH! " : " no match"));

    return match;
    }
    });

    if (stuff.isEmpty ())
    return null;
    else
    return (UniqueObject) stuff.iterator().next();
    }
  */	  

  /**
   * Given a collection of impossible tasks, make failed disposition for each. 
   * <p>
   * If <code>stopOnFailure</code> is true, exits.
   * @param impossibleTasks -- tasks that the scheduler couldn't figure out 
   *                           what to do with
   */
  protected void handleImpossibleTasks (Collection impossibleTasks) {
    if (!impossibleTasks.isEmpty ())
      debug (getName () + 
			  ".handleImpossibleTasks - failing " + 
			  impossibleTasks.size () + 
			  " tasks.");

    for (Iterator iter = impossibleTasks.iterator (); iter.hasNext ();) {
      Object obj = allocHelper.makeFailedDisposition (this, ldmf, 
						      (Task) iter.next ()); 
      publishAddWithCheck (obj);
    }

    if (stopOnFailure && !impossibleTasks.isEmpty()) {
      debug (getName() + ".handleImpossibleTasks - stopping on failure!");
      System.exit (-1);
    }
  }

  /** 
   * <pre>
   * Should define in subclass -- create an allocation 
   *
   * The parameters are what got returned from the vishnu scheduler.
   *
   * implemented for ResultListener interface 
   * </pre>
   * @see VishnuAllocatorPlugin#handleAssignment
   * @param task  task that was assigned to asset
   * @param asset asset handling task
   * @param start of main task
   * @param end   of main task
   * @param setupStart start of setup task
   * @param wrapupEnd end of wrapup task
   */
  public void handleAssignment (org.cougaar.planning.ldm.plan.Task task, Asset asset, 
				Date start, Date end, Date setupStart, Date wrapupEnd, String contribs, String taskText) {
    logger.warn ("somehow calling this function? - nothing will happen.");
  }

  /** 
   * <pre>
   * Should define in subclass -- create an aggregation
   *
   * The parameters are what got returned from the vishnu scheduler.
   *
   * implemented for ResultListener interface 
   * </pre>
   * @see VishnuAggregatorPlugin#handleMultiAssignment
   * @param tasks  tasks to be aggregated together and assigned to asset
   * @param asset asset handling task
   * @param start of main task
   * @param end   of main task
   * @param setupStart start of setup task
   * @param wrapupEnd end of wrapup task
   */
  public void handleMultiAssignment (Vector tasks, Asset asset, 
				     Date start, Date end, Date setupStart, Date wrapupEnd, boolean assetWasUsedBefore) {}

  /** 
   * Must use a special allocation result aggregator that does NOT include the transit (setup, wrapup) tasks
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
   * @return List of subtasks created
   */
  protected List makeSetupWrapupExpansion (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
    if (isDebugEnabled())
      debug (getName () + ".makeSetupWrapupExpansion : " + 
			  " assigning " + task.getUID() + 
			  "\nto " + asset.getUID () +
			  " from " + start + 
			  " to " + end);

    if (setupStart.after (start))
      error (getName () + ".makeSetupWrapupExpansion : ERROR, assigned setupStart - " + setupStart + " after start " + start + 
			  " for task " + task);
    if (start.after (end))
      error (getName () + ".makeSetupWrapupExpansion : ERROR, assigned start - " + start + " after end " + end + 
			  " for task " + task);
    if (end.after (wrapupEnd))
      error (getName () + ".makeSetupWrapupExpansion : ERROR, assigned end - " + end + " after wrapupEnd " + wrapupEnd + 
			  " for task " + task);
	  
    Vector subtasks = new Vector ();
	
    subtasks.add (createMainTask (task, asset, start, end, setupStart, wrapupEnd));

    if (makeSetupAndWrapupTasks) {
      if (setupStart.getTime() < start.getTime()) {
	if (isDebugEnabled())
	  debug (getName () + ".makeSetupWrapupExpansion : making setup task for " + task.getUID());
	subtasks.add (createSetupTask (task, asset, start, end, setupStart, wrapupEnd));
      }

      if (wrapupEnd.getTime() > end.getTime()) {
	if (isDebugEnabled())
	  debug (getName () + ".makeSetupWrapupExpansion : making wrapup task for " + task.getUID());
	subtasks.add (createWrapupTask (task, asset, start, end, setupStart, wrapupEnd));
      }
    }

    publishSubtasks (wantMediumConfidenceOnExpansion, task, subtasks);
	
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
   * </pre>
   **/
  protected Task createMainTask (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
    NewTask mainTask = (NewTask) expandHelper.makeSubTask (ldmf, task, task.getDirectObject(), task.getSource());
    mainTask.setPrepositionalPhrases (getPrepPhrases (task, asset).elements());
    synchronized (task) { // bug #2124
      mainTask.setPreferences (getPreferences (task, start, start, end, end).elements());
    }
    if (isDebugEnabled()) debug (getName () + ".createMainTask : made main task : " + mainTask.getUID());
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
    NewTask setupTask = (NewTask) expandHelper.makeSubTask (ldmf, task, task.getDirectObject(), task.getSource());
    setupTask.setVerb (Constants.Verb.Transit);
    setupTask.setPrepositionalPhrases (getPrepPhrases (task, asset).elements());
    setupTask.setPreferences (getPreferences (task, setupStart, setupStart, start, start).elements());
    if (isDebugEnabled()) debug (getName () + ".createSetupTask : made setup task : " + setupTask.getUID());
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
    NewTask wrapupTask = (NewTask) expandHelper.makeSubTask (ldmf, task, task.getDirectObject(), task.getSource());
    wrapupTask.setVerb (Constants.Verb.Transit);
    wrapupTask.setPrepositionalPhrases (getPrepPhrases (task, asset).elements());
    wrapupTask.setPreferences (getPreferences(task, end, end, wrapupEnd, wrapupEnd).elements());
    if (isDebugEnabled()) debug (getName () + ".createWrapupTask : made wrapup task : " + wrapupTask.getUID());
    return wrapupTask;
  }

  /**
   * <pre>
   * Adjust preferences so that the start time preference is the assigned 
   * start time, and the end time preference has a best date that is the 
   * assigned end time.  The early and late dates of the end time preference
   * are the same as the first parent task. (This isn't very important, as the
   * downstream allocator should just allocate to the start and best times.)
   * 
   * </pre>
   * @param a - the asset associated with the MPTask
   * @param g - parent task list
   * @param start - the date for the START_TIME preference
   * @param end - the best date for the END_TIME preference
   * @return Vector - list of preferences for the MPTask
   */
  protected Vector getPreferences (Task parentTask, Date readyAt, Date earliest, Date best, Date latest) { 
    Vector prefs = allocHelper.enumToVector(parentTask.getPreferences());
    prefs = prefHelper.replacePreference (prefs, prefHelper.makeStartDatePreference (ldmf, readyAt));
    prefs = prefHelper.replacePreference (prefs, 
					  prefHelper.makeEndDatePreference (ldmf, 
									    earliest,
									    best,
									    latest));
    return prefs;
  }

  /** 
   * This method Expands the given Task.
   *
   * @param wantConfidence set the confidence to 100% on expansion
   * @param t the task to be expanded.
   * @param subtasks the expanded subtasks
   */
  public void publishSubtasks (boolean wantConfidence, Task t, List subtasks) {
    if (isDebugEnabled()){
      debug(getName() + ".handleTask: Subtask(s) created for task :" + 
			 t.getUID());
    }

    Workflow wf = expandHelper.makeWorkflow (ldmf, subtasks, skipTransitARA, t);

    Expansion exp = null;
    if(wantConfidence){
      exp = expandHelper.makeExpansionWithConfidence (ldmf, wf);
    }
    else{
      exp = expandHelper.makeExpansion (ldmf, wf);
    }

    if (isDebugEnabled()){
      debug(getName () + ".handleTask: Expansion created. (" +
			 exp.getUID() + ")");
    }
    
    for (Iterator i = subtasks.iterator (); i.hasNext ();) {
      publishAddWithCheck (i.next());
    }
    publishAddWithCheck(exp);

    if (isDebugEnabled()){
      debug(getName() + ".handleTask: Expansion published. Workflow has " + 
			 allocHelper.enumToList(exp.getWorkflow ().getTasks()).size () + " subtasks." );
    }

  }

  /**
   * Defines how the task holds the asset for the task->asset association.
   *
   * Critical, because the allocator downstream will probably look for this prep and
   * pluck the asset off to make the allocation or use it in some way.
   *
   * @param a - asset to attach to task
   * @param g - parent tasks
   * @return the original set of prep phrases from the first parent task PLUS the WITH
   *         prep with the asset
   */
  protected Vector getPrepPhrases(Task parentTask, Asset a) {
    Vector preps = new Vector (allocHelper.enumToVector(parentTask.getPrepositionalPhrases()));
    if (!prepHelper.hasPrepNamed (parentTask, Constants.Preposition.WITH))
      preps.addElement(prepHelper.makePrepositionalPhrase(ldmf, 
							  Constants.Preposition.WITH, 
							  a));

    preps.addElement(prepHelper.makePrepositionalPhrase(ldmf, 
							"VISHNU", getClassName(this)));
    return preps;
  }

  protected void publishAddWithCheck (Object obj) {
    publishAdd(obj);
  }

  // ------------- MODES ------------------------ 
  /** determines whether to run in internal or external (with web server) mode */
  protected boolean runInternal = true;
  /** determines whether to do XML or direct translation of Cougaar objects */
  protected boolean runDirectly = false;
  /** incremental or batch mode */
  protected boolean incrementalScheduling = false;

  // ------------- TASKS -------------------------
  /** how many tasks to examine to automatically determine format in automatic translation mode */
  protected int firstTemplateTasks;
  /** memory for which tasks are being processed in this batch -- used when assignments are returned */
  protected Map myTaskUIDtoObject  = new HashMap ();

  // ------------- ASSETS ------------------------ 
  /** assets to use */
  protected UTILAssetCallback myAssetCallback;
  /** memory of which assets are available -- used when assignments are returned */
  protected Map myAssetUIDtoObject = new HashMap ();
  /** recently received assets to tell the scheduler about */
  protected Set myNewAssets = new HashSet ();
  /** changed assets to tell the scheduler about */
  protected Set myChangedAssets = new HashSet ();

  // ------------- FLAGS ------------------------ 

  /** option : create setup and wrapup tasks, in addition to assignment task */
  protected boolean makeSetupAndWrapupTasks = true;
  /** controls whether to use custom translation */
  protected boolean useStoredFormat = false;
  /** controls whether to do exit on failure, sometimes useful for debugging */
  protected boolean stopOnFailure = false;
  /** report debug output showing timing info */
  protected boolean showTiming = true;

  // ------------- STATE ---------------------------------
  /** sent the format already?  Send it only once unless in batch mode */
  protected boolean sentFormatAlready = false;
  /** object format doc, either generated or from a file */
  protected Document objectFormatDoc;

  protected boolean localDidRehydrate = false;

  protected boolean wantMediumConfidenceOnExpansion;

  protected int total = 0;

  // ------------- HELPER OBJECTS ------------------------
  /** mode - manages scheduler lifecycle */
  protected SchedulerLifecycle mode;
  /** handles results, calls methods in plugin to create plan elements */
  protected ResultHandler resultHandler;

  /** manages communication with URLs or internally */
  protected VishnuComm comm;
  /** utility functions for manipulating DOM documents */
  protected VishnuDomUtil domUtil;
  /** automatic translator */
  protected XMLProcessor xmlProcessor;
  /** config files, gets representative tasks and assets for automatic translation */
  protected VishnuConfig config;

}


