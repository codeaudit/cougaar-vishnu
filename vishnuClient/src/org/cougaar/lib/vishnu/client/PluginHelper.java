/*
 * <copyright>
 *  
 *  Copyright 2003-2004 BBNT Solutions, LLC
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
