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

import org.cougaar.domain.planning.ldm.asset.Asset;
import org.cougaar.domain.planning.ldm.plan.Task;
import org.cougaar.lib.param.ParamMap;
import org.cougaar.lib.vishnu.server.Scheduler;
import org.cougaar.util.StringKey;

import org.w3c.dom.Document;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

public class InternalMode extends ExternalMode {
  public InternalMode (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
					   VishnuDomUtil domUtil, VishnuConfig config, XMLResultHandler resultHandler, 
					   ParamMap myParamTable) {
	super (parent, comm, xmlProcessor, domUtil, config, resultHandler, myParamTable);
	localSetup ();
  }

  public void setupScheduler () {
	if (!incrementalScheduling || sched == null) {
	  if (myExtraOutput)
		System.out.println (parent.getName () + ".processTasks - creating scheduler.");

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
	* Run internally.  Create a new scheduler, and give it the contents of <br>
	* the internalBuffer, which has captured all the xml output that would <br>
	* normally go to the various URLs.  Then, parse the results using a SAX <br>
	* Parser and the AssignmentHandler, which just calls parseStartElement and <br>
	* parseEndElement.  The AssignmentHandler will create plan elements for
	* each assignment.<p>
	*
	* @see #parseStartElement
	* @see #parseEndElement
	*/
   public void run () {
	 int unhandledTasks = prepareScheduler ();

	 try {
	   if (myExtraExtraOutput)
		 for (int i = 0; i < sched.getSchedulingData().getResources ().length; i++) {
		   System.out.println (getName () + ".runInternally - Known Resource #" + i + 
							   " : \n" + sched.getSchedulingData().getResources()[i]);
		 }

	   // sched is the scheduler...
	   sched.scheduleInternal();

	   // the second argument controls whether to include frozen assignments in those returned
	   String assignments = sched.getXMLAssignments(true, !incrementalScheduling);
	 
	   if (myExtraOutput) 
		 System.out.println(getName () + ".runInternally - scheduled assignments were : " + assignments);

	   SAXParser parser = new SAXParser();
	   parser.setContentHandler (resultHandler.getHandler ());
	   try {
		 parser.parse (new InputSource (new StringReader (assignments)));
	   } catch (SAXException sax) {
		 System.out.println (getName () + ".runInternally - Got sax exception:\n" + sax);
	   } catch (IOException ioe) {
		 System.out.println (getName () + ".runInternally - Could not open file : \n" + ioe);
	   } catch (NullPointerException npe) {
		 System.out.println (getName () + ".runInternally - ERROR - no assignments were made, badly confused : \n" + npe);
	   }
	 } catch (Exception e) {
	   System.out.println (getName () + ".runInternally - Got error running scheduler : " + e.getMessage ());
	   e.printStackTrace ();
	 } finally {
	   cleanUpAfterScheduling (unhandledTasks);
	 }
   }

  /** implemented for SchedulerLifecycle */
  public void initializeWithFormat () {
	sched.setupInternal (comm.getBuffer (), false);
	comm.clearBuffer ();
  }
  
  protected int prepareScheduler () {
	// sched is the scheduler...
	// Call setupInternal before adding the data, parses the specs, object format, and other data
	sched.setupInternal (comm.getBuffer (), false);
	comm.clearBuffer ();
	
	return parent.getNumTasks();
  }

  protected void cleanUpAfterScheduling (int unhandledTasks) {
	Date start = new Date ();
	
	comm.clearBuffer ();

	if (incrementalScheduling) {
	  if (myExtraOutput)
		System.out.println (getName () + ".cleanUpAfterScheduling - sending freeze all.");

	  comm.serializeAndPostData (xmlProcessor.prepareFreezeAll ());
	  sched.setupInternal (comm.getBuffer(), false);
	  comm.clearBuffer ();
	}
	  
	if (showTiming) {
	  domUtil.reportTime (".run" + 
						  " - created successful plan elements for " +
						  (unhandledTasks-parent.getNumTasks ()) + " tasks in ", start);
	} else {
	  if (myExtraOutput || true)
		System.out.println (getName () + ".run" + 
							" - created successful plan elements for " +
							(unhandledTasks-parent.getNumTasks ()) + " tasks.");
	}
  }

  protected String getName () { return "InternalMode"; }
  
  Map myNameToDescrip;
  String singleAssetClassName;
  boolean alwaysClearDatabase;
  protected Scheduler sched;
  protected boolean sentOtherDataAlready = false;
  
  private final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
}
