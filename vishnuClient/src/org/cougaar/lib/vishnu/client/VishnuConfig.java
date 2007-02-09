/*
 * <copyright>
 *  
 *  Copyright 2001-2004 BBNT Solutions, LLC
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

import org.cougaar.lib.param.ParamMap;
import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.util.StringKey;
import org.cougaar.util.log.Logger;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;

/**
 * Keeps track of configuration files <p>
 * Also has methods for dealing with template tasks and prototypical resources for when in introspective mode. 
 */
public class VishnuConfig {
  private static String SPECS_SUFFIX = ".vsh.xml";
  private static String GA_SUFFIX = ".ga.xml";
  private static String OTHER_FORMAT_SUFFIX = ".odf.xml";
  private static String OTHER_DATA_SUFFIX = ".odd.xml";
  private static String DFF_SUFFIX = ".dff.xml";

  public VishnuConfig (ParamMap myParamTable, String pluginName, String clusterName, Logger logger) {
    this.myParamTable = myParamTable;
    this.clusterName = clusterName;
    this.name = pluginName;
    this.logger = logger;
  }

  protected String     getClusterName () { return clusterName;  }
  protected ParamMap   getMyParams    () { return myParamTable; }
  protected String     getName        () { return name;         }

  /**
   * <pre>
   * Sets the set of template tasks.  Template tasks are examined
   * to create the ObjectFormat for the tasks used in the problem.
   *
   * Say 2 tasks are sent to the vishnu bridge, but only one is 
   * used as the template task.  If the second task has an indirect
   * object with an object of a type that is not in the first task,
   * Vishnu will reject this object when the task is sent as data AND
   * the specs will not be able to reference the field.
   *
   * So it's imperative that the template tasks have all the fields
   * and all the types that should be used in the problem.
   *
   * This may not be that big of a deal in practice, but this function 
   * may have to be overridden.
   *
   * </pre>
   * By default looks at the parameter <code>firstTemplateTasks</code> 
   * to determine how many of the tasks should be sent as templates.
   */
  protected List getTemplateTasks (List tasks, int firstTemplateTasks) {
    List templateTasks = new ArrayList ();
    int size = (tasks.size () < firstTemplateTasks) ?
      tasks.size () : firstTemplateTasks;

    for (int i = 0; i < size; i++)
      templateTasks.add (tasks.get (i));
    return templateTasks;
  }

  /**
   * <pre>
   * Using the task list, figure out which assets are relevant to 
   * the problem and return them.  For example, if there is a 
   * prep "WITH CargoShip#5" on a task, and you only want decks for that ship,
   * you could subclass this function and select those decks here.
   *
   * NOTE that this could also be achieved by the Vishnu CAPABILITY CRITERION.
   * In general, that will be a more flexible way to go, if less efficient.
   *
   * If you want to do :
   *  getAssetCallback().getSubscription ().getCollection();
   * instead do :
   *  new HashSet( getAssetCallback().getSubscription ().getCollection());
   *
   * </pre>
   * @param tasks of tasks to use to filter out relevant assets
   * @return Collection of assets to send to Vishnu
   */
  protected Collection getAssetTemplatesForTasks (List tasks, List assetClassName, Collection assetCollection) {
    return getDistinctAssetTypes (assetClassName, assetCollection);
  }

  /**
   * <pre>
   * Looks through all assets and finds prototypical instances
   * of distinct classes.
   *
   * Conceptually, if the cluster has 10 trucks and 10 railcars
   * as assets, we want to return a list of one truck and 
   * one railcar to be used as templates.
   *
   * Uses type identification PG to find distinct types.
   *
   * </pre>
   * @return Collection of the asset instances
   */
  protected Collection getDistinctAssetTypes (List assetClassName, Collection assetCollection) {
    Map typeIDToAsset = new HashMap ();

    for (Iterator iter = assetCollection.iterator (); iter.hasNext (); ) {
      Asset asset = (Asset) iter.next ();
      String typeID =
        asset.getTypeIdentificationPG().getTypeIdentification();
      StringKey typeKey = new StringKey (typeID);

      if (!typeIDToAsset.containsKey (typeKey))
        typeIDToAsset.put (typeKey, asset);
    }

    Set distinctAssets = new HashSet (typeIDToAsset.values ());

    // find most-derived common descendant of all assets

    Object first = distinctAssets.iterator().next();
    Class firstClass = first.getClass();
    Class currentClass = firstClass;
    Stack currentClasses = new Stack ();
    currentClasses.push (currentClass);

    while ((currentClass = currentClass.getSuperclass()) != java.lang.Object.class) {
      if (logger.isDebugEnabled())
        logger.debug (getName() + ".getDistinctAssetTypes : super " + currentClass);
      currentClasses.push (currentClass);
    }

    for (Iterator iter = distinctAssets.iterator(); iter.hasNext();) {
      Class assetClass = iter.next().getClass();

      if (assetClass != firstClass){
        currentClass = assetClass;
        Stack otherClasses  = new Stack ();

        otherClasses.push (currentClass);

        while ((currentClass = currentClass.getSuperclass()) != java.lang.Object.class) {
          if (logger.isDebugEnabled())
            logger.debug (getName() + ".getDistinctAssetTypes : super " + currentClass);
          otherClasses.push (currentClass);
        }

        currentClasses.retainAll (otherClasses);

        if (logger.isInfoEnabled()) {
          for (int i = 0; i < currentClasses.size(); i++)
            logger.info (getName() + ".getDistinctAssetTypes : shared class " + currentClasses.get(i));
        }
      }

    }

    // return final name in complete class name, e.g. from org.cougaar.something.ldm.asset.Truck, Truck
    String classname = "" + currentClasses.get(0);
    int index = classname.lastIndexOf (".");
    classname = classname.substring (index+1, classname.length ());

    assetClassName.add (classname);

    if (logger.isInfoEnabled()) {
      for (int i = 0; i < currentClasses.size(); i++)
        logger.info (getName() + ".getDistinctAssetTypes : result class " + currentClasses.get(i));
    }

    if (distinctAssets.isEmpty())
      logger.error (getName () + ".getDistinctAssetTypes - ERROR? no templates assets?");

    return distinctAssets;
  }

  /**
   *<pre>
   * get the file containing the other data object format
   *
   * If the parameter "otherDataFormatFile" is set, it will look
   * for a file in the data directory with a name equal to the 
   * value of the parameter.  
   * Otherwise, looks for a file called <ClusterName>.odf.xml.
   *
   * </pre>
   * @see #getNeededFile
   * @return filename of other data object format file
   */
  protected String getOtherDataFormat () {
    return getNeededFile ("otherDataFormatFile", OTHER_FORMAT_SUFFIX);
  }

  /**
   *<pre>
   * get the file containing the other data
   *
   * If the parameter "otherDataFile" is set, it will look
   * for a file in the data directory with a name equal to the 
   * value of the parameter.
   * Otherwise, looks for a file called <ClusterName>.odd.xml.
   *
   * </pre>
   * @see #getNeededFile
   * @return filename of other data object(s)
   */
  protected String getOtherData () {
    return getNeededFile ("otherDataFile", OTHER_DATA_SUFFIX);
  }

  /**
   *<pre>
   * get the file containing the vishnu scheduling specs
   *
   * If the parameter "specsFile" is set, it will look
   * for a file in the data directory with a name equal to the 
   * value of the parameter.
   * Otherwise, looks for a file called <ClusterName>.vsh.xml.
   *
   * </pre>
   * @see #getNeededFile
   * @return filename of specs file
   */
  protected String getSpecsFile () {
    return getNeededFile ("specsFile", SPECS_SUFFIX);
  }

  /**
   * <pre>
   * get the file containing the ga parameters for VISHNU
   *
   * If the parameter "gaFile" is set, it will look
   * for a file in the data directory with a name equal to the 
   * value of the parameter.
   * Otherwise, looks for a file called <ClusterName>.ga.xml.
   *
   * return relative path of env file with which to start the
   * Vishnu Scheduler.
   * </pre>
   * @see #getNeededFile
   * @return relative path to specs parameters
   */
  protected String getGASpecsFile () {
    return getNeededFile ("gaFile", GA_SUFFIX);
  }

  protected String getFormatFile () {
    return getNeededFile ("defaultFormat", DFF_SUFFIX);
  }

  /**
   * <pre>
   * Get file name for input file.  If the parameter exists, use it,
   * otherwise append the defaultSuffix to the cluster name and use that.
   *
   * If there are more than one vishnu plugins in a cluster, one should
   * set the parameter to the name of the file.
   * </pre>
   */
  public String getNeededFile (String paramName, String defaultSuffix) {
    String envFile  = null;

    try {
      if (getMyParams().hasParam (paramName)) {
        envFile = getMyParams().getStringParam (paramName);
        if (logger.isInfoEnabled())
          logger.info ("VishnuConfig.getNeededFile - envFile = " + envFile +
            " - paramName - " + paramName);
      }
      else
        envFile = getClusterName () + defaultSuffix; // no parameter, try default
    } catch (Exception pe) {}

    return envFile;
  }

  protected ParamMap myParamTable;
  protected String clusterName;
  protected String name;
  protected Logger logger;
}
