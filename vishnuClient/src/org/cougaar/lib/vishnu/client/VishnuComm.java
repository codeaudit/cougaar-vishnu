/* $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/client/VishnuComm.java,v 1.1 2001-02-15 22:27:33 gvidaver Exp $ */

package org.cougaar.lib.vishnu.client;

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

import java.util.Date;

import org.apache.xerces.dom.DocumentImpl;
import org.apache.xerces.parsers.SAXParser;
import org.apache.xml.serialize.OutputFormat;
import org.apache.xml.serialize.XMLSerializer;

import org.xml.sax.HandlerBase;
import org.xml.sax.Parser;

import org.w3c.dom.Document;

public class VishnuComm {
  
  boolean showTiming;
  boolean testing;
  boolean myExtraOutput;
  boolean writeEncodedXMLToFile;
  String phpPath;
  String name;
  String clusterName;
  VishnuDomUtil domUtil;
  
  public VishnuComm (boolean showTiming, boolean testing, boolean myExtraOutput,
						  boolean writeEncodedXMLToFile,
						  String phpPath,
						  String name, String clusterName,
						  VishnuDomUtil domUtil) {
	this.showTiming = showTiming;
	this.testing = testing;
	this.myExtraOutput = myExtraOutput;
	this.writeEncodedXMLToFile = writeEncodedXMLToFile;
	this.phpPath = phpPath;
	this.name = name;
	this.clusterName = clusterName;
	this.domUtil = domUtil;
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
		System.out.println (name + ".getResponse - IO Exception on reading from URL, trying again.");
		numTries--;
		try { Thread.sleep (500l); } catch (Exception e) {}
	  }
	}
	if (!madeInputStream)
		System.out.println (name + ".getResponse - ERROR : could not read from URL " + connection);

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

  protected int numFilesWritten = 0; // how many files have been written out via the writeXMLToFile flag
}
