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
import org.xml.sax.InputSource;
import org.apache.xerces.parsers.SAXParser;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
import org.cougaar.lib.vishnu.server.Scheduler;
import java.util.HashMap;

public class JobshopInternal {

  private static class AssignmentHandler extends DefaultHandler {
    public void startElement (String uri, String local,
                              String name, Attributes atts) {
      if (name.equals ("ASSIGNMENT"))
        System.out.println ("Assignment: task = " + atts.getValue ("task") +
                            " resource = " + atts.getValue ("resource") +
                            " setup = " + atts.getValue ("setup") +
                            " wrapup = " + atts.getValue ("wrapup") +
                            " start = " + atts.getValue ("start") +
                            " end = " + atts.getValue ("end"));
    }
  }

  public static void main (String[] args2) {
    try {
      // initial data
      RandomAccessFile f = new RandomAccessFile ("testjs.vsh", "r");
      byte[] b = new byte [(int) f.length()];
      f.read (b, 0, b.length);
      Scheduler sched = new Scheduler();
      String str = sched.runInternalToProcess (new String (b), true, true);
      SAXParser parser = new SAXParser();
      parser.setContentHandler (new AssignmentHandler());
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished initial\n");

      // freeze all
      str = sched.runInternalToProcess ("<DATA><FREEZEALL/></DATA>", false, true);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished freezeall\n");

      // unfreeze all
      str = sched.runInternalToProcess ("<DATA><UNFREEZEALL/></DATA>", false, true);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished unfreezeall\n");

      // freeze inidividually
      str = sched.runInternalToProcess ("<DATA><FREEZE task=\"welding 2\"/><FREEZE task=\"cutting 1\"/></DATA>", false, true);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished freeze some\n");

      // unfreeze inidividually
      str = sched.runInternalToProcess ("<DATA><UNFREEZE task=\"welding 2\"/><UNFREEZE task=\"cutting 1\"/></DATA>", false, true);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished unfreeze some\n");

      // updated data
      f = new RandomAccessFile ("testjs.update.vsh", "r");
      b = new byte [(int) f.length()];
      f.read (b, 0, b.length);
      str = sched.runInternalToProcess (new String (b), false, true);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished updated\n");

      // clear database
      str = sched.runInternalToProcess ("<DATA><CLEARDATABASE/></DATA>", false, true);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished clearing database\n");
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
  }

}
