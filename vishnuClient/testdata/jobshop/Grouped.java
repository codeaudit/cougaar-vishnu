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

import java.io.*;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
import org.cougaar.lib.vishnu.server.ClientComms;
import java.util.Map;

public class Grouped {

  private static class AssignmentHandler extends DefaultHandler {
    public void startElement (String uri, String local,
                              String name, Attributes atts) {
      if (name.equals ("MULTITASK"))
        System.out.println ("Assignment:" +
                            " resource = " + atts.getValue ("resource") +
                            " start = " + atts.getValue ("start") +
                            " end = " + atts.getValue ("end"));
      if (name.equals ("TASK"))
        System.out.println ("    Task = " + atts.getValue ("task"));
    }
  }

  public static void main (String[] args2) {
    ClientComms.initialize();
    try {
      ClientComms.initialize();
      Map args = ClientComms.defaultArgs();
      RandomAccessFile f = new RandomAccessFile ("testgrouped.vsh", "r");
      byte[] b = new byte [(int) f.length()];
      f.read (b, 0, b.length);
      args.put ("data", new String(b));
      System.out.println (ClientComms.postToURL (args, "postproblem.php"));
      args.remove ("data");
      args.put ("problem", "jobshop_grouped");
      System.out.println (ClientComms.postToURL (args, "postkickoff.php"));
      while (true) {
        String res = ClientComms.postToURL (args, "readstatus.php");
        if (res.indexOf ("percent_complete=100") != -1)
          break;
        try { Thread.sleep (2000); } catch (Exception e) {}
      }
      ClientComms.readXML (args, "assignments.php", new AssignmentHandler());
//      System.out.println (ClientComms.postToURL (args, "assignments.php"));
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
  }

}
