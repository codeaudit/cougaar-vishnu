<?
  require ("browserlink.php");
  require ("utilities.php");
  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Updated parameters for " . $problem;
  }
  function mainContent () {
  } 
  function getSubheader() {
    global $problem;
    echo "<BR><A href=\"parameters.php?problem=" . $problem . "\">" .
         "Return to Parameters</A>"; 
  }

  function isValid ($val, $type, $name) {
    if ((! $val) && ($type == "datetime"))
      return 1;
    if (checkValid ($val, $type))
      return 1;
    echo "Error: Invalid value $value for $name";
    return 0;
  }

  function getHeader () { 
    global $problem, $start, $end, $popsize, $ps, $maxevals, $maxtime;
    global $dups, $tda, $xprob, $mprob, $mfm;
    echo "Results of updating parameters for problem $problem<BR>\n";
    if (! isValid ($start, "datetime", "Start Time"))
      return;
    if (! isValid ($end, "datetime", "End Time"))
      return;
    if (! isValid ($popsize, "number", "Population Size"))
      return;
    if (! isValid ($ps, "number", "Parent Scalar"))
      return;
    if (! isValid ($maxevals, "number", "Maximum Evaluations"))
      return;
    if (! isValid ($maxtime, "number", "Maximum Time"))
      return;
    if (! isValid ($dups, "number", "Maximum Duplicates"))
      return;
    if (! isValid ($tda, "number", "Maximum Top Dog Age"))
      return;
    if (! isValid ($xprob, "number", "Crossover Probability"))
      return;
    if (! isValid ($mprob, "number", "Mutation Probability"))
      return;
    if (! isValid ($mfm, "number", "Maximum Fraction Mutated"))
      return;
    mysql_db_query ("vishnu_prob_" . $problem,
          "update window set start_time=" .
          ($start ? ("\"" . $start . "\"") : "NULL") .
          ", end_time=" . ($end ? ("\"" . $end . "\"") : "NULL") . ";");
    if ($end)
      mysql_db_query ("vishnu_prob_" . $problem,
          "update window set end_time=\"" . $end . "\";");
    mysql_db_query ("vishnu_prob_" . $problem,
        "update gaparms set pop_size=\"" . $popsize .
        "\", parent_scalar=\"" . $ps .
        "\", max_evals=\"" . $maxevals .
        "\", max_time=\"" . $maxtime .
        "\", max_duplicates=\"" . $dups .
        "\", max_top_dog_age=\"" . $tda .
        "\", operator1_name=\"com.bbn.sched.OrderedMutation" .
        "\", operator1_prob=\"" . $mprob .
        "\", operator1_parms=\"" . $mfm .
        "\", operator2_name=\"com.bbn.sched.OrderedCrossover" .
        "\", operator2_prob=\"" . $xprob .
        "\", operator2_parms=\"\";");
    echo "<BR>Update Complete";
  }
?>
