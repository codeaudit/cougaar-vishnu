package org.cougaar.lib.vishnu.server;

import java.io.*;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;
import java.net.InetAddress;
import java.net.ConnectException;
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;
import org.apache.xerces.parsers.SAXParser;
import org.xml.sax.helpers.DefaultHandler;

/**
 * Contains a bunch of utility routines to allow clients (scheduler,
 * expression compiler, and external clients such as the COUGAAR bridge)
 * to communicate with the web server.
 *
 * Everything is static.  Call initialize() before anything else.
 * The three main methods are postToURL, readFromURL, and defaultArgs.
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class ClientComms {

  private static String user;
  private static String password;
  private static String host;
  private static String path;
  private static int port;
  private static String localHost = "";
  private static boolean debugXML =
    "true".equals (System.getProperty ("vishnu.debugXML"));

  public static String getHost () { return host; }
  
  public static void initialize() {
    try {
      localHost = InetAddress.getLocalHost().getHostName();
    } catch (Exception e) {
    }
    host = System.getProperty ("vishnu.host", localHost);
    path = System.getProperty ("vishnu.path", "/~vishnu/");
    user = System.getProperty("vishnu.user", "vishnu");
    password = System.getProperty("vishnu.password", "");
    port = Integer.parseInt (System.getProperty("vishnu.port", "80"));
  }

  public static Map defaultArgs() {
    Map args = new HashMap (7);
    args.put ("user", user);
    args.put ("username", user);
    args.put ("password", password);
    args.put ("localhost", localHost);
    return args;
  }

  /**
   *  General routine to write data to a URL and then read back
   *  the results.
   *  @param args name-value pairs that get attached to the URL
   *  @param pagename does not contain the full path
   *  @return the text string returned by the URL
   */
  public static String postToURL (Map args, String pagename) {
    try {
      Socket socket = new Socket (host, port);
      OutputStream os = socket.getOutputStream();
      String data = convertArgs (args, false);
      String request = "POST " + path + pagename + " HTTP/1.0\r\n" +
        "Host: " + host + "\r\n" +
        "Content-Type: application/x-www-form-urlencoded\r\n" +
        "Content-Length: " + data.length() + "\r\n\r\n" + data + "\r\n\r\n";
      os.write (request.getBytes());

      InputStream is = socket.getInputStream();

      StringBuffer sb = new StringBuffer ();
      byte b[] = new byte[1024];
      int len;
      while ((len = is.read(b)) > -1)
        sb.append (new String(b, 0, len));

	  os.close ();
	  is.close ();
	  
      return sb.toString();

    } catch (ConnectException ce) {
      printDiagnostic (ce, null);
    } catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
    return "";
  }

  private static Exception printDiagnostic (Exception e, String stringURL) {
    System.err.println ("ClientComms.printDiagnositic - exception : " + e.getMessage());
    if (stringURL != null)
      System.out.println
        ("ClientComms.readXML - could not connect to :\n" + stringURL);
    System.out.println
      ("The Java command-line variables you can set are:");
    System.out.println ("-Dvishnu.host (default = localhost)");
    System.out.println ("-Dvishnu.path (default = /~vishnu/)");
    System.out.println ("-Dvishnu.user (default = vishnu)");
    System.out.println ("-Dvishnu.password (default = \"\")");
    System.out.println ("-Dvishnu.port (default = 80)");
    return e;
  }

  /**
   *  Routine to read XML data from a URL and parse it.
   *  @param args name-value pairs that get attached to the URL
   *  @param pagename does not contain the full path
   *  @param handler the XML parsing routine
   */
  public static Exception readXML (Map args, String pagename,
                                   DefaultHandler handler) {
      String stringURL = "http://" + host + ":" + port + path + pagename +
	  convertArgs (args, true);
    try {
      if (debugXML) {
        URL url = new URL (stringURL);
        System.out.println ("ClientComms.readXML - Only testing URL. " +
                            "No scheduling will take place.");
        System.out.println ("ClientComms.readXML - url " + url);
        System.out.println ("ClientComms.readXML - " + testURL (url));
        return null;
      }
      SAXParser parser = new SAXParser();
      parser.setContentHandler (handler);
      parser.parse (stringURL);
    } catch (ConnectException ce) {
      return printDiagnostic (ce, stringURL);
    } catch (Exception e) {
      System.err.println ("ClientComms.readXML - Got exception : " +
                          e.getMessage());
//      e.printStackTrace();
      try {
	  System.out.println ("ClientComms.readXML - returned html was :\n" +
                              testURL (new URL (stringURL)));
      } catch (Exception ee) {}
      return e;
    }
    return null;
  }

  public static String testURL (URL aURL) {
    try {
      URLConnection connection = aURL.openConnection();
      connection.setDoInput  (true);

      return getResponse (connection);
    } catch (FileNotFoundException fnfe) {
      printDiagnostic (fnfe, aURL.toString());
    } catch(Exception e) {
      System.err.println ("ClientComms.testURL -- \n" + e.getMessage());
      e.printStackTrace();
    }
    return "";
  }

  /**
   * Returns response as string.
   *
   * @param  connection the url connection to get data from
   * @return String reponse from URL
   */
  public static String getResponse (URLConnection conn) throws IOException {
    InputStream is = conn.getInputStream();
    StringBuffer sb = new StringBuffer ();

    byte b[] = new byte[512];
    int len;
    while ((len = is.read(b)) > -1)
      sb.append (new String (b, 0, len));
    return sb.toString ();
  }


  private static String convertArgs (Map args, boolean needqm) {
    Iterator iter = args.keySet().iterator();
    String data = "";
    while (iter.hasNext()) {
      if (! data.equals (""))
        data = data + "&";
      else if (needqm)
        data = "?";
      Object key = iter.next();
      data = data + key + "=" +
        java.net.URLEncoder.encode (args.get(key).toString());
    }
    return data;
  }

}
