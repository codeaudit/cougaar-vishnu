
import java.io.*;
import org.xml.sax.InputSource;
import org.apache.xerces.parsers.SAXParser;
import org.xml.sax.Attributes;
import org.xml.sax.helpers.DefaultHandler;
import org.cougaar.lib.vishnu.server.Scheduler;
import java.util.HashMap;

public class FreezeInternal {

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
      RandomAccessFile f = new RandomAccessFile ("frozen.vsh", "r");
      byte[] b = new byte [(int) f.length()];
      f.read (b, 0, b.length);
      Scheduler sched = new Scheduler();
      String str = sched.runInternalToProcess (new String (b), true, true);
      SAXParser parser = new SAXParser();
      parser.setContentHandler (new AssignmentHandler());
      parser.parse (new InputSource (new StringReader (str)));
      System.out.println ("finished initial\n");
    }
    catch(Exception e) {
      System.err.println (e.getMessage());
      e.printStackTrace();
    }
  }

}
