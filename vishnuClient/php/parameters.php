<?
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
<INPUT type=text size=20 name=start value=<? echo $window["start_time"]?>>
</font></td><td></td></tr>
<tr><td nowrap><font size=+1>
End (default = end of time)
</td><td>
<INPUT type=text size=20 name=end value=<? echo $window["end_time"]?>>
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
</table>
<br><input type=submit value="Update Parameters">
</form>
<?
  }
?>

