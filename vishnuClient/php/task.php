<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Display the data and assignment for a particular task

  require ("browserlink.php");
  require_once ("utilities.php");
  require ("editobject.php");
  require ("showobjects.php");

  if (! $action)
    $action = "View";
  require ("navigation.php");

  function getTitle () {
    global $action;
    if ($action == "View All")
      showTitle();
    else
      getHeader();
  }

  function getHeader () {
    global $taskobject, $taskname, $action;
    if ($action == "View")
      echo "Viewing " . $taskobject . " - " . $taskname;
    else if ($action == "Edit")
      echo "Editing " . $taskobject . " - " . $taskname;
    else if ($action == "Create")
      echo "Creating new " . $taskobject;
    else if ($action == "View All")
      showHeader();
  }

  function getSubheader() { 
  }

  function isFree ($resource, $start, $end) {
    global $problem;
    $result = mysql_db_query ("vishnu_prob_$problem",
                  "select * from assignments where resource_key " .
                  "= \"$resource\";");
    while ($value = mysql_fetch_array ($result))
      if (($value["wrapup_time"] > $start) &&
          ($value["setup_time"] < $end))
        return 0;
    $result = mysql_db_query ("vishnu_prob_$problem",
                  "select * from activities where resource_key " .
                  "= \"$resource\";");
    while ($value = mysql_fetch_array ($result))
      if (($value["start_time"] > $start) &&
          ($value["end_time"] < $end))
        return 0;
    return 1;
  }

  function constReferencesResource ($const) {
    global $problem;
    $result = mysql_db_query ("vishnu_prob_$problem",
                  "select $const" . "_type, $const" . "_index " .
                  "from constraints;");
    $value = mysql_fetch_row ($result);
    return (($value[0] == "literal") &&
            litReferencesResource ($value[1])) ||
           (($value[0] == "operator") &&
            opReferencesResource ($value[1]));
  }

  function opReferencesResource ($index) {
    global $problem;
    $result = mysql_db_query ("vishnu_prob_$problem",
                  "select * from operator where id = \"$index\";");
    $value = mysql_fetch_array ($result);
    return checkNth ("first", $value) ||
           checkNth ("second", $value) ||
           checkNth ("third", $value) ||
           checkNth ("fourth", $value);
  }

  function checkNth ($num, $value) {
    return (($value [$num . "_arg_type"] == "literal") &&
            litReferencesResource ($value [$num . "_arg_index"])) ||
           (($value [$num . "_arg_type"] == "operator") &&
            opReferencesResource ($value [$num . "_arg_index"]));
  }

  function litReferencesResource ($index) {
    global $problem;
    $result = mysql_db_query ("vishnu_prob_$problem",
                  "select * from literal where id = \"$index\";");
    $value = mysql_fetch_array ($result);
    return ($value["value"] == "resource") &&
           ($value["lit_type"] == "variable");
  }

  function mainContent () { 
    global $problem, $taskkey, $taskname, $taskobject, $resourcekey;
    global $resourcename, $resourceobject, $freezeaction, $action;
    global $norightbar, $reassign, $reassignment;

    if ($action == "View All") {
      showContent();
      return;
    }
    if ($action == "Edit") {
      editobject ($taskobject, $taskname, $problem, $taskkey);
      $norightbar = 1;
      return;
    }
    if ($action == "Create") {
      createobject ($taskobject, $problem, $taskkey);
      $norightbar = 1;
      return;
    }
    
    if ($freezeaction == "Freeze Assignment")
      mysql_db_query ("vishnu_prob_" . $problem,
                  "update assignments set frozen = \"yes\" where " .
                  "task_key = \"" . $taskname . "\";");
    if ($freezeaction == "Unfreeze Assignment")
      mysql_db_query ("vishnu_prob_" . $problem,
                  "update assignments set frozen = \"no\" where " .
                  "task_key = \"" . $taskname . "\";");
    if ($reassign) {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                    "select * from assignments where task_key = \"" .
                    $taskname . "\";");
      if (isFree ($reassignment, $aval["setup_time"], $aval["wrapup_time"]))
        mysql_db_query ("vishnu_prob_$problem",
            "update assignments set resource_key = \"$reassignment\" " .
            "where task_key = \"" . $taskname . "\";");
      else {
        echo "<h2>$reassignment is no longer free at that time.</h2>";
        return;
      }
    }
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select * from assignments where task_key = \"" .
                  $taskname . "\";");
    $value = mysql_fetch_array ($result);
    mysql_free_result ($result);
    echo "<table><tr>";
    if (! $value)
      echo "<td align=center><B>No Assignment Yet</B><BR></td>";
    else {
      $page = "resource.php?problem=" . $problem . "&taskobject=" .
              $taskobject . "&taskkey=" . $taskkey . "&resourcename=" .
              urlencode ($value["resource_key"]) . "&resourcekey=" .
              $resourcekey . "&resourceobject=" . $resourceobject;
      echo "<td align=center>";
      $aval = $value;
      echo "<B>Assignment Data</B><p><TABLE BORDER=1 CELLPADDING=1>\n" .
           "<TR><TD>Assigned Resource</TD><TD>" . "<A HREF=\"" . $page .
           "\">" . $value["resource_key"] . "</A></TD></TR>\n";
      if (! ignoringtime ($problem)) {
        if ($value["setup_time"] != $value["start_time"])
          echo "<TR><TD>Setup Start Time</TD><TD>" .
               $value["setup_time"] . "</TD></TR>\n";
        echo "<TR><TD>Task Start Time</TD><TD>" .
             $value["start_time"] . "</TD></TR>\n";
        echo "<TR><TD>Task End Time</TD><TD>" .
             $value["end_time"] . "</TD></TR>\n";
        if ($value["wrapup_time"] != $value["end_time"])
          echo "<TR><TD>Wrapup End Time</TD><TD>" .
               $value["wrapup_time"] . "</TD></TR>\n";
      }
      echo "<TR><TD>Frozen</TD><TD>" .
           $value["frozen"] . "</TD></TR>\n";
      echo "</TABLE>\n";
      echo "</td>";
      echo "</tr>";
      $act = ($value["frozen"] == "yes") ?
             "Unfreeze Assignment" : "Freeze Assignment";
?>
<tr>
 <td align=center><p><p>
<FORM METHOD="get" ACTION="task.php">
  <INPUT TYPE=hidden NAME="taskname" VALUE="<? echo $taskname ?>">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="taskobject" VALUE="<? echo $taskobject ?>">
  <INPUT TYPE=hidden NAME="taskkey" VALUE="<? echo $taskkey ?>">
  <INPUT TYPE=hidden NAME="resourceobject" VALUE="<? echo $resourceobject ?>">
  <INPUT TYPE=hidden NAME="resourcekey" VALUE="<? echo $resourcekey ?>">
  <INPUT TYPE=submit VALUE="<? echo $act ?>" NAME="freezeaction"><p>
<?
      if ((! ismultitask ($problem)) &&
          (! isgrouped ($problem)) &&
          (! constReferencesResource ("task_duration")) &&
          (! constReferencesResource ("setup_duration")) &&
          (! constReferencesResource ("wrapup_duration"))) {
        echo "<SELECT name=\"reassignment\">\n";
        $result = mysql_db_query ("vishnu_prob_" . $problem,
                      "select resource_key from capabilities where " .
                      "task_key = \"" . $taskname . "\";");
        while ($value = mysql_fetch_row ($result))
          if (($aval["resource_key"] == $value[0]) ||
              isFree ($value[0], $aval["setup_time"], $aval["wrapup_time"]))
            echo "<OPTION " . (($aval["resource_key"] == $value[0]) ?
                               "SELECTED> " : "> ") . $value[0] . "\n";
        echo "</SELECT>\n<INPUT TYPE=submit " .
             "VALUE=\"Reassign Task\" NAME=\"reassign\">\n";
      }
?>
</FORM>
 </td>
</tr>
<?
    }
?>

<tr>
 <td align=center>
<BR><B>Internal Data</B>
<p><TABLE BORDER=1>
<TR>
  <TD><B>Field Name</B></TD>
  <TD><B>Value</B></TD>
</TR>
<?
    printobject ($problem, $taskobject, $taskname, $taskkey);
    mysql_close();
?>
</TABLE>
 </td>
</tr>
<tr>
 <td align=center>
  <br>
  <? linkToProblem ($problem); ?>
 </td>
</tr>
</TABLE>
<? } ?>
