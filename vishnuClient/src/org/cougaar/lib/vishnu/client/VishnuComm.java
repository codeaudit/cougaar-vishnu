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

import org.w3c.dom.Document;

import org.xml.sax.helpers.DefaultHandler;

public class VishnuComm {
  private static Map clusterToInstance = new HashMap ();

  public VishnuComm (ParamMap myParamTable,
					 String name, 
					 String clusterName,
					 VishnuDomUtil domUtil,
					 boolean runInternal) {
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
  
  protected void localSetup () 
  {
    try {myExtraOutput = getMyParams().getBooleanParam("ExtraOutput");}    
    catch(Exception e) {myExtraOutput = false;}

    try {myExtraExtraOutput = getMyParams().getBooleanParam("ExtraExtraOutput");}    
    catch(Exception e) {myExtraExtraOutput = false;}

    try {hostName = getMyParams().getStringParam("hostName");}    
    catch(Exception e) {hostName = "dante.bbn.com";}

    try {phpPath = getMyParams().getStringParam("phpPath");}    
    catch(Exception e) {phpPath = "/~dmontana/vishnu/";}

    try {myUser = getMyParams().getStringParam("user");}    
    catch(Exception e) {myUser = "vishnu";}

    try { myPassword = getMyParams().getStringParam("password");} 
	catch(Exception e) {myPassword = "vishnu";}

    try { myLegalHosts = getMyParams().getStringParam("legalHosts").trim();} 
	catch(Exception e) {myLegalHosts = "";} // empty = all schedulers are OK

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

    try {showTiming = 
		   getMyParams().getBooleanParam("showTiming");}    
    catch(Exception e) {showTiming = true;}

    try {testing = getMyParams().getBooleanParam("testing");}    
    catch(Exception e) {testing = false;}

	// writes the XML sent to Vishnu web server to a file (human readable)
    try {writeXMLToFile = 
		   getMyParams().getBooleanParam("writeXMLToFile");}    
    catch(Exception e) {writeXMLToFile = false;}

	// writes the XML sent to Vishnu web server to a file (machine readable)
    try {writeEncodedXMLToFile = 
		   getMyParams().getBooleanParam("writeEncodedXMLToFile");}    
    catch(Exception e) {writeEncodedXMLToFile = false;}

    // seconds - total wait time is maxWaitCycles * waitTime
    try {waitTime = getMyParams().getLongParam("waitTime")*1000L;}    
    catch(Exception e) {waitTime = 5000L;}

    // how many times to poll Vishnu before giving up 
	// total wait time is maxWaitCycles * waitTime
    try {maxWaitCycles = getMyParams().getIntParam("maxWaitCycles");}    
    catch(Exception e) {maxWaitCycles = 10;}
  }

  public void serializeAndPostData (Document doc) {
      serializeAndPost (doc, true, runInternal, internalBuffer);
  }

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
   * @param doc - DOM doc to send to URL
   * @param postData - true if posting data 
   */
  protected void serializeAndPost (Document doc, boolean postData, 
								   boolean runInternal, StringBuffer internalBuffer) {
	serializeAndPost (domUtil.getDocAsArray (doc).toString(), postData, runInternal, internalBuffer);

	if (writeXMLToFile) {
	  String suffix = (postData) ? "data" : "problem";
	  String fileName = getClusterName () + "_" + suffix + "_" + numFilesWritten++ + ".xml";
	  System.out.println (getName () + ".serializeAndPost - Writing XML to file " + fileName);
	  try {
		FileOutputStream temp = new FileOutputStream (fileName);
		domUtil.writeDocToStream (doc, temp);
	  } 
	  catch (FileNotFoundException fnfe) { /* never happen */ }
	  catch (IOException ioe) { /* never happen */ }
	}
  }

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

  public void appendToBuffer (String data) {
	appendToInternalBuffer (data, internalBuffer);
  }

  protected void appendToInternalBuffer (String data, StringBuffer internalBuffer) {
	int index;
	if ((index = data.indexOf ("?>")) != -1) {
	  String stuff = data.substring (index+2);
	  internalBuffer.append (stuff);
	}
  }

  public void clearBuffer () {
	internalBuffer = new StringBuffer (INITIAL_INTERNAL_BUFFER_SIZE);
  }

  public String getBuffer () {
	return new String (internalBuffer);
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
	  System.err.println (getName () + ".localSetup - Huh? Could not find localhost? " +
						  uhe.getMessage ());
	}
  }

  public boolean postData (String data) {
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
	  domUtil.reportTime (" - did post of data string to URL in ", start);

	if (!reply.startsWith ("SUCCESS")) {
      System.out.println (getName () + ".postData - ERROR : Reply to post data was <" + reply + ">");
	  return false;
	}
	else if (myExtraOutput)
      System.out.println (getName () + ".postData - Reply to post data was <" + reply.trim() + ">");
	
	return true;
  }

  public boolean postData (Document dataDoc) {
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
	  domUtil.reportTime (" - did post of data Doc to URL in ", start);
	
	if (!reply.startsWith ("SUCCESS")) {
      System.out.println (getName () + ".postData - ERROR : Reply to post data was <" + reply + ">");
	  return false;
	}
	else if (myExtraOutput)
      System.out.println (getName () + ".postData - Reply to post data was <" + reply.trim() + ">");

	return true;
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

    String reply = postToURL (hostName, postProblemFile, sb.toString (), null, true);

    if (myExtraOutput)
      System.out.println (getName() + ".postProblem - reply was <" + reply.trim() + ">");
  }

  /**
   * <pre>
   * Cancels any pending jobs.
   * 
   * Should only be done once, when the plugin loads.
   *
   * This is an insurance policy against the case where someone
   * starts a society and runs it, but never starts a scheduler, or otherwise
   * gets a problem into the state of "processing" but not "complete."  
   * Once in the "processing" state, the scheduler will not accept new 
   * jobs for this problem, effectively blocking it for all time.
   *
   * </pre>
   * bogus is sent first because <code>user</code> would not arrive 
   * at php with value if it was sent first.  No idea why.
   *
   */
  public void postCancel () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&"); 
    sb.append (getProblemPostVar  () + "&");
    sb.append ("username=" + myUser + "&");
    sb.append ("password=" + myPassword);

    if (myExtraOutput)
	  System.out.println (getName () + ".postCancel - canceling any pending scheduling requests for " + 
						  myProblem);

	String reply = postToURL (hostName, postCancelFile, sb.toString (), null, true);
    if (myExtraOutput)
	  System.out.println (getName () + ".postCancel - reply was " + reply);
  }

  public void postClear () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&"); 
    sb.append (getProblemPostVar  () + "&");
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword);

    if (myExtraOutput)
	  System.out.println (getName () + ".postClear - clearing data from previous runs " + 
						  myProblem);

	String clearDataMsg = sb + "&<PROBLEM NAME="+getProblem ()+"/><CLEARDATABASE" + '\\' + ">";

	String reply = postToURL (hostName, postDataFile, clearDataMsg, null, true);
    if (myExtraOutput)
	  System.out.println (getName () + ".postClear - reply was " + reply);
  }

  /** 
   * bogus is sent first because <code>user</code> would not arrive <br>
   * at php with it's value if it was sent first.  No idea why.  <p>
   *
   * BOZO - Still a problem???
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
    if (myExtraOutput)
	  System.out.println (getName () + ".startScheduling - reply to kickoff was " + reply.trim());
  }

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
      else if (myExtraOutput) {
		System.out.println (getName() + ".waitTillFinished - Scheduler not done. Reply was <" + response.trim() + ">");
	  }

      try { Thread.sleep (waitTime); } catch (Exception e) {}
    }
	
    return gotAnswer;
  }

  protected String getWaitPostVars () {
    StringBuffer sb = new StringBuffer ();
    sb.append ("?" + "bogus=ferris&" + getProblemPostVar ());
    sb.append (getInstancePostVar () + "&");
    sb.append ("user=" + myUser + "&");
    sb.append ("password=" + myPassword + "&");
    sb.append ("ferris=bueller");
	return sb.toString ();
  }
  
  public void getAnswer (DefaultHandler assignmentHandler) {
	try {
	  String url = "http://" + hostName + phpPath + assignmentsFile + getWaitPostVars();
	  URL aURL = new URL (url);

	  if (myExtraOutput)
		System.out.println (getName () + ".getAnswer - reading from " + url);

	  readXML (aURL, assignmentHandler);
	} catch (Exception e) {
	  System.out.println (getName () + ".getAnswer - BAD URL : " + e);
	  e.printStackTrace ();
	}
  }

  protected String getProblemPostVar () {
    return "problem=" + myProblem + "&";
  }

  protected String getInstancePostVar () {
    return "instance=" + myInstance;
  }

  protected String getUserPostVar () {
    return "user=" + myUser;
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
      System.err.println ("VishnuPlugIn.postToURL -- exception sending data to URL : " + aURL +
			  "\n" + e.getMessage());
      e.printStackTrace();
    }
    return "";
  }
  /**
    Sends data on the connection.
   */

  public void sendData(URLConnection connection, String data, Document doc) throws IOException {
    if (myExtraOutput) {
	  System.out.println (name + ".sendData - Sending " + data.length () + " characters.");
	  System.out.println ("\tData=" + data.substring (0,
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
		System.out.println ("Writing XML to file " + fileName);
		FileOutputStream temp = new FileOutputStream (fileName);
		writeDocToStream (doc, temp);
	  }
	  */
	} else if (writeEncodedXMLToFile) {
	  String fileName = clusterName + "_encoded_" + numFilesWritten++;
	  System.out.println (name + ".sendData : Writing XML to file " + fileName);
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
   * <pre>
   * Returns response as string.
   *
   * If there is an IOException on the input stream, will try two more times.
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
		System.out.println (name + ".getResponse - IO Exception on reading from URL, trying again.");
		numTries--;
		try { Thread.sleep (5000l); } catch (Exception e) {}
	  }
	}
	if (!madeInputStream) {
	  System.out.println (name + ".getResponse - ERROR : could not read from URL " + connection);
	  return null;
	}

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

  protected void readXML (URL aURL, DefaultHandler handler) {
    try {
      if (myExtraOutput) {
	  URLConnection connection = aURL.openConnection();
	  connection.setDoOutput (false);
	  connection.setDoInput  (true);

	  System.out.println (getResponse (connection));
      }

      SAXParser parser = new SAXParser();
	  parser.setContentHandler(handler);
      parser.parse (aURL.toString());
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
  }

  // necessary configuration parameters - info about the Vishnu web server and mysql user and password
  protected String myUser     = "vishnu";
  protected String myPassword = "vishnu";
  protected String hostName = "dante.bbn.com";
  protected String phpPath  = "/~dmontana/vishnu/";
  protected String URL      = "http://" + hostName + phpPath;
  protected String myLegalHosts = "";

  protected String PHP_SUFFIX = ".php";
  protected String postProblemFile = "postproblem" + PHP_SUFFIX;
  protected String postDataFile    = "postdata" + PHP_SUFFIX;
  protected String kickoffFile     = "postkickoff" + PHP_SUFFIX;
  protected String readStatusFile  = "readstatus" + PHP_SUFFIX;
  protected String assignmentsFile = "assignments" + PHP_SUFFIX;
  protected String postCancelFile  = "postcancel" + PHP_SUFFIX;
  protected String done            = "percent_complete=100";

  protected int maxWaitCycles = 10;
  protected long waitTime      = 1000;

  protected String myProblem  = "testProblem";
  protected String myInstance = "testInstance";

  protected boolean showTiming;
  protected boolean testing;
  protected boolean myExtraOutput;
  protected boolean myExtraExtraOutput;
  protected boolean writeEncodedXMLToFile;
  protected boolean writeXMLToFile = false;
  protected String name;
  protected String clusterName;
  protected VishnuDomUtil domUtil;
  protected int numFilesWritten = 0; // how many files have been written out via the writeEncodedXMLToFile flag

  protected ParamMap myParamTable;
  protected boolean runInternal;
  private static final int INITIAL_INTERNAL_BUFFER_SIZE = 16384; //2097152; // 2 M
  protected StringBuffer internalBuffer = new StringBuffer ();
}
