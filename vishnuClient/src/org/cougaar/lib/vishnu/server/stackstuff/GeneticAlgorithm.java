// $Header: /opt/rep/cougaar/vishnu/vishnuClient/src/org/cougaar/lib/vishnu/server/stackstuff/Attic/GeneticAlgorithm.java,v 1.1 2001-08-15 18:21:51 dmontana Exp $

package org.cougaar.lib.vishnu.server;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Random;

/**
 * A simple genetic algorithm.
 * It was originally intended to be completely independent of the
 * scheduling code, but a few references leaked in.
 * It implements a steady-state genetic algorithm with an exponential
 * rank-based selection probability distribution.
 * It allows the user to define the chromosome, genetic operators,
 * initializer, and decoder by specifying class names in the
 * XML parameters input.
 * At regular intervals, it reports its progress and checks for
 * cancellation of the run.
 *
 * This software is to be used in accordance with the COUGAAR license
 * agreement. The license agreement and other information can be found at
 * http://www.cougaar.org.
 *
 * Copyright 2001 BBNT Solutions LLC
 */

public class GeneticAlgorithm {

  private boolean minimizing;
  private int popSize;
  private int maxEvals;
  private int maxTime;
  private int maxDuplicates;
  private int maxTopDogAge;
  private int reportInterval;
  private GAInitializer initializer;
  private GADecoder decoder;
  private GAOperator[] operators;
  private float[] operatorProbs;
  private float[] parentProbs;
  private HashSet chromosomes;   // for uniqueness check
  private ArrayList population;
  private int numEvals;
  private int numDuplicates;
  private int topDogAge;
  private long startTime;
  private long stopTime;
  private long reportTime;
  private Scheduler scheduler;
  private static Random random = new Random();

  private static boolean debug = 
    ("true".equals (System.getProperty ("vishnu.Scheduler.debug")));
  private static boolean explain = 
    ("true".equals (System.getProperty ("vishnu.explain")));

  public static synchronized float getRandomFloat() {
    return random.nextFloat();
  }

  public static synchronized int getRandomInt (int range) {
    return Math.abs (random.nextInt()) % range;
  }

  public GeneticAlgorithm (Scheduler scheduler) {
    this.scheduler = scheduler;
  }

  /** return true if canceled */
  public boolean execute (SchedulingData data, SchedulingSpecs specs) {
    minimizing = specs.isMinimizing();
    resetCounts();
    Date start = new Date ();
    boolean printed = false;
    while (! checkForTermination()) {
      Chromosome c;
      if (numEvals < popSize)
        c = initializer.generateIndividual (numEvals + numDuplicates, data);
      else {
        GAOperator op = selectOperator();
        c = op.generateChild (selectParents (op.numParents()), data);
      }
      if (chromosomes.contains (c)) {
        numDuplicates++;
        continue;
      }
      data.clearAssignments();
      decoder.generateAssignments (c, data, specs, false);
      float val = specs.evaluate ();
      numEvals++;
      boolean isBest = insertNewIndividual (c, val);
      topDogAge = isBest ? 0 : (topDogAge + 1);
      if (reportIfNecessary())
        return true;
      if (debug && !printed && (numEvals >= popSize)) {
        reportTime ("Seeding complete in ", start);
        printed = true;
      }
    }
    if (debug) {
      reportTermination ();
      reportTime ("Did " + numEvals + " evals in ", start);
      System.out.println (getDifference ("Time per eval ",
                                         (new Date ().getTime () -
                                          start.getTime())/numEvals));
      ((OrderedDecoder)decoder).reportTiming ();
    }

    if (explain || (topDogAge != 0)) {
      data.clearAssignments();
      decoder.generateAssignments (((Member) population.get(0)).chromosome,
                                   data, specs, explain);
    }
    return false;
  }

  protected void reportTime (String prefix, Date start) 
  {
    Date end = new Date ();
    long diff = end.getTime () - start.getTime ();
    System.out.println  (getDifference(prefix, diff));
  }

  protected String getDifference (String prefix, long diff) {
    Runtime rt = Runtime.getRuntime ();
    long min  = diff/60000l;
    long sec  = (diff - (min*60000l))/1000l;
    return prefix + min + 
          ":" + ((sec < 10) ? "0":"") + sec + 
          " free "  + (rt.freeMemory  ()/(1024*1024)) + "M" +
          " total " + (rt.totalMemory ()/(1024*1024)) + "M";
  }

  public DefaultHandler getXMLHandler() {
    return new ParmsHandler();
  }

  private boolean checkForTermination() {
    return ((numEvals >= maxEvals) ||
            (numDuplicates > maxDuplicates) ||
            (topDogAge > maxTopDogAge) ||
            (System.currentTimeMillis() > stopTime));
  }

  private void reportTermination () {
    System.out.println
      ("GeneticAlgorithm.execute - Terminated because " + 
       ((numEvals >= maxEvals) ?
        "numEvals (" + numEvals + ") >= maxEvals (" + maxEvals + ")" : "") +
       ((numDuplicates > maxDuplicates) ?
        "numDuplicates (" + numDuplicates +
        ") >= maxDuplicates (" + maxDuplicates + ")" : "") +
       ((topDogAge > maxTopDogAge)  ?
        "topDogAge (" + topDogAge + ") >= maxTopDogAge (" +
        maxTopDogAge + ")" : "") +
       ((System.currentTimeMillis() > stopTime) ?
        "currentTime (" + new Date () + ") >= stopTime (" +
        new Date(stopTime) + ")" : ""));
    if (numDuplicates > maxDuplicates)
      System.out.println
        ("\t\nThis means that the problem is so small that\n" + 
         "the population contains all possible solutions,\n" + 
         "but the number of members in the population is less " +
         "than the population size.\n" + "For more information, " + 
         "contact Gordon Vidaver (gvidaver@bbn.com) or " +
         "Dave Montana (dmontana@bbn.com)");
  }

  private void resetCounts() {
    chromosomes = new HashSet();
    population = new ArrayList();
    numEvals = 0;
    numDuplicates = 0;
    topDogAge = 0;
    startTime = System.currentTimeMillis();
    stopTime = startTime + 1000 * ((long) maxTime);
    if (reportInterval != 0)
      reportTime = startTime + 1000 * ((long) reportInterval);
  }

  /** return true if canceled */
  private boolean reportIfNecessary() {
    if (reportInterval == 0)
      return false;
    long current = System.currentTimeMillis();
    if (current > reportTime) {
      float f1 = ((float) numEvals) / ((float) maxEvals);
      float f2 = (((float) (current - startTime)) /
                  ((float) (stopTime - startTime)));
      float f = (f1 > f2) ? f1 : f2;
      int percent = (int) (f * 100.0f);
      if ((percent > 1) &&
          scheduler.ackProblem (percent, null))
        return true;
      reportTime = System.currentTimeMillis() + 1000 * ((long) reportInterval);
      System.out.println ("After " + numEvals + " evaluations, best " +
                          "score is " +
                          ((Member) population.get(0)).evaluation);
    }
    return false;
  }

  private Chromosome[] selectParents (int num) {
    Chromosome[] parents = new Chromosome [num];
    for (int i = 0; i < num;) {
      Chromosome c = selectParent();
      boolean unique = true;
      for (int j = 0; j < i; j++)
        if (c.equals (parents[j]))
          unique = false;
      if (unique)
        parents [i++] = c;
    }
    return parents;
  }

  private Chromosome selectParent() {
    return ((Member) population.get (selectIndex (parentProbs))).chromosome;
  }

  private GAOperator selectOperator() {
    return operators [selectIndex (operatorProbs)];
  }

  private int selectIndex (float[] probs) {
    float rand_num = getRandomFloat();
    int low = 0;
    int high = probs.length - 1;
    while (low <= high) {
      int med = (low + high) / 2;
      if (rand_num < probs[med] &&
          (med == 0 || (rand_num >= probs[med - 1])))
	return med;
      else if (med != 0 && rand_num < probs[med - 1])
	high = med;
      else
	low = med + 1;
    }
    return -1;
  }

  private boolean insertNewIndividual (Chromosome chrom, float evaluation) {
    int low = 0;
    int high = population.size() - 1;
    while (low <= high) {
      int med = (low + high) / 2;
      if (minimizing &&
          evaluation < ((Member) population.get(med)).evaluation &&
          (med == 0 ||
           evaluation >= ((Member) population.get(med-1)).evaluation))
        return doInsertion (med, chrom, evaluation);
      else if ((! minimizing) &&
               evaluation > ((Member) population.get(med)).evaluation &&
               (med == 0 ||
                evaluation <= ((Member) population.get(med-1)).evaluation))
        return doInsertion (med, chrom, evaluation);
      else if ((minimizing && med != 0 &&
                evaluation < ((Member) population.get(med-1)).evaluation) ||
               ((! minimizing) && med != 0 &&
                evaluation > ((Member) population.get(med-1)).evaluation))
	high = med;
      else
	low = med + 1;
    }
    return doInsertion (population.size(), chrom, evaluation);
  }

  private boolean doInsertion (int pos, Chromosome chrom, float evaluation) {
    population.add (pos, new Member (chrom, evaluation));
    chromosomes.add (chrom);
    if (population.size() > popSize) {
      chromosomes.remove
        (((Member) population.get (population.size() - 1)).chromosome);
      population.remove (population.size() - 1);
    }
    return (pos == 0);
  }

  private void computeParentProbs (float parentScalar) {
    parentProbs = new float [popSize];
    float val = 1.0f;
    float sum = 0.0f;
    for (int i = 0; i < popSize; i++) {
      sum += val;
      parentProbs[i] = sum;
      val *= parentScalar;
    }
    for (int i = 0; i < (popSize - 1); i++)
      parentProbs[i] /= sum;
    parentProbs [popSize - 1] = 1.0f;
  }

  private static class Member {
    Chromosome chromosome;
    float evaluation;

    public Member (Chromosome c, float e) {
      chromosome = c;
      evaluation = e;
    }
  }

  /** Parses the parameters */
  private class ParmsHandler extends DefaultHandler {

    ArrayList ops = new ArrayList(4);
    ArrayList probs = new ArrayList(4);

    public void startElement (String uri, String local,
                              String name, Attributes atts) {
      if (name.equals ("GAPARMS")) {
        popSize = Integer.parseInt (atts.getValue ("pop_size"));
        computeParentProbs
          (Float.valueOf (atts.getValue ("parent_scalar")).floatValue());
        maxEvals = Integer.parseInt (atts.getValue ("max_evals"));
        maxTime = Integer.parseInt (atts.getValue ("max_time"));
        maxDuplicates = Integer.parseInt (atts.getValue ("max_duplicates"));
        maxTopDogAge = Integer.parseInt (atts.getValue ("max_top_dog_age"));
        try {
          reportInterval =
            Integer.parseInt (atts.getValue ("report_interval"));
        } catch (Exception e) {
          reportInterval = 0;
        }
        try {
          initializer = (GAInitializer)
            Class.forName (atts.getValue ("initializer")).newInstance();
          decoder = (GADecoder)
            Class.forName (atts.getValue ("decoder")).newInstance();
        } catch (Exception e) {
          System.err.println (e.getMessage());
          e.printStackTrace();
        }
        if (atts.getValue ("initializer_parms") != null)
          initializer.setParms (atts.getValue ("initializer_parms"));
        if (atts.getValue ("decoder_parms") != null)
          decoder.setParms (atts.getValue ("decoder_parms"));
      }
      else if (name.equals ("GAOPERATOR")) {
        try {
          GAOperator op = (GAOperator)
            Class.forName (atts.getValue ("name")).newInstance();
          ops.add (op);
          probs.add (Float.valueOf (atts.getValue ("prob")));
          if (atts.getValue ("parms") != null)
            op.setParms (atts.getValue ("parms"));
        } catch (Exception e) {
          System.err.println (e.getMessage());
          e.printStackTrace();
        }
      }
      else if (! name.equals ("GAOPERATORS"))
        System.out.println ("Unknown tag in GA parameters: " + name);
    }

    public void endElement (String uri, String local, String name) {
      if (name.equals ("GAOPERATORS")) {
        operators = new GAOperator [ops.size()];
        ops.toArray (operators);
        operatorProbs = new float [probs.size()];
        float sum = 0.0f;
        for (int i = 0; i < probs.size(); i++)
          sum += ((Float) probs.get(i)).floatValue();
        for (int i = 0; i < probs.size(); i++)
          operatorProbs[i] = ((Float) probs.get(i)).floatValue() / sum;
        operatorProbs [probs.size() - 1] = 1.0f;
      }
      else if (name.equals ("GAPARMS")) {
        // do the initialization
      }
    }
  }

}
