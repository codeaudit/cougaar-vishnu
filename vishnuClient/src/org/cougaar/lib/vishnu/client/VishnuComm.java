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

import java.io.CharArrayReader;
import java.io.CharArrayWriter;
import java.io.File;
import java.io.FileWriter;
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

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.xerces.dom.DocumentImpl;
import org.apache.xerces.parsers.SAXParser;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;

import org.cougaar.lib.param.ParamMap;
import org.cougaar.util.log.*;

import org.w3c.dom.Document;

import org.xml.sax.helpers.DefaultHandler;

/** 
 * Abstractions of communication for Vishnu  <p>
 *
 * Hides whether we're running internally or externally from callers. <p>
 *
 * Knows about command-to-URL mapping, e.g. postCancel becomes a URL calling 
 * the php script postcancel.php. <p>
 *
 * Uses an internalBuffer to write to when we're running internally.  It holds
 * the same bytes as are sent to the web server when running externally.
 **/
public class VishnuComm {
  private static Map clusterToInstance = new HashMap ();

  /** 
   * Sets the problem name <p>
   * calls postCancel and postClear if running externally 
   */
  public VishnuComm (ParamMap myParamTable,
		     String name, 
		     String clusterName,
		     VishnuDomUtil domUtil,
		     boolean runInternal,
		     Logger logger) {
    this.logger = logger;
    this.myParamTable = myParamTable;
	
    localSetup ();
    this.name = name;
    this.clusterName = clusterName;
    this.domUtil = domUtil;

    URL = "http://" + hostName + phpPath;

    setProblemName ();

    this.runInternal = runInternal;
	
    // clears any pending jobs for this problem
    if (!runInternal) {
      postCancel ();
      postClear  ();
    }
  }

  protected ParamMap   getMyParams    () { return myParamTable; }
  protected String     getName        () { return name;         }
  protected String     getClusterName () { return clusterName;  }
  public    String     getProblem     () { return myProblem;    }
  
  /** sets a variety of parameters */
  protected void localSetup () {
    try {    
      if (getMyParams().hasParam("hostName"))    
	hostName = getMyParams().getStringParam("hostName");    
      else 
	hostName = "dante.bbn.com";

      if (getMyParams().hasParam("phpPath"))
	phpPath = getMyParams().getStringParam("phpPath");    
      else 
	phpPath = "/~dmontana/vishnu/";

      if (getMyParams().hasParam("user"))
	myUser = getMyParams().getStringParam("user");    
      else 
	myUser = "vishnu";

      if (getMyParams().hasParam("password"))
	myPassword = getMyParams().getStringParam("password"); 
      else 
	myPassword = "vishnu";

      if (getMyParams().hasParam("legalHosts")) 
	myLegalHosts = getMyParams().getStringParam("legalHosts").trim(); 
      else 
	myLegalHosts = ""; // empty = all schedulers are OK

      if (getMyParams().hasParam("postProblemFile"))
	postProblemFile = getMyParams().getStringParam("postProblemFile");    
      else 
	postProblemFile = "postproblem" + PHP_SUFFIX;

      if (getMyParams().hasParam("postDataFile"))
	postDataFile = getMyParams().getStringParam("postDataFile");    
      else 
	postDataFile = "postdata" + PHP_SUFFIX;

      if (getMyParams().hasParam("kickoffFile"))
	kickoffFile = getMyParams().getStringParam("kickoffFile");    
      else 
	kickoffFile = "postkickoff" + PHP_SUFFIX;

      if (getMyParams().hasParam("readStatusFile"))
	readStatusFile = getMyParams().getStringParam("readStatusFile");    
      else 
	readStatusFile = "readstatus" + PHP_SUFFIX;

      if (getMyParams().hasParam("assignmentsFile"))    
	assignmentsFile = getMyParams().getStringParam("assignmentsFile");    
      else 
	assignmentsFile = "assignments" + PHP_SUFFIX;

      if (getMyParams().hasParam("showTiming"))
	showTiming = getMyParams().getBooleanParam("showTiming");    
      else 
	showTiming = true;

      if (getMyParams().hasParam("testing"))
	testing = getMyParams().getBooleanParam("testing");    
      else 
	testing = false;

      // writes the XML sent to Vishnu web server to a file (human readable)
      if (getMyParams().hasParam("writeXMLToFile"))    
	writeXMLToFile = 
	  getMyParams().getBooleanParam("writeXMLToFile");    
      else 
	writeXMLToFile = false;

      // writes the XML sent to Vishnu web server to a file (machine readable)
      if (getMyParams().hasParam("writeEncodedXMLToFile"))
	writeEncodedXMLToFile = 
	  getMyParams().getBooleanParam("writeEncodedXMLToFile");    
      else 
	writeEncodedXMLToFile = false;

      // seconds - total wait time is maxWaitCycles * waitTime
      if (getMyParams().hasParam("waitTime"))
	waitTime = getMyParams().getLongParam("waitTime")*1000L;    
      else 
	waitTime = 5000L;

      // how many times to poll Vishnu before giving up 
      // total wait time is maxWaitCycles * waitTime
      if (getMyParams().hasParam("maxWaitCycles"))    
	maxWaitCycles = getMyParams().getIntParam("maxWaitCycles");    
      else 
	maxWaitCycles = 10;

    } catch (Exception e) {}
  }

  /** 
   * serialize document and post as data to web server or internal buffer 
   *
   * Just calls serializeAndPost with correct arguments.
   * @see #serializeAndPost
   **/
  public void serializeAndPostData (Document doc) {
    serializeAndPost (doc, true, runInternal, internalBuffer);
  }

  /** 
   * serialize document and post as problem definition to web server or internal buffer 
   *
   * Just calls serializeAndPost with correct arguments.
   * @see #serializeAndPost
   */
  public void serializeAndPostProblem (Document doc) {
    serializeAndPost (doc, false, runInternal, internalBuffer);
  }

  /**
   * post the Document <code>doc</code> to a URL.                            <p>
   *                                                                        <br>
   * If <code>writeXMLToFile</code> is set, will write a copy of what is     
   * sent to the URL to a file named ClusterName_type_number, where type is  
   * problem (the problem definition) or data (the tasks and resources), and 
   * number is a counter that keeps the file names unique                    <p>
   *                                                                        <br>
   * What's written to the file is human readable, whereas if                
   * <code>writeEncodedXMLToFile</code> is set, a different file is written, 
   * named ClusterName_encoded_number.  This file contains exactly what is   
   * sent to the web server, after URL encoding has been performed.          <p>
   *
   * Does the work of serialization here, by calling DomUtil function getDocAsArray,
   * and lets the other signature do actual posting.
   *
   * @see VishnuDomUtil#getDocAsArray
   * @param doc - DOM doc to send to URL
   * @param postData - true if posting data 
   */
  protected void serializeAndPost (Document doc, boolean postData, 
				   boolean runInternal, StringBuffer internalBuffer) {
    serializeAndPost (domUtil.getDocAsArray (doc).toString(), postData, runInternal, internalBuffer);

    if (writeXMLToFile) {
      String suffix = (postData) ? "data" : "problem";
      String fileName = getClusterName () + "_" + suffix + "_" + numFilesWritten++ + ".xml";
      logger.info (getName () + ".serializeAndPost - Writing XML to file " + fileName);
      try {
	FileOutputStream temp = new FileOutputStream (fileName);
	domUtil.writeDocToStream (doc, temp);
      } 
      catch (FileNotFoundException fnfe) { /* never happen */ }
      catch (IOException ioe) { /* never happen */ }
    }
  }

  /** 
   * <pre>
   * Does most of the work of posting, the other signature does the serializing.
   *
   * If running internally, just appends the data to the buffer. Otherwise tries to
   * to either post data or post the problem
   *
   * Only called by other serializeAndPost
   *
   * </pre>
   * @see #postProblem
   * @see #postData
   **/
  protected void serializeAndPost (String doc, boolean postData, 
				   boolean runInternal, StringBuffer internalBuffer) {
    if (runInternal)
      appendToInternalBuffer( doc, internalBuffer);
    else {
      if (postData) {
	if (!postData (doc)) {
	  showPostDataWarning ();
	}
      }
      else
	postProblem (doc);
    }
  }

  /** adds data to internal buffer */
  public void appendToBuffer (String data) {
    appendToInternalBuffer (data, internalBuffer);
  }

  /** adds data to internal buffer, removing any xml header */
  protected void appendToInternalBuffer (String data, StringBuffer internalBuffer) {
    int index;
    if ((index = data.indexOf ("?>")) != -1) {
      String stuff = data.substring (index+2);
      internalBuffer.append (stuff);
    }
  }

  /** 
   * Clears internal buffer  <p>
   * 
   * Called by various methods in InternalMode, after having asked scheduler to parse data
   * in the buffer.
   * @see InternalMode#prepareScheduler
   **/
  public void clearBuffer () {
    internalBuffer = new StringBuffer (INITIAL_INTERNAL_BUFFER_SIZE);
  }

  /** return string representation of buffer */
  public String getBuffer () {
    return new String (internalBuffer);
  }

  /** dumps warning to stdout when problem definition is out of sync with data format */
  protected void showPostDataWarning () {
    logger.info ("\n-----------------------------------------------\n" + 
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

    try {
      if (getMyParams().hasParam("problemName"))
	myProblem = getMyParams().getStringParam("problemName");
    } catch(Exception e) {
      myProblem = getClusterName();

      synchronized (clusterToInstance) {
	if (((List) clusterToInstance.get (getClusterName ())).size () > 1) {
	  myProblem = myProblem + "_" + 
	    ((List) clusterToInstance.get (getClusterName ())).indexOf (this);
	  if (logger.isDebugEnabled())
	    logger.debug (getName ()+ ".localSetup - this " + this + " is " + 
			  ((List) clusterToInstance.get (getClusterName ())).indexOf (this) +
			  " of " + 
			  ((List) clusterToInstance.get (getClusterName ())).size ());
	}
      }
      // mysql doesn't like -'s
      myProblem = myProblem.replace('-', '_');
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
      logger.error (getName () + ".localSetup - Huh? Could not find localhost? " +
		    uhe.getMessage (), uhe);
    }
  }

  /** 
   * Posts data to web site or internal buffer, depending on mode  <p>
   *
   * URL encodes the data <p>
   *
   * Calls postToURL with URL header and data
   * @see #postToURL
   * @param data to send to URL
   */
  public boolean postData (String data) {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&");
    sb.append (getProblemPostVar ());
    sb.append (getInstancePostVar () + "&");
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("data=");
    try { sb.append (java.net.URLEncoder.encode(data, "UTF-8"));
    } catch (Exception e) { logger.error ("huh?", e);}

    Date start = new Date();
    String reply =
      postToURL (hostName, postDataFile, sb.toString (), null, true);
    if (showTiming)
      domUtil.reportTime (" - did post of data string to URL in ", start);

    if (!reply.startsWith ("SUCCESS")) {
      logger.error (getName () + ".postData - ERROR : Reply to post data was <" + reply + ">");
      return false;
    }
    else if (logger.isInfoEnabled())
      logger.info (getName () + ".postData - Reply to post data was <" + reply.trim() + ">");
	
    return true;
  }

  /**
   * Posts problem to web site/internal buffer <p>
   *
   * URL encodes the data <p>
   *
   * Calls postToURL with URL header and data <p>

   * bogus is sent first because user would not arrive 
   * at php with value if it was sent first.  No idea why. <p>
   *
   * @see #postToURL
   * @param data to send to URL
   */
  public void postProblem (String data) {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&"); 
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("data=");
    try { sb.append (java.net.URLEncoder.encode(data, "UTF-8"));
    } catch (Exception e) { logger.error ("huh?", e);}

    String reply = postToURL (hostName, postProblemFile, sb.toString (), null, true);

    if (logger.isInfoEnabled())
      logger.info (getName() + ".postProblem - reply was <" + reply.trim() + ">");
  }

  /**
   * Cancels any pending jobs. <p>
   * 
   * Should only be done once, when the plugin loads. <p>
   *
   * This is an insurance policy against the case where someone
   * starts a society and runs it, but never starts a scheduler, or otherwise
   * gets a problem into the state of "processing" but not "complete."  
   * Once in the "processing" state, the scheduler will not accept new 
   * jobs for this problem, effectively blocking it for all time.
   *
   * bogus is sent first because <code>user</code> would not arrive 
   * at php with value if it was sent first.  No idea why. <p>
   *
   * Calls postToURL with URL header
   * @see #postToURL
   */
  public void postCancel () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&"); 
    sb.append (getProblemPostVar  () + "&");
    sb.append ("username=" + myUser + "&");
    sb.append ("password=" + myPassword);

    if (logger.isInfoEnabled())
      logger.info (getName () + ".postCancel - canceling any pending scheduling requests for " + 
			  myProblem);

    String reply = postToURL (hostName, postCancelFile, sb.toString (), null, true);
    if (logger.isInfoEnabled())
      logger.info (getName () + ".postCancel - reply was " + reply);
  }

  /**
   * <pre>
   * Tells database or scheduler to forget all data associated with the problem
   *
   * Calls postToURL with URL header
   * </pre>
   * @see #postToURL 
   */
  public void postClear () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&"); 
    sb.append (getProblemPostVar  () + "&");
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword);

    if (logger.isInfoEnabled())
      logger.info (getName () + ".postClear - clearing data from previous runs " + 
			  myProblem);

    String clearDataMsg = sb + "&<PROBLEM NAME="+getProblem ()+"/><CLEARDATABASE" + '\\' + ">";

    String reply = postToURL (hostName, postDataFile, clearDataMsg, null, true);
    if (logger.isInfoEnabled())
      logger.info (getName () + ".postClear - reply was " + reply);
  }

  /** 
   * <pre>
   * Tells the scheduler to start.
   *
   * bogus is sent first because <code>user</code> would not arrive <br>
   * at php with it's value if it was sent first.  No idea why.  <p>
   *
   * BOZO - Still a problem???
   * Calls postToURL with URL header
   * </pre>
   * @see #postToURL 
   */
  public void startScheduling () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&" + getProblemPostVar ());
    sb.append (getInstancePostVar () + "&");
    sb.append (getUserPostVar () + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("legalhosts=" + myLegalHosts + "&");
    sb.append ("ferris=bueller");

    String reply = postToURL (hostName, kickoffFile, sb.toString (), null, true);
    if (logger.isInfoEnabled())
      logger.info (getName () + ".startScheduling - reply to kickoff was " + reply.trim());
  }

  /** 
   * <pre>
   * Polls the scheduler for it's status
   *
   * Only uses in external mode
   *
   * Sleeps between polls
   *
   * Calls postToURL with URL header
   * </pre>
   * @see ExternalMode#run
   * @see #postToURL 
   */
  public boolean waitTillFinished () {
    String postVars = getWaitPostVars ();
	
    boolean gotAnswer = false;
    for (int i = 0; i < maxWaitCycles; i++) {
      String response = 
	postToURL (hostName, readStatusFile, postVars, null, true);
      if (response.indexOf (done) != -1) {
	gotAnswer = true;
	break;
      }
      else if (logger.isInfoEnabled()) {
	logger.info (getName() + ".waitTillFinished - Scheduler not done. Reply was <" + response.trim() + ">");
      }

      try { Thread.sleep (waitTime); } catch (Exception e) {}
    }
	
    return gotAnswer;
  }

  /** 
   * <pre>
   * Get the answer back from the web site/scheduler 
   *
   * Called by XMLResultHandler
   *
   * Calls readXML with the assignment handler
   *
   * </pre>
   * @see XMLResultHandler#parseAnswer
   * @see #readXML
   **/
  public void getAnswer (DefaultHandler assignmentHandler) {
    try {
      String url = "http://" + hostName + phpPath + assignmentsFile + getWaitPostVars();
      URL aURL = new URL (url);

      if (logger.isInfoEnabled())
	logger.info (getName () + ".getAnswer - reading from " + url);

      readXML (aURL, assignmentHandler);
    } catch (Exception e) {
      logger.error (getName () + ".getAnswer - BAD URL : " + e);
      e.printStackTrace ();
    }
  }

  /** create wait URL */
  protected String getWaitPostVars () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&" + getProblemPostVar ());
    sb.append (getInstancePostVar () + "&");
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("ferris=bueller");
    return sb.toString ();
  }
  
  /** the problem post variable */
  protected String getProblemPostVar () {
    return "problem=" + myProblem + "&";
  }

  /** the problem instance post variable */
  protected String getInstancePostVar () {
    return "instance=" + myInstance;
  }

  /** the user post variable */
  protected String getUserPostVar () {
    return "user=" + myUser;
  }

  /** 
   * Posts data to a URL, given the host, the php file, the URL header data, the doc to send
   *
   * @return response, if asked for one with <code>readResponse</code>
   */
  public String postToURL (String host,
			   String fileToExec,
			   String data,
			   Document doc,
			   boolean readResponse) {
    try {
      String url = "http://" + host + phpPath + fileToExec;
      if (testing) {
	logger.info ("postToURL - (complete) Sending to : " + url);
	try { logger.info (java.net.URLDecoder.decode(data, "UTF-8"));
	} catch (Exception e) { logger.error ("huh?", e);}
      }
      else if (logger.isInfoEnabled()) {
	logger.info ("postToURL - (partial) Sending to : " + url);
	logger.info (data.substring (0,
					    (data.length () > 100) ? 100 : data.length()));
      }
      return postToURL (new URL (url), 
			data, doc,
			readResponse);
    } catch (Exception e) {
      logger.error ("BAD URL : " + e, e);
      return "";
    }
  }

  /** 
   * Called from other signature  <p>
   * 
   * Post data to the URL <br>
   * If readResponse is true, read the response back from the URL and return it.
   */
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
	domUtil.reportTime (" - postToURL sent " + data.length() + " chars of data in ", start);

      if (readResponse) {
	start = new Date();
	String response = getResponse (connection);
	if (showTiming)
	  domUtil.reportTime (" - postToURL read response of " + response.length() + " in ", start);
	return response;
      }
    }
    catch(Exception e) {
      logger.error ("VishnuPlugin.postToURL -- exception sending data to URL : " + aURL +
		    "\n" + e.getMessage(), e);
    }
    return "";
  }

  /**
   * Sends data on the connection.  Writes to buffered stream that wraps the URL output stream. <br>
   *
   * Calls VishnuDomUtil.writeDocToStream to do most of work. <br>
   *
   * Optionally writes encoded XML to a file.
   * @see VishnuDomUtil#writeDocToStream
   */
  public void sendData(URLConnection connection, String data, Document doc) throws IOException {
    if (logger.isInfoEnabled()) {
      logger.info (name + ".sendData - Sending " + data.length () + " characters.");
      logger.info ("\tData=" + data.substring (0,
						      (data.length () > 100) ? 100 : data.length()));
    }

    OutputStream os = new BufferedOutputStream(connection.getOutputStream ());
    byte [] bytes = data.getBytes ();
    os.write(bytes);
    if (doc != null) {
      domUtil.writeDocToStream (doc, os);
      /*
	if (writeXMLToFile) {
	String fileName = getClusterName () + "_" + numFilesWritten++;
	debug ("Writing XML to file " + fileName);
	FileOutputStream temp = new FileOutputStream (fileName);
	writeDocToStream (doc, temp);
	}
      */
    } else if (writeEncodedXMLToFile) {
      String fileName = clusterName + "_encoded_" + numFilesWritten++;
      logger.info (name + ".sendData : Writing XML to file " + fileName);
      FileOutputStream temp = new FileOutputStream (fileName);
      bytes = data.getBytes ();
      temp.write(bytes);
      temp.flush ();
      temp.close ();
    }
	
    os.flush ();
    os.close ();
  }

  /**
   * Returns response as string. <br>
   *
   * If there is an IOException on the input stream, will try two more times.
   *
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
	logger.info (name + ".getResponse - IO Exception on reading from URL, trying again.");
	numTries--;
	try { Thread.sleep (5000l); } catch (Exception e) {}
      }
    }
    if (!madeInputStream) {
      logger.error (name + ".getResponse - ERROR : could not read from URL " + connection);
      return null;
    }

    byte b[] = new byte[1024];
    int len;
    while ((len = is.read(b)) > -1)
      sb.append (new String(b, 0, len));

    return sb.toString ();
  }

  /** post to URL without using URLConnection -- currently not used */
  private static String socketPostToURL (String hostName,
					 String phpPath,
					 String url,
					 String data, 
					 boolean readResponse,
					 Logger logger) {
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
      logger.error (e.getMessage(), e);
    }
    return "";
  }

  /** 
   * Get XML back from URL and give it to a SAX Parser, running the handler 
   *
   * @param aURL the URL to read from
   * @param handler will parse the XML coming from URL
   **/
  protected void readXML (URL aURL, DefaultHandler handler) {
    try {
      if (logger.isInfoEnabled()) {
	URLConnection connection = aURL.openConnection();
	connection.setDoOutput (false);
	connection.setDoInput  (true);

	logger.info (getResponse (connection));
      }

      SAXParser parser = new SAXParser();
      parser.setContentHandler(handler);
      parser.parse (aURL.toString());
    }
    catch(Exception e) {
      logger.error (e.getMessage(), e);
    }
  }

  // necessary configuration parameters - info about the Vishnu web server and mysql user and password
  /** web server user */
  protected String myUser     = "vishnu";
  /** web server password */
  protected String myPassword = "vishnu";
  /** web server host */
  protected String hostName = "dante.bbn.com";
  /** php path on web server host, relative to document root */
  protected String phpPath  = "/~dmontana/vishnu/";
  /** root of the URL, set above */
  protected String URL      = "http://" + hostName + phpPath;
  /** list of hosts the scheduler can run on */
  protected String myLegalHosts = "";

  protected String PHP_SUFFIX = ".php";
  /** php file to execute */
  protected String postProblemFile = "postproblem" + PHP_SUFFIX;
  /** php file to execute */
  protected String postDataFile    = "postdata" + PHP_SUFFIX;
  /** php file to execute */
  protected String kickoffFile     = "postkickoff" + PHP_SUFFIX;
  /** php file to execute */
  protected String readStatusFile  = "readstatus" + PHP_SUFFIX;
  /** php file to execute */
  protected String assignmentsFile = "assignments" + PHP_SUFFIX;
  /** php file to execute */
  protected String postCancelFile  = "postcancel" + PHP_SUFFIX;
  /** message from web server when problem is done */
  protected String done            = "percent_complete=100";

  /** max times to wait between polls in waitTillFinished */
  protected int maxWaitCycles = 10;

  /** wait between polls in waitTillFinished */
  protected long waitTime      = 1000;

  /** problem name */
  protected String myProblem  = "testProblem";
  /** not used... */
  protected String myInstance = "testInstance";

  /** parameter -- dump timing results to stdout */
  protected boolean showTiming;

  /** parameter -- write complete URL to stdout -- little used */
  protected boolean testing;
  /** parameter -- write encoded xml to a file */
  protected boolean writeEncodedXMLToFile;
  /** parameter -- write xml to a file */
  protected boolean writeXMLToFile = false;
  /** name of the cluster+plugin */
  protected String name;
  /** name of the cluster */
  protected String clusterName;
  /** dom helper */
  protected VishnuDomUtil domUtil;

  /** how many files have been written out via the writeEncodedXMLToFile or writeXMLToFile flag */
  protected int numFilesWritten = 0; 

  /** param table from plugin */
  protected ParamMap myParamTable;
  /** parameter -- run internally (when true) or externally */
  protected boolean runInternal;
  private static final int INITIAL_INTERNAL_BUFFER_SIZE = 16384; //2097152; // 2 M

  /** holds data posted to URLs when running internally */
  protected StringBuffer internalBuffer = new StringBuffer ();
  protected Logger logger;
}
