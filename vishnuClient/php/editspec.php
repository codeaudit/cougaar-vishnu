<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// For editing one constraint in the scheduling specifications.

  require ("browserlink.php");
  require ("utilities.php");

  $index1 = strpos ($specname, " ");
  $index2 = strpos ($specname, "default=");
  $spec = substr ($specname, 0, $index1);
  $name = substr ($specname, $index1 + 1, $index2 - $index1 - 2);
  $value = substr ($specname, $index2 + 8);
  $value = stripslashes ($value);

  $str = "";
  while ($pos = strpos ($value, "qxy")) {
    $str .= substr ($value, 0, $pos) . "\n";
    $value = substr ($value, $pos + 3);
    $pos = strpos ($value, "q");
    $num = substr ($value, 0, $pos);
    $value = substr ($value, $pos + 1);
    for ($i = 0; $i < $num; $i++)
      $str .= " ";
  }
  $value = $str . $value;

  require ("navigation.php");

  function getTitle () {
    global $name;
    echo "Editing spec " . $name;
  }

  function getHeader() {
    global $problem;
    echo "Problem <font color=\"green\">" . $problem . "</font>\n";
  }

  function getSubheader() { 
    global $name;

    $name_no_space = str_replace (" ", "_", $name);

    echo "Editing the specification for " . 
	"<a href='fulldoc.php#" . $name_no_space . "'><font color=\"green\">" . $name  . "</font></a>";
  }

  function multiplechoice ($options, $default) {
    echo "  <SELECT NAME=\"choice\">\n";
    for ($i = 0; $i < sizeof($options); $i++)
      echo "    <OPTION" . (($options[$i] == $default) ? " SELECTED" : "") .
           "> " . $options[$i] . "\n";
    echo "  </SELECT>\n";
  }    

  /** create a link to the a typical task and a typical resource so can do 
   *  copy and paste of fields 
   */
  function showTaskAndResource ($problem) {
   $arr = gettaskandresourcetypes ($problem);
   $taskobject = $arr[0];
   $resourceobject = $arr[1];

   $result = mysql_db_query ("vishnu_prob_" . $problem,
               "select * from object_fields where is_key=\"true\";");
   while ($value = mysql_fetch_array ($result)) {
    if ($value["object_name"] == $taskobject)
      $taskkey = $value["field_name"];
    if ($value["object_name"] == $resourceobject)
      $resourcekey = $value["field_name"];
   }
   mysql_free_result ($result);

   $result = mysql_db_query ("vishnu_prob_" . $problem,
                 "select obj_" . $taskkey . " from obj_" . $taskobject . ";");
   while ($value = mysql_fetch_row ($result)) {
	$taskname = $value[0];
	break;
   }
   mysql_free_result ($result);

   $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select obj_" . $resourcekey . " from obj_" . $resourceobject . ";");
   while ($value = mysql_fetch_row ($result)) {
	$resourcename = $value[0];
	break;
   }
   mysql_free_result ($result);
	
   echo "<table border=0 width=100%><tr><td></td></tr><tr><td align=center>";
   $url = "task.php?problem=" . $problem .
	"&taskobject=" . $taskobject .
	"&taskkey=" . $taskkey .
	"&resourceobject=" . $resourceobject .
	"&resourcekey=" . $resourcekey .
	"&taskname=" . urlencode ($taskname);
   echo "<a href=\"" . $url . "\"><h3>" . "Typical task fields" .
        "</h3></a>" . "</td><td align=center>";
   $url = "resource.php?problem=" . $problem .
	"&taskobject=" . $taskobject .
	"&taskkey=" . $taskkey .
	"&resourceobject=" . $resourceobject .
	"&resourcekey=" . $resourcekey .
	"&resourcename=" . urlencode ($resourcename);
   echo "<a href=\"" . $url . "\"><h3>" . "Typical resource fields" .
        "</h3></a>" . "</td></tr></table>";
  }

  function mainContent () { 
    global $problem, $name, $specname, $spec, $value;
    echo "<a href=\"fulldoc.php#a\"/>What functions can I use?</a>";
    echo "<FORM METHOD=post ACTION=\"updatespec.php\">\n";

    /** show constraint description table */
    $result = mysql_db_query ("vishnu_central",
                  "select * from constraint_descrip where name='" .
                  $spec . "';");

    echo "<table border=1 cellspacing=0>";
    while ($row = mysql_fetch_array ($result)) {
      echo "<tr><td width=100 BGCOLOR=#DBDBDB><b>Description</b>" .
           "</td><td BGCOLOR=#CCCCCC>" . $row["description"] . "</td></tr>";
      if (strcmp ($row["defined_vars"], "N/A") != 0)
	$appendText = ", tasks, resources, start_time, end_time";
      echo "<tr><td BGCOLOR=#DBDBDB><b>Defined Variables</b>" .
           "</td><td BGCOLOR=#CCCCCC>" . $row["defined_vars"] .
           $appendText . "</td></tr>";
      echo "<tr><td BGCOLOR=#DBDBDB><b>Return Type</b></td>" .
           "<td BGCOLOR=#CCCCCC>" . $row["return_type"] . "</td></tr>";
      echo "<tr><td BGCOLOR=#DBDBDB><b>Default Value</b></td>" .
           "<td BGCOLOR=#CCCCCC>" .
           (($row["default_value"] == "") ?
            "&nbsp;" : $row["default_value"]) . "</td></tr>";
    }
    echo "</table><br>";
    mysql_free_result ($result);	

    if ($spec == "opt_direction")
      multiplechoice (array ("minimize", "maximize"), $value);
    else if ($spec == "multitasking")
      multiplechoice (array ("none", "grouped", "ungrouped",
                             "ignoring_time"), $value);
    else if ($spec == "setup_display")
      multiplechoice (array ("left", "right", "line", "color"), $value);
    else if ($spec == "wrapup_display")
      multiplechoice (array ("left", "right", "line", "color"), $value);
    else
      echo "<TEXTAREA NAME=\"text\" ROWS=10 COLS=80>\n" . $value .
           "\n</TEXTAREA>\n";

    showTaskAndResource ($problem);
?>

  <INPUT TYPE=hidden NAME="spec" VALUE="<? echo $spec ?>">
  <INPUT TYPE=hidden NAME="name" VALUE="<? echo $name ?>">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <DIV ALIGN=center><INPUT TYPE=submit VALUE="Compile spec"></DIV>

<? } ?>