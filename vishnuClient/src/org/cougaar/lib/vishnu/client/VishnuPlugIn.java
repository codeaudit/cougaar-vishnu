/* $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/client/Attic/VishnuPlugIn.java,v 1.5 2001-02-14 00:15:46 gvidaver Exp $ */

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
import org.cougaar.core.util.XMLizable;

import java.io.CharArrayReader;
import java.io.CharArrayWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.IOException;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;

import java.net.MalformedURLException;
import java.net.Socket;
import java.net.UnknownHostException;
import java.net.URL;
import java.net.URLConnection;

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
import java.util.TreeSet;
import java.util.Vector;

import org.apache.xerces.dom.DocumentImpl;
import org.apache.xerces.parsers.DOMParser;
import org.apache.xerces.parsers.SAXParser;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.TextSerializer;
import org.apache.xml.serialize.XMLSerializer;

import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Text;

import org.xml.sax.AttributeList;
import org.xml.sax.HandlerBase;
import org.xml.sax.InputSource;
import org.xml.sax.Parser;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.ParserFactory;

import org.cougaar.lib.vishnu.server.Scheduler;
	
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

  private static Map clusterToInstance = new HashMap ();

  /**
   * Here all the various runtime parameters get set.  See documentation for details.
   */
  public void localSetup() {     
    super.localSetup();

    try {hostName = getMyParams().getStringParam("hostName");}    
    catch(Exception e) {hostName = "dante.bbn.com";}

    try {phpPath = getMyParams().getStringParam("phpPath");}    
    catch(Exception e) {phpPath = "/~dmontana/vishnu/";}

    try {myUser = getMyParams().getStringParam("user");}    
    catch(Exception e) {myUser = "vishnu";}

    try { myPassword = getMyParams().getStringParam("password");} 
	catch(Exception e) {myPassword = "vishnu";}

    try {postProblemFile = getMyParams().getStringParam("postProblemFile");}    
    catch(Exception e) {postProblemFile = "postproblem" + PHP_SUFFIX;}

    try {postDataFile = getMyParams().getStringParam("postDataFile");}    
    catch(Exception e) {postDataFile = "postdata" + PHP_SUFFIX;}

    try {kickoffFile = getMyParams().getStringParam("kickoffFile");}    
    catch(Exception e) {kickoffFile = "postkickoff" + PHP_SUFFIX;}

    try {readStatusFile = getMyParams().getStringParam("readStatusFile");}    
    catch(Exception e) {readStatusFile = "readstatus" + PHP_SUFFIX;}

    try {assignmentsFile = getMyParams().getStringParam("assignmentsFile");}    
    catch(Exception e) {assignmentsFile = "assignments" + PHP_SUFFIX;}

    try {testing = getMyParams().getBooleanParam("testing");}    
    catch(Exception e) {testing = false;}

    try {showALPXML = getMyParams().getBooleanParam("showALPXML");}    
    catch(Exception e) {showALPXML = false;}

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

	// writes the XML sent to Vishnu web server to a file (machine readable)
    try {writeEncodedXMLToFile = 
		   getMyParams().getBooleanParam("writeEncodedXMLToFile");}    
    catch(Exception e) {writeEncodedXMLToFile = false;}

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

    // seconds - total wait time is maxWaitCycles * waitTime
    try {waitTime = getMyParams().getLongParam("waitTime")*1000L;}    
    catch(Exception e) {waitTime = 5000L;}

    // how many times to poll Vishnu before giving up 
	// total wait time is maxWaitCycles * waitTime
    try {maxWaitCycles = getMyParams().getIntParam("maxWaitCycles");}    
    catch(Exception e) {maxWaitCycles = 10;}

    // how many of the input tasks to use as templates when producing the 
	// OBJECT FORMAT for tasks
    try {firstTemplateTasks = getMyParams().getIntParam("firstTemplateTasks");}    
    catch(Exception e) {firstTemplateTasks = 2;}

	setProblemName ();
	
    URL = "http://" + hostName + phpPath;

	// helpful for debugging connection configuration problems
	if (runInternal)
	  System.out.println (getName () + " - will run internal Vishnu Scheduler.");
	else
	  System.out.println (getName () + " - will try to connect to Vishnu Web Server : " + 
						  hostName);
  }

  /**
   * <pre>
   * sets Problem name used by Vishnu
   *
   * Uses a shared, static Map of cluster names to plugin instances so
   * that if there is more than one Vishnu plugin per cluster, can
   * number them in ascending order.
   *
   * Appends the machine name to divide the name space of problems 
   * automatically.
   *
   * For example, if there were an expander and aggregator in the
   * AsmaraTFSP cluster, run on a machine named pumpernickle, 
   * the names would be 
   *   AsmaraTFSP_0_pumpernickle and
   *   AsmaraTFSP_1_pumpernickle
   *
   * (There is nothing to tell which is which in the name.)
   *
   * </pre>
   */
  protected void setProblemName () {
	synchronized (clusterToInstance) {
	  List instances = (List) clusterToInstance.get (getClusterName ());
	  if (instances == null) {
		clusterToInstance.put (getClusterName (), instances = new ArrayList ());
	  }
	  instances.add (this);
	}

    try {myProblem = getMyParams().getStringParam("problemName");}    
    catch(Exception e) {
	  myProblem = getClusterName();

	  synchronized (clusterToInstance) {
		if (((List) clusterToInstance.get (getClusterName ())).size () > 1) {
		  myProblem = myProblem + "_" + 
			((List) clusterToInstance.get (getClusterName ())).indexOf (this);
		  if (myExtraExtraOutput)
			System.out.println (getName ()+ ".localSetup - this " + this + " is " + 
								((List) clusterToInstance.get (getClusterName ())).indexOf (this) +
								" of " + 
								((List) clusterToInstance.get (getClusterName ())).size ());
		}
	  }
	}
	
	try {
	    String machineName = java.net.InetAddress.getLocalHost().getHostName ().replace('-', '_');
	    if (machineName.indexOf('.') != -1) {
		machineName = machineName.substring (0, machineName.indexOf('.'));
	    }
	    machineName = machineName.replace('.', '_');
	    myProblem = myProblem + "_" + machineName;
	}
	catch (UnknownHostException uhe) {
	  System.err.println (getName () + ".localSetup - Huh? Could not find localhost? " +
						  uhe.getMessage ());
	}
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
	newRoot.setAttribute ("NAME", myProblem);
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

	Set changed = new HashSet ();
	changed.add (changedAsset);
    sendDataToVishnu (changed, myNameToDescrip, myTypesToNodes, 
					  false /* don't clear database */, 
					  true /* send assets as CHANGEDOBJECTS */,
					  pe);

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
   * Parameters that effect behavior:
   * 
   * 1) showALPXML - shows the XML that comes from XMLize on alp
   *    objects.  No XML gets sent to Vishnu.  This XML is equivalent
   *    to what you get from TASKS.PSP
   * 2) sendSpecsEveryTime - sends the specs and object format every time
   *    useful if debugging problems with XSL.
   * 3) alwaysClearDatabase - clears the Vishnu database for the problem
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
      
	  if (showALPXML) {
		Collection formatTemplates = getAssetTemplatesForTasks(tasks);
		formatTemplates.addAll (getTemplateTasks(tasks));
	  
		Document trDoc = getDoc (formatTemplates);
		System.out.println (getDocAsString (trDoc));
		return;
	  }
      
	  if (!sentFormatAlready || sendSpecsEveryTime) {
		Collection formatTemplates = getAssetTemplatesForTasks(tasks);
		formatTemplates.addAll (getTemplateTasks(tasks));
		if (myExtraOutput) {
		  System.out.println (getName () + ".processTasks - " + formatTemplates.size() + " unique assets : ");
		  for (Iterator iter = formatTemplates.iterator (); iter.hasNext(); )
			System.out.print ("\t" + iter.next().getClass ());
		  System.out.println ("");
		}

		Map [] nameInfo = sendFormat (formatTemplates);
		myNameToDescrip   = nameInfo[0];
		myTypesToNodes    = nameInfo[1];
		if (!runInternal)
		  sentFormatAlready = true;
		if (showTiming)
		  reportTime (" - Vishnu completed format XML processing in ", start);
	  }
      
	  setUIDToObjectMap (tasks, myTaskUIDtoObject);
      
	  if (myExtraOutput)
		System.out.println (getName () + ".processTasks - sending " + 
							myTaskUIDtoObject.values ().size () + " tasks.");
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
      
	  sendDataToVishnu (tasks, myNameToDescrip, myTypesToNodes, 
						alwaysClearDatabase, 
						false /* send assets as NEWOBJECTS */, null);
	  if (showTiming) {
		reportTime (" - Vishnu completed data XML processing in ", dataStart);
		reportTime (" - Vishnu completed XML processing in ", start);
	  }

	  if (runInternal) {
		runInternally ();
	  } else {
		startScheduling ();
	
		if (!waitTillFinished ())
		  System.out.println ("VishnuPlugIn.processTasks -- " + 
							  "timed out waiting for scheduler to finish.");
	  }
	  if (showTiming)
		reportTime (" - Vishnu did " + numTasks + " tasks in ", start);
	} // end of synchronized
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
	if (myExtraOutput)
	  System.out.println (getName () + ".runInternally - internal buffer is " + internalBuffer);

	internalBuffer.append ("</root>");
	if (myExtraOutput)
	  System.out.println(getName () + ".runInternally - sending stuff " + internalBuffer.toString());

	int unhandledTasks = myTaskUIDtoObject.size ();

	String assignments = internal.runInternalToProcess (internalBuffer.toString());
	Parser parser = new SAXParser();
	parser.setDocumentHandler (new AssignmentHandler ());
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
   * Prints out time since <code>start</code> with prefix <code>prefix</code>
   * @param start since when
   * @param prefix meaning of time difference
   */
  protected void reportTime (String prefix, Date start) 
  {
    Runtime rt = Runtime.getRuntime ();
    Date end = new Date ();
    long diff = end.getTime () - start.getTime ();
    long min  = diff/60000l;
    long sec  = (diff - (min*60000l))/1000l;
    long millis = diff - (min*60000l) - (sec*1000l);
	if (min < 1l && sec < 1l && millis < 500l) return;
    System.out.println  (getName() + prefix +
			 min + 
			 ":" + ((sec < 10) ? "0":"") + sec + 
			 ":" + ((millis < 10) ? "0":"") + millis + 
			 " (Wall clock time)" + 
			 " free "  + (rt.freeMemory  ()/(1024*1024)) + "M" +
			 " total " + (rt.totalMemory ()/(1024*1024)) + "M");
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
  protected Collection getAssetTemplatesForTasks (List tasks) {
	return getDistinctAssetTypes ();
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
  protected Collection getDistinctAssetTypes () {
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

	if (distinctAssets.isEmpty())
	  System.out.println (getName () + ".getDistinctAssetTypes - no templates assets?");

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
  protected Map [] sendFormat (Collection templates) {
	if (myExtraOutput)
	  System.out.println (getName () + ".sendFormat");
    Map [] nameInfo = null;
	Date start = new Date ();
	
    try {
      // perform the transform!
	  Document problemFormatDoc = getFormatDoc (templates);

	  if (showFormatXML) {
		System.out.println (getDocAsString(problemFormatDoc));
	  }
	  if (showTiming)
		reportTime (" - Vishnu completed format XML transform in ", start);
	  
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
      ((Element)root).setAttribute ("NAME", myProblem);

      if (myExtraOutput)
		System.out.println (getName () + ".sendFormat - problem is " + myProblem);

      // appending any global other data object formats 
      String otherDataFormat = getOtherDataFormat();
	  try {
		if (getCluster().getConfigFinder ().open (otherDataFormat) != null) {
		  if (myExtraOutput)
			System.out.println (getName () + ".sendFormat -  appending " + 
								otherDataFormat + " other data format file");

		  appendDoc (problemFormatDoc, 
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

		appendDoc (problemFormatDoc, specsFile);
	  }

      // append the ga specs
      specsFile = getGASpecsFile(); 

      if (myExtraOutput)
		System.out.println (getName () + ".sendFormat - appending " + 
							specsFile + " vishnu ga specs xml file");

      appendDoc (problemFormatDoc, specsFile);

      // send to postdata URL
      serializeAndPostProblem (problemFormatDoc);
    } catch (Exception ioe) {
      System.out.println ("send Format - Exception " + ioe.getMessage());
      ioe.printStackTrace ();
    }
    return nameInfo;
  }

  /** 
   * Get a document that is equivalent to <code>taskAndAssets</code> 
   * collection
   */
  protected Document getDoc (Collection taskAndAssets) {
    Document doc = new DocumentImpl(); 
    Element root = doc.createElement("CHANGEDOBJECTS");
    doc.appendChild(root);
    addObjectsToDocument (taskAndAssets.iterator (), doc, root);

    return doc;
  }

  /** uses formatXMLizer to generate XML for Vishnu */
  protected Document getFormatDoc (Collection taskAndAssets) {
	FormatXMLize formatXMLizer = new FormatXMLize (debugFormatXMLizer);
    return formatXMLizer.createDoc (taskAndAssets);
  }

  /** 
   * Uses dataXMLizer to generate XML for Vishnu 
   *
   * Passes nameToDescrip Map to dataXMLizer so can rename fields to be unique.
   *
   * @param taskAndAssets what to send
   * @param nameToDescrip mapping of object type to object description (field names, etc.)
   */
  protected Document getDataDoc (Collection taskAndAssets, Map nameToDescrip) {
	  DataXMLize dataXMLizer = new DataXMLize  (debugDataXMLizer);
	  dataXMLizer.setNameToDescrip (nameToDescrip);
	  return dataXMLizer.createDoc (taskAndAssets);
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
   * and removed duplicates (two object formats with the same name and 
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

	pruneObjectFormat (root, nameToNodes, potentialDuplicates);
	
    addFieldsForDifferentTypes (root, doc, nameToNodes, nameToDescrip);

	// possibly unnecessary
	pruneObjectFormat (root, nameToNodes, potentialDuplicates);

    return new Map [] { nameToDescrip, nameToNodes };
  }

  /**
   * <pre>
   * Given a set of potential duplicate types, removes those that are duplicates
   * from the set of DOM Node OBJECTFORMATs sent to Vishnu.
   *
   * Removes duplicate OBJECTFORMATs from <code>root</code>.
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
  protected void pruneObjectFormat (Node root, Map nameToNodes, Set potentialDuplicates) {
    Set toRemove = new HashSet ();
	Set dupsToRemove = new HashSet ();
    for (Iterator iter = potentialDuplicates.iterator (); iter.hasNext(); ){
      String type = (String) iter.next();
	  
	  if (myExtraExtraOutput)
		System.out.println ("type " + type);
	  
	  List nodesForType = (List) nameToNodes.get (type);
	  List copyOfNodesForType = new ArrayList (nodesForType);
	  if (myExtraExtraOutput)
		System.out.println ("nodes for type " + nodesForType);

	  Set nameToNodeToRemove = new HashSet ();
	  for (Iterator iter2 = copyOfNodesForType.iterator (); iter2.hasNext(); ){
		Node objectFormat = (Node) iter2.next();
		if (duplicateNode (objectFormat, nodesForType)) {
		  if (myExtraExtraOutput)
			System.out.println ("\tfound dup");
		  toRemove.add (objectFormat);
		}
	  }
	  if (nodesForType.size () == 1) {
		if (myExtraExtraOutput)
		  System.out.println ("\tremoving " + type);
		dupsToRemove.add (type);
	  }
    }
	if (myExtraExtraOutput)
	  System.out.println ("removing " + dupsToRemove + " from " + potentialDuplicates);
	potentialDuplicates.removeAll (dupsToRemove);
	if (myExtraExtraOutput)
	  System.out.println (getName () + ".dup - " + potentialDuplicates.size () + " potential dups remain");

    for (Iterator iter = toRemove.iterator (); iter.hasNext (); )
      root.removeChild ((Node) iter.next ());
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
	  boolean thisIsResource = 
		first.getAttributes().getNamedItem ("is_resource").getNodeValue().equals("true");
	  boolean otherIsNotResource = 
		other.getAttributes().getNamedItem ("is_resource").getNodeValue().equals("false");
	  if (thisIsResource && otherIsNotResource)
		continue;

      NodeList otherChildNodes = other.getChildNodes ();

      if (firstChildNodes.getLength () > otherChildNodes.getLength ())
		continue; // can't be a subset if more fields

      Map fieldNames = new HashMap ();
      for (int k = 0; k < otherChildNodes.getLength (); k++) {
		String field = otherChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();
		String type  = otherChildNodes.item (k).getAttributes().getNamedItem ("datatype").getNodeValue();
		fieldNames.put (field, type);
      }

      boolean allFound = true;
      // go through fields of node we're checking
      for (int k = 0; k < firstChildNodes.getLength (); k++) {
		String firstChildName = 
		  firstChildNodes.item (k).getAttributes().getNamedItem ("name").getNodeValue();

		if (fieldNames.get (firstChildName) == null) {
		  allFound = false;
		  break;
		}
      }
	  
      // we found all the fields of the first node in the fields of another ->
      // it's a subset node...
      if (allFound) {
		if (myExtraExtraOutput) {
		  String name  = first.getAttributes().getNamedItem ("name").getNodeValue();
		  System.out.println ("Found a duplicate " + first.getNodeName () + " " + name);
		}
		nodes.remove (first);
		return true;
      }
    }
    return false;
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

			Node clone = createClone(fieldFormat, doc);
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
		  String type = newNode.getAttributes().getNamedItem("datatype").getNodeValue();
		  String name = newNode.getAttributes().getNamedItem("name").getNodeValue();

		  if (myExtraOutput) {
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
   * appends the document at filename onto originalDoc.
   *
   * @param originalDoc - doc to append the filename doc to
   * @param filename    - name of the document to append
   */
  protected void appendDoc (Document originalDoc, String filename) {
    Element originalRoot = originalDoc.getDocumentElement ();
	appendDoc (originalDoc, originalRoot, filename);
  }

  /**
   * appends the document at filename onto originalDoc.
   *
   * @param originalDoc - doc to append the filename doc to
   * @param filename    - name of the document to append
   */
  protected void appendDoc (Document originalDoc, Element originalAppendLoc,
							String filename) {
    try {
      DOMParser parser = new DOMParser ();
      InputStream inputStream = getCluster().getConfigFinder ().open(filename);
      parser.parse (new InputSource(inputStream));
      Document appendDoc = parser.getDocument ();

      Element appendDocRoot = appendDoc.getDocumentElement ();
      merge (originalAppendLoc, appendDocRoot);

    } catch (SAXException sax) {
      System.out.println (getName () + ".appendDoc - Got sax exception:\n" + sax);
    } catch (IOException ioe) {
      System.out.println ("Could not open file : \n" + ioe);
    }
  }

  /**
   * appends the document at filename onto originalDoc.
   *
   * @param originalDoc - doc to append the filename doc to
   * @param filename    - name of the document to append
   */
  protected void appendChildrenToDoc (Document originalDoc, Element originalAppendLoc,
									  String filename) {
    try {
      DOMParser parser = new DOMParser ();
      InputStream inputStream = getCluster().getConfigFinder ().open(filename);
      parser.parse (new InputSource(inputStream));
      Document appendDoc = parser.getDocument ();

      Element appendDocRoot = appendDoc.getDocumentElement ();
	  
	  if (appendDocRoot.getTagName().equals ("GLOBAL_DATA_LIST")) {
		
		NodeList nlist = appendDocRoot.getChildNodes();

		for (int i = 0; i < nlist.getLength(); i++) {
		  Node rootChild = nlist.item (i);
		  merge (originalAppendLoc, rootChild);
		}
	  }
	  else
		merge (originalAppendLoc, appendDoc.getDocumentElement ());
	  
    } catch (SAXException sax) {
      System.out.println (getName () + ".appendDoc - Got sax exception:\n" + sax);
    } catch (IOException ioe) {
      System.out.println ("Could not open file : \n" + ioe);
    }
  }

  /**
   * <pre>
   * Takes two nodes of xml documents and makes the rootToAdd
   * node as a child of the placeToAdd node.  
   *
   * On the first call, these two nodes are the roots of two
   * separate xml documents.
   *
   * It recurses down the tree to be added.
   *
   * Note that naively taking the root to be added and
   * adding it directly by doing appendChild doesn't work,
   * since all DOM Nodes have an "owner document," and all
   * nodes in a tree must have the same owner.  Since the
   * rootToAdd node comes from a different document, you'll get
   * a "Wrong Document Err" when you try to do this.
   * 
   * So you have to create copies with the target document's
   * createElement method and add those.
   *
   * BOZO : probably better way to do this!
   * </pre>
   * @param placeToAdd - the root of the destination document
   * @param rootToAdd  - the root of the document to merge into the first
   *                     doc
   * 
   */
  protected void merge (Node placeToAdd, Node rootToAdd) {
    Document targetDoc = placeToAdd.getOwnerDocument ();

    // clone the node to be added

    if (rootToAdd.getNodeType() == Node.ELEMENT_NODE) {
      Node clonedNode = createClone (rootToAdd, targetDoc);

      placeToAdd.appendChild (clonedNode);

      NodeList nlist = rootToAdd.getChildNodes();
      int nlength = nlist.getLength();

      for(int i = 0; i < nlength; i++){
		Node child = nlist.item(i);
		merge (clonedNode, child);
      }
    }
    else if (rootToAdd.getNodeType() == Node.TEXT_NODE) {
      String data = rootToAdd.getNodeValue ().trim();
      if (data.length () > 0) {
		Text textNode = targetDoc.createTextNode (data);
		placeToAdd.appendChild (textNode);
      }
    }
  }

  /**
   * Clone a node (only its attributes)
   *
   * @param toClone - the node to copy
   * @param doc     - is the factory for new nodes
   * @return the clone
   */
  protected Node createClone (Node toClone, Document doc) {
    Element clonedNode = doc.createElement (toClone.getNodeName ());

    // clone the attributes
    NamedNodeMap attrs = toClone.getAttributes ();
    for(int i = 0; i < attrs.getLength (); i++) {
      Attr attrNode = (Attr) attrs.item (i);
      clonedNode.setAttribute (attrNode.getName (), attrNode.getValue ());
    }
    
    return clonedNode;
  }

  /**
   * send the data section of the problem to the postdata URL.
   *
   * Handles sending changed objects.
   *
   * @param tasks -- a collection of all the tasks and resources 
   * @param sendingChangedObjects -- controls whether assets will be sent
   *                                 inside of <CHANGEDOBJECT> tags
   */
  protected void sendDataToVishnu (Collection tasks, 
								   Map nameToDescrip, 
								   Map typesToNodes,
								   boolean clearDatabase, 
								   boolean sendingChangedObjects,
								   PlanElement givenPE) {
    try {
      Document dataDoc = getDataDoc (tasks, nameToDescrip);
	  
	  if (showDataXML)
		System.out.println (getDocAsString(dataDoc));

      Node root = dataDoc.getDocumentElement ();
      ((Element)root).setAttribute ("NAME", myProblem);

      Node dataNode = root.getFirstChild ();
      Node windowNode = dataNode.getFirstChild ();

      ((Element)windowNode).setAttribute ("starttime", vishnuEpochStartTime);
      ((Element)windowNode).setAttribute ("endtime",   vishnuEpochEndTime);

      NodeList nlist = dataNode.getChildNodes ();

	  if (clearDatabase)
		root.getFirstChild().insertBefore (dataDoc.createElement("CLEARDATABASE"),
										   root.getFirstChild ().getFirstChild ());

      for (int i = 0; i < nlist.getLength(); i++) {
		if (nlist.item (i).getNodeName ().equals ("NEWOBJECTS")) {
		  Node newobject = nlist.item (i);
		  NodeList objects = newobject.getChildNodes ();

		  if (!mySentOtherDataAlready) {
			appendOtherData (dataDoc, (Element) newobject);
			//			mySentOtherDataAlready = true;
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

      serializeAndPostData (dataDoc);
    } catch (Exception ioe) {
      System.out.println ("Exception " + ioe.getMessage());
      ioe.printStackTrace ();
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
	  if (getCluster().getConfigFinder ().open (otherData) != null) {
		if (myExtraOutput)
		  System.out.println (getName () + " appending " + 
							  otherData + " other data file");

		appendChildrenToDoc (dataDoc, 
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
	  appendToInternalBuffer( getDocAsArray (doc).toString());
	else {
	  if (postData) {
		//	  postData (doc);
		postData (getDocAsArray (doc).toString());
	  } else {
		//		postProblem (getDocAsString (doc));
		postProblem (getDocAsArray (doc).toString());
	  }
	  if (writeXMLToFile) {
		String suffix = (postData) ? "data" : "problem";
		String fileName = getClusterName () + "_" + suffix + "_" + numFilesWritten++;
		System.out.println (getName () + ".serializeAndPost - Writing XML to file " + fileName);
		try {
		  FileOutputStream temp = new FileOutputStream (fileName);
		  writeDocToStream (doc, temp);
		} catch (FileNotFoundException fnfe) { /* never happen */ }
	  }
	}
  }

  protected void appendToInternalBuffer (String data) {
	int index;
	if ((index = data.indexOf ("?>")) != -1) {
	  String stuff = data.substring (index+2);
	  internalBuffer.append (stuff);
	}
  }

  protected String getDocAsString (Document doc) {
    StringWriter sw = new StringWriter();

    OutputFormat of = new OutputFormat (doc, OutputFormat.Defaults.Encoding, true);
    of.setLineWidth (150);
    XMLSerializer serializer = new XMLSerializer (sw, of);
    try {
	  Date start = new Date();
      serializer.serialize (doc);
	  if (showTiming)
		reportTime (" - got doc as string in ", start);
    } catch (IOException ioe) {System.out.println ("Exception " + ioe);}

	return sw.toString ();
  }
  
  protected CharArrayWriter getDocAsArray (Document doc) {
    CharArrayWriter sw = new CharArrayWriter();

    OutputFormat of = new OutputFormat (doc);
	of.setPreserveSpace (false);
	
	XMLSerializer serializer = new XMLSerializer (sw, of);
    try {
      serializer.serialize (doc);
    } catch (IOException ioe) {System.out.println ("Exception " + ioe);}

	return sw;
  }

  protected void addObjectsToDocument (Iterator iter, Document doc, Element nodeToAddTo) {
    Element element   = null;
    XMLizable xmlable = null;

    while  (iter.hasNext ()) {
      xmlable = (XMLizable) iter.next ();
      element = xmlable.getXML (doc);
      nodeToAddTo.appendChild (element);
    }
  }

  public void postData (String data) {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&");
    sb.append (getProblemPostVar ());
    sb.append (getInstancePostVar () + "&");
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("data=");
    sb.append (java.net.URLEncoder.encode(data));

	Date start = new Date();
    String reply =
      postToURL (hostName, postDataFile, sb.toString (), null, true);
	if (showTiming)
	  reportTime (" - did post of data string to URL in ", start);
	
    if (myExtraOutput)
      System.out.println (getName () + ".postData - Reply to post data <" + reply.trim() + ">");
  }

  public void postData (Document dataDoc) {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&");
    sb.append (getProblemPostVar ());
    sb.append (getInstancePostVar () + "&");
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("data=");

	Date start = new Date();
    String reply =
      postToURL (hostName, postDataFile, sb.toString (), dataDoc, true);
	if (showTiming)
	  reportTime (" - did post of data Doc to URL in ", start);
	
	if (!reply.startsWith ("SUCCESS"))
      System.out.println (getName () + ".postData - ERROR : Reply to post data was <" + reply + ">");
	else if (myExtraOutput)
      System.out.println (getName () + ".postData - Reply to post data was <" + reply.trim() + ">");
  }

  /**
   * bogus is sent first because user would not arrive 
   * at php with value if it was sent first.  No idea why.
   *
   */
  public void postProblem (String data) {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&"); 
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("data=");
    sb.append (java.net.URLEncoder.encode(data));

    String reply =
      postToURL (hostName, postProblemFile, sb.toString (), null, true);

    if (myExtraOutput)
      System.out.println (getName() + ".postProblem - reply was <" + reply.trim() + ">");
  }

  public void startScheduling () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&" + getProblemPostVar ());
    sb.append (getInstancePostVar () + "&");
    sb.append (getUserPostVar () + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("ferris=bueller");

    String reply = postToURL (hostName, kickoffFile, sb.toString (), null, true);
    if (myExtraOutput)
	System.out.println (getName () + ".startScheduling - reply to kickoff was " + reply.trim());
  }

  public boolean waitTillFinished () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&" + getProblemPostVar ());
    sb.append (getInstancePostVar () + "&");
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("ferris=bueller");
    String postVars = sb.toString ();

    boolean gotAnswer = false;
    for (int i = 0; i < maxWaitCycles; i++) {
      String response = 
	  postToURL (hostName, readStatusFile, postVars, null, true);
      if (response.indexOf (done) != -1) {
		gotAnswer = true;
		break;
      }
      else if (myExtraOutput) {
		System.out.println (getName() + ".waitTillFinished - Scheduler not done. Reply was <" + response.trim() + ">");
	  }

      try { Thread.sleep (waitTime); } catch (Exception e) {}
    }
	
	if (!alwaysClearDatabase)
	  sendFreezeAll ();

    if (gotAnswer)
	  parseAnswer(postVars);

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
    protected void parseAnswer(String postVars) {
      if (myExtraOutput)
		System.out.println (getName() + ".waitTillFinished - Vishnu scheduler result returned!");
      try {
		String url = "http://" + hostName + phpPath + assignmentsFile + postVars;
		URL aURL = new URL (url);

		int unhandledTasks = myTaskUIDtoObject.size ();

		if (myExtraOutput)
		  System.out.println (getName () + ".parseAnswer - reading from " + url);

		readXML (aURL, new AssignmentHandler ());

		if (myExtraOutput)
		  System.out.println (getName () + ".parseAnswer - created successful plan elements for " +
							  (unhandledTasks-myTaskUIDtoObject.size ()) + " tasks.");

		handleImpossibleTasks (myTaskUIDtoObject.values ());
		myTaskUIDtoObject.clear ();
		
      } catch (Exception e) {
		System.out.println ("BAD URL : " + e);
		e.printStackTrace ();
      }
    }

  protected void sendFreezeAll () {
	Document doc = new DocumentImpl ();
    Element newRoot = doc.createElement("PROBLEM");
	newRoot.setAttribute ("NAME", myProblem);
    doc.appendChild(newRoot);
	
	Element freeze = doc.createElement("FREEZEALL");
	newRoot.appendChild (freeze);

	serializeAndPostData (doc);
  }

  protected String getProblemPostVar () {
    return "problem=" + myProblem + "&";
  }

  protected String getInstancePostVar () {
    return "instance=" + myInstance;
  }

  protected String getUserPostVar () {
    return "username=" + myUser;
  }

  public URLConnection getConnection (String host,
									  String fileToExec,
									  String data,
									  Document doc,
									  boolean readResponse) {
    try {
      String url = "http://" + host + phpPath + fileToExec;
      URL newURL = new URL (url);
      URLConnection connection = newURL.openConnection();
      connection.setDoOutput (true);
      connection.setDoInput  (readResponse);

	  return connection;
    } catch (Exception e) {
      System.out.println ("BAD URL : " + e);
	  e.printStackTrace ();
      return null;
    }
  }

  public String postToURL (String host,
						   String fileToExec,
						   String data,
						   Document doc,
						   boolean readResponse) {
    try {
      String url = "http://" + host + phpPath + fileToExec;
      if (testing) {
		System.out.println ("postToURL - (complete) Sending to : " + url);
		System.out.println (java.net.URLDecoder.decode(data));
      }
      else if (myExtraOutput) {
		System.out.println ("postToURL - (partial) Sending to : " + url);
		System.out.println (data.substring (0,
											(data.length () > 100) ? 100 : data.length()));
      }
      return postToURL (new URL (url), 
						data, doc,
						readResponse);
    } catch (Exception e) {
      System.out.println ("BAD URL : " + e);
	  e.printStackTrace ();
      return "";
    }
  }

  public String postToURL (URL aURL,
						   String data,
						   Document doc,
						   boolean readResponse) {
    try {
      URLConnection connection = aURL.openConnection();
      connection.setDoOutput (true);
      connection.setDoInput  (readResponse);

	  Date start = new Date();
      sendData (connection, data, doc);
	  if (showTiming)
		reportTime (" - postToURL sent " + data.length() + " chars of data in ", start);

      if (readResponse) {
		start = new Date();
		String response = getResponse (connection);
		if (showTiming)
		  reportTime (" - postToURL read response of " + response.length() + " in ", start);
		return response;
	  }
    }
    catch(Exception e) {
      System.err.println ("VishnuPlugIn.postToURL -- exception sending data to URL : " + aURL +
			  "\n" + e.getMessage());
      e.printStackTrace();
    }
    return "";
  }

  protected void clearInternalBuffer () {
	internalBuffer = new StringBuffer ();
  }

  /**
    Sends data on the connection.
   */

  public void sendData(URLConnection connection, String data, Document doc) throws IOException {
    if (myExtraOutput) {
	  System.out.println (getName () + ".sendData - Sending " + data.length () + " characters.");
	  System.out.println ("\tData=" + data.substring (0,
													  (data.length () > 100) ? 100 : data.length()));
    }

    OutputStream os = new BufferedOutputStream(connection.getOutputStream ());
    byte [] bytes = data.getBytes ();
    os.write(bytes);
	if (doc != null) {
	  writeDocToStream (doc, os);
	  /*
	  if (writeXMLToFile) {
		String fileName = getClusterName () + "_" + numFilesWritten++;
		System.out.println ("Writing XML to file " + fileName);
		FileOutputStream temp = new FileOutputStream (fileName);
		writeDocToStream (doc, temp);
	  }
	  */
	} else if (writeEncodedXMLToFile) {
	  String fileName = getClusterName () + "_encoded_" + numFilesWritten++;
	  System.out.println (getName () + ".sendData : Writing XML to file " + fileName);
	  FileOutputStream temp = new FileOutputStream (fileName);
	  bytes = data.getBytes ();
	  temp.write(bytes);
	  temp.flush ();
	  temp.close ();
	}
	
    os.flush ();
    os.close ();
  }

  protected void writeDocToStream (Document doc, OutputStream os) {
    OutputFormat of = new OutputFormat (doc, "UTF-8", true);
	of.setLineWidth (150);
	
	XMLSerializer serializer = new XMLSerializer (os, of);

    try {
      serializer.serialize (doc);
    } catch (IOException ioe) {System.out.println ("Exception " + ioe);}
  }
  
  /**
   * <pre>
   * Returns response as string.
   *
   * If there is IOException on the input stream, will try two more times.
   *
   * </pre>
   * @param  connection the url connection to get data from
   * @return String reponse from URL
   */

  public String getResponse(URLConnection connection) throws IOException {
    StringBuffer sb = new StringBuffer ();
	int numTries = 3;
	boolean madeInputStream = false;
    InputStream is = null;
	
	while (numTries > 0 && !madeInputStream) {
	  try {
		is = connection.getInputStream();
		madeInputStream = true;
	  } catch (IOException ioe) {
		System.out.println (getName () + ".getResponse - IO Exception on reading from URL, trying again.");
		numTries--;
		try { Thread.sleep (500l); } catch (Exception e) {}
	  }
	}
	if (!madeInputStream)
		System.out.println (getName () + ".getResponse - ERROR : could not read from URL " + connection);

    byte b[] = new byte[1024];
    int len;
    while ((len = is.read(b)) > -1)
      sb.append (new String(b, 0, len));

    return sb.toString ();
  }

  private static String socketPostToURL (String hostName,
					 String phpPath,
					 String url,
					 String data, 
					 boolean readResponse) {
    try {
      Socket socket = new Socket (hostName, 80);
      OutputStream os = socket.getOutputStream();
      String request = "POST " + phpPath + url + " HTTP/1.0\r\n" +
        "Content-Type: application/x-www-form-urlencoded\r\n" +
        "Content-Length: " + data.length() + "\r\n\r\n" + data + "\r\n\r\n";
      os.write (request.getBytes());
      if (! readResponse)
        return "";
      InputStream is = socket.getInputStream();
      String result = "";
      byte[] b = new byte[1];
      while ((b[0] = (byte) is.read()) != -1)
        result = result + new String (b);
      return result;
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
    return "";
  }

  protected void readXML (URL aURL, HandlerBase handler) {
    try {
      if (myExtraOutput) {
	  URLConnection connection = aURL.openConnection();
	  connection.setDoOutput (false);
	  connection.setDoInput  (true);

	  System.out.println (getResponse (connection));
      }

      Parser parser = new SAXParser();
      parser.setDocumentHandler (handler);
      parser.parse (aURL.toString());
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
  }

  /**
   * this is where we look up unique ids
   */
  public class AssignmentHandler extends HandlerBase {
	/**
	 * 
	 */
    public void startElement (String name, AttributeList atts) {
	  parseStartElement (name, atts);
    }
	/**
	 * 
	 */
    public void endElement (String name) {
	  parseEndElement (name);
    }
  }

  protected Asset assignedAsset;
  protected Date start, end, setup, wrapup;
  protected Vector alpTasks = new Vector ();

  protected void parseStartElement (String name, AttributeList atts) {
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
	  System.out.println (getName () + ".handleAssignment : " + 
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

	if (setupStart.getTime() < start.getTime()) {
	  subtasks.add (createSetupTask (task, asset, start, end, setupStart, wrapupEnd));
	}

	if (wrapupEnd.getTime() > end.getTime()) {
	  subtasks.add (createWrapupTask (task, asset, start, end, setupStart, wrapupEnd));
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
    Vector preps = UTILAllocate.enumToVector(parentTask.getPrepositionalPhrases());
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
      if (type.startsWith ("string"))
		type = "string(128)";

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

  protected String myProblem  = "testProblem";
  protected String myInstance = "testInstance";
  protected String myUser     = "vishnu";
  protected String myPassword = "vishnu";

  protected UTILAssetCallback         myAssetCallback;
  protected int maxWaitCycles = 10;
  protected int firstTemplateTasks;
  protected long waitTime      = 1000;
  protected boolean sentFormatAlready = false;
  protected boolean mySentOtherDataAlready = false;
  protected boolean mySentAssetDataAlready = false;
  protected Map myTaskUIDtoObject = new HashMap ();
  protected Map myAssetUIDtoObject = new HashMap ();
  protected Set myFrozenTasks = new HashSet ();

  protected String hostName = "dante.bbn.com";
  protected String phpPath  = "/~dmontana/vishnu/";
  protected String URL      = "http://" + hostName + phpPath;

  protected String PHP_SUFFIX = ".php";
  protected String postProblemFile = "postproblem" + PHP_SUFFIX;
  protected String postDataFile    = "postdata" + PHP_SUFFIX;
  protected String kickoffFile     = "postkickoff" + PHP_SUFFIX;
  protected String readStatusFile  = "readstatus" + PHP_SUFFIX;
  protected String assignmentsFile = "assignments" + PHP_SUFFIX;

  protected String done            = "percent_complete=100";

  protected boolean testing = false;
  protected boolean showALPXML = false;
  protected boolean showFormatXML = false;
  protected boolean showDataXML = false;
  protected boolean ignoreSpecsFile = false;
  protected boolean sendSpecsEveryTime = false;
  protected boolean alwaysClearDatabase = false;
  protected boolean showTiming = true;
  protected boolean writeXMLToFile = false;
  protected boolean writeEncodedXMLToFile = false;
  protected int numFilesWritten = 0; // how many files have been written out via the writeXMLToFile flag
  protected boolean sendRoleScheduleUpdates = false;
  protected boolean makeSetupAndWrapupTasks = true;
  protected boolean runInternal = true;
  protected boolean debugFormatXMLizer = false;
  protected boolean debugDataXMLizer = false;

  protected String vishnuEpochStartTime;
  protected String vishnuEpochEndTime;

  private boolean debugParseAnswer = false;
}

