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

import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.util.Collection;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.lib.param.ParamMap;
import org.cougaar.util.StringKey;
import org.cougaar.util.log.Logger;

import org.w3c.dom.Document;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;

/** 
 * Takes XML results returned from the scheduler and calls methods on the result listener 
 * to create plan elements 
 */
public class XMLResultHandler extends PluginHelper implements ResultHandler {
  public XMLResultHandler (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
			   VishnuDomUtil domUtil, VishnuConfig config,
			   ParamMap myParamTable,
			   Logger logger) {
    super (parent, comm, xmlProcessor, domUtil, config, myParamTable, logger);
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
    if (logger.isInfoEnabled())
      logger.info (parent.getName() + ".waitTillFinished - Vishnu scheduler result returned!");
    int unhandledTasks = parent.getNumTasks ();

    comm.getAnswer (new AssignmentHandler ());

    if (logger.isInfoEnabled())
      logger.info (parent.getName () + ".parseAnswer - created successful plan elements for " +
			  (unhandledTasks-parent.getNumTasks()) + " tasks.");
  }

  public DefaultHandler getAssignmentHandler () {
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
  String multicontribs;
  String multitext;
  protected Vector alpTasks = new Vector ();

  /**
   * Given the XML that indicates assignments, parse it
   *
   * Uses the <code>myTaskUIDtoObject</code> and <code>myAssetUIDtoObject</code> maps
   * to lookup the keys returned in the xml to figure out which task was assigned to
   * which asset.  These were set in processTasks using setUIDToObjectMap.
   * 
   * @param name the tag name
   * @param atts the tag's attributes
   * @see org.cougaar.lib.vishnu.client.VishnuPlugin#processTasks
   * @see org.cougaar.lib.vishnu.client.VishnuPlugin#setUIDToObjectMap
   */
  protected void parseStartElement (String name, Attributes atts) {
    try {
      if (logger.isDebugEnabled())
	logger.debug (parent.getName() + ".parseStartElement got " + name);
	  
      if (name.equals ("ASSIGNMENT")) {
	if (logger.isInfoEnabled()) {
	  logger.info (parent.getName () + ".parseStartElement -\nAssignment: task = " + atts.getValue ("task") +
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
	String contribs  = atts.getValue ("contribs");
	Date start         = format.parse (startTime);
	Date end           = format.parse (endTime);
	Date setup         = format.parse (setupTime);
	Date wrapup        = format.parse (wrapupTime);

	StringKey taskKey = new StringKey (taskUID);
	Task handledTask  = resultListener.getTaskForKey (taskKey);
	if (handledTask == null) {
	  // Ignore this assignment since it has already been handled previously
	  return;
		  
	  // logger.debug ("VishnuPlugin - AssignmentHandler.startElement no task found with " + taskUID);
	  // logger.debug ("\tmap was " + myTaskUIDtoObject);
	}
	else {
	  resultListener.removeTask (taskKey);
	}

	Asset assignedAsset = resultListener.getAssetForKey (new StringKey (resourceUID));
	if (assignedAsset == null) 
	  logger.debug ("VishnuPlugin - AssignmentHandler.startElement no asset found with " + resourceUID);
	
	resultListener.handleAssignment (handledTask, assignedAsset, start, end, setup, wrapup, contribs, atts.getValue("text"));
      }
      else if (name.equals ("MULTITASK")) {
	if (logger.isInfoEnabled() || debugParseAnswer) {
	  logger.info (getName () + ".parseStartElement -\nAssignment: " + 
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
	multicontribs  = atts.getValue ("contribs");
	start     = format.parse (startTime);
	end       = format.parse (endTime);
	setup     = format.parse (setupTime);
	wrapup    = format.parse (wrapupTime);

	multitext = atts.getValue("text");

	assignedAsset = resultListener.getAssetForKey (new StringKey (resourceUID));
	if (assignedAsset == null) 
	  logger.debug (getName () + ".parseStartElement - no asset found with " + resourceUID);
      }
      else if (name.equals ("TASK")) {
	if (logger.isInfoEnabled() || debugParseAnswer) {
	  logger.info (getName () + ".parseStartElement -\nTask: " + 
			      " task = " + atts.getValue ("task"));
	}
	String taskUID = atts.getValue ("task");

	StringKey taskKey = new StringKey (taskUID);
	Task handledTask = resultListener.getTaskForKey (taskKey);
	if (handledTask == null) {
	  // Ignore since task has already been handled
	  return;

	  // debug (getName () + ".parseStartElement - no task found with " + taskUID + " uid.");
	} else
	  alpTasks.add (handledTask);

	// this is absolutely critical, otherwise VishnuPlugin will make a failed disposition
	resultListener.removeTask (taskKey);
      }
      //	  else if (logger.isDebugEnabled()) {
      //		debug (getName () + ".parseStartElement - ignoring tag " + name);
      //	  }
    } catch (NullPointerException npe) {
      npe.printStackTrace ();
      logger.error (getName () + ".parseStartElement - got bogus assignment", npe);
    } catch (ParseException pe) {
      logger.error (getName () + ".parseStartElement - start or end time is in bad format " + 
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
	logger.debug (getName () + ".parseEndElement - got ending MULTITASK.");
      }
      for (int i = 0; i < alpTasks.size (); i++)
	resultListener.handleAssignment ((Task) alpTasks.get(i), assignedAsset, start, end, setup, wrapup, multicontribs, multitext);
      alpTasks.clear ();
    }
    else if (name.equals ("TASK")) {}
    else if (debugParseAnswer) {
      logger.debug (getName () + ".parseEndElement - ignoring tag " + name);
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
