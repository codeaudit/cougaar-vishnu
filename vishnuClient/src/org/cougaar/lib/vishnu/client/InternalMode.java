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

import com.bbn.vishnu.scheduling.Scheduler;
//import com.bbn.vishnu.scheduling.Task;

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
import org.cougaar.util.StringKey;
import org.cougaar.util.log.Logger;

import org.w3c.dom.Document;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

/** 
 * Internal mode.  
 * <p>
 * Creates an internal instance of the scheduler and talks to it, instead
 * of to a web server.  
 *
 */
public class InternalMode extends ExternalMode {
  protected boolean writeXMLToFile = false;
  protected boolean newDecoder = false;
  protected boolean writeVSHToFile = false;

  /** just calls localSetup */
  public InternalMode (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
		       VishnuDomUtil domUtil, VishnuConfig config, ResultHandler resultHandler,
		       ParamMap myParamTable, Logger logger) {
    super (parent, comm, xmlProcessor, domUtil, config, resultHandler, myParamTable, logger);
    localSetup ();
    try {
      if (myParamTable.hasParam("writeXMLToFile"))    
	writeXMLToFile = 
	  myParamTable.getBooleanParam("writeXMLToFile");    
      else 
	writeXMLToFile = false;

      if (myParamTable.hasParam("writeVSHToFile"))
	writeVSHToFile = myParamTable.getBooleanParam("writeVSHToFile");
      else
	writeVSHToFile = false;

      if (myParamTable.hasParam("newDecoder"))    
	newDecoder = myParamTable.getBooleanParam("newDecoder");    
      else 
	newDecoder = false;
    } catch (Exception e) {}
  }

  /** Create a new scheduler if in batch mode or if called the first time */
  public void setupScheduler () {
    if (!incrementalScheduling || sched == null) {
      sched = new Scheduler ();
      sched.setNewDecoder (newDecoder);
      if (logger.isInfoEnabled())
	logger.info (getName () + ".setupScheduler - created scheduler " + sched);

      sched.setupInternalObjects ();
      sched.getData().readEverything();
    }
  }
  
  /**
   * Place to handle rescinded tasks. <p>
   *
   * Sends XML to unfreeze the task assignment and delete it.
   * @param removedTasks changed assets found in the container
   * @see com.bbn.vishnu.scheduling.Scheduler#setupInternal
   */
  public void handleRemovedTasks(Enumeration removedTasks) {
    if (incrementalScheduling) {
      Vector knownTasks = new Vector();
      for (;removedTasks.hasMoreElements();) {
	Task task = (Task) removedTasks.nextElement();

	if (sched.getData().getTask(task.getUID().toString()) != null)
	  knownTasks.add (task);
      }

      Document docToSend = xmlProcessor.prepareRescind(knownTasks.elements(), parent.getTaskName());

      comm.serializeAndPostData (docToSend);

      if (logger.isInfoEnabled())
	logger.info ("InternalMode.handleRemovedTasks - telling scheduler " + sched + " to remove tasks.");

      //      try {
	sched.setupInternal (comm.getBuffer(), false);
	//      } catch (Exception e) {
	//	if (logger.isDebugEnabled())
	//	  logger.debug ("InternalMode.handleRemovedTasks - " + 
	//			"got exception related to a task that the scheduler didn't know about.\n" +
	//			" Is this innocuous?");
	//      }
      comm.clearBuffer ();
    }
  }

  /**
   * Place to handle unfrozen tasks. <p>
   *
   * Sends XML to unfreeze the task assignment
   * @param tasks
   * @see com.bbn.vishnu.scheduling.Scheduler#setupInternal
   */
  public void unfreezeTasks(Collection tasks) {
    if (incrementalScheduling) {
      Vector knownTasks = new Vector();
      for (java.util.Iterator iter = tasks.iterator();iter.hasNext();) {
	Task task = (Task) iter.next();

	if (sched.getData().getTask(task.getUID().toString()) != null)
	  knownTasks.add (task);
	else {
	  logger.warn ("skipping unfreezing unknown task " + task.getUID());
	}
      }

      Document docToSend = xmlProcessor.prepareUnfreeze(knownTasks);

      comm.serializeAndPostData (docToSend);

      if (logger.isInfoEnabled())
	logger.info ("InternalMode.unfreezeTasks - telling scheduler " + sched + " to remove tasks.");

      sched.setupInternal (comm.getBuffer(), false);
      comm.clearBuffer ();
    }
  }

  public Collection getTaskKeys () { 
    com.bbn.vishnu.scheduling.Task [] tasks = sched.getData().getTasks();
    Collection taskKeys = new java.util.HashSet();

    for (int i = 0; i < tasks.length; i++) {
      taskKeys.add(tasks[i].getKey());
    }

    return taskKeys;
  } 

  /** 
   * <pre>
   * Run internally. Give the scheduler the contents of 
   * the internalBuffer (in VishnuComm), which has captured all the xml output 
   * that would normally go to the various URLs if in external mode.  
   * 
   * Then, parse the results using an XMLResultHandler, which is just a SAX 
   * Parser and the AssignmentHandler, which just calls parseStartElement and
   * parseEndElement.  The AssignmentHandler will call methods in the VishnuPlugin
   * to create plan elements for each assignment.
   *
   * </pre>
   * @see XMLResultHandler#parseStartElement
   * @see XMLResultHandler#parseEndElement
   */
  public void run () {
    int unhandledTasks = prepareScheduler ();

    try {
      if (logger.isDebugEnabled())
	for (int i = 0; i < sched.getData().getResources ().length; i++) {
	  logger.debug (getName () + ".run - Known Resource #" + i + 
			      " : \n" + sched.getData().getResources()[i]);
	}

      // sched is the scheduler...
      sched.scheduleInternal(null, false);

      // the second argument controls whether to include frozen assignments in those returned
      String assignments = sched.getXMLAssignments(true, !incrementalScheduling);
	 
      if (writeXMLToFile) {
	if (logger.isInfoEnabled()) 
	  logger.info(getName () + ".run - writing assignments to XML file.");
	comm.writeBufferToFile("assignments", sched.getXMLAssignments(false, !incrementalScheduling));
        //  logger.info(getName () + ".run - writing complete Vishnu problem to XML file.");
        //comm.writeBufferToFile("complete", sched.toXML());
      }
      dumpPostProcess();

      if (logger.isInfoEnabled()) 
	logger.info(getName () + ".run - scheduled assignments were : " + assignments);

      SAXParser parser = new SAXParser();
      parser.setContentHandler (((XMLResultHandler)resultHandler).getAssignmentHandler ());
      try {
	parser.parse (new InputSource (new StringReader (assignments)));
      } catch (SAXException sax) {
	logger.error (getName () + ".run - Got sax exception:\n" + sax, sax);
      } catch (IOException ioe) {
	logger.error (getName () + ".run - Could not open file : \n" + ioe, ioe);
      } catch (NullPointerException npe) {
	logger.error (getName () + ".run - ERROR - no assignments were made, badly confused : \n" + npe, npe);
      }
    } catch (Exception e) {
      logger.error (getName () + ".run - Got error running scheduler : " + e.getMessage (), e);
    } finally {
      cleanUpAfterScheduling (unhandledTasks);
    }
  }

  /** Method to hide domain-specific output routines */
  protected void dumpPostProcess() {
    if (writeVSHToFile) {
      if (logger.isInfoEnabled())
	logger.info(getName () + ".run - writing complete Vishnu problem to VSH file (vishnu XML format).");
      comm.writeBufferToFile_withBackup("complete", ".vsh", sched.toXML());
    }
  }

  /** 
   * Implemented for SchedulerLifecycle
   * <p>
   * Call SAXParser in scheduler to set it up with the specs, object format, etc.
   * @see com.bbn.vishnu.scheduling.Scheduler#setupInternal
   */
  public void initializeWithFormat () {
    if (logger.isInfoEnabled())
      logger.info ("InternalMode - initializing scheduler " + sched + " with format.");

    sched.setupInternal (comm.getBuffer (), false);
    comm.clearBuffer ();
  }
  
  /** 
   * Call setupInternal to initialize scheduler with task and asset data 
   * @see com.bbn.vishnu.scheduling.Scheduler#setupInternal
   */  
  protected int prepareScheduler () {
    // sched is the scheduler...
    if (comm.getBuffer ().length () != 0) {
      sched.setupInternal (comm.getBuffer (), false);
      comm.clearBuffer ();
    }
	
    return parent.getNumTasks();
  }

  /** 
   * send other data, if it hasn't already been sent 
   * @see com.bbn.vishnu.scheduling.Scheduler#setupInternal
   */
  protected void sendOtherData () {
    if (comm.getBuffer ().length () != 0) {
      sched.setupInternal (comm.getBuffer (), false);
      comm.clearBuffer ();
    }
    super.sendOtherData ();
  }
  
  /** 
   * Inform of # of unhandled tasks <br>
   * Freeze all assignments if incremental mode 
   */
  protected void cleanUpAfterScheduling (int unhandledTasks) {
    Date start = new Date ();
	
    comm.clearBuffer ();

    if (incrementalScheduling) {
      if (logger.isDebugEnabled())
	logger.debug (getName () + ".cleanUpAfterScheduling - sending freeze all.");

      serializeAndPostDoc (xmlProcessor.prepareFreezeAll ());
      sched.getData().checkpointFrozen();
    }
	  
    if (showTiming) {
      domUtil.reportTime (getName () + ".cleanUpAfterScheduling" + 
			  " - created successful plan elements for " +
			  (unhandledTasks-parent.getNumTasks ()) + " tasks in ", start);
    } else {
      if (logger.isInfoEnabled())
	logger.info (getName () + 
		     " - created successful plan elements for " +
		     (unhandledTasks-parent.getNumTasks ()) + " tasks.");
    }
  }

  /** 
   * Serialize and post telling scheduler to setupInternal 
   *
   * @see com.bbn.vishnu.scheduling.Scheduler#setupInternal
   */
  protected void serializeAndPostDoc (Document doc) {
    comm.serializeAndPostData (doc);
    sched.setupInternal (comm.getBuffer(), false);
    comm.clearBuffer ();
  }

  /** name of this object */
  protected String getName () { return parent.getName() + "-InternalMode"; }

  /** queries the scheduler to get a full specification of the problem
   *   (including specs, logic, gaspecs, objects, assignments, etc)
   */
  public String dumpToXML() {
      try {
          return sched.toXML();
      }
      catch (Exception e) {
          return "";
      }
  }

  /** seeds the scheduler with the given chromosome 
   *   in format  "Cid*%*id*%*..."
   */
  public void seedScheduler(String seedChrom) {
      sched.seedChromosome(seedChrom);
  }

  
  Map myNameToDescrip;
  String singleAssetClassName;
  boolean alwaysClearDatabase;
  /** the internal scheduler instance */
  protected Scheduler sched;
  
  private final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
}
