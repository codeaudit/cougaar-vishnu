package org.cougaar.lib.vishnu.client;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import org.w3c.dom.Document;
import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.lib.param.ParamMap;

/** 
 * Base class for Modes and ResultHandlers that help the VishnuPlugIn to do its work.
 * <p>
 * Holds references to the ModeListener(VishnuPlugIn) and utility objects like the 
 * xmlProcessor, VishnuComm, DomUtil, Config, and the parameter map.
 */
public class PlugInHelper {
  public PlugInHelper (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
					   VishnuDomUtil domUtil, VishnuConfig config,
					   ParamMap myParamTable) {
	this.parent = parent;
	this.comm = comm;
	this.xmlProcessor = xmlProcessor;
	this.domUtil = domUtil;
	this.config = config;
	
	this.myParamTable = myParamTable;
	
	localSetup ();
  }
  
  protected ParamMap   getMyParams    () { 
	return myParamTable; 
  }

  protected void localSetup () {
    try {myExtraOutput = getMyParams().getBooleanParam("ExtraOutput");}    
    catch(Exception e) {myExtraOutput = false;}

    try {myExtraExtraOutput = getMyParams().getBooleanParam("ExtraExtraOutput");}    
    catch(Exception e) {myExtraExtraOutput = false;}

    try {showTiming = 
		   getMyParams().getBooleanParam("showTiming");}    
    catch(Exception e) {  showTiming = true; }
  }
  
  protected ParamMap myParamTable;
  VishnuComm comm;
  ModeListener parent;
  boolean showTiming, myExtraOutput, myExtraExtraOutput;
  XMLProcessor xmlProcessor;
  VishnuDomUtil domUtil;
  VishnuConfig config;
}
