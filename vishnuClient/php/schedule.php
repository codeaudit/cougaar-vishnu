<?
  require ("browserlink.php");
  require ("utilities.php");

  $norightbar = 1;
  $horizbar = 1;
  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Schedule for $problem";
  }
  function getHeader() {
  }
  function getSubheader() { 
    global $problem;
    echo "Schedule for $problem";
  }

  function mainContent () {
    global $problem, $resourceobject, $taskobject, $resourcekey, $taskkey;
    global $start_time, $end_time, $start_time2, $end_time2;
  $ismultitask = ismultitask ($problem);
  $isgrouped = isgrouped ($problem);
  $ignoretime = ignoringtime ($problem);
  $resources = array();
  $result = mysql_db_query ("vishnu_prob_" . $problem,
               "select obj_" . $resourcekey . " from obj_" .
               $resourceobject . " order by obj_" . $resourcekey . ";");
  while ($value = mysql_fetch_row ($result))
    $resources[] = $value[0];
  mysql_free_result ($result);
  if ($start_time2) {
    $start_time = strtotime ($start_time2);
    $end_time = strtotime ($end_time2);
  }
  if ((! $ignoretime) && (! $start_time) && (! $end_time)) {
    $window = getwindow ($problem);
    $start_time = maketime ($window["start_time"]);
    if ($window["end_time"])
      $end_time = maketime ($window["end_time"]);
    else {
      $end_time = $start_time;
      for ($i = 0; $i < sizeof ($resources); $i++) {
        $window = resourcewindow ($problem, $ismultitask || $isgrouped,
                                  $resources[$i]);
        $t1 = $window["end_time"];
        if (($t1 != 0) && ($t1 > $end_time))
          $end_time = $t1;
      }
    }
    if ($start_time == $end_time)
      $ignoretime = 1;
  }

  if (! $ignoretime)
    for ($i = 0; $i < sizeof ($resources); $i++)
      imagemap ($problem, $taskobject, $taskkey, $resourceobject,
                $resourcekey, $end_time, $start_time,
                $resources[$i], $isgrouped, $ismultitask);

  echo "<TABLE CELLPADDING=5>\n";
  $t = time();
  $first = 1;
  if ((! $ignoretime) && (! $ismultitask)) {
    echo "<TR><TD colspan=2 align=center nowrap>";
    imageControls ("schedule", $problem, $resourceobject, $taskobject,
                   $resourcekey, $taskkey, "", $start_time, $end_time);
    echo "</TD></TR>";
    echo "<TR><TD></TD><TD align=center>";
    echo "<IMG SRC=\"legend.php?data=" . getlegenddata ($problem) . 
         "&t=" . $t . "\"><BR><BR>";
    echo "</TD></TR>\n";
  }
  for ($i = 0; $i < sizeof ($resources); $i++) {
    $resourcename = $resources[$i];
    $text1 = "problem=" . $problem .
             "&resourcename=" . urlencode($resourcename); 
    $text2 = "start_time=" . $start_time .
             "&end_time=" . $end_time . "&t=" . $t;
    $reslink = "<a href=\"resource.php?" . $text1 . 
               "&resourceobject=" . $resourceobject . 
               "&resourcekey=" . $resourcekey . 
               "&taskobject=" . $taskobject . 
               "&taskkey=" . $taskkey . "\">" . $resourcename . "</a>";
    if ($ignoretime) {
      echo "<TR><TD>" . $reslink . "</TD><TD align=left>";
      assignmenttable ($problem, $taskobject, $taskkey, $resourceobject,
                       $resourcekey, $resourcename);
    }
    else {
      echo "<TR><TD valign=bottom nowrap>" . $reslink .
           "</TD><TD align=center>";
      if ($first)
        echo "<IMG SRC=\"labels.php?" . $text2 . "\"><BR>\n";
      $first = 0;
      echo "<IMG SRC=\"tics.php?" . $text2 . "\"><BR>\n";
      if ($ismultitask)
        echo "<IMG SRC=\"multitaskimage.php?" . $text1 . "&" . $text2 .
             "\" USEMAP=\"#" . $resourcename . "\">";
      else
        echo "<IMG SRC=\"image.php?" . $text1 . "&" . $text2 .
             "&setupdisplay=" . getsetupdisplay ($problem) .
             "&isgrouped=" . $isgrouped .
             "\" USEMAP=\"#" . $resourcename . "\">";
    }
    echo "</TD></TR>\n";
  }
  echo "</TABLE>\n";

  $taskstr = "obj_" . $taskobject;
  $keystr = $taskstr . ".obj_" . $taskkey;
  $result = mysql_db_query ("vishnu_prob_" . $problem,
              "select $keystr from $taskstr left join assignments " .
              "on $keystr = assignments.task_key where assignments" .
              ".task_key is NULL;");
  if (mysql_num_rows ($result) == 0)
    echo "<br><b><font size=+1>All Tasks Assigned</font></b>\n";
  else {
?>
<FORM METHOD="get" ACTION="task.php">
<b><font size=+1>Unassigned Tasks:&nbsp;</font></b>
<SELECT NAME="taskname">
<?
  while ($value = mysql_fetch_row ($result))
    echo "<OPTION> $value[0]";
?>
</SELECT>
<INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
<INPUT TYPE=hidden NAME="taskobject" VALUE="<? echo $taskobject ?>">
<INPUT TYPE=hidden NAME="taskkey" VALUE="<? echo $taskkey ?>">
<INPUT TYPE=hidden NAME="resourceobject" VALUE="<? echo $resourceobject ?>">
<INPUT TYPE=hidden NAME="resourcekey" VALUE="<? echo $resourcekey ?>">
<INPUT TYPE=submit VALUE="View" NAME="action">
</FORM>
<?
  }
  mysql_free_result ($result);

//  linkToProblem ($problem);
  mysql_close();
  }
?>

