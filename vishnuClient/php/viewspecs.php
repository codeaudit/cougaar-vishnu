<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Display all the values of the constraint in the scheduling
// specifications in tabular format

  require ("browserlink.php");
  require ("utilities.php");

  $binaries = array ("/", "*", "-", "+", "=", "!=", "<", ">", "<=", ">=");
  $constraints = array();
  $norightbar = 1;

  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Scheduling specs for $problem";
  }

  function getHeader() {
  }

  function getSubheader() { 
    global $problem;
    echo "Scheduling specifications for <font color=\"green\">" .
         $problem . "</font>\n";
  }

  function gettypeandindex ($name) {
    global $problem;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                 "select " . $name . "_type, " . $name .
                 "_index from constraints;");
    $value = mysql_fetch_row ($result);
    mysql_free_result ($result);
    return $value;
  }

  function encodeexp ($exp) {
    $str = "";
    while ($pos = strpos ($exp, "<br>")) {
      $str .= substr ($exp, 0, $pos) . "qxy";
      $exp = substr ($exp, $pos + 4);
      $num = 0;
      while (substr ($exp, 0, 6) == "&nbsp;") {
        $num++;
        $exp = substr ($exp, 6);
      }
      $str .= $num . "q";
    }
    $str .= $exp;
    return $str;
  }

  function treetostring ($typeandindex, $precedence, $quoteconst) {
    $lines = treetolines ($typeandindex, $precedence, $quoteconst);
    $str = $lines[0];
    for ($i = 1; $i < sizeof($lines); $i++)
      $str .= "<br>" . $lines[$i];
    return $str;
  }

  function indentlines ($lines, $space, $dofirst) {
    $sp = "";
    for ($i = 0; $i < $space; $i++)
      $sp .= "&nbsp;";
    $arr = $dofirst ? array ($sp . $lines[0]) : array ($lines[0]);
    for ($i = 1; $i < sizeof ($lines); $i++)
      $arr[] = $sp . $lines[$i];
    return $arr;
  }

  function oneliner ($arr) {
    $maxlen = 30;
    $sum = 0;
    for ($i = 0; $i < sizeof($arr); $i++) {
      if (sizeof ($arr[$i]) != 1)
        return 0;
      $sum += strlen ($arr[$i][0]);
    }
    return $sum < $maxlen;
  }

  function treetolines ($typeandindex, $precedence, $quoteconst) {
    global $binaries, $problem;
    if ($typeandindex[0] == "literal") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                   "select * from literal where id = " .
                   $typeandindex[1] . ";");
      $value = mysql_fetch_array ($result);
      mysql_free_result ($result);
      if ($quoteconst &&
          ($value["datatype"] == "string") &&
          ($value["lit_type"] == "constant"))
        return array ("\"" . $value["value"] . "\"");
      return array ($value["value"]);
    }
    else if ($typeandindex[0] == "operator") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                   "select * from operator where id = " .
                   $typeandindex[1] . ";");
      $value = mysql_fetch_array ($result);
      mysql_free_result ($result);
      $pos = position ($value["operation"], $binaries);
      if ($pos != 1000 ) {
        $parens = $pos > $precedence;
        $arg1 = getarg ("first", $value, $pos, 1);
        $arg2 = getarg ("second", $value, $pos - 1, 1);
        if (oneliner (array ($arg1, $arg2)))
          return array (($parens ? "(" : "") . $arg1[0] . " " .
                        $value["operation"] . " " . $arg2[0] .
                        ($parens ? ")" : ""));
        $arr2 = array();
        if ($parens) {
          $arg1 = indentlines ($arg1, 1, 0);
          $arg2 = indentlines ($arg2, 1, 1);
        }
        for ($i = 0; $i < sizeof ($arg1); $i++) {
          $str = $arg1[$i];
          if ($parens && ($i == 0))
            $str = "(" . $str;
          if ($i == (sizeof($arg1) - 1))
            $str .= " " . $value["operation"];
          $arr2[] = $str;
        }
        for ($i = 0; $i < sizeof ($arg2); $i++) {
          $str = $arg2[$i];
          if ($parens && ($i == (sizeof($arg2) - 1)))
            $str = $str . ")";
          $arr2[] = $str;
        }
        return $arr2;
      }
      if (($value["operation"] == "get") ||
          ($value["operation"] == "globget")) {
        $arg1 = getarg ("first", $value, 1000, 1);
        $arg2 = getarg ("second", $value, 1000, 0);
        $arr2 = array ();
        for ($i = 0; $i < sizeof ($arg1); $i++) {
          $str = $arg1[$i];
          if ($i == (sizeof ($arg1) - 1))
            $str .= "." . $arg2[0];
          $arr2[] = $str;
        }
        return $arr2;
      }
      $arg1 = getarg ("first", $value, 1000, 1);
      $arg2 = getarg ("second", $value, 1000, 1);
      $arg3 = getarg ("third", $value, 1000, 1);
      $arg4 = getarg ("fourth", $value, 1000, 1);
      if (oneliner (array ($arg1, $arg2, $arg3, $arg4)))
        return array ($value["operation"] . " (" . $arg1[0] .
                      (($arg2[0] == "") ? "" : (", " . $arg2[0])) .
                      (($arg3[0] == "") ? "" : (", " . $arg3[0])) .
                      (($arg4[0] == "") ? "" : (", " . $arg4[0])) . ")");
      $arr2 = array();
      $indent = strlen ($value["operation"]) + 2;
      if (sizeof ($arg1) > 1)
        $arg1 = indentlines ($arg1, $indent, 0);
      for ($i = 0; $i < sizeof ($arg1); $i++) {
        $str = $arg1[$i];
        if ($i == 0)
          $str = $value["operation"] . " (" . $str;
        if ($i == (sizeof($arg1) - 1))
          $str .= ($arg2[0] == "") ? ")" : ",";
        $arr2[] = $str;
      }
      if ($arg2[0] != "") {
        $arg2 = indentlines ($arg2, $indent, 1);
        for ($i = 0; $i < sizeof ($arg2); $i++) {
          $str = $arg2[$i];
          if ($i == (sizeof($arg2) - 1))
            $str .= ($arg3[0] == "") ? ")" : ",";
          $arr2[] = $str;
        }
      }
      if ($arg3[0] != "") {
        $arg3 = indentlines ($arg3, $indent, 1);
        for ($i = 0; $i < sizeof ($arg3); $i++) {
          $str = $arg3[$i];
          if ($i == (sizeof($arg3) - 1))
            $str .= ($arg4[0] == "") ? ")" : ",";
          $arr2[] = $str;
        }
      }
      if ($arg4[0] != "") {
        $arg4 = indentlines ($arg4, $indent, 1);
        for ($i = 0; $i < sizeof ($arg4); $i++) {
          $str = $arg4[$i];
          if ($i == (sizeof($arg4) - 1))
            $str .= ")";
          $arr2[] = $str;
        }
      }
      return $arr2;
    }
    return array ("");
  }

  function position ($val, $arr) {
    for ($i = 0; $i < sizeof($arr); $i++)
      if ($val == $arr[$i])
        return $i;
    return 1000;
  }

  function getarg ($which, $value, $precedence, $quoteconst) {
    if (! $value[$which . "_arg_type"])
      return array ("");
    return treetolines (array ($value[$which . "_arg_type"],
                               $value[$which . "_arg_index"]),
                        $precedence, $quoteconst);
  }

  function tableentry2 ($name, $entry) {
    global $problem;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                 "select " . $entry . " from constraints;");
    $value = mysql_fetch_row ($result);
    mysql_free_result ($result);
    echoentry ($name, $value[0], $entry);
  }

  function tableentry ($name, $entry) {
    echoentry ($name, treetostring (gettypeandindex ($entry), 1000, 1),
               $entry);
  }

  function echoentry ($name, $value, $entry) {
    global $constraints, $problem;

    $constraints[$name] = $entry . " " . $name . " default=" .
                          htmlentities (encodeexp ($value));
    echo "<TR><TD>" . 
	"<a href=\"editspec.php?problem=" . $problem . 
	"&specname=" . urlencode($constraints[$name]) . "\"/>" . 
	"<font color=green>" . $name . "</font></a>" . 
	"</TD><TD><font face=\"courier\">" .
        ($value ? $value : "&nbsp;") . "</font></TD></TR>\n";
  }

  function dechex2 ($num) {
    return ($num > 15) ? dechex ($num) : ("0" . dechex ($num));
  }


  function mainContent () { 
    global $problem, $constraints;
    echo "<TABLE BORDER=1>\n";
    tableentry ("Optimization Criterion", "opt_criterion");
    tableentry2 ("Optimization Direction", "opt_direction");
    tableentry ("Delta Criterion", "delta_criterion");
    tableentry ("Best Time", "best_time");
    tableentry2 ("Multitasking", "multitasking");
    tableentry ("Capability Criterion", "capability");
    tableentry ("Task Duration", "task_duration");
    tableentry ("Setup Duration", "setup_duration");
    tableentry ("Wrapup Duration", "wrapup_duration");
    tableentry ("Prerequisites", "prerequisites");
    tableentry ("Resource Unavailable Times", "resource_unavail");
    tableentry ("Task Unavailable Times", "task_unavail");
    tableentry ("Capacity Contributions", "capacity_contrib");
    tableentry ("Capacity Thresholds", "capacity_thresh");
    tableentry ("Groupable", "groupable");
    tableentry ("Linked", "linked");
    tableentry ("Link Time Difference", "link_time_diff");
    tableentry ("Task Text", "task_text");
    tableentry ("Grouped Tasks Text", "grouped_text");
    tableentry ("Activity Text", "activity_text");
    tableentry2 ("Setup Display", "setup_display");
    tableentry2 ("Wrapup Display", "wrapup_display");
    echo "</TABLE>\n";
?>

<BR><FORM METHOD=post ACTION="editspec.php">
  <SELECT NAME="specname">
<? for (reset($constraints); $key = key($constraints); next($constraints))
     echo "    <OPTION VALUE=\"" . $constraints[$key] .
          "\"> " . $key . "\n"; ?>
  </SELECT>
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=submit VALUE="Edit selected spec">
</FORM>

<?
    $args = "problem=" . $problem;
    echo "<BR><h2>Color specifications</h2>\n<TABLE BORDER=1>\n";
    echo "<tr><th>&nbsp;Color&nbsp;</th><th>&nbsp;Object Type&nbsp;</th>" .
         "<th>&nbsp;Legend Entry&nbsp;</th><th>Formula</th></tr>\n";
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from color_tests;");
    while ($value = mysql_fetch_array ($result)) {
      $result2 = mysql_db_query ("vishnu_central",
                    "select * from color_defs where name = \"" .
                    $value["color"] . "\";");
      $value2 = mysql_fetch_array ($result2);
      mysql_free_result ($result2);
      $color = "#" . dechex2 ($value2["red"]) .
               dechex2 ($value2["green"]) . dechex2 ($value2["blue"]);
      $exp = treetostring (array ($value["test_type"],
                                  $value["test_id"]), 1000, 1);
      $href = "editcolorspec.php?color=" . $value["color"] . "&" .
              $args . "&title=" . urlencode ($value["title"]) .
              "&expression=" . urlencode (encodeexp ($exp));
      $href = htmlspecialchars ($href);
      echo "<TR><TD bgcolor=\"#e1e1e1\">" .
           "<A HREF=\"" . $href . "\"><IMG SRC=\"rect.php?red=" .
           $value2["red"] . "&green=" . $value2["green"] . "&blue=" .
           $value2["blue"] . "\"></A>" .
           "<FONT color=\"" . $color . "\">&nbsp;" .
           $value["color"] . "</FONT></TD><TD align=center>" .
           $value["obj_type"] .
           "</TD><TD align=center>" . $value["title"] .
           "</TD><TD><FONT face=\"courier\">" . $exp . "</font></TD></TR>\n";
    }
    echo "</TABLE>\n";
    echo "<BR>Click on colored box to edit/delete color spec or <A HREF=" .
         "\"editcolorspec.php?" . $args .
         "\">click here</A> to add new color spec.<BR><BR>\n";
    mysql_close();
    linkToProblem ($problem);
  }
?>
