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
 * Internal mode.  
 * <p>
 * Creates an internal instance of the scheduler and talks to it, instead
 * of to a web server.  
 *
 */
public class InternalMode extends ExternalMode {
  public InternalMode (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
					   VishnuDomUtil domUtil, VishnuConfig config, ResultHandler resultHandler,
					   ParamMap myParamTable) {
	super (parent, comm, xmlProcessor, domUtil, config, resultHandler, myParamTable);
	localSetup ();
  }

  /** Create a new scheduler if in batch mode or if called the first time */
  public void setupScheduler () {
	if (!incrementalScheduling || sched == null) {
	  if (myExtraOutput)
		System.out.println (getName () + ".setupScheduler - creating scheduler.");

	  sched = new Scheduler ();
	  sched.setupInternalObjects ();
	}
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
   public void handleRemovedTasks(Enumeration removedTasks) {
	 if (incrementalScheduling) {
	   Document docToSend = xmlProcessor.prepareRescind(removedTasks);

	   comm.serializeAndPostData (docToSend);
	   sched.setupInternal (comm.getBuffer(), false);
	   comm.clearBuffer ();
	 }
   }

   /** 
	* Run internally. Give the scheduler the contents of 
	* the internalBuffer (in VishnuComm), which has captured all the xml output 
	* that would normally go to the various URLs if in external mode.  
	* <p>
	* Then, parse the results using an XMLResultHandler, which is just a SAX <br>
	* Parser and the AssignmentHandler, which just calls parseStartElement and <br>
	* parseEndElement.  The AssignmentHandler will call methods in the VishnuPlugin
	* to create plan elements for each assignment.<p>
	*
	* @see XMLResultHandler#parseStartElement
	* @see XMLResultHandler#parseEndElement
	*/
   public void run () {
	 int unhandledTasks = prepareScheduler ();

	 try {
	   if (myExtraExtraOutput)
		 for (int i = 0; i < sched.getSchedulingData().getResources ().length; i++) {
		   System.out.println (getName () + ".run - Known Resource #" + i + 
							   " : \n" + sched.getSchedulingData().getResources()[i]);
		 }

	   // sched is the scheduler...
	   sched.scheduleInternal();

	   // the second argument controls whether to include frozen assignments in those returned
	   String assignments = sched.getXMLAssignments(true, !incrementalScheduling);
	 
	   if (myExtraOutput) 
		 System.out.println(getName () + ".run - scheduled assignments were : " + assignments);

	   SAXParser parser = new SAXParser();
	   parser.setContentHandler (((XMLResultHandler)resultHandler).getAssignmentHandler ());
	   try {
		 parser.parse (new InputSource (new StringReader (assignments)));
	   } catch (SAXException sax) {
		 System.out.println (getName () + ".run - Got sax exception:\n" + sax);
	   } catch (IOException ioe) {
		 System.out.println (getName () + ".run - Could not open file : \n" + ioe);
	   } catch (NullPointerException npe) {
		 System.out.println (getName () + ".run - ERROR - no assignments were made, badly confused : \n" + npe);
	   }
	 } catch (Exception e) {
	   System.out.println (getName () + ".run - Got error running scheduler : " + e.getMessage ());
	   e.printStackTrace ();
	 } finally {
	   cleanUpAfterScheduling (unhandledTasks);
	 }
   }

  /** 
   * Implemented for SchedulerLifecycle
   * <p>
   * Call SAXParser in scheduler to set it up with the specs, object format, etc.
   */
  public void initializeWithFormat () {
	sched.setupInternal (comm.getBuffer (), false);
	comm.clearBuffer ();
  }
  
  /** Call setupInternal to initialize scheduler with task and asset data */  
  protected int prepareScheduler () {
	// sched is the scheduler...
	if (comm.getBuffer ().length () != 0) {
	  sched.setupInternal (comm.getBuffer (), false);
	  comm.clearBuffer ();
	}
	
	return parent.getNumTasks();
  }

  /** send other data, if it hasn't already been sent */
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
	  if (myExtraOutput)
		System.out.println (getName () + ".cleanUpAfterScheduling - sending freeze all.");

	  serializeAndPostDoc (xmlProcessor.prepareFreezeAll ());
	}
	  
	if (showTiming) {
	  domUtil.reportTime (getName () + ".cleanUpAfterScheduling" + 
						  " - created successful plan elements for " +
						  (unhandledTasks-parent.getNumTasks ()) + " tasks in ", start);
	} else {
	  if (myExtraOutput || true)
		System.out.println (getName () + 
							" - created successful plan elements for " +
							(unhandledTasks-parent.getNumTasks ()) + " tasks.");
	}
  }

  protected void serializeAndPostDoc (Document doc) {
	comm.serializeAndPostData (doc);
	sched.setupInternal (comm.getBuffer(), false);
	comm.clearBuffer ();
  }

  protected String getName () { return parent.getName() + "-InternalMode"; }
  
  Map myNameToDescrip;
  String singleAssetClassName;
  boolean alwaysClearDatabase;
  protected Scheduler sched;
  protected boolean sentOtherDataAlready = false;
  
  private final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
}
