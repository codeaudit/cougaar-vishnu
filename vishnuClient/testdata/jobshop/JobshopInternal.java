
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
      String str = sched.runInternalToProcess (new String (b), true);
      SAXParser parser = new SAXParser();
      parser.setContentHandler (new AssignmentHandler());
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished initial\n");

      // freeze all
      str = sched.runInternalToProcess ("<DATA><FREEZEALL/></DATA>", false);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished freezeall\n");

      // unfreeze all
      str = sched.runInternalToProcess ("<DATA><UNFREEZEALL/></DATA>", false);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished unfreezeall\n");

      // freeze inidividually
      str = sched.runInternalToProcess ("<DATA><FREEZE task=\"welding 2\"/><FREEZE task=\"cutting 1\"/></DATA>", false);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished freeze some\n");

      // unfreeze inidividually
      str = sched.runInternalToProcess ("<DATA><UNFREEZE task=\"welding 2\"/><UNFREEZE task=\"cutting 1\"/></DATA>", false);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished unfreeze some\n");

      // updated data
      f = new RandomAccessFile ("testjs.update.vsh", "r");
      b = new byte [(int) f.length()];
      f.read (b, 0, b.length);
      str = sched.runInternalToProcess (new String (b), false);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished updated\n");

      // clear database
      str = sched.runInternalToProcess ("<DATA><CLEARDATABASE/></DATA>", false);
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished clearing database\n");
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
  }

}
