/*
 * <copyright>
 *  Copyright 1997-2001 BBNT Solutions, LLC
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

import org.cougaar.core.util.PropertyNameValue;
import org.cougaar.planning.ldm.asset.Asset;
import org.cougaar.planning.ldm.plan.Task;
import org.cougaar.planning.ldm.asset.LockedPG;

import org.cougaar.planning.ldm.measure.AbstractMeasure;

import org.cougaar.core.util.UID;
import org.cougaar.core.util.UniqueObject;

import java.beans.BeanInfo;
import java.beans.Beans;
import java.beans.IndexedPropertyDescriptor;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.*;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 * Create and return xml for first class log plan objects.
 * <p>
 * Element name is extracted from object class, by taking the
 * last field of the object class, and dropping a trailing "Impl",
 * if it exists.
 */

public abstract class BaseXMLize {
  /** Maximum search depth -- Integer.MAX_VALUE means unlimited. **/
  protected final int DEFAULT_UID_DEPTH = 6;
  protected static final String MAX_VALUE_STRING = Float.toString(Float.MAX_VALUE);
  protected static final String MIN_VALUE_STRING = Float.toString(Float.MIN_VALUE);
  protected Class numberClass;
  protected Class booleanClass;
  protected Class classClass;
  protected Class stringClass;
  protected Class abstractMeasureClass;
  protected Map classToBeanInfo;
  protected Map commonUnitToNoUnders;

  public BaseXMLize () {
	try {
	  numberClass  = Class.forName ("java.lang.Number");
	  booleanClass = Class.forName ("java.lang.Boolean");
	  stringClass  = Class.forName ("java.lang.String");
	  classClass   = Class.forName ("java.lang.Class");
	  abstractMeasureClass = Class.forName ("org.cougaar.planning.ldm.measure.AbstractMeasure");
	} catch (ClassNotFoundException cnfe) {}
	classToBeanInfo = new HashMap();
	commonUnitToNoUnders = new HashMap ();
  }

  public Element getPlanObjectXML(Object obj, Document doc, String resourceClassName) {
    return getPlanObjectXML (obj, doc, DEFAULT_UID_DEPTH, resourceClassName);
  }

  public Element getPlanObjectXML(Object obj, Document doc,
								  int searchDepth, String resourceClassName) {
    Collection nodes = getPlanObjectXMLNodes (obj, doc, DEFAULT_UID_DEPTH, resourceClassName);
	if (nodes.isEmpty ())
	  return null;
	return (Element) nodes.iterator().next ();
  }
  
  public Collection getPlanObjectXMLNodes (Object obj, Document doc, String resourceClassName) {
    return getPlanObjectXMLNodes (obj, doc, DEFAULT_UID_DEPTH, resourceClassName);
  }

  public Collection getPlanObjectXMLNodes(Object obj, Document doc, 
										  int searchDepth, String resourceClassName) {
    String tag;
	boolean isResource = false;
	boolean isTask  = false;
	
    if (Asset.class.isInstance(obj)) {
	  tag = "Asset";
	  isResource = true;
	  if (debug) System.out.println ("BaseXMLize - getPlanObjectXMLNodes thinks " + obj + " is a resource");
    } else if (Task.class.isInstance(obj)) {
      tag = ((Task) obj).getVerb ().toString();
	  isTask = true;
	  if (debug) System.out.println ("BaseXMLize - getPlanObjectXMLNodes thinks " + obj + " is a task");
    } else {
      tag = obj.getClass().getName();
      int i = tag.lastIndexOf(".");
      if (i >= 0) {
        tag = tag.substring(i+1);
      }
      i = tag.lastIndexOf("Impl");
      if (i >= 0) {
        tag = tag.substring(0, i);
      }
	  if (debug) System.out.println ("BaseXMLize - getPlanObjectXMLNodes thinks " + obj + 
									 " is neither a task nor a resource.");
    }
	Element root = createRootNode(doc, tag, isTask, isResource, obj, resourceClassName);
	Set createdNodes = new HashSet ();
	createdNodes.add (root);
    addNodes(doc, obj, root, searchDepth, createdNodes);
    return createdNodes;
  }

  /** subclass to generate different tag */
  protected abstract Element createRootNode (Document doc,
											 String tag,
											 boolean isTask,
											 boolean isResource,
											 Object obj,
											 String resourceClassName);
  
  /** 
   * <b>Recursively</b> introspect and add nodes to the XML document.
   * <p>
   * Keeps a Set of objects (as these can be circular) and stops 
   * when it tries to introspect over an object a second time.
   * <p>
   * Also keeps a depth counter, decrements for each call to addNodes, 
   * and stops when the counter is zero.  Use Integer.MAX_VALUE to 
   * indicate an unlimited search.
   */

  protected void addNodes(
      Document doc, Object obj, 
      Element parentElement, 
      int searchDepth, 
	  Collection createdNodes) {
    if (obj == null) {
      return;
    }

    if (searchDepth <= 0) {
	  generateElementReachedMaxDepth (doc, parentElement, obj);
      return;
    }

	Map listProps = new HashMap ();

    List propertyNameValues = getProperties (obj, listProps);

    // add the nodes for the properties and values
    for (int i = 0; i < propertyNameValues.size(); i++) {
      PropertyNameValue pnv = 
        (PropertyNameValue) propertyNameValues.get(i);
	  generateElem (doc, parentElement, pnv.name, pnv.value, 
					searchDepth, false, false, createdNodes);
    }
  }

  protected void generateElem (Document doc, Element parentElement, 
							   String propertyName, Object propertyValue,
							   int searchDepth,
							   boolean isList, boolean isFirst, 
							   Collection createdNodes) {
	// check if this should be a leaf
	boolean isLeaf = !isList &&
	  (stringClass.isInstance (propertyValue) ||
	   classClass.isInstance  (propertyValue));

	if (isLeaf) 
	  generateLeaf    (doc, parentElement, propertyName, propertyValue);
	else {
	  generateNonLeaf (doc, parentElement, propertyName, propertyValue, 
					   searchDepth, isList, isFirst, 
					   createdNodes);
	}
  }

  /**
   * Already seen this object or reached maximum depth. 
   * Write the UID if possible, otherwise write the "toString".
   */
  protected abstract void generateElementReachedMaxDepth (Document doc, Element parentElement, 
														  Object obj);

  protected abstract void generateLeaf (Document doc, Element parentElement, 
										String propertyName, Object propertyValue);
  
  protected abstract void generateNonLeaf (Document doc, Element parentElement, 
										   String propertyName, Object propertyValue,
										   int searchDepth,
										   boolean isList, boolean isFirst, 
										   Collection createdNodes);

  protected boolean isUniqueObject (Object obj) {
	return (obj instanceof UniqueObject) &&
	  (((UniqueObject)obj).getUID() != null);
  }
  
  protected List getProperties (Object obj, Map listProps) {
    BeanInfo info = null;
    List propertyNameValues;
	
	Class objectClass =
	  ((!(LockedPG.class.isInstance(obj))) ?
	   obj.getClass() :
	   ((LockedPG)obj).getIntrospectionClass());

	int mods = objectClass.getModifiers();
	if (debug)
	  System.out.println("BaseXMLize.getProperties - Introspecting on: " + objectClass + 
						 " modifiers: " + Modifier.toString(mods));
	if (!Modifier.isPublic(mods)) {
	  propertyNameValues = specialIntrospection(obj);
	} else {
	  try {
		info = (BeanInfo) classToBeanInfo.get (objectClass);
		if (info == null) {
		  info = Introspector.getBeanInfo(objectClass);
		  classToBeanInfo.put (objectClass, info);
		}
	  } catch (IntrospectionException e) {
		System.out.println("Exception in converting object to XML: " + 
						   e.getMessage());
	  }

	  propertyNameValues = 
		getPropertyNamesAndValues(info.getPropertyDescriptors(), obj, listProps);
	}

	return propertyNameValues;
  }
	  
  /*
    Handle the case in which an object's class is a private or protected
    implementation class which implements one or more public interfaces or
    abstract classes.
    First check for abstract classes extended by, or interfaces implemented by,
    the class or its superclasses.
    (Note that this stops when it finds the first abstract class or
    interfaces in the class chain.)
    Then, introspect on the abstract class or all the interfaces
    found (note that these are assumed to be public)
    and invoke read property methods
    on the object cast to that class or those interfaces.
  */

  private List specialIntrospection(Object obj) {
    if (debug) 
	  System.out.println("Performing special introspection for:" + obj);

    Class objClass = obj.getClass();
    Class[] interfaces;
    while (true) {
      if (objClass == null) {
        return null;
      }
      if (Modifier.isAbstract(objClass.getModifiers())) {
        interfaces = new Class[1];
        interfaces[0] = objClass;
        break;
      }
      interfaces = objClass.getInterfaces();
      if (interfaces.length != 0) {
        break;
      }
      objClass = objClass.getSuperclass();
    }
    List propertyNameValues = new ArrayList(10);
    for (int i = 0; i < interfaces.length; i++) {
      if (debug)
		System.out.println("Interface:" + interfaces[i].toString());
      try {
		BeanInfo info = (BeanInfo) classToBeanInfo.get (interfaces[i]);
		if (info == null) {
		  info = Introspector.getBeanInfo(interfaces[i]);
		  classToBeanInfo.put (interfaces[i], info);
		}

        PropertyDescriptor[] properties = info.getPropertyDescriptors();
		Map listProps = new HashMap ();
        List tmp = getPropertyNamesAndValues(properties, 
											 Beans.getInstanceOf(obj, interfaces[i]), 
											 listProps);
        if (tmp != null)
		  propertyNameValues.addAll (tmp);
      } catch (IntrospectionException e) {
        System.out.println(
          "Exception generating XML for plan object:" + e.getMessage());
      }
    }
    // for debugging
    //    for (int i = 0; i < propertyNameValues.size(); i++) {
    //      PropertyNameValue p = (PropertyNameValue)(propertyNameValues.elementAt(i));
    //      System.out.println("Property Name: " + p.name + " Property Value: " + p.value);
    //    }
    return propertyNameValues;
  }

    /**
     * Get the property names and values (returned in a vector)
     * from the given property descriptors and for the given object.
     *
     * Removes redundant properties from measure objects.
     */

  private List getPropertyNamesAndValues(PropertyDescriptor[] properties, 
										 Object obj, Map listProps) {
    List pv = new ArrayList();

    // IGNORE JAVA.SQL.DATE CLASS
    if (Date.class.isInstance  (obj) ||
		String.class.isInstance(obj)) {
      return pv;
    }

    if (abstractMeasureClass.isInstance(obj)) {
	  properties = 
	    prunePropertiesFromMeasure ((AbstractMeasure)obj, properties);
    }

    for (int i = 0; i < properties.length; i++) {
      PropertyDescriptor pd = properties[i];
	  if (debug)
		System.out.println ("getPropertyNamesAndValues - " + pd.getPropertyType () +  
							" : " + pd.getName ());
      Method rm = pd.getReadMethod();
      if (rm == null) {
		if (debug)
		  System.out.println ("\tread method was null.");
        continue;
      }

      // invoke the read method for each property
      Object childObject = getReadResult (obj, rm);
      if (childObject == null) {
		if (debug)
		  System.out.println ("\tread result of " + rm.getName () + " was null.");
        continue;
      }
      
      // add property name and value to vectorarray
      String name = pd.getName();
      if (pd.getPropertyType().isArray()) {
        int length = Array.getLength(childObject);
		listProps.put (name, new Integer(length));
		if (debug)
		  System.out.println ("getProp - " + pd.getPropertyType () + 
							  " : " + name + " - " + length + " now " + listProps.size() + " props");
		
        for (int j = 0; j < length; j++) {
          Object value = Array.get(childObject, j);
          if (value.getClass().isPrimitive()) {
			if (isPrimitiveFloat (value.getClass ()))
			  value = getValueOfPrimitiveFloat (value);
			else
			  value = String.valueOf(value);
          }
          pv.add(new PropertyNameValue(name, value));
        }
      } else {
		// need first class object, can't have a reference to a primitive
		if (isPrimitive(childObject.getClass())) {
	      childObject = String.valueOf(childObject);
		  if (debug)
			System.out.println ("getProp - " + pd.getName () + 
								" - childObject " + childObject + " is a primitive.");
		}
		if (!ignoreClass (childObject.getClass()))
		  pv.add(new PropertyNameValue(name, childObject));
      }
    }

	if (Asset.class.isInstance (obj))
	  pv.addAll (getDynamicAssetProperties ((Asset) obj));

    Collections.sort(pv, lessStringIgnoreCase);
    return pv;
  }

  protected boolean isPrimitiveFloat (Class theClass) {
	return (theClass == Float.TYPE) || (theClass == Double.TYPE);
  }

  protected String getValueOfPrimitiveFloat (Object value) {
	String stringValue = String.valueOf(value);
	char first = stringValue.charAt(0);
	
	if (first == 'I' || first == '-') {
	  if (stringValue.equals ("Infinity"))
		stringValue = MAX_VALUE_STRING;
	  else if (stringValue.equals ("-Infinity"))
		stringValue = MIN_VALUE_STRING;
	}
	return stringValue;
  }

  /**
   * ignore these classes when generating properties
   * Ignore : Class, AspectScoreRange, WorkflowImpl
   */
  protected boolean ignoreClass (Class aClass) {
	return (aClass == Class.class) ||
	  (aClass == org.cougaar.planning.ldm.plan.AspectScoreRange.class) ||
	  (aClass == org.cougaar.planning.ldm.plan.WorkflowImpl.class) ||
	  (aClass == org.cougaar.planning.ldm.plan.RelationshipScheduleImpl.class) || 
	  (aClass == org.cougaar.planning.ldm.plan.AspectValue.class) ||
	  (aClass == org.cougaar.planning.ldm.plan.AllocationImpl.class) ||
	  (org.cougaar.core.plugin.PlugInAdapter.class.isAssignableFrom (aClass)) ||
	  (org.cougaar.planning.ldm.asset.LockedPG.class.isAssignableFrom (aClass));
  }
  
  private final Comparator lessStringIgnoreCase = 
    new Comparator() {
        public int compare(Object first, Object second) {
          String firstName = ((PropertyNameValue)first).name;
          String secondName = ((PropertyNameValue)second).name;
          return firstName.compareToIgnoreCase(secondName);
        }
      };

    /** 
     * Invoke read method on object
     * 
     * @return Object that is the result of the read
     */
    protected Object getReadResult (Object obj, Method rm) {
	// invoke the read method for each property
	Object childObject = null;
	try {
	    childObject = rm.invoke(obj, null);
	} catch (InvocationTargetException ie) {
	  if (!(ie.getTargetException () instanceof IndexOutOfBoundsException)) {
	    System.out.println("Invocation target exception invoking: " + 
			       rm.getName() + 
			       " on object of class:" + 
			       obj.getClass().getName());
	    System.out.println(ie.getTargetException().getMessage());
	  }
	} catch (Exception e) {
	    System.out.println("Exception " + e.toString() + 
			       " invoking: " + rm.getName() + 
			       " on object of class:" + 
			       obj.getClass().getName());
	    System.out.println(e.getMessage());
	}
	return childObject;
    }

    /** 
     * Removes redundant measure properties.
     * Returns only the common unit measure.  
     * For example, for Distance, returns only the meters property and discards furlongs.
     *
     * (Converts underscores in common unit names.)
     * 
     * @param measure needed so can get common unit
     * @param properties initial complete set of measure properties
     * @return array containing the one property descriptor for the common unit property
     */
    protected PropertyDescriptor[] prunePropertiesFromMeasure (AbstractMeasure measure, 
								      PropertyDescriptor [] properties) {
	
	  String cu = measure.getUnitName(measure.getCommonUnit());
	  if (cu == null) {
		return new PropertyDescriptor[0];
	  }
	  String noUnders;
	  if ((noUnders = (String) commonUnitToNoUnders.get (cu)) == null) {
		int pos = 0;
		int underIndex = -1;
		noUnders = "";
		while ((underIndex = cu.indexOf ('_', pos)) != -1) {
		  noUnders = noUnders + cu.substring (pos, underIndex) +
			cu.substring (underIndex+1, underIndex+2).toUpperCase ();
		  pos = underIndex+2;
		}
		while ((underIndex = cu.indexOf ('/', pos)) != -1) {
		  noUnders = noUnders + cu.substring (pos, underIndex) + "Per" +
			cu.substring (underIndex+1, underIndex+2).toUpperCase ();
		  pos = underIndex+2;
		}
		noUnders = noUnders + cu.substring (pos);
		commonUnitToNoUnders.put (cu, noUnders);
	  }
	
	  for (int i = 0; i < properties.length; i++) {
		PropertyDescriptor pd = properties[i];
	  
		if (pd.getName ().equals (noUnders))
		  return new PropertyDescriptor[]{pd};
	  }
	  return null;
    }
	
    /**
     * Includes Double, Integer, etc. and Boolean as primitive types.
     *
     * Checks to see if class is a direct descendant of Number or a 
     * Boolean.
     *
     * @return true when class is of a primitive type
     */
    protected boolean isPrimitive (Class propertyClass) {
      if (propertyClass.isPrimitive())
	  return true;
      try {
	  Class superClass = propertyClass.getSuperclass ();
	  if (superClass.equals (numberClass))
	      return true;
	  if (propertyClass.equals (booleanClass))
	      return true;
      } catch (Exception e) {
	  System.out.println ("Exception " + e);
      }
      
      return false;
    }

  public List getDynamicAssetProperties (Asset asset) {
	List propertyNameValues = new ArrayList ();
    try {
      // get all dynamic properties of asset
      Enumeration dynamicProperties = asset.getOtherProperties();
      while (dynamicProperties.hasMoreElements()) {
		Object dynamicProperty = dynamicProperties.nextElement();
		if (debug)
		  System.out.println("Adding dynamic property: " + 
							 dynamicProperty.toString() +
							 " Value: " + dynamicProperty.toString() +
							 " Class: " + dynamicProperty.getClass().toString());
		propertyNameValues.add(new PropertyNameValue(prettyName(dynamicProperty.getClass().toString()), 
													 dynamicProperty));
      }
    } catch (Exception e) {
      System.out.println("Asset introspection exception: " + e.toString());
    }
    return propertyNameValues;
  }

  // Return the last field of a fully qualified name.
  // If the input string contains an "@" then it's assumed
  // that the fully qualified name preceeds it.

  private String prettyName(String s) {
    int i = s.indexOf("@");
    if (i != -1)
      s = s.substring(0, i);
    return (s.substring(s.lastIndexOf(".")+1));
  }

  protected void reportTime (String prefix, Date start) 
  {
    Runtime rt = Runtime.getRuntime ();
    Date end = new Date ();
    long diff = end.getTime () - start.getTime ();
    long min  = diff/60000l;
    long sec  = (diff - (min*60000l))/1000l;
    System.out.println  ("\n" + prefix +
			 min + 
			 ":" + ((sec < 10) ? "0":"") + sec + 
			 " (Wall clock time)" + 
			 " free "  + (rt.freeMemory  ()/(1024*1024)) + "M" +
			 " total " + (rt.totalMemory ()/(1024*1024)) + "M");
  }

  private boolean debug = false;
}
