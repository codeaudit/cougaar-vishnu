/*
 * <copyright>
 *  
 *  Copyright 2001-2004 BBNT Solutions, LLC
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

import java.io.*;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
import org.cougaar.lib.vishnu.server.ClientComms;
import java.util.Map;

public class Jobshop {

  private static class AssignmentHandler extends DefaultHandler {
    public void startElement (String uri, String local,
                              String name, Attributes atts) {
      if (name.equals ("ASSIGNMENT"))
        System.out.println ("Assignment: task = " + atts.getValue ("task") +
                            " resource = " + atts.getValue ("resource") +
                            " setup = " + atts.getValue ("setup") +
                            " start = " + atts.getValue ("start") +
                            " end = " + atts.getValue ("end") +
                            " wrapup = " + atts.getValue ("wrapup"));
    }
  }

  public static void main (String[] args2) {
    ClientComms.initialize();
    try {
      // initial data
      ClientComms.initialize();
      Map args = ClientComms.defaultArgs();
      RandomAccessFile f = new RandomAccessFile ("testjs.vsh", "r");
      byte[] b = new byte [(int) f.length()];
      f.read (b, 0, b.length);
      args.put ("data", new String(b));
      System.out.println (ClientComms.postToURL (args, "postproblem.php"));
      args.remove ("data");
      args.put ("problem", "jobshop_testjs");
      System.out.println (ClientComms.postToURL (args, "postkickoff.php"));
      while (true) {
        String res = ClientComms.postToURL (args, "readstatus.php");
        if (res.indexOf ("percent_complete=100") != -1)
          break;
        try { Thread.sleep (2000); } catch (Exception e) {}
      }
      ClientComms.readXML (args, "assignments.php", new AssignmentHandler());
//      System.out.println (ClientComms.postToURL (args, "assignments.php"));
      System.out.println ("finished initial");

      // updated data
/*      f = new RandomAccessFile ("testjs.update.vsh", "r");
      b = new byte [(int) f.length()];
      f.read (b, 0, b.length);
      args = ClientComms.defaultArgs();
      args.put ("problem", "jobshop_testjs");
      args.put ("data", new String(b));
      ClientComms.postToURL (args, "postdata.php");
      args.remove ("data");
      ClientComms.postToURL (args, "postkickoff.php");
      while (true) {
        String res = ClientComms.postToURL (args, "readstatus.php");
        if (res.indexOf ("percent_complete=100") != -1)
          break;
        try { Thread.sleep (2000); } catch (Exception e) {}
      }
      ClientComms.readXML (args, "assignments.php", new AssignmentHandler());
*/
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }

  }

}
