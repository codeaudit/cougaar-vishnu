<?
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

  function mainContent () { 
    global $problem, $taskkey, $taskname, $taskobject, $resourcekey;
    global $resourcename, $resourceobject, $freezeaction, $action;
    global $norightbar;

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
    
  if ($freezeaction == "Freeze")
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "update assignments set frozen = \"yes\" where " .
                "task_key = \"" . $taskname . "\";");
  if ($freezeaction == "Unfreeze")
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "update assignments set frozen = \"no\" where " .
                "task_key = \"" . $taskname . "\";");
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
    $act = ($value["frozen"] == "yes") ? "Unfreeze" : "Freeze";
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
  <INPUT TYPE=submit VALUE="<? echo $act ?>" NAME="freezeaction">
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
  global $problem;
  global $taskobject;
  global $taskname;
  global $taskkey;
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
