package org.cougaar.lib.vishnu.client;

import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;

import java.util.Date;
import java.lang.NumberFormatException;

public class xslhelper {
  public static int FIELD_LENGTH_MULTIPLIER = 4;
  public static String getType (String tagValue) {
    boolean isInt = false, isDouble = false;

    if (tagValue == null)
      return "valueWasNull";

    if (tagValue.equals ("true") || tagValue.equals ("false"))
      return "boolean";

    try {
      Integer.parseInt (tagValue);
      isInt = true;
    } catch (NumberFormatException nfe) {}

    try {
      Double.parseDouble (tagValue);
      isDouble = true;
    } catch (NumberFormatException nfe) {}

    if (isDouble || isInt)
      return "number";

    int len = FIELD_LENGTH_MULTIPLIER*tagValue.length ();
    if (len == 0)
	return "string(" + "why tag value zero?" + ")";
    if (len > 255)
      len = 255;
    return "string(" + len + ")";
  }

  public static String getDate (String dateMillis) {
    try {
      long millis = Long.parseLong (dateMillis);
      Date date = new Date (millis);
      return format.format (date);
    } catch (NumberFormatException nfe) {
      try {
	double millis = Double.parseDouble (dateMillis);
	Date date = new Date ((long) millis);
	return format.format (date);
      } catch (NumberFormatException nfe2) {
	try {
	  ParsePosition pp = new ParsePosition (0);
	  Date time = javaFormat.parse (dateMillis, pp);
	  return format.format (time);
	} catch (NumberFormatException nfe3) {
	  return "unparsable:" + dateMillis;
	} catch (NullPointerException npe) {
	  return "not-java-date-unparsable:" + dateMillis;
	}
      }
    } catch (Exception e) {
      return "excep:" + e;
    }
  }

  public static String getEitherDate (String first, String second) {
    if (first.length () == 0)
      return getDate (second);
    return getDate (first);
  }

  public static String getClassName (String fullName) {
    if (fullName == null)
      return "nullname";
    return fullName.substring (fullName.lastIndexOf ('.')+1);
  }

  private static final SimpleDateFormat format =
    new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

  private static final SimpleDateFormat javaFormat =
    new SimpleDateFormat ("EEE MMM dd HH:mm:ss z yyyy");

  public static void main (String []arg) {
    Date d = new Date ();
    String millis = "" + d.getTime ();
    System.out.println ("Date " + d + " = " + getDate (millis));
    String other = "" + d;
    System.out.println ("Date " + d + " = " + getDate (other));
    
    System.out.println ("full " + d.getClass () + " last " + getClassName("" + d.getClass ()));
    
  }

}
