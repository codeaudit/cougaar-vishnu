package org.cougaar.lib.vishnu.server;

import java.util.Date;
import java.util.Random;
import java.util.Stack;
import java.util.List;
import java.util.ArrayList;
import org.cougaar.lib.vishnu.server.FastStack;

/**
 * <copyright>
 *  Copyright 2000-2001 Defense Advanced Research Projects
 *  Agency (DARPA) and ALPINE (a BBN Technologies (BBN) and
 *  Raytheon Systems Company (RSC) Consortium).
 *  This software to be used only in accordance with the
 *  COUGAAR license agreement.
 * </copyright>
 */

public class StackImpl extends ArrayList implements FastStack {
  public boolean empty() 
  {
	return myList.isEmpty();
  }
  
  public Object peek() 
  {
	return myList.get(size-1);
  }
  
  public Object pop() 
  {
	return myList.remove(--size);
  }
  
  public Object push(Object item)
  {
	size++;
	myList.add(item);
	return item;
  }
  
  public int search(Object item)
  {
	return myList.indexOf (item);
  }
  
  List myList = new ArrayList (10);
  int size = 0;

  public static void main (String [] arg) 
  {
	FastStack fs = new StackImpl();
	
	fs.push (new Integer (0));
	fs.push (new Integer (1));	
	fs.push (new Integer (2));
	
	System.out.println ("pop " + fs.pop());
	System.out.println ("pop " + fs.pop());
	System.out.println ("pop " + fs.pop());

	int size = 1000000;
	
	Integer [] ints = new Integer [size];

	Random rand = new Random ();
	
	for (int i = 0; i < size; i++)
	  ints[i] = new Integer (rand.nextInt ());

	Stack oldstack = new Stack ();

	Date start = new Date ();
	for (int i = 0; i < size; i++)
	  oldstack.push (ints[i]);
	long t1 = reportTime ("push old stack ", start);

	start = new Date ();
	for (int i = 0; i < size; i++)
	  oldstack.pop ();
	long t2 = reportTime ("pop old stack ", start);

	start = new Date ();
	for (int i = 0; i < size; i++)
	  fs.push (ints[i]);
	long t3 = reportTime ("push new stack ", start);
	System.out.println ("push pct " + t1 + " vs " + t3 + " - " + ((float) t1)/((float) t3));
	
	start = new Date ();
	for (int i = 0; i < size; i++)
	  fs.pop ();
	long t4 = reportTime ("pop new stack ", start);
	System.out.println ("pop pct " + t2 + " vs " + t4 + " - " + ((float) t2)/((float) t4));

	for (int i = 0; i < size; i++)
	  oldstack.push (ints[i]);

	start = new Date ();
	try {
	for (int i = 0; i < size; i++) {
	  oldstack.peek ();
	}
	} catch (Exception e) {}
	
	long t5 = reportTime ("peek old stack ", start);

	for (int i = 0; i < size; i++)
	  fs.push (ints[i]);

	start = new Date ();
	try {
	for (int i = 0; i < size; i++) {
	  fs.peek ();
	}
	} catch (Exception e) {}
	long t6 = reportTime ("peek new stack ", start);
	System.out.println ("peek pct - old " + t5 + " vs new " + t6 + 
						" - " + ((float) t6)/((float) t5));

  }

  protected static long reportTime (String prefix, Date start) 
  {
    Date end = new Date ();
    Runtime rt = Runtime.getRuntime ();
    long diff = end.getTime () - start.getTime ();
    long min  = diff/60000l;
    long sec  = (diff - (min*60000l))/1000l;

    System.out.println  (prefix +
			 min + 
			 ":" + ((sec < 10) ? "0":"") + sec + 
			 " (Wall clock time)" + 
			 " free "  + (rt.freeMemory  ()/(1024*1024)) + "M" +
			 " total " + (rt.totalMemory ()/(1024*1024)) + "M");
	return diff;
  }

};

