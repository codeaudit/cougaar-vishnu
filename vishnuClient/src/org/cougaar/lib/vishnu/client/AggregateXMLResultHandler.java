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

import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.lib.param.ParamMap;
import org.cougaar.util.StringKey;
import org.cougaar.util.log.Logger;

import org.w3c.dom.Document;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/** 
 * Result handler used by VishnuAggregatorPlugin  <p>
 *
 * Interacts with ResultListener, which the plugin implements
 *
 * @see ResultListener
 */
public class AggregateXMLResultHandler extends XMLResultHandler {
  /** called by VishnuAggregatorPlugin#createXMLResultHandler */
  public AggregateXMLResultHandler (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
				    VishnuDomUtil domUtil, VishnuConfig config,
				    ParamMap myParamTable, Logger logger) {
    super (parent, comm, xmlProcessor, domUtil, config, myParamTable, logger);
  }

  /**
   * Given the XML that indicates assignments, parse it <p>
   *
   * Asks the ResultListener to lookup the keys returned in the xml to figure out <br>
   * which task was assigned to which asset.  These were set in processTasks using <br>
   * setUIDToObjectMap.
   * 
   * @param name the tag name
   * @param atts the tag's attributes
   * @see org.cougaar.lib.vishnu.client.VishnuPlugin#processTasks
   * @see org.cougaar.lib.vishnu.client.VishnuPlugin#setUIDToObjectMap
   */
  protected void parseStartElement (String name, Attributes atts) {
    try {
      if (logger.isDebugEnabled())
	logger.debug (getName() + ".parseStartElement got " + name);
	  
      if (name.equals ("MULTITASK")) {
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
	start     = format.parse (startTime);
	end       = format.parse (endTime);
	setup     = format.parse (setupTime);
	wrapup    = format.parse (wrapupTime);

	assignedAsset = resultListener.getAssetForKey (new StringKey (resourceUID));
	assetWasUsedBefore = false;
	if (assignedAsset == null) 
	  logger.debug (getName () + ".parseStartElement - no asset found with " + resourceUID);
      }
      else if (name.equals ("TASK")) {
	if (logger.isInfoEnabled() || debugParseAnswer) {
	  logger.info (getName () + ".parseStartElement -\nTask: " + 
		       " task = " + atts.getValue ("task"));
	}
	if (atts.getValue ("task") == null)
	  logger.error (getName () + ".parseStartElement - ERROR, no task attribute on TASK element? " + 
			"Element attributes were " + atts);

	String taskUID = atts.getValue ("task");

	StringKey taskKey = new StringKey (taskUID);
	Task handledTask  = resultListener.getTaskForKey (taskKey);
	if (handledTask == null) {
	  // Already handled before
	  assetWasUsedBefore = true;
	  return;
	  // debug (getName () + ".parseStartElement - no task found with " + taskUID + " uid.");
	  // debug ("\tmap keys were " + myTaskUIDtoObject.keySet());
	}
	else {
	  alpTasks.add (handledTask);
	}

	// this is absolutely critical, otherwise VishnuPlugin will make a failed disposition
	resultListener.removeTask (taskKey);
	if (debugParseAnswer)
	  logger.debug (getName () + ".parseStartElement - removing task key " + taskKey);
      }
      else if (debugParseAnswer) {
	logger.debug (getName () + ".parseStartElement - ignoring tag " + name);
      }
    } catch (ParseException pe) {
      logger.error (getName () + ".parseStartElement - start or end time is in bad format " + 
		    pe + "\ndates were : " +
		    " start = " + atts.getValue ("start") +
		    " end = " + atts.getValue ("end") +
		    " setup = " + atts.getValue ("setup") +
		    " wrapup = " + atts.getValue ("wrapup"), pe);
    } catch (Exception npe) {
      logger.error (getName () + ".parseStartElement - got bogus assignment " + npe.getMessage(), npe);
    }
  }

  /** Calls resultListener (= the plugin) handleMultiAssignment when sees a MULTITASK end tag */
  protected void parseEndElement (String name) {
    try {
      if (name.equals ("MULTITASK")) {
	if (debugParseAnswer) {
	  logger.debug (getName () + ".parseEndElement - got ending MULTITASK.");
	}
	if (!alpTasks.isEmpty()) {
	  resultListener.handleMultiAssignment (alpTasks, assignedAsset, start, end, setup, wrapup, assetWasUsedBefore);
	  assetWasUsedBefore = false;
	  alpTasks.clear ();
	}
      }
      else if (name.equals ("TASK")) {}
      //	  else if (debugParseAnswer) {
      //		debug (getName () + ".parseEndElement - ignoring tag " + name);
      //	  }
    } catch (Exception npe) {
      logger.error (getName () + ".parseEndElement - got bogus assignment " + npe.getMessage(), npe);
    }
  }

  protected String getName () {
    return "AggregateXMLResultHandler";
  }

  protected boolean assetWasUsedBefore;
  protected boolean debugParseAnswer = false;
  
  private final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
}
