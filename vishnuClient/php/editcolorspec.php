<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// This allows for editing of the fields, most importantly the
// expression, associated with a color specification.

  require ("browserlink.php");
  require ("utilities.php");
  require ("navigation.php");

  function getTitle () {
    global $color;
    echo "Editing " . ($color ? $color : "new") . " spec";
  }

  function getHeader() {
  }

  function getSubheader() { 
    global $color;
    echo "Editing spec for " .
         ($color ? ("color " . $color) : "new color") . ".<br>\n";
    if ($color)
      echo "(To delete, specify an empty expression.)<br>\n";
  }

  function multiplechoice ($name, $options, $default) {
    echo "  <SELECT NAME=\"" . $name . "\">\n";
    for ($i = 0; $i < sizeof($options); $i++)
      echo "    <OPTION" . (($options[$i] == $default) ? " SELECTED" : "") .
           "> " . $options[$i] . "\n";
    echo "  </SELECT>\n";
  }    

  function mainContent () {
    global $problem, $color, $expression, $title;
    echo "<FORM METHOD=get ACTION=\"updatespec.php\">\n";
    $colors = array ($color);
    $color_defs = array();
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select vishnu_central.color_defs.* from " .
                "vishnu_central.color_defs left join color_tests on " .
                "vishnu_central.color_defs.name = color_tests.color " .
                "where color_tests.color is NULL;");
    while ($value = mysql_fetch_array ($result)) {
      $colors[] = $value["name"];
      $color_defs [$value["name"]] = $value;
    }
    echo "<table><tr><td align=right>Color</td>\n<td>";
    multiplechoice ("color", $colors, $color);
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from color_tests where color=\"" .
                              $color . "\";");
    $value = mysql_fetch_array ($result);
    mysql_free_result ($result);
    echo "</td></tr><tr><td align=right>Object Type</td>\n<td>";
    $isg = isgrouped ($problem);
    multiplechoice ("objtype",
                    array ($isg ? "grouped_tasks" : "task",
                           $isg ? "grouped_setup" : "setup",
                           $isg ? "grouped_wrapup" : "wrapup",
                           "activity"),
                    $value["obj_type"]);
    echo "</td></tr><tr><td align=right>" .
         "Description for legend</td>\n<td>";
    echo "<INPUT type=\"text\" size=30 maxlength=80 name=\"title\" " .
         "value=\"" . $title . "\">\n</td></tr></table>";
    $expression = stripslashes ($expression);
  
    $str = "";
    while ($pos = strpos ($expression, "qxy")) {
      $str .= substr ($expression, 0, $pos) . "\n";
      $expression = substr ($expression, $pos + 3);
      $pos = strpos ($expression, "q");
      $num = substr ($expression, 0, $pos);
      $expression = substr ($expression, $pos + 1);
      for ($i = 0; $i < $num; $i++)
        $str .= " ";
    }
    $expression = $str . $expression;
  
    echo "<BR>Enter formula:<BR><TEXTAREA NAME=\"text\" ROWS=4 " .
         "COLS=80>\n" . $expression . "\n</TEXTAREA>\n";
?>

  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="oldcolor" VALUE="<? echo $color ?>">
  <BR><BR><INPUT TYPE=submit VALUE="Submit new values">
</FORM>
<BR>Color chart:<TABLE BORDER=1>

<?
    for (reset($color_defs); $color = key($color_defs); next($color_defs)) {
      echo "<TR><TD bgcolor=\"#e1e1e1\"><IMG SRC=\"rect.php?red=" .
           $color_defs[$color]["red"] . "&green=" .
           $color_defs[$color]["green"] . "&blue=" .
           $color_defs[$color]["blue"] . "\">&nbsp;" . $color .
           "</TD></TR>\n";
    }
    echo "</table>\n";
  }
?>

