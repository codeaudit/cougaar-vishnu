// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/TimeBlock.java,v 1.2 2001-04-06 18:50:32 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.text.SimpleDateFormat;

/**
 * An interval of time with color and text for display
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
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
