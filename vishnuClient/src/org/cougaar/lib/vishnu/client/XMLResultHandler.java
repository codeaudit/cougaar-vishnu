package org.cougaar.lib.vishnu.client;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.StringReader;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Collection;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.xerces.dom.DocumentImpl;
import org.apache.xerces.parsers.DOMParser;
import org.apache.xerces.parsers.SAXParser;

import org.cougaar.domain.planning.ldm.asset.Asset;
import org.cougaar.domain.planning.ldm.plan.Task;
import org.cougaar.lib.param.ParamMap;
import org.cougaar.util.StringKey;

import org.w3c.dom.Document;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

public class XMLResultHandler extends PlugInHelper {
  public XMLResultHandler (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
						   VishnuDomUtil domUtil, VishnuConfig config,
						   ParamMap myParamTable) {
	super (parent, comm, xmlProcessor, domUtil, config, myParamTable);
	resultListener = (ResultListener) parent;
  }

  protected void localSetup () {
	super.localSetup ();
	
	try {debugParseAnswer = 
		   getMyParams().getBooleanParam("debugParseAnswer");}    
	catch(Exception e) {debugParseAnswer = false;}
  }

  /**
   * <pre>
   * Reads XML from the URL to get the assignments.  Uses AssignmentHandler
   * (SAX) to parse XML.
   *
   * Uses myTaskUIDtoObject to figure out if there were any impossible tasks.
   * (If there were any, they will be in the myTaskUIDtoObject Map.)
   *
   * The AssignmentHandler removes any assigned tasks from myTaskUIDtoObject.
   *
   * </pre>
   */
  protected void parseAnswer() {
	if (myExtraOutput)
	  System.out.println (parent.getName() + ".waitTillFinished - Vishnu scheduler result returned!");
	int unhandledTasks = parent.getNumTasks ();

	comm.getAnswer (new AssignmentHandler ());

	if (myExtraOutput)
	  System.out.println (parent.getName () + ".parseAnswer - created successful plan elements for " +
						  (unhandledTasks-parent.getNumTasks()) + " tasks.");
  }

  public DefaultHandler getHandler () {
	return new AssignmentHandler ();
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

  protected Asset assignedAsset = null;
  protected Date start, end, setup, wrapup;
  protected Vector alpTasks = new Vector ();

  /**
   * Given the XML that indicates assignments, parse it <p>
   *
   * Uses the <code>myTaskUIDtoObject</code> and <code>myAssetUIDtoObject</code> maps <br>
   * to lookup the keys returned in the xml to figure out which task was assigned to  <br>
   * which asset.  These were set in processTasks using setUIDToObjectMap.
   * 
   * @param name the tag name
   * @param atts the tag's attributes
   * @see #processTasks
   * @see #setUIDToObjectMap
   */
  protected void parseStartElement (String name, Attributes atts) {
	try {
	  if (myExtraExtraOutput)
	  	System.out.println (parent.getName() + ".parseStartElement got " + name);
	  
	  if (name.equals ("ASSIGNMENT")) {
		if (myExtraOutput) {
		  System.out.println (parent.getName () + ".parseStartElement -\nAssignment: task = " + atts.getValue ("task") +
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
		Task handledTask  = resultListener.getTaskForKey (taskKey);
		if (handledTask == null) {
		  // Ignore this assignment since it has already been handled previously
		  return;
		  
		  // System.out.println ("VishnuPlugIn - AssignmentHandler.startElement no task found with " + taskUID);
		  // System.out.println ("\tmap was " + myTaskUIDtoObject);
		}
		else {
		  resultListener.removeTask (taskKey);
		}

		Asset assignedAsset = resultListener.getAssetForKey (new StringKey (resourceUID));
		if (assignedAsset == null) 
		  System.out.println ("VishnuPlugIn - AssignmentHandler.startElement no asset found with " + resourceUID);
	
		resultListener.handleAssignment (handledTask, assignedAsset, start, end, setup, wrapup);
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
		String resourceUID = atts.getValue ("resource");
		String startTime   = atts.getValue ("start");
		String endTime     = atts.getValue ("end");
		String setupTime   = atts.getValue ("setup");
		String wrapupTime  = atts.getValue ("wrapup");
		start     = format.parse (startTime);
		end       = format.parse (endTime);
		setup     = format.parse (setupTime);
		wrapup    = format.parse (wrapupTime);

		assignedAsset = resultListener.getAssetForKey (new StringKey (resourceUID));
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
		Task handledTask = resultListener.getTaskForKey (taskKey);
		if (handledTask == null) {
		  // Ignore since task has already been handled
		  return;

		  // System.out.println (getName () + ".parseStartElement - no task found with " + taskUID + " uid.");
		} else
		  alpTasks.add (handledTask);

		// this is absolutely critical, otherwise VishnuPlugIn will make a failed disposition
		resultListener.removeTask (taskKey);
	  }
	  //	  else if (myExtraExtraOutput) {
	  //		System.out.println (getName () + ".parseStartElement - ignoring tag " + name);
	  //	  }
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
		resultListener.handleAssignment ((Task) alpTasks.get(i), assignedAsset, start, end, setup, wrapup);
	  alpTasks.clear ();
	}
	else if (name.equals ("TASK")) {}
	else if (debugParseAnswer) {
	  System.out.println (getName () + ".parseEndElement - ignoring tag " + name);
	}
  }

  public void setNameToDescrip (Map map) {
	myNameToDescrip = map;
  }

  public void setSingleAssetClassName (String name) {
	singleAssetClassName = name;
  }

  protected String getName () {
	return "XMLResultHandler";
  }
  
  Map myNameToDescrip;
  String singleAssetClassName;
  protected boolean debugParseAnswer = false;
  ResultListener resultListener;
  
  private final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
}
