// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/TimeOps.java,v 1.8 2001-09-07 15:15:27 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Translates between string values of times and an internal representation
 * of time.  The internal representation stores a base time, which is
 * the first time encountered for a problem, and all times are the
 * number of seconds before or after this base time.
 * The purpose is to allow representation of times as ints rather
 * than longs.
 * This not only is more efficient computationally but also solved a
 * bug we were encountering with Java and longs.
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class TimeOps {

  // should not be static -- 
  // introduces intermittent problems when running multiple schedulers simulataneously
  private final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

  private long baseTime = Long.MIN_VALUE;
  private long minTime = Long.MIN_VALUE;
  private long maxTime = Long.MAX_VALUE;
  public static boolean debug = 
    ("true".equals (System.getProperty ("vishnu.TimeBlock.debug")));

  public String timeToString (int time) {
    long ltime = 1000l * (long) time;
    return format.format (new Date (baseTime + ltime));
  }
  
  public Date timeToDate (int time) {
    long ltime = 1000l * (long) time;
    return new Date (baseTime + ltime);
  }

  public int dateToTime (Date time) {
	return millisToTime (time.getTime());
  }

  public int stringToTime (String str) {
    try {
      long t = format.parse (str).getTime();
      return millisToTime (t);
    } catch (Exception e) {
      System.out.println ("TimeBlock.stringToTime - Bad date string=" + str);
      e.printStackTrace();
      return 0;
    }
  }

  /** t is in milliseconds */
  public int millisToTime (long t) {
	if (t <= minTime)
	  return Integer.MIN_VALUE;
	if (t >= maxTime)
	  return Integer.MAX_VALUE;
	if (baseTime == Long.MIN_VALUE) {
	  baseTime = t;
	  minTime = t + 1000l * (long) Integer.MIN_VALUE;
	  maxTime = t + 1000l * (long) Integer.MAX_VALUE;
	  if (debug)
		System.out.println ("Base time set to " +
							new java.util.Date (baseTime));
	}
	return (int) ((t - baseTime) / 1000);
  }
}
