/*
 * <copyright>
 *  Copyright 2003 BBNT Solutions, LLC
 *  under sponsorship of the Defense Advanced Research Projects Agency (DARPA).
 * 
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the Cougaar Open Source License as published by
 *  DARPA on the Cougaar Open Source Website (www.cougaar.org).
 * 
 *  THE COUGAAR SOFTWARE AND ANY DERIVATIVE SUPPLIED BY LICENSOR IS
 *  PROVIDED 'AS IS' WITHOUT WARRANTIES OF ANY KIND, WHETHER EXPRESS OR
 *  IMPLIED, INCLUDING (BUT NOT LIMITED TO) ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND WITHOUT
 *  ANY WARRANTIES AS TO NON-INFRINGEMENT.  IN NO EVENT SHALL COPYRIGHT
 *  HOLDER BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT OR CONSEQUENTIAL
 *  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE OF DATA OR PROFITS,
 *  TORTIOUS CONDUCT, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *  PERFORMANCE OF THE COUGAAR SOFTWARE.
 * </copyright>
 */
package org.cougaar.lib.vishnu.client;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.cougaar.lib.param.ParamMap;
import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.util.log.Logger;
import org.w3c.dom.Document;

/** 
 * Base class for Modes and ResultHandlers that help the VishnuPlugin to do its work.
 * <p>
 * Holds references to the ModeListener(VishnuPlugin) and utility objects like the 
 * xmlProcessor, VishnuComm, DomUtil, Config, and the parameter map.
 */
public class PluginHelper {
  public PluginHelper (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
		       VishnuDomUtil domUtil, VishnuConfig config,
		       ParamMap myParamTable,
		       Logger logger) {
    this.parent = parent;
    this.comm = comm;
    this.xmlProcessor = xmlProcessor;
    this.domUtil = domUtil;
    this.config = config;
	
    this.myParamTable = myParamTable;
    this.logger = logger;

    localSetup ();
  }
  
  protected ParamMap   getMyParams    () { 
    return myParamTable; 
  }

  protected void localSetup () {
    try {showTiming = 
	   getMyParams().getBooleanParam("showTiming");}    
    catch(Exception e) {  showTiming = true; }
  }
  
  protected ParamMap myParamTable;
  protected VishnuComm comm;
  protected ModeListener parent;
  protected boolean showTiming;
  protected XMLProcessor xmlProcessor;
  protected VishnuDomUtil domUtil;
  protected VishnuConfig config;
  protected Logger logger;
}
