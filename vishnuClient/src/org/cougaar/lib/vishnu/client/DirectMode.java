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

import org.cougaar.lib.param.ParamMap;
import com.bbn.vishnu.objects.Assignment;
import com.bbn.vishnu.objects.MultitaskAssignment;
import com.bbn.vishnu.objects.Resource;
import com.bbn.vishnu.scheduling.Scheduler;
import com.bbn.vishnu.objects.SchedulingData;
import com.bbn.vishnu.objects.TimeOps;
import org.cougaar.util.StringKey;
import org.cougaar.util.log.Logger;

import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.asset.Asset;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import org.w3c.dom.Document;

/** 
 * Direct mode.  
 * <p>
 * Creates an internal instance of the scheduler and talks to it, instead
 * of to a web server.  Uses direct translation of Cougaar to Vishnu objects,
 * and reads the assignments directly.  <b>No XML involved.</b>
 *
 * Needs the plugin to be a DirectResultListener.  Mainly this means implementing
 * the prepareVishnuObjects method.
 * @see DirectResultListener
 */
public class DirectMode extends InternalMode {
  public DirectMode (ModeListener parent, VishnuComm comm, XMLProcessor xmlProcessor, 
		     VishnuDomUtil domUtil, VishnuConfig config, ResultHandler resultHandler,
		     ParamMap myParamTable, Logger logger) {
    super (parent, comm, xmlProcessor, domUtil, config, resultHandler,
	   myParamTable, logger);
    localSetup ();
  }
	
  protected void localSetup () {
    super.localSetup ();

    try {debugParseAnswer = 
	   getMyParams().getBooleanParam("debugParseAnswer");}    
    catch(Exception e) {debugParseAnswer = false;}
  }
  
  /**  
   * Handles direct mode differently from external/internal. 
   * <p> 
   * Calls prepareVishnuObjects on listener to populate <tt>vishnuTasks</tt> and 
   * <tt>vishnuResources</tt> lists with Vishnu objects.  
   * <p>
   * Also sends header with the time window information, and any other 
   * data to scheduler via the internal buffer (in VishnuComm). 
   * @param stuffToSend Cougaar tasks and assets
   * @param objectFormatDoc used to figure out info about fields
   */
  public void prepareData (List stuffToSend, Document objectFormatDoc) {
    vishnuTasks     = new ArrayList ();
    vishnuResources = new ArrayList ();
    changedVishnuResources = new ArrayList ();

    Date start = new Date ();
	   
    ((DirectModeListener)parent).prepareVishnuObjects (stuffToSend, parent.getChangedAssets(), 
						       vishnuTasks, vishnuResources, changedVishnuResources,
						       objectFormatDoc, sched.getSchedulingData());
    parent.clearChangedAssets ();

    if (logger.isDebugEnabled())
      logger.debug (getName () + ".prepareData - clearing changed assets!");
	   
    if (showTiming)
      domUtil.reportTime (".prepareData - prepared vishnu objects in ", start);
	   
    // think it's OK to send this more than once
    serializeAndPostDoc (xmlProcessor.getVanillaHeader ());

    sendOtherData ();
  }

  /**
   * Run directly.  Give Vishnu tasks and resources to scheduler and get assignments
   * back, <i>without</i> using XML. <p>
   *
   * Uses <tt>internalBuffer</tt> to send the specs, the object format and other data.<br>
   * Adds the task and resources (<tt>addTasksDirectly</tt>), and then runs the scheduler
   * (<tt>Scheduler.scheduleInternal</tt>).  Reads the assignments with 
   * <tt>directlyHandleAssignments</tt>. 
   * <p>
   * <tt>vishnuTasks</tt> and <tt>vishnuResources</tt> are created in prepareData and populated
   * in #prepareVishnuObjects. <p>
   *
   * @see #addTasksDirectly
   * @see #prepareData
   * @see org.cougaar.lib.vishnu.client.VishnuPlugin#prepareVishnuObjects
   * @see com.bbn.vishnu.scheduling.Scheduler#scheduleInternal
   */
  public void run () {
    Date start = new Date ();

    int unhandledTasks = prepareScheduler ();
	 
    // These are things created by the scheduler during setup that
    // are needed for direct object writing.
    TimeOps timeOps = sched.getTimeOps();
    SchedulingData data = sched.getSchedulingData();
    //    sched.clearCaches ();

    // add tasks and resources to data
    // vishnuTasks & Resources created in prepareData and set in prepareVishnuObjects
    addTasksDirectly (data, vishnuTasks, vishnuResources, changedVishnuResources);

    // Call scheduleInternal after adding all the data
    Date start2 = new Date ();

    try {
      sched.scheduleInternal();

      if (showTiming)
	domUtil.reportTime (".runDirectly - scheduler processed " +
			    parent.getNumTasks () + " tasks in ", start2);

      // get the assignments the scheduler made, make plan elements
      ((DirectResultHandler)resultHandler).directlyHandleAssignments (sched, data, timeOps);
    } catch (Exception e) {
      logger.error (getName () + ".runDirectly - Got error running scheduler : " + e.getMessage (), e);
    } finally {
      cleanUpAfterScheduling (unhandledTasks);
    }
  }

  /** calls methods on SchedulingData to add tasks, resources, and changed resources */
  protected void addTasksDirectly (SchedulingData data, List vishnuTasks, List vishnuResources,
				   List changedVishnuResources) {
    Date start = new Date ();

    if (logger.isInfoEnabled()) 
      logger.info(getName () + ".runDirectly - adding " + 
			 vishnuTasks.size() + " tasks, " +
			 vishnuResources.size () + " resources, " +
			 changedVishnuResources.size () + " changed resources to scheduler data.");

    for (int i = 0; i < vishnuTasks.size (); i++) {
      Object vishnuObject = vishnuTasks.get(i);
      data.addTask ((com.bbn.vishnu.objects.Task) vishnuObject);
    }
    for (int i = 0; i < vishnuResources.size (); i++) {
      Object vishnuObject = vishnuResources.get(i);
      data.addResource ((Resource) vishnuObject);
    }
    for (int i = 0; i < changedVishnuResources.size (); i++) {
      Object vishnuObject = changedVishnuResources.get(i);
      data.replaceResource ((Resource) vishnuObject);
    }
    if (logger.isDebugEnabled())
      for (int i = 0; i < data.getResources ().length; i++) {
	logger.debug (getName () + ".addTasksDirectly - Known Resource #" + i + 
		      " : \n" + data.getResources()[i]);
      }
  }

  protected String getName () { return parent.getName () + "-DirectMode"; }

  protected List vishnuTasks, vishnuResources, changedVishnuResources;
  protected boolean debugParseAnswer = false;
}
