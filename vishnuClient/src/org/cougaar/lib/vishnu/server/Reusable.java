// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/Attic/Reusable.java,v 1.2 2001-04-06 18:50:32 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import java.util.ArrayList;

/**
 * Classes allowing objects to be recycled rather than garbage collected
 * after finishing with them.
 *
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public class Reusable {

  private ArrayList floatObjects = new ArrayList();
  private ArrayList intObjects = new ArrayList();
  private ArrayList listObjects = new ArrayList();
  private int floatObjsUsed = 0;
  private int intObjsUsed = 0;
  private int listObjsUsed = 0;

  public void resetObjects() {
    floatObjsUsed = 0;
    intObjsUsed = 0;
    listObjsUsed = 0;
  }

  public static class RFloat {
    private float val;
    public RFloat (float val)  { this.val = val; }
    private final void setValue (float val)  { this.val = val; }
    public final float floatValue ()  { return val; }
    public final int intValue ()  { return (int) val; }
    public String toString()  { return (new Float (val)).toString(); }
    public RFloat copy()  { return new RFloat (val); }
    public boolean equals (Object obj) {
      return ((obj instanceof RFloat) ?
              (val == ((RFloat) obj).floatValue()) : false);
    }
  }

  public static class RInteger {
    private int val;
    public RInteger (int val)  { this.val = val; }
    private final void setValue (int val)  { this.val = val; }
    public final int intValue ()  { return val; }
    public String toString()  { return (new Integer (val)).toString(); }
    public RInteger copy()  { return new RInteger (val); }
    public boolean equals (Object obj) {
      return ((obj instanceof RInteger) ?
              (val == ((RInteger) obj).intValue()) : false);
    }
  }

  public RFloat getFloat (float val) {
    if (floatObjsUsed < floatObjects.size()) {
      RFloat f = (RFloat) floatObjects.get (floatObjsUsed);
      f.setValue (val);
      floatObjsUsed++;
      return f;
    }
    RFloat f = new RFloat (val);
    floatObjects.add (f);
    floatObjsUsed++;
    return f;
  }

  public RInteger getInteger (int val) {
    if (intObjsUsed < intObjects.size()) {
      RInteger i = (RInteger) intObjects.get (intObjsUsed);
      i.setValue (val);
      intObjsUsed++;
      return i;
    }
    RInteger i = new RInteger (val);
    intObjects.add (i);
    intObjsUsed++;
    return i;
  }

  public ArrayList getList () {
    if (listObjsUsed < listObjects.size()) {
      ArrayList l = (ArrayList) listObjects.get (listObjsUsed);
      l.clear();
      listObjsUsed++;
      return l;
    }
    ArrayList l = new ArrayList ();
    listObjects.add (l);
    listObjsUsed++;
    return l;
  }

}
