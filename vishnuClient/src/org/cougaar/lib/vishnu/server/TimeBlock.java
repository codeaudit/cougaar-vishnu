// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/TimeBlock.java,v 1.3 2001-04-12 17:50:31 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.text.SimpleDateFormat;

/**
 * An interval of time with color and text for display
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class TimeBlock {

  private int startTime;
  private int endTime;
  private String color = "";
  private String text = "";
  protected TimeOps timeOps;

  public TimeBlock (int startTime, int endTime, TimeOps timeOps) {
    this.startTime = startTime;
    this.endTime = endTime;
    this.timeOps = timeOps;
    if (startTime > endTime)
      System.out.println ("TimeBlock.ctor - Error : start " +
                          timeOps.timeToString(startTime) +
			  " after end " + timeOps.timeToString(endTime));
  }

  public TimeBlock (int startTime, int endTime, TimeOps timeOps,
                    String color, String text) {
    this (startTime, endTime, timeOps);
    this.color = color;
    this.text = text;
  }

  public int getStartTime() { return startTime; }
  public int getEndTime() { return endTime; }
  public String getColor() { return color; }
  public String getText() { return text; }

  public void setStartTime (int startTime) { this.startTime = startTime; }
  public void setEndTime (int endTime) { this.endTime = endTime; }
  public void setColor (String color)  { this.color = color; }
  public void setText (String text)  { this.text = text; }

  public String activityString (Resource resource) {
    return ("<ACTIVITY resource=\"" + resource.getKey() + "\" " +
            attributesString() + " />");
  }

  public String attributesString() {
    return ("start=\"" + timeOps.timeToString (getStartTime())
            + "\" end=\"" + timeOps.timeToString (getEndTime())
            + "\" color=\"" + getColor()
            + "\" text=\"" + getText() + "\"");
  }

}
