// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/TimeOps.java,v 1.1 2001-01-10 19:29:55 rwu Exp $

package org.cougaar.lib.vishnu.server;

import java.text.SimpleDateFormat;

/**
 * Translates between string values of times and an internal representation
 * of time.  The internal representation stores a base time, which is
 * the first time encountered for a problem, and all times are the
 * number of seconds before or after this base time
 *
 * Copyright (C) 2000 BBN Technologies
 */

public class TimeOps {

  private static final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

  private long baseTime = Long.MIN_VALUE;
  private long minTime = Long.MIN_VALUE;
  private long maxTime = Long.MAX_VALUE;
  public static boolean debug = 
    ("true".equals (System.getProperty ("org.cougaar.lib.vishnu.server.TimeBlock.debug")));

  public String timeToString (int time) {
    long ltime = 1000l * (long) time;
    return format.format (new java.util.Date (baseTime + ltime));
  }

  public int stringToTime (String str) {
    try {
      long t = format.parse (str).getTime();
      if (t <= minTime)
        return Integer.MIN_VALUE;
      if (t >= maxTime)
        return Integer.MAX_VALUE;
      if (baseTime == Long.MIN_VALUE) {
        baseTime = t;
        minTime = t + 1000l * (long) Integer.MIN_VALUE;
        maxTime = t + 1000l * (long) Integer.MAX_VALUE;
	if (debug)
	  System.out.println ("Base time set to " + new java.util.Date (baseTime));
      }
      return (int) ((t - baseTime) / 1000);
    } catch (java.text.ParseException e) {
      if (debug) {
	System.out.println ("TimeBlock.stringToTime - Bad date string");
	e.printStackTrace();
      }
      return 0;
    } catch (NullPointerException npe) {
      System.out.println ("TimeBlock.stringToTime - Bad date string=" + 
			  str);

      return 0;
    }
  }

}
