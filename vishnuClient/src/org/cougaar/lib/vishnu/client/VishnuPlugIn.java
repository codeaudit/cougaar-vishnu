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
import org.apache.xerces.parsers.SAXParser;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import org.cougaar.lib.vishnu.server.Scheduler;
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
  implements UTILAssetListener {

  private static final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
  private static String SEPARATOR = "_";
  private static String SPECS_SUFFIX = ".vsh.xml";
  private static String GA_SUFFIX = ".ga.xml";
  private static String OTHER_FORMAT_SUFFIX = ".odf.xml";
  private static String OTHER_DATA_SUFFIX = ".odd.xml";

  /**
   * Here all the various runtime parameters get set.  See documentation for details.
   */
  public void localSetup() {     
    super.localSetup();

    try {hostName = getMyParams().getStringParam("hostName");}    
    catch(Exception e) {hostName = "dante.bbn.com";}

    try {testing = getMyParams().getBooleanParam("testing");}    
    catch(Exception e) {testing = false;}

    try {showFormatXML = getMyParams().getBooleanParam("showFormatXML");}    
    catch(Exception e) {showFormatXML = false;}

    try {showDataXML = getMyParams().getBooleanParam("showDataXML");}    
    catch(Exception e) {showDataXML = false;}

    try {ignoreSpecsFile = getMyParams().getBooleanParam("ignoreSpecsFile");}  
    catch(Exception e) {ignoreSpecsFile = false;}

    try {sendSpecsEveryTime = 
		   getMyParams().getBooleanParam("sendSpecsEveryTime");}    
    catch(Exception e) {sendSpecsEveryTime = false;}

    try {alwaysClearDatabase = 
		   getMyParams().getBooleanParam("alwaysClearDatabase");}    
    catch(Exception e) {alwaysClearDatabase = true;}

    try {showTiming = 
		   getMyParams().getBooleanParam("showTiming");}    
    catch(Exception e) {showTiming = true;}

    try {sendRoleScheduleUpdates = 
		   getMyParams().getBooleanParam("sendRoleScheduleUpdates");}    
    catch(Exception e) {sendRoleScheduleUpdates = false;}

    try {makeSetupAndWrapupTasks = 
		   getMyParams().getBooleanParam("makeSetupAndWrapupTasks");}    
    catch(Exception e) {makeSetupAndWrapupTasks = true;}

    try {runInternal = 
		   getMyParams().getBooleanParam("runInternal");}    
    catch(Exception e) {runInternal = false;}

	// writes the XML sent to Vishnu web server to a file (human readable)
    try {writeXMLToFile = 
		   getMyParams().getBooleanParam("writeXMLToFile");}    
    catch(Exception e) {writeXMLToFile = false;}

    try {debugFormatXMLizer = 
		   getMyParams().getBooleanParam("debugFormatXMLizer");}
    catch(Exception e) {debugFormatXMLizer = false;}

    try {debugDataXMLizer = 
		   getMyParams().getBooleanParam("debugDataXMLizer");}    
    catch(Exception e) {debugDataXMLizer = false;}

	// controls the time period that Vishnu uses - assumes world starts at this time
	// has large effect on scaling of gantt chart displays
    try {vishnuEpochStartTime = 
		   getMyParams().getStringParam("vishnuEpochStartTime");}    
    catch(Exception e) {vishnuEpochStartTime = "2000-01-01 00:00:00";}

	// controls the time period that Vishnu uses - assumes world ends at this time
	// has large effect on scaling of gantt chart displays
    try {vishnuEpochEndTime = 
		   getMyParams().getStringParam("vishnuEpochEndTime");}    
    catch(Exception e) {vishnuEpochEndTime = "2002-01-01 00:00:00";}

    // how many of the input tasks to use as templates when producing the 
	// OBJECT FORMAT for tasks
    try {firstTemplateTasks = getMyParams().getIntParam("firstTemplateTasks");}    
    catch(Exception e) {firstTemplateTasks = 2;}

    try {sendDataChunkSize = getMyParams().getIntParam("sendDataChunkSize");}    
    catch(Exception e) {sendDataChunkSize = 100;}
	
	domUtil = new VishnuDomUtil (getMyParams(), getName(), getConfigFinder());
	comm    = new VishnuComm    (getMyParams(), getName(), getClusterName(), domUtil, runInternal);

	// helpful for debugging connection configuration problems
	if (runInternal)
	  System.out.println (getName () + " - will run internal Vishnu Scheduler.");
	else
	  System.out.println (getName () + " - will try to connect to Vishnu Web Server : " + 
						  hostName);
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
	if (myExtraOutput) {
	  Set changed = new HashSet ();
	  for (; newAssets.hasMoreElements (); ){
		Object asset = newAssets.nextElement ();
		changed.add (asset);
	  }
	  System.out.println (getName () + ".handleNewAssets - got new assets = " + changed);
	}
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
	if (myExtraOutput)
	  System.out.println (getName () + ".handleChangedAssets - got changed assets.");
  }
  
  /**
   * <pre>
   * To be called from handleSuccessfulXXX methods in allocator, aggregator, 
   * and expander.
   *
   * It's up to them to take apart plan element to send task->asset mappings.
   * 
   * Inefficient for large numbers of tasks that could go in one batch to the 
   * web server.
   *
   * If sendRoleScheduleUpdates is false, this method is ignored.
   *
   * </pre>
   * @param changedAsset -- the asset that has been allocated to, with an 
   *        updated role schedule
   * @param assignedTask -- the task that was frozen, now should be unfrozen
   */
  protected void sendUpdatedRoleSchedule(PlanElement pe, Asset changedAsset, 
										 Collection assignedTasks) {
	if (!sendRoleScheduleUpdates)
	  return;
	
	if (myExtraOutput) {
	  System.out.println (getName () + 
						  ".sendUpdatedRoleSchedule - got changed asset = " + 
						  changedAsset);
	}
	
	Set frozenTasks = new HashSet (myFrozenTasks);
	frozenTasks.retainAll (assignedTasks);

	if (frozenTasks.isEmpty ()) 
	  return;
	
	Document doc = new DocumentImpl ();
    Element newRoot = doc.createElement("PROBLEM");
	newRoot.setAttribute ("NAME", comm.getProblem());
    doc.appendChild(newRoot);
	
	for (Iterator iter = frozenTasks.iterator (); iter.hasNext (); ) {
	  UniqueObject task = (UniqueObject) iter.next ();
	  Element unfreeze = doc.createElement("UNFREEZE");
	  unfreeze.setAttribute ("TASK", task.getUID ().getUID());
	  newRoot.appendChild (unfreeze);
	  if (myExtraOutput)
		System.out.println (getName () + 
							".sendUpdatedRoleSchedule - unfreezing " + 
							task.getUID ());
	}
	
	if (myExtraOutput)
	  System.out.println (getName () + 
						  ".sendUpdatedRoleSchedule - sending " + 
						  frozenTasks.size () + 
						  " changed assets.");

	serializeAndPostData (doc);

	if (myExtraOutput)
	  System.out.println (getName () + 
						  ".sendUpdatedRoleSchedule - sending updated asset " +
						  changedAsset.getUID ());

	List changed = new ArrayList ();
	changed.add (changedAsset);
    sendDataToVishnu (changed, myNameToDescrip, 
					  false /* don't clear database */, 
					  true /* send assets as CHANGEDOBJECTS */,
					  singleAssetClassName);

	myFrozenTasks.removeAll (frozenTasks);
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
   * (Outdated) Parameters that effect behavior:
   * 
   * 1) sendSpecsEveryTime - sends the specs and object format every time
   *    useful if debugging problems with XSL.
   * 2) alwaysClearDatabase - clears the Vishnu database for the problem
   *    This is problematic.  It's inefficient to send all the assets 
   *    with every problem, but there's currently no way to just 
   *    clear the tasks, so if you don't clear, you get back assignments 
   *    to tasks from previous runs.  Defaults to TRUE.
   *
   * </pre>
   *
   * @param tasks the tasks to handle
   */
  public void processTasks (List tasks) {
	synchronized (static_mutex) {
	  System.out.println (getName () + ".processTasks - received " + 
						  tasks.size () + " tasks");
	  if (runInternal)
		internalBuffer.append ("<root>");

	  if (myExtraOutput)
		for (int i = 0; i < tasks.size (); i++)
		  System.out.print ("" + ((Task) tasks.get(i)).getUID () + ", ");
	  
	  Date start = new Date();
      
	  if (!sentFormatAlready || sendSpecsEveryTime) {
		List assetClassName = new ArrayList(); // just a way of returning a second return value from function
		Collection formatTemplates = getAssetTemplatesForTasks(tasks, assetClassName);
		singleAssetClassName = (String) assetClassName.get(0);
		
		formatTemplates.addAll (getTemplateTasks(tasks));
		if (myExtraOutput) {
		  System.out.println (getName () + ".processTasks - " + formatTemplates.size() + " unique assets : ");
		  for (Iterator iter = formatTemplates.iterator (); iter.hasNext(); )
			System.out.print ("\t" + iter.next().getClass ());
		  System.out.println ("");
		}

		Map [] nameInfo = sendFormat (formatTemplates, singleAssetClassName);
		myNameToDescrip   = nameInfo[0];
		myTypesToNodes    = nameInfo[1];
		if (!runInternal)
		  sentFormatAlready = true;
		if (showTiming)
		  domUtil.reportTime (" - Vishnu completed format XML processing in ", start);
	  }
      
	  setUIDToObjectMap (tasks, myTaskUIDtoObject);

	  if (myExtraOutput)
		System.out.println (getName () + ".processTasks - sending " + 
							myTaskUIDtoObject.values ().size () + " tasks.");
	  if (myExtraExtraOutput)
		System.out.println (getName () + ".processTasks - task uid map keys " + myTaskUIDtoObject.keySet());
      
	  int numTasks = myTaskUIDtoObject.values ().size ();
      
	  Date dataStart = new Date();
      
	  if (!mySentAssetDataAlready) {
		Collection allAssets = getAllAssets();
		if (myExtraOutput)
		  System.out.println (getName () + ".processTasks - sending " + 
							  allAssets.size () + " assets.");
	  
		tasks.addAll (allAssets);
	  
		if (myExtraExtraOutput) 
		  for (Iterator iter = tasks.iterator (); iter.hasNext (); ) {
			Object obj = iter.next ();
		  
			System.out.println (getName () + ".processTasks sending stuff " + 
								((UniqueObject) obj).getUID ());
		  }
	  
		setUIDToObjectMap (allAssets, myAssetUIDtoObject);
	  
		if (!alwaysClearDatabase)
		  mySentAssetDataAlready = true;
	  }
      
	  sendDataToVishnu (tasks, myNameToDescrip, 
						alwaysClearDatabase, 
						false /* send assets as NEWOBJECTS */,
						singleAssetClassName);
	  if (showTiming) {
		domUtil.reportTime (" - Vishnu completed data XML processing in ", dataStart);
		domUtil.reportTime (" - Vishnu completed XML processing in ", start);
	  }

	  if (runInternal) {
		runInternally ();
	  } else {
		comm.startScheduling ();
	
		if (!waitTillFinished ())
		  showTimedOutMessage ();
	  }
	  if (showTiming)
		domUtil.reportTime (" - Vishnu did " + numTasks + " tasks in ", start);
	} // end of synchronized
  }

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

  /** 
   * Run internally.  Create a new scheduler, and give it the contents of <p>
   * the internalBuffer, which has captured all the xml output that would <p>
   * normally go to the various URLs.  Then, parse the results using a SAX <p>
   * Parser and the AssignmentHandler, which just calls parseStartElement and <p>
   * parseEndElement.  The AssignmentHandler will create plan elements for
   * each assignment.
   *
   * @see #parseStartElement
   * @see #parseEndElement
   */
  protected void runInternally () {
	Scheduler internal = new Scheduler ();
	internalBuffer.append ("</root>");
	if (myExtraExtraOutput)
	  System.out.println(getName () + ".runInternally - sending stuff " + internalBuffer.toString());

	int unhandledTasks = myTaskUIDtoObject.size ();

	String assignments = internal.runInternalToProcess (internalBuffer.toString());
	if (myExtraOutput)
	  System.out.println(getName () + ".runInternally - scheduled assignments were : " + assignments);
	
	SAXParser parser = new SAXParser();
	//	parser.setDocumentHandler (new AssignmentHandler ());
	parser.setContentHandler (new AssignmentHandler ());
	try {
	  parser.parse (new InputSource (new StringReader (assignments)));
	} catch (SAXException sax) {
	  System.out.println (getName () + ".runInternally - Got sax exception:\n" + sax);
	} catch (IOException ioe) {
	  System.out.println (getName () + ".runInternally - Could not open file : \n" + ioe);
	} catch (NullPointerException npe) {
	  System.out.println (getName () + ".runInternally - ERROR - no assignments were made, badly confused : \n" + npe);
	}
	clearInternalBuffer ();

	if (myExtraOutput)
	  System.out.println (getName () + ".runInternally - created successful plan elements for " +
						  (unhandledTasks-myTaskUIDtoObject.size ()) + " tasks.");

	handleImpossibleTasks (myTaskUIDtoObject.values ());
	myTaskUIDtoObject.clear ();
  }
  
  protected static Object static_mutex = new Object ();

  protected void setUIDToObjectMap (Collection objects, Map UIDtoObject) {
	for (Iterator iter = objects.iterator (); iter.hasNext ();) {
	  UniqueObject obj = (UniqueObject) iter.next ();
	  StringKey key = new StringKey (obj.getUID().getUID());
	  if (!UIDtoObject.containsKey (key)) {
		UIDtoObject.put (key, obj);
	  }
	}
  }

  protected Collection getAllAssets() {
	return getAssetCallback().getSubscription ().getCollection();
  }

  /**
   * <pre>
   * Sets the set of template tasks.  Template tasks are examined
   * to create the ObjectFormat for the tasks used in the problem.
   *
   * Say 2 tasks are sent to the vishnu bridge, but only one is 
   * used as the template task.  If the second task has an indirect
   * object with an object of a type that is not in the first task,
   * Vishnu will reject this object when the task is sent as data AND
   * the specs will not be able to reference the field.
   *
   * So it's imperative that the template tasks have all the fields
   * and all the types that should be used in the problem.
   *
   * This may not be that big of a deal in practice, but this function 
   * may have to be overridden.
   *
   * By default looks at the parameter <code>firstTemplateTasks</code> 
   * to determine how many of the tasks should be sent as templates.
   * </pre>
   */
  protected List getTemplateTasks (List tasks) {
	List templateTasks = new ArrayList ();
	int size = (tasks.size () < firstTemplateTasks) ?
	  tasks.size () : firstTemplateTasks;
	
	for (int i = 0; i < size; i++)
	  templateTasks.add (tasks.get (i));
	return templateTasks;
  }

  /**
   * <pre>
   * Using the task list, figure out which assets are relevant to 
   * the problem and return them.  For example, if there is a 
   * prep "WITH CargoShip#5" on a task, and you only want decks for that ship,
   * you could subclass this function and select those decks here.
   *
   * NOTE that this could also be achieved by the Vishnu CAPABILITY CRITERION.
   * In general, that will be a more flexible way to go, if less efficient.
   * 
   * If you want to do :
   *  getAssetCallback().getSubscription ().getCollection();
   * instead do :
   *  new HashSet( getAssetCallback().getSubscription ().getCollection());
   *
   * </pre>
   * @param list of tasks to use to filter out relevant assets
   * @return Collection of assets to send to Vishnu
   */
  protected Collection getAssetTemplatesForTasks (List tasks, List assetClassName) {
	return getDistinctAssetTypes (assetClassName);
  }
  
  /**
   * <pre>
   * Looks through all assets and finds prototypical instances
   * of distinct classes.
   *
   * Conceptually, if the cluster has 10 trucks and 10 railcars
   * as assets, we want to return a list of one truck and 
   * one railcar to be used as templates.
   *
   * Uses type identification PG to find distinct types.
   *
   * </pre>
   * @return Collection of the asset instances
   */
  protected Collection getDistinctAssetTypes (List assetClassName) {
	Map typeIDToAsset = new HashMap ();

    for (Iterator iter = getAssets (); iter.hasNext (); ) {
      Asset asset = (Asset) iter.next ();
	  String typeID = 
		asset.getTypeIdentificationPG().getTypeIdentification();
	  StringKey typeKey = new StringKey (typeID);
	  
      if (!typeIDToAsset.containsKey (typeKey))
		typeIDToAsset.put (typeKey, asset);
    }

    Set distinctAssets = new HashSet (typeIDToAsset.values ());

	// find most-derived common descendant of all assets

	Object first = distinctAssets.iterator().next();
	Class firstClass = first.getClass();
	Class currentClass = firstClass;
	Stack currentClasses = new Stack ();
	currentClasses.push (currentClass);
	
	while ((currentClass = currentClass.getSuperclass()) != java.lang.Object.class) {
	  if (myExtraExtraOutput)
		System.out.println (getName() + ".getDistinctAssetTypes : super " + currentClass);
	  currentClasses.push (currentClass);
	}
	
	for (Iterator iter = distinctAssets.iterator(); iter.hasNext();) {
	  Class assetClass = iter.next().getClass();
	  
	  if (assetClass != firstClass){
		currentClass = assetClass;
		Stack otherClasses  = new Stack ();

		otherClasses.push (currentClass);
		
		while ((currentClass = currentClass.getSuperclass()) != java.lang.Object.class) {
		  if (myExtraExtraOutput)
			System.out.println (getName() + ".getDistinctAssetTypes : super " + currentClass);
		  otherClasses.push (currentClass);
		}

		currentClasses.retainAll (otherClasses);
		
		if (myExtraOutput) {
		  for (int i = 0; i < currentClasses.size(); i++)
			System.out.println (getName() + ".getDistinctAssetTypes : shared class " + currentClasses.get(i));
		}
	  }
		
	}

	// return final name in complete class name, e.g. from org.cougaar.domain.glm.ldm.asset.Truck, Truck
	String classname = "" + currentClasses.get(0);
    int index = classname.lastIndexOf (".");
    classname = classname.substring (index+1, classname.length ());
	
	assetClassName.add (classname);
	
	if (myExtraOutput) {
	  for (int i = 0; i < currentClasses.size(); i++)
		System.out.println (getName() + ".getDistinctAssetTypes : result class " + currentClasses.get(i));
	}
	
	if (distinctAssets.isEmpty())
	  System.out.println (getName () + ".getDistinctAssetTypes - ERROR? no templates assets?");

	return distinctAssets;
  }

  /** 
   * Utility method for finding all assets. 
   * @return Iterator that iterates over assets.
   */
  protected final Iterator getAssets() {
    Collection assets = 
      getAssetCallback().getSubscription ().getCollection();

    if (assets.size() != 0) {
      return assets.iterator();
    }
    return new ArrayList ().iterator();
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
   */
  protected Map [] sendFormat (Collection templates, String assetClassName) {
	if (myExtraOutput)
	  System.out.println (getName () + ".sendFormat, resource " + assetClassName);
    Map [] nameInfo = null;
	Date start = new Date ();
	
    try {
      // perform the transform!
	  Document problemFormatDoc = getFormatDoc (templates, assetClassName);

	  if (showFormatXML) {
		System.out.println (domUtil.getDocAsString(problemFormatDoc));
	  }
	  if (showTiming)
		domUtil.reportTime (" - Vishnu completed format XML transform in ", start);
	  
      // must remove duplicate OBJECTFORMATS
      
      Node root = problemFormatDoc.getDocumentElement ();
	  if (myExtraOutput)
		System.out.println (getName () + "- root " + ((Element)root).getTagName () + 
							" has " + root.getChildNodes().getLength()+ " children");
	  
      NodeList nlist = root.getChildNodes();
      Node dataformat = nlist.item(0);  // assumes first child is dataformat
	  if (myExtraOutput)
		System.out.println (getName () + "- dataformat " + ((Element)dataformat).getTagName () + 
							" has " + dataformat.getChildNodes().getLength()+ " children");
      nameInfo = removeDuplicates (dataformat, problemFormatDoc);

      // label the problem with the name of the problem
      ((Element)root).setAttribute ("NAME", comm.getProblem());

      if (myExtraOutput)
		System.out.println (getName () + ".sendFormat - problem is " + comm.getProblem());

      // appending any global other data object formats 
      String otherDataFormat = getOtherDataFormat();
	  try {
		//		if (getCluster().getConfigFinder ().open (otherDataFormat) != null) {
		if (getConfigFinder ().open (otherDataFormat) != null) {
		  if (myExtraOutput)
			System.out.println (getName () + ".sendFormat -  appending " + 
								otherDataFormat + " other data format file");

		  domUtil.appendDoc (problemFormatDoc, 
					 (Element)((Element)root).getFirstChild(), // OBJECTFORMAT tag
					 otherDataFormat);
		}
	  } catch (FileNotFoundException fnf) {
		if (myExtraOutput)
		  System.out.println (getName () + 
							  ".sendFormat could not find optional file : " + 
							  otherDataFormat );
	  }

      // append the scheduling specs
      String specsFile;
	  
	  if (!ignoreSpecsFile) {
		specsFile = getSpecsFile();

		if (myExtraOutput)
		  System.out.println (getName () + ".sendFormat - appending " + 
							  specsFile + " vishnu specs xml file");

		domUtil.appendDoc (problemFormatDoc, specsFile);
	  }

      // append the ga specs
      specsFile = getGASpecsFile(); 

      if (myExtraOutput)
		System.out.println (getName () + ".sendFormat - appending " + 
							specsFile + " vishnu ga specs xml file");

      domUtil.appendDoc (problemFormatDoc, specsFile);

      // send to postdata URL
      serializeAndPostProblem (problemFormatDoc);
    } catch (Exception ioe) {
      System.out.println ("send Format - Exception " + ioe.getMessage());
      ioe.printStackTrace ();
    }
    return nameInfo;
  }

  /** uses formatXMLizer to generate XML for Vishnu */
  protected Document getFormatDoc (Collection taskAndAssets, String assetClassName) {
	FormatXMLize formatXMLizer = new FormatXMLize (debugFormatXMLizer);
    return formatXMLizer.createDoc (taskAndAssets, assetClassName);
  }

  /** 
   * Uses dataXMLizer to generate XML for Vishnu 
   *
   * Passes nameToDescrip Map to dataXMLizer so can rename fields to be unique.
   *
   * @param taskAndAssets what to send
   * @param nameToDescrip mapping of object type to object description (field names, etc.)
   */
  protected Document getDataDoc (Collection taskAndAssets, DataXMLize dataXMLizer, String assetClassName) {
	return dataXMLizer.createDoc (taskAndAssets, assetClassName);
  }

  /**
   * <pre>
   * get the file containing the other data object format
   *
   * If the parameter "otherDataFormatFile" is set, it will look
   * for a file in the data directory with a name equal to the 
   * value of the parameter.  
   * Otherwise, looks for a file called <ClusterName>.odf.xml.
   *
   * </pre>
   * @see #getNeededFile
   * @return filename of other data object format file
   */
  protected String getOtherDataFormat () {
	return getNeededFile ("otherDataFormatFile", OTHER_FORMAT_SUFFIX);
  }

  /**
   * <pre>
   * get the file containing the other data
   *
   * If the parameter "otherDataFile" is set, it will look
   * for a file in the data directory with a name equal to the 
   * value of the parameter.
   * Otherwise, looks for a file called <ClusterName>.odd.xml.
   *
   * </pre>
   * @see #getNeededFile
   * @return filename of other data object(s)
   */
  protected String getOtherData () {
	return getNeededFile ("otherDataFile", OTHER_DATA_SUFFIX);
  }

  /**
   * <pre>
   * get the file containing the vishnu scheduling specs
   *
   * If the parameter "specsFile" is set, it will look
   * for a file in the data directory with a name equal to the 
   * value of the parameter.
   * Otherwise, looks for a file called <ClusterName>.vsh.xml.
   *
   * </pre>
   * @see #getNeededFile
   * @return filename of specs file
   */
  protected String getSpecsFile () {
	return getNeededFile ("specsFile", SPECS_SUFFIX);
  }

  /**
   * <pre>
   * get the file containing the ga parameters for VISHNU
   *
   * If the parameter "gaFile" is set, it will look
   * for a file in the data directory with a name equal to the 
   * value of the parameter.
   * Otherwise, looks for a file called <ClusterName>.ga.xml.
   *
   * return relative path of env file with which to start the
   * Vishnu Scheduler.
   * </pre>
   * @see #getNeededFile
   * @return relative path to specs parameters
   */
  protected String getGASpecsFile () {
	return getNeededFile ("gaFile", GA_SUFFIX);
  }

  /**
   * <pre>
   * Get file name for input file.  If the parameter exists, use it,
   * otherwise append the defaultSuffix to the cluster name and use that.
   *
   * If there are more than one vishnu plugins in a cluster, one should
   * set the parameter to the name of the file.
   * </pre>
   */
  protected String getNeededFile (String paramName, String defaultSuffix) {
    String envFile  = null;
    try {
	  envFile = getMyParams().getStringParam (paramName);
	  if (myExtraOutput)
		System.out.println ("getNeededFile - envFile = " + envFile);
    } 
    catch (ParamException pe) { // no parameter, try default
	  envFile = getClusterName () + defaultSuffix;
    }
	
    return envFile;
  }

  /**
   * <pre>
   * Looks at all the object format nodes in the document
   * and removes duplicates (two object formats with the same name and 
   * same fields).
   * 
   * Object formats that have the same name but with different fields are 
   * renamed to make them distinct.
   *
   * addFieldsForDifferentTypes adds fields to refer to the new
   * unique names, and setObjectNames renames the object formats.
   * 
   * The returned maps are needed for the object data phase, so we
   * can figure out what the unique type should be for a data object
   * with an ambiguous type.
   *
   * </pre>
   * @param root - where to start in document
   * @param doc - doc to remove the duplicates from
   * @return Map [] containing two maps - name to object description
   *         and name to node
   */ 
  protected Map [] removeDuplicates (Node root, Document doc) {
    Set children = new HashSet ();

    NodeList nlist = root.getChildNodes();

    Map nameToNodes   = new HashMap ();
    Map nameToDescrip = new HashMap ();

	Set potentialDuplicates = new HashSet ();
	
    for (int i = 0; i < nlist.getLength(); i++) {
      Node child = nlist.item (i);
      String attr = 
		child.getAttributes().getNamedItem ("name").getNodeValue().toLowerCase();
      
      boolean duplicate = false;
      List nodes = (List) nameToNodes.get (attr);
      if (nodes == null)
		nameToNodes.put (attr, (nodes = new ArrayList()));
      nodes.add (child);

	  if (nodes.size () > 1)
		potentialDuplicates.add (attr);
	  
      ObjectDescrip descrip = (ObjectDescrip) nameToDescrip.get (attr);
      if (descrip == null) {
		if (myExtraExtraOutput)
		  System.out.println ("creating object descrip for - " + attr);

		descrip = new ObjectDescrip ();
		nameToDescrip.put (attr, descrip);
      }
      descrip.addFields (child);
    }

	processObjectFormats (root, nameToNodes, potentialDuplicates, new DuplicateProcessor ());
	processObjectFormats (root, nameToNodes, potentialDuplicates, new MergeProcessor ());
	
    addFieldsForDifferentTypes (root, doc, nameToNodes, nameToDescrip);

	// possibly unnecessary
	processObjectFormats (root, nameToNodes, potentialDuplicates, new DuplicateProcessor ());
	processObjectFormats (root, nameToNodes, potentialDuplicates, new MergeProcessor ());

    return new Map [] { nameToDescrip, nameToNodes };
  }

  /**
   * <pre>
   * Given a set of potential duplicate types, removes those that are duplicates
   * from the set of DOM Node OBJECTFORMATs sent to Vishnu.
   * </pre>
   * Removes duplicate OBJECTFORMATs from <code>root</code>.
   * <pre>
   * 
   * If there is only one remaining Node for a type in potentialDuplicates, the type
   * is removed from the list of potential duplicates.
   *
   * First finds those nodes that should be removed and then removes them in a separate 
   * step.
   * </pre>
   * @param potentialDuplicates set of type names of potential duplicates
   * @param nameToNodes list of DOM Nodes for type 
   * @param root DATAFORMAT tag which is the parent of all OBJECTFORMATs
   */
  protected void processObjectFormats (Node root, Map nameToNodes, Set potentialDuplicates, 
									   FormatProcessor formatProcessor) {
    Set toRemove = new HashSet ();
	Set dupsToRemove = new HashSet ();
    for (Iterator iter = potentialDuplicates.iterator (); iter.hasNext(); ){
      String type = (String) iter.next();
	  
	  if (myExtraExtraOutput)
		System.out.println (getName() + ".pruneObjectFormat - type " + type);
	  
	  List nodesForType = (List) nameToNodes.get (type);
	  List copyOfNodesForType = new ArrayList (nodesForType);
	  if (myExtraExtraOutput)
		System.out.println ("nodes for type " + nodesForType);

	  Set nameToNodeToRemove = new HashSet ();
	  for (Iterator iter2 = copyOfNodesForType.iterator (); iter2.hasNext(); ){
		Node objectFormat = (Node) iter2.next();
		formatProcessor.examineObjectFormat (objectFormat, nodesForType, iter2, toRemove);
	  }
	  if (nodesForType.size () == 1) {
		if (myExtraExtraOutput)
		  System.out.println ("\tremoving " + type);
		dupsToRemove.add (type);
	  }
    }
	if (myExtraExtraOutput)
	  System.out.println (getName() + ".pruneObjectFormat - removing " + 
						  dupsToRemove + " from " + potentialDuplicates);
	potentialDuplicates.removeAll (dupsToRemove);
	if (myExtraExtraOutput)
	  System.out.println (getName () + ".pruneObjectFormat - " + 
						  potentialDuplicates.size () + " potential dups remain.");

    for (Iterator iter = toRemove.iterator (); iter.hasNext (); )
      root.removeChild ((Node) iter.next ());
  }
  
  class FormatProcessor {
	protected void examineObjectFormat (Node objectFormat, List nodesForType, Iterator iter, Set toRemove) {};
  }
  
  class MergeProcessor extends FormatProcessor {
	protected void examineObjectFormat (Node objectFormat, List nodesForType, Iterator iter, Set toRemove) {
	  mergeNode (objectFormat, nodesForType, iter);
	}
  }
  
  class DuplicateProcessor extends FormatProcessor {
	protected void examineObjectFormat (Node objectFormat, List nodesForType, Iterator iter, Set toRemove) {
	  if (duplicateNode (objectFormat, nodesForType)) {
		if (myExtraExtraOutput)
		  System.out.println ("\tfound dup");
		toRemove.add (objectFormat);
	  }
	}
  }

  /**
   * <pre>
   * Checks to see if first is an object format that has already been
   * seen when iterating over the document.
   * 
   * Duplicates can be subsets -- i.e. have some subset of the fields
   * of another object with this name.
   *
   * NOTE : if <code>first</code> is a duplicate of another of the Nodes in 
   * <code>nodes</code>, first is removed from the nodes list.
   *  
   * If something is a resource, it should not be seen as a duplicate of
   * another object that is not a resource!
   *
   * </pre>
   * @param first - the node itself
   * @param nameToNodes - hash that records name -> object format node mappings
   * @return true if it's a duplicate of one already seen
   */
  protected boolean duplicateNode (Node first, List nodes) {
    if (nodes.size () == 1)
      return false; // if no others to compare against, it's not a duplicate

    NodeList firstChildNodes  = first.getChildNodes ();

    for (int i = 0; i < nodes.size (); i++) {
      Node other = (Node) nodes.get (i);
      if (first == other)
		continue;  // ignore self to tell if duplicate

      NodeList otherChildNodes = other.getChildNodes ();

	  if (firstChildNodes.getLength () > otherChildNodes.getLength ())
	  	continue; // can't be a subset if more fields

	  // create name->type mapping for other node
      Map otherFieldToType = new HashMap ();

      for (int k = 0; k < otherChildNodes.getLength (); k++) {
		String field = otherChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		String type  = otherChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();
		otherFieldToType.put (field, type);
      }

      boolean allFound = true;
      // go through fields of node we're checking
      for (int k = 0; k < firstChildNodes.getLength (); k++) {
		String firstChildName = 
		  firstChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		String otherType = (String) otherFieldToType.get (firstChildName);

		if (otherType == null) {
		  allFound = false;
		  break;
		}
		else {
		  String firstChildType = 
			firstChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();

		  if (!firstChildType.equals (otherType)) {
			allFound = false;
			break;
		  }
		}
      }
	  
      // we found all the fields of the first node in the fields of another ->
      // it's a subset node...
      if (allFound) {
		if (myExtraExtraOutput) {
		  String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
		  System.out.println ("VishnuPlugIn.duplicateNode - Found a duplicate " + first.getNodeName () + " " + name);
		}
		setResourceAttributes (first, other);
		
		nodes.remove (first);
		return true;
      }
    }
    return false;
  }

  protected void mergeNode (Node first, List nodes, Iterator nodeListIter) {
	if (myExtraOutput) {
	  String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
	  System.out.println (getName() + ".mergeNode - examining " + first.getNodeName () + " " + name);
	}

    if (nodes.size () == 1)
      return; // if no others to compare against, it's not a duplicate

    NodeList firstChildNodes  = first.getChildNodes ();

	Map firstFieldToType = new HashMap ();

	for (int k = 0; k < firstChildNodes.getLength (); k++) {
	  String firstChildName = 
		firstChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
	  String type  = 
		firstChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();
	  firstFieldToType.put (firstChildName, type);
	}
	
    for (int i = 0; i < nodes.size (); i++) {
      Node other = (Node) nodes.get (i);
      if (first == other)
		continue;  // ignore self to tell if duplicate

      NodeList otherChildNodes = other.getChildNodes ();

	  //	  if (firstChildNodes.getLength () > otherChildNodes.getLength ())
	  //	  	continue; // can't be a subset if more fields

	  // create name->type mapping for other node
      Map otherFieldToType = new HashMap ();
	  Map otherNameToNode  = new HashMap ();

	  boolean hasTypeCollision = false;
      for (int k = 0; k < otherChildNodes.getLength (); k++) {
		String field = otherChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		String type  = otherChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();
		if (myExtraOutput)
		  System.out.println (getName() + ".mergeNodes - other field " + field + " - type " + type);
		
		if (firstFieldToType.containsKey(field) &&
			!firstFieldToType.get(field).equals (type)) {
		  if (myExtraOutput)
			System.out.println (getName() + ".mergeNodes - found type collision at " + field + " - " + 
								firstFieldToType.get(field) + " vs " + type);
		  hasTypeCollision=true;
		  break;
		}
		
		otherFieldToType.put (field, type);
		otherNameToNode.put  (field, otherChildNodes.item (k));
      }

	  if (hasTypeCollision) continue; // can't merge

	  Map namesInOther = new HashMap (otherFieldToType);
	  namesInOther.entrySet().removeAll (firstFieldToType.entrySet());
	  
	  for (Iterator iter = namesInOther.keySet ().iterator(); iter.hasNext();) {
		Object fieldName = iter.next();
		Node otherNode = (Node) otherNameToNode.get (fieldName);
		// add new fields
		first.appendChild (otherNode);
		firstFieldToType.put (fieldName, namesInOther.get(fieldName));
	  }

	  if (myExtraOutput) {
		String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
		System.out.println (getName() + ".mergeNode - Found a mergable node " + first.getNodeName () + " " + name);
	  }
	  setResourceAttributes (first, other);
		
	  nodeListIter.remove ();
	}
  }

  protected void setResourceAttributes (Node first, Node other) {
	boolean thisIsResource = 
	  first.getAttributes().getNamedItem ("is_resource").getNodeValue().equals("true");
	boolean otherIsNotResource = 
	  other.getAttributes().getNamedItem ("is_resource").getNodeValue().equals("false");
	if (thisIsResource && otherIsNotResource) {
	  if (myExtraExtraOutput) {
		String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
		System.out.println (getName() + ".mergeNode - Found a mergable node - setting resource attribute for duplicate " + name);
	  }
		  
	  other.getAttributes().getNamedItem ("is_resource").setNodeValue("true");

	  // set is_key attribute on other object format
      NodeList otherChildNodes = other.getChildNodes ();
	  for (int k = 0; k < otherChildNodes.getLength (); k++) {
		String field = otherChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		if (field.equals("UID")) {
		  otherChildNodes.item (k).getAttributes().getNamedItem ("is_key").setNodeValue("true");
		  break;
		}
	  }
	}
  }
  
  /**
   * <pre>
   * Add new fields
   *
   * Where there was :
   * FIELDFORMAT datatype="indirectObject" ... is_subobject="true" name="indirectObject"
   *
   * now have :
   *
   * FIELDFORMAT datatype="indirectObject_0" ... is_subobject="true" name="indirectObject_0"
   * FIELDFORMAT datatype="indirectObject_1" ... is_subobject="true" name="indirectObject_1"
   * FIELDFORMAT datatype="string(128)"      ... is_subobject="true" name="indirectObject_2"
   * 
   * for as many duplicates as there are in the nameToNode map.
   *
   * nameToDescrip is used to lookup the object description for a type.  Then for each
   * field in the object description, if there is more than one known type for that field, 
   * adds new fields with unique names for each type.
   *
   * nameToDescrip is created in removeDuplicates
   *
   * </pre>
   * @see #removeDuplicates
   * @param root - of the document
   * @param doc - needed so can manufacture new nodes (fields), gets altered through addition of
   *              new fields
   * @param nameToNodes   -- per field name, holds all the different possible object formats
   * @param nameToDescrip -- contents are altered to record new name->type pairs
   */
  protected void addFieldsForDifferentTypes (Node root, Document doc, Map nameToNodes, Map nameToDescrip) {
    NodeList nlist = root.getChildNodes();

    Map nodeToNewFields = new HashMap ();
    Map nodeToRemoveFields = new HashMap ();

    for (int i = 0; i < nlist.getLength(); i++) {
      Node objectFormat = nlist.item (i);
      NodeList objectFormatNodeList = objectFormat.getChildNodes ();
      Set fieldsToAdd = new TreeSet (new Comparator () {
		  public int compare (Object o1, Object o2) {
			String n1 = ((Node) o1).getAttributes().getNamedItem("name").getNodeValue();
			String n2 = ((Node) o2).getAttributes().getNamedItem("name").getNodeValue();
			return n1.compareTo (n2);
		  }
		});
	  Set fieldsToRemove = new HashSet ();
      nodeToNewFields.put    (objectFormat, fieldsToAdd);
      nodeToRemoveFields.put (objectFormat, fieldsToRemove);

      String name = objectFormat.getAttributes().getNamedItem ("name").getNodeValue().toLowerCase();
      ObjectDescrip descrip = (ObjectDescrip) nameToDescrip.get (name);

	  if (myExtraOutput)
		System.out.println (getName () + ".addFieldsForDifferentTypes - " + 
							name + " has " + 
							objectFormatNodeList.getLength() + " children");
	  
      for (int j = 0; j < objectFormatNodeList.getLength(); j++) {
		Node fieldFormat = objectFormatNodeList.item (j);
		String fieldName = fieldFormat.getAttributes().getNamedItem("name").getNodeValue();
		String datatype  = fieldFormat.getAttributes().getNamedItem("datatype").getNodeValue();
		if (myExtraOutput)
		  System.out.println (getName () + ".addFieldsForDifferentTypes - " + datatype + "-" + fieldName);

		if (descrip == null) {
		  System.out.println (getName () + ".addFieldsForDifferentTypes - huh? no " + name);
		  continue;
		}

		Set knownTypes = descrip.typesForField (fieldName);

		int distinctNames=0;
		
		if (knownTypes.size () > 1) {
		  fieldsToRemove.add (fieldFormat);
		  if (myExtraOutput)
			System.out.println (getName () + ".addFieldsForDifferentTypes - will remove " + 
								fieldName + "-" + 
								datatype);
		  for (Iterator iter = knownTypes.iterator (); iter.hasNext();) {
			String newtype = (String) iter.next();
			/*			if (newtype.equals (datatype) ||
				(newtype.startsWith ("string(") && (datatype.startsWith ("string(")))) {
			  if (myExtraOutput)
				System.out.println (getName () + ".addFieldsForDifferentTypes - skipping field " + 
									newtype + "-" + 
									name);
			  continue;
			}
			*/

			Node clone = domUtil.createClone(fieldFormat, doc);
			String newname = fieldName + SEPARATOR + distinctNames++;
		  
			descrip.addNewNameType (fieldName, newname, newtype);

			clone.getAttributes().getNamedItem("name").setNodeValue(newname);
			clone.getAttributes().getNamedItem("datatype").setNodeValue(newtype);
			clone.getAttributes().getNamedItem("is_subobject").setNodeValue(isObject(newtype) ? "true" : "false");
			boolean result = fieldsToAdd.add (clone);
			if (myExtraOutput && result)
			  System.out.println (getName () + ".addFieldsForDifferentTypes - storing new field " + 
								  newtype + "-" + 
								  newname);
		  }
		}
      }
    }

    // go through each OBJECTFORMAT node and add any new fields
    for (Iterator iter = nodeToNewFields.keySet().iterator (); iter.hasNext ();) {
      Node objectFormatNode = (Node) iter.next ();
      Set removeFields = (Set) nodeToRemoveFields.get (objectFormatNode);
	  for (Iterator iter2 = removeFields.iterator (); iter2.hasNext ();)
		objectFormatNode.removeChild ((Node)iter2.next());

      Set newFields = (Set) nodeToNewFields.get (objectFormatNode);
      
      if (!newFields.isEmpty ()) {
		for (Iterator iter2 = newFields.iterator (); iter2.hasNext ();) {
		  Node newNode = (Node) iter2.next ();
		  if (myExtraOutput) {
			String type = newNode.getAttributes().getNamedItem("datatype").getNodeValue();
			String name = newNode.getAttributes().getNamedItem("name").getNodeValue();

			String ofName = 
			  objectFormatNode.getAttributes().getNamedItem("name").getNodeValue();
			System.out.println (getName () + ".addFieldsForDifferentTypes - to node " + 
								objectFormatNode.getNodeName () + "/" + 
								ofName + " adding new field " +
								newNode.getNodeName () + " - " +
								type + " : " + 
								name);
		  }

		  objectFormatNode.appendChild (newNode);
		}
      }
    }
  }

  /** check type and see if it is not a primitive = object */
    protected boolean isObject (String type) {
      return (!type.equals ("number") &&
	      !type.equals ("datetime") &&
	      !type.equals ("latlong") &&
	      !type.equals ("boolean") &&
	      !type.startsWith ("string") &&
	      !type.equals ("list") &&
	      !type.equals ("interval") &&
	      !type.equals ("matrix"));
    }

  /**
   * <pre>
   * Send the data section of the problem to the postdata URL.
   *
   * Chunks data into <code>sendDataChunkSize</code> chunks of tasks.
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
	int totalTasks = tasks.size ();
	int totalSent  = 0;

	DataXMLize dataXMLizer = new DataXMLize (debugDataXMLizer);
	dataXMLizer.setNameToDescrip (nameToDescrip);
	dataXMLizer.setResourceName (assetClassName);
	
	while (totalSent < totalTasks) {
	  int toIndex = totalSent+sendDataChunkSize;
	  if (toIndex > totalTasks)
		toIndex = totalTasks;
	  
	  Collection chunk = new ArrayList (tasks.subList (totalSent, toIndex));

	  if (myExtraOutput)
		System.out.println (getName () + ".sendDataToVishnu, from " + totalSent + " to " + toIndex);
	  
	  sendDocument (chunk, dataXMLizer, clearDatabase, sendingChangedObjects, assetClassName);
	  if (clearDatabase) clearDatabase = false; // flip bit after first one
	  totalSent += sendDataChunkSize;
	}

	mySentOtherDataAlready = false;
  }

  protected void sendDocument (Collection tasks, 
							   DataXMLize dataXMLizer,
							   boolean clearDatabase, 
							   boolean sendingChangedObjects,
							   String assetClassName) {
	Document dataDoc = getDataDoc (tasks, dataXMLizer, assetClassName);
	  
	if (showDataXML)
	  System.out.println (domUtil.getDocAsString(dataDoc));

	Node dataNode = setDocHeader (dataDoc, clearDatabase);

	postProcessData (dataDoc, dataNode, sendingChangedObjects);
	  
	serializeAndPostData (dataDoc);
  }
  
  protected Node setDocHeader (Document dataDoc, boolean clearDatabase) {
	Node root = dataDoc.getDocumentElement ();
	((Element)root).setAttribute ("NAME", comm.getProblem ());
	
	Node dataNode   = root.getFirstChild ();
	Node windowNode = dataNode.getFirstChild ();

	((Element)windowNode).setAttribute ("starttime", vishnuEpochStartTime);
	((Element)windowNode).setAttribute ("endtime",   vishnuEpochEndTime);

	NodeList nlist = dataNode.getChildNodes ();

	if (clearDatabase)
	  root.getFirstChild().insertBefore (dataDoc.createElement("CLEARDATABASE"),
										 root.getFirstChild ().getFirstChild ());

	return dataNode;
  }

  protected void postProcessData (Document dataDoc,
								  Node dataNode, boolean sendingChangedObjects) {
	NodeList nlist = dataNode.getChildNodes ();

	for (int i = 0; i < nlist.getLength(); i++) {
	  if (nlist.item (i).getNodeName ().equals ("NEWOBJECTS")) {
		Node newobject = nlist.item (i);
		NodeList objects = newobject.getChildNodes ();

		if (!mySentOtherDataAlready) {
		  appendOtherData (dataDoc, (Element) newobject);
		  mySentOtherDataAlready = true;
		}

		if (sendingChangedObjects) {
		  String was = newobject.getNodeName ();
		  Node changedObjects = dataDoc.createElement("CHANGEDOBJECTS");
		  dataNode.insertBefore(changedObjects, newobject);
		  dataNode.removeChild (newobject);
		  for (int j =  0; j < objects.getLength (); j++)
			changedObjects.appendChild (objects.item (j));
		}

		break; // we're only interested in the NEWOBJECTS tag
	  }
	}
  }
  
  /**
   * <pre>
   * Append any global other data
   * 
   * Global data is optional, so if it can't find the file specified
   * (for instance a default odd file) nothing will happen.
   * </pre>
   */
  protected void appendOtherData (Document dataDoc, Element placeToAdd) {
	String otherData = getOtherData ();
	try {
	  if (getConfigFinder ().open (otherData) != null) {
	  if (myExtraOutput)
		  System.out.println (getName () + " appending " + 
							  otherData + " other data file");

		domUtil.appendChildrenToDoc (dataDoc, 
							 placeToAdd, // NEWOBJECTS tag
							 otherData);
	  }
	} catch (FileNotFoundException fnf) {
	  if (myExtraOutput)
		System.out.println (getName () + ".appendOtherData could not find optional file : " + otherData);
	} catch (IOException ioe) {
	  System.out.println (getName () + ".appendOtherData - got io exception " +
						  ioe);
	}
  }
  
  /**
   * OK - horrible hack -- for allocators, need givenPE, since
   * query won't work within same transaction cycle.
   */
  protected void handleRoleSchedule (Node field, PlanElement givenPE) {
	if (myExtraOutput)
	  System.out.println (getName () + ".handleRoleSchedule - found role schedule.");
	
	Node list = field.getFirstChild ();
	NodeList values = list.getChildNodes ();
	
	for (int i = 0; i < values.getLength(); i++) {
	  Node value = (Node) values.item (i);
	  Node object = value.getFirstChild ();
	  Node startField = object.getFirstChild ();
	  Node endField = object.getLastChild ();
	  
	  final String uid = 
		startField.getAttributes().getNamedItem ("value").getNodeValue();
	  if (myExtraOutput) 
		System.out.println ("Looking for UID " + uid);

	  Collection results;
	  
	  if (givenPE != null) {
		results = new HashSet ();
		results.add (givenPE);
	  }
	  else
		results = query (new UnaryPredicate () {
			public boolean execute (Object obj) {
			  if (obj instanceof PlanElement) {
				//System.out.println ("\t found PE with uid <" + ((PlanElement) obj).getUID () + ">");
				return ((PlanElement) obj).getUID ().equals (uid);
			  }
			
			  return false;
			}
		  });

	  if (results.iterator ().hasNext ()) {
		TimeSpan ts = (TimeSpan) results.iterator ().next ();
	  
		String startString = format.format (new Date (ts.getStartTime ()));
		String endString   = format.format (new Date (ts.getEndTime ()));
	  
		startField.getAttributes().getNamedItem ("value").setNodeValue(startString);
		endField.getAttributes().getNamedItem ("value").setNodeValue(endString);
	  }
	  else
		System.out.println (getName () + ".handleRoleSchedule : ERROR - could not find plan element UID " + 
							uid);
		
	}
	
  }
  
  protected void serializeAndPostData (Document doc) {
      serializeAndPost (doc, true);
  }

  protected void serializeAndPostProblem (Document doc) {
      serializeAndPost (doc, false);
  }

  /**
   * post the Document <code>doc</code> to a URL.                            <p>
   *                                                                        <br>
   * If <code>writeXMLToFile</code> is set, will write a copy of what is     <p>
   * sent to the URL to a file named ClusterName_type_number, where type is  <p>
   * problem (the problem definition) or data (the tasks and resources), and <p>
   * number is a counter that keeps the file names unique                    <p>
   *                                                                        <br>
   * What's written to the file is human readable, whereas if                <p>
   * <code>writeEncodedXMLToFile</code> is set, a different file is written, <p>
   * named ClusterName_encoded_number.  This file contains exactly what is   <p>
   * sent to the web server, after URL encoding has been performed.
   *
   * @param doc - DOM doc to send to URL
   * @param postData - true if posting data 
   */
  protected void serializeAndPost (Document doc, boolean postData) {
	if (runInternal)
	  appendToInternalBuffer( domUtil.getDocAsArray (doc).toString());
	else {
	  if (postData) {
		if (!comm.postData (domUtil.getDocAsArray (doc).toString())) {
		  showPostDataWarning ();
		}
	  }
	  else
		comm.postProblem (domUtil.getDocAsArray (doc).toString());

	  if (writeXMLToFile) {
		String suffix = (postData) ? "data" : "problem";
		String fileName = getClusterName () + "_" + suffix + "_" + numFilesWritten++ + ".xml";
		System.out.println (getName () + ".serializeAndPost - Writing XML to file " + fileName);
		try {
		  FileOutputStream temp = new FileOutputStream (fileName);
		  domUtil.writeDocToStream (doc, temp);
		} catch (FileNotFoundException fnfe) { /* never happen */ }
	  }
	}
  }

  protected void showPostDataWarning () {
	System.out.println ("\n-----------------------------------------------\n" + 
						getName() + ".serializeAndPost - got an error posting data.\n"+
						"\nThis could be due to one of several causes :\n" + 
						"1) Connection problems with the web server, if running with a web server OR \n" +
						"2) An inconsistency between the object format defined for the problem and\n" + 
						"   the data.  You may have to regenerate your object format definition file if you\n" +
						"   see messages like:\n"+
						"<DIV align=left>\n" +
						"Context: parsing data<BR>\n" +
						"Action: object<BR>\n" +
						"Identifier: <BR>\n" +
						"Command: insert into obj_Package values ();<BR>\n" +
						"Database: vishnu_prob_TRANSCOM_pumpernickle<BR>\n" +
						"Error Text: You have an error in your SQL syntax near ');' at line 1<BR><BR>\n" +
						"</DIV>\n\n" +
						"The problem is that the scheduler is expecting the input tasks and assets \n" +
						"to be consistent with the object format, but an unexpected field or object\n" +
						"is being sent.\n" +
						"For more information, contact Gordon Vidaver, gvidaver@bbn.com, 617 873 3558\n"+
						"-----------------------------------------------");
  }
  
  protected void appendToInternalBuffer (String data) {
	int index;
	if ((index = data.indexOf ("?>")) != -1) {
	  String stuff = data.substring (index+2);
	  internalBuffer.append (stuff);
	}
  }

  public boolean waitTillFinished () {
	Date start = new Date();
	
	boolean gotAnswer = comm.waitTillFinished ();

	if (!alwaysClearDatabase)
	  sendFreezeAll ();

	if (showTiming)
	  domUtil.reportTime (" - Vishnu received answer, was waiting for ", start);

    if (gotAnswer)
	  parseAnswer();

    return gotAnswer;
  }

  /**
   * Reads XML from the URL to get the assignments.  Uses AssignmentHandler
   * (SAX) to parse XML.
   *
   * Uses myTaskUIDtoObject to figure out if there were any impossible tasks.
   * (If there were any, they will be in the myTaskUIDtoObject Map.)
   *
   * The AssignmentHandler removes any assigned tasks from myTaskUIDtoObject.
   *
   * @param postVars - the variables to send to the script
   */
  protected void parseAnswer() {
	if (myExtraOutput)
	  System.out.println (getName() + ".waitTillFinished - Vishnu scheduler result returned!");
	int unhandledTasks = myTaskUIDtoObject.size ();

	comm.getAnswer (new AssignmentHandler ());

	if (myExtraOutput)
	  System.out.println (getName () + ".parseAnswer - created successful plan elements for " +
						  (unhandledTasks-myTaskUIDtoObject.size ()) + " tasks.");

	handleImpossibleTasks (myTaskUIDtoObject.values ());
	myTaskUIDtoObject.clear ();
  }

  protected void sendFreezeAll () {
	Document doc = new DocumentImpl ();
    Element newRoot = doc.createElement("PROBLEM");
	newRoot.setAttribute ("NAME", comm.getProblem ());
    doc.appendChild(newRoot);
	
	Element freeze = doc.createElement("FREEZEALL");
	newRoot.appendChild (freeze);

	serializeAndPostData (doc);
  }

  protected void clearInternalBuffer () {
	internalBuffer = new StringBuffer ();
  }

  /**
   * this is where we look up unique ids
   */
  public class AssignmentHandler extends DefaultHandler {
	/**
	 * just calls parseStartElement in plugin
	 */
	public void startElement (String uri, String local, String name, Attributes atts) throws SAXException {
	  parseStartElement (name, atts);
    }
	/**
	 * just calls parseEndElement in plugin
	 */
	public void endElement (String uri, String local, String name) throws SAXException {
	  parseEndElement (name);
    }
  }

  protected Asset assignedAsset;
  protected Date start, end, setup, wrapup;
  protected Vector alpTasks = new Vector ();

  protected void parseStartElement (String name, Attributes atts) {
  try {
	  if (myExtraExtraOutput || debugParseAnswer)
		System.out.println (getName() + ".parseStartElement got " + name);
	  
	  if (name.equals ("ASSIGNMENT")) {
		if (myExtraOutput) {
		  System.out.println (getName () + ".parseStartElement -\nAssignment: task = " + atts.getValue ("task") +
							  " resource = " + atts.getValue ("resource") +
							  " start = " + atts.getValue ("start") +
							  " end = " + atts.getValue ("end"));
		}
		String taskUID     = atts.getValue ("task");
		String resourceUID = atts.getValue ("resource");
		String startTime   = atts.getValue ("start");
		String endTime     = atts.getValue ("end");
		String setupTime   = atts.getValue ("setup");
		String wrapupTime  = atts.getValue ("wrapup");
		Date start         = format.parse (startTime);
		Date end           = format.parse (endTime);
		Date setup         = format.parse (setupTime);
		Date wrapup        = format.parse (wrapupTime);

		StringKey taskKey = new StringKey (taskUID);
		Task handledTask    = (Task)  myTaskUIDtoObject.get (taskKey);
		if (handledTask == null) {
		  System.out.println ("VishnuPlugIn - AssignmentHandler.startElement no task found with " + taskUID);
		  System.out.println ("\tmap was " + myTaskUIDtoObject);
		}
		else {
		  myTaskUIDtoObject.remove (taskKey);
		}

		Asset assignedAsset = (Asset) myAssetUIDtoObject.get (new StringKey (resourceUID));
		if (assignedAsset == null) 
		  System.out.println ("VishnuPlugIn - AssignmentHandler.startElement no asset found with " + resourceUID);
	
		myFrozenTasks.add (handledTask);
	  
		handleAssignment (handledTask, assignedAsset, start, end, setup, wrapup);
	  }
	  else if (name.equals ("MULTITASK")) {
		if (myExtraOutput || debugParseAnswer) {
		  System.out.println (getName () + ".parseStartElement -\nAssignment: " + 
							  " resource = " + atts.getValue ("resource") +
							  " start = " + atts.getValue ("start") +
							  " end = " + atts.getValue ("end") +
							  " setup = " + atts.getValue ("setup") +
							  " wrapup = " + atts.getValue ("wrapup"));
		}
		String taskList    = atts.getValue ("tasklist");
		String resourceUID = atts.getValue ("resource");
		String startTime   = atts.getValue ("start");
		String endTime     = atts.getValue ("end");
		String setupTime   = atts.getValue ("setup");
		String wrapupTime  = atts.getValue ("wrapup");
		start     = format.parse (startTime);
		end       = format.parse (endTime);
		setup     = format.parse (setupTime);
		wrapup    = format.parse (wrapupTime);

		assignedAsset = (Asset) myAssetUIDtoObject.get (new StringKey (resourceUID));
		if (assignedAsset == null) 
		  System.out.println (getName () + ".parseStartElement - no asset found with " + resourceUID);
	  }
	  else if (name.equals ("TASK")) {
		if (myExtraOutput || debugParseAnswer) {
		  System.out.println (getName () + ".parseStartElement -\nTask: " + 
							  " task = " + atts.getValue ("task"));
		}
		String taskUID = atts.getValue ("task");

		StringKey taskKey = new StringKey (taskUID);
		Task handledTask = (Task) myTaskUIDtoObject.get (taskKey);
		if (handledTask == null) 
		  System.out.println (getName () + ".parseStartElement - no task found with " + taskUID + 
							  " uid.");
		else
		  alpTasks.add (handledTask);

		// this is absolutely critical, otherwise VishnuPlugIn will make a failed disposition
		myTaskUIDtoObject.remove (taskKey);
		myFrozenTasks.add (handledTask);
	  }
	  else if (debugParseAnswer) {
		System.out.println (getName () + ".parseStartElement - ignoring tag " + name);
	  }
	} catch (NullPointerException npe) {
	  System.out.println (getName () + ".parseStartElement - got bogus assignment");
	  npe.printStackTrace ();
	} catch (ParseException pe) {
	  System.out.println (getName () + ".parseStartElement - start or end time is in bad format " + 
						  pe + "\ndates were : " +
						  " start = " + atts.getValue ("start") +
						  " end = " + atts.getValue ("end") +
						  " setup = " + atts.getValue ("setup") +
						  " wrapup = " + atts.getValue ("wrapup"));
	}
  }

  protected void parseEndElement (String name) {
	if (name.equals ("MULTITASK")) {
	  if (debugParseAnswer) {
		System.out.println (getName () + ".parseEndElement - got ending MULTITASK.");
	  }
	  for (int i = 0; i < alpTasks.size (); i++)
		handleAssignment ((Task) alpTasks.get(i), assignedAsset, start, end, setup, wrapup);
	  alpTasks.clear ();
	}
	else if (name.equals ("TASK")) {}
	else if (debugParseAnswer) {
	  System.out.println (getName () + ".parseEndElement - ignoring tag " + name);
	}
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
	
	for (Iterator iter = impossibleTasks.iterator (); iter.hasNext ();)
	    publishAdd (UTILAllocate.makeFailedDisposition (this, ldmf, 
							    (Task) iter.next ()));
  }

  protected void handleAssignment (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {}

  protected AllocationResultAggregator skipTransitARA = new VishnuAllocationResultAggregator ();

  protected List makeSetupWrapupExpansion (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
    if (myExtraOutput)
	  System.out.println (getName () + ".makeSetupWrapupExpansion : " + 
			" assigning " + task.getUID() + 
			"\nto " + asset.getUID () +
			" from " + start + 
			" to " + end);
    boolean wantConfidence = false;
    
	// if true, the estimated alloc result has a medium confidence 
    try { wantConfidence = getMyParams().getBooleanParam ("wantMediumConfidenceOnExpansion"); }
    catch (Exception e) {}

	Vector subtasks = new Vector ();
	
	subtasks.add (createMainTask (task, asset, start, end, setupStart, wrapupEnd));

	if (makeSetupAndWrapupTasks) {
	  if (setupStart.getTime() < start.getTime()) {
		subtasks.add (createSetupTask (task, asset, start, end, setupStart, wrapupEnd));
		if (myExtraOutput)
		  System.out.println (getName () + ".makeSetupWrapupExpansion : making setup task for " + task.getUID());
	  }

	  if (wrapupEnd.getTime() > end.getTime()) {
		subtasks.add (createWrapupTask (task, asset, start, end, setupStart, wrapupEnd));
		if (myExtraOutput)
		  System.out.println (getName () + ".makeSetupWrapupExpansion : making wrapup task for " + task.getUID());
	  }
	}

    publishSubtasks (wantConfidence, task, subtasks);
	
	return subtasks;
  }

  protected Task createMainTask (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
	NewTask mainTask = (NewTask) UTILExpand.makeSubTask (ldmf, task, task.getDirectObject(), task.getSource());
	mainTask.setPrepositionalPhrases (getPrepPhrases (task, asset).elements());
	mainTask.setPreferences (getPreferences (task, start, start, end, end).elements());
	if (myExtraOutput) System.out.println (getName () + ".createMainTask : made main task : " + mainTask.getUID());
	return mainTask;
  }

  protected Task createSetupTask (Task task, Asset asset, Date start, Date end, Date setupStart, Date wrapupEnd) {
	NewTask setupTask = (NewTask) UTILExpand.makeSubTask (ldmf, task, task.getDirectObject(), task.getSource());
	setupTask.setVerb (Constants.Verb.Transit);
	setupTask.setPrepositionalPhrases (getPrepPhrases (task, asset).elements());
	setupTask.setPreferences (getPreferences (task, setupStart, setupStart, start, start).elements());
	if (myExtraOutput) System.out.println (getName () + ".createSetupTask : made setup task : " + setupTask.getUID());
	return setupTask;
  }

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

  public class ObjectDescrip {
    Map fields = new HashMap ();
    Map newNames = new HashMap ();

	boolean debug = false;
	
    public void addFields (Node node) {
      NodeList nlist = node.getChildNodes();

      for (int i = 0; i < nlist.getLength(); i++) {
		Node field = nlist.item (i);

		String name = field.getAttributes().getNamedItem ("name").getNodeValue();
		String type = field.getAttributes().getNamedItem ("datatype").getNodeValue();
	
		addField (name, type);
      }
    }

    public void addField (String name, String type) {
      Set namedFields = (Set) fields.get (name);

      if (namedFields == null) {
		namedFields = new TreeSet ();
		fields.put (name, namedFields);
      }

      if (!namedFields.contains (type)) {
		namedFields.add (type);
		if (debug && namedFields.size () > 1)
		  System.out.println ("\tfield " + name + 
							  " now " + namedFields);
      }
    }

    public void addNewNameType (String oldname, String newname, String newtype) {
      Set nameTypePairs = (Set) newNames.get (oldname);

      if (nameTypePairs == null) {
		nameTypePairs = new HashSet ();
		newNames.put (oldname, nameTypePairs);
      }
	  if (debug)
		System.out.println ("OD.addNewNameType - for oldname " + oldname + 
							" adding newname " + newname + 
							" newtype " + newtype);
	  
      nameTypePairs.add (new String [] { newname, newtype });
    }

    public Set getNameTypePairs (String oldname) {
      return (Set) newNames.get (oldname);
    }

    public Set typesForField (String name) {
      return (Set) fields.get (name);
    }
    
    public Map getFields () { return fields; }
  }

  protected StringBuffer internalBuffer = new StringBuffer ();
  protected Map myTypesToNodes, myNameToDescrip;

  protected UTILAssetCallback         myAssetCallback;
  protected int firstTemplateTasks;
  protected int sendDataChunkSize;
  protected boolean sentFormatAlready = false;
  protected boolean mySentOtherDataAlready = false;
  protected boolean mySentAssetDataAlready = false;
  protected Map myTaskUIDtoObject = new HashMap ();
  protected Map myAssetUIDtoObject = new HashMap ();
  protected Set myFrozenTasks = new HashSet ();

  protected String hostName = "dante.bbn.com";

  protected boolean testing = false;
  protected boolean showFormatXML = false;
  protected boolean showDataXML = false;
  protected boolean ignoreSpecsFile = false;
  protected boolean sendSpecsEveryTime = false;
  protected boolean alwaysClearDatabase = false;
  protected boolean showTiming = true;
  protected boolean writeXMLToFile = false;

  protected int numFilesWritten = 0; // how many files have been written out via the writeXMLToFile flag
  protected boolean sendRoleScheduleUpdates = false;
  protected boolean makeSetupAndWrapupTasks = true;
  protected boolean runInternal = true;
  protected boolean debugFormatXMLizer = false;
  protected boolean debugDataXMLizer = false;

  protected String vishnuEpochStartTime;
  protected String vishnuEpochEndTime;

  private boolean debugParseAnswer = false;

  protected VishnuComm comm;
  protected VishnuDomUtil domUtil;
  protected String singleAssetClassName;
}
