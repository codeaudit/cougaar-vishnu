<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// View the schedule graphics for all the resources on a single page

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
    if ((! $resourceobject) || (! $taskobject) ||
        (! $resourcekey) || (! $taskkey)) {
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
    }
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
    if (! $ignoretime) {
      $task_start = 0;
      $task_end = 0;
      for ($i = 0; $i < sizeof ($resources); $i++) {
        $window = resourcewindow ($problem, $ismultitask || $isgrouped,
                                  $resources[$i]);
        $t1 = $window["end_time"];
        if (($t1 != 0) && (($task_end == 0) || ($t1 > $task_end)))
          $task_end = $t1;
        $t1 = $window["start_time"];
        if (($t1 != 0) && (($task_start == 0) || ($t1 < $task_start)))
          $task_start = $t1;
      }
      $window = getwindow ($problem);
      $win_start = maketime ($window["start_time"]);
      if ($window["end_time"])
        $win_end = maketime ($window["end_time"]);
      else
        $win_end = $task_end;
      if ((! $start_time) && (! $end_time)) {
        $start_time = $win_start;
        $end_time = $win_end;
      }
      if ($start_time == $end_time)
        $ignoretime = 1;

      for ($i = 0; $i < sizeof ($resources); $i++)
        imagemap ($problem, $taskobject, $taskkey, $resourceobject,
                  $resourcekey, $end_time, $start_time,
                  $resources[$i], $isgrouped, $ismultitask);
    }

    echo "<TABLE CELLPADDING=5>\n";
    $t = time();
    $first = 1;
    if (! $ignoretime) {
      echo "<TR><TD colspan=2 align=center nowrap>";
      imageControls ("schedule", $problem, $resourceobject, $taskobject,
                     $resourcekey, $taskkey, "", $start_time, $end_time,
                     $win_start, $win_end, $task_start, $task_end);
      echo "</TD></TR>";
      if (! $ismultitask) {
        echo "<TR><TD></TD><TD align=center>";
        echo "<IMG SRC=\"legend.php?data=" . getlegenddata ($problem) . 
             "&t=" . $t . "\"><BR><BR>";
        echo "</TD></TR>\n";
      }
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
               "&setupdisplay=" . getdisplay ($problem, "setup") .
               "&wrapupdisplay=" . getdisplay ($problem, "wrapup") .
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

  function hintsForPage() {
    global $problem;
?>
This page displays the schedule for all of the resources in Gantt chart
form for the problem <? echo $problem; ?>.
It is accessible with one click from any page associated with this
problem using the navigation bar.
<p>
The Gantt charts all share the same time axis.
By default, the range of the time axis is the
scheduling window.  If there is no explicitly defined start time
for the scheduling window, then the start time is taken to be
the current time.
If there is no explicitly defined end time
for the scheduling window, then the end time is taken to be the
end time of the last assignment.
<p>
There are a variety of controls at the top to adjust the range of
the time axis:
<ul>
<li><b>Zoom In</b> will keep the center time the same while
halving the size of the range.
<li><b>Zoom Out</b> will keep the center time the same while
doubling the size of the range.
<li><b>Scroll Left</b> will set the center time equal to the
previous minimum (leftmost) time and will keep the same size of
the range.
<li><b>Scroll Right</b> will set the center time equal to the
previous maximum (rightmost) time and will keep the same size of
the range.
</li><b>Show Scheduling Window</b> will restore the time range
to the default.
<li><b>Show Assignment Range</b> will set the time range such that
the leftmost time is the start time of the earliest assignment and
the rightmost time is the end time of the latest assignment.
<li><b>Select New Time Range</b> will set the time range to be whatever
you enter explicitly into the "Start" and "End" boxes.
</ul>
<?
  }
?>

