<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Displays the genetic algorithm and scheduling window parameters

  require ("browserlink.php");
  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Parameters for " . $problem;
  }
  function getHeader () {
    global $problem;
    echo "Viewing/Editing Parameters for problem <font color=\"green\">" .
         $problem . "</font>";
  } 
  function getSubheader() { 
  }

  function mainContent () { 
    global $problem;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from window;");
    $window = mysql_fetch_array ($result);
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from gaparms;");
    $gaparms = mysql_fetch_array ($result);
    $op1mut = strpos ($gaparms["operator1_name"], "Mutation");
?>
<form method=post action="updateparms.php">
<input type=hidden name=problem value="<? echo $problem; ?>">
<table COLS=3  >
<tr>
<td COLSPAN="3" BGCOLOR="<? echo getcolor(); ?>">
<font size=+2>Scheduling Window</font></td>
</tr>
<tr><td nowrap><font size=+1>
Start (default = now)
</td><td>
<INPUT type=text size=20 name=start value="<? echo $window["start_time"]?>">
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
End (default = end of time)
</td><td>
<INPUT type=text size=20 name=end value="<? echo $window["end_time"]?>">
</font></td><td></td></tr>
<tr><td></td></tr>
<tr><td></td></tr>
<tr><td></td></tr>
<tr>
<td COLSPAN="3" BGCOLOR="<? echo getcolor(); ?>">
<font size=+2>Genetic Algorithm</font></td>
</tr>
<tr><td nowrap><font size=+1>
Population Size
</td><td>
<INPUT type=text size=20 name=popsize value=<? echo $gaparms["pop_size"]?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Parent Scalar
</td><td>
<INPUT type=text size=20 name=ps value=<? echo $gaparms["parent_scalar"]?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Maximum Evaluations
</td><td>
<INPUT type=text size=20 name=maxevals value=<? echo $gaparms["max_evals"]?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Maximum Time
</td><td>
<INPUT type=text size=20 name=maxtime value=<? echo $gaparms["max_time"]?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Maximum Duplicates
</td><td>
<INPUT type=text size=20 name=dups value=<? echo $gaparms["max_duplicates"]?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Maximum Top Dog Age
</td><td>
<INPUT type=text size=20 name=tda value=<? echo $gaparms["max_top_dog_age"]?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Crossover Probability
</td><td>
<INPUT type=text size=20 name=xprob value =<?
echo $op1mut ? $gaparms["operator2_prob"] : $gaparms["operator1_prob"]; ?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Mutation Probability
</td><td>
<INPUT type=text size=20 name=mprob value =<?
echo $op1mut ? $gaparms["operator1_prob"] : $gaparms["operator2_prob"]; ?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Maximum Fraction Mutated
</td><td>
<INPUT type=text size=20 name=mfm value =<?
echo $op1mut ? $gaparms["operator1_parms"] : $gaparms["operator2_parms"]; ?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
Report Interval
</td><td>
<INPUT type=text size=20 name=rep value =<?
echo $gaparms["report_interval"]; ?>>
</font></td><td></td></tr>
</table>
<br><input type=submit value="Update Parameters">
</form>
<?
  }

  function hintsForPage() {
?>
This page allows you to view and edit the scheduling window and the
genetic algorithm parameters.
You can edit any of the values by changing them and then clicking
"Update Parameters".
<b>The parameter values are not actually changed until you click
"Update Parameters".</b>
When you click on "Update Parameters", a check is performed to
ensure that the new entries are valid.
<p>
The scheduling window is a range of time in which assignments can
be made.  The start time of an assignment cannot be before the start
time of the window, and the end time of an assignment cannot be after
the end  time of the window.
If you enter no value for the start time, it will be set to the
current time when you start scheduling.
If you enter no value for the end time, there will be no limit on
the end time of assignments.
<p>
The genetic algorithm parameters and how to choose good values for
them is described in the <a href="fulldoc.php#gaparameters">
full documentation</a>.
<?
  }
?>

