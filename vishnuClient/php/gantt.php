<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Functions shared by the different pages displaying Gantt charts


  function getimageheight() {
    return 20;
  }

  function getimagewidth() {
    return 700;
  }


  // make image map for resource
  function imagemap ($problem, $taskobject, $taskkey, $resourceobject,
                     $resourcekey, $end_time, $start_time,
                     $resourcename, $isgrouped, $ismultitask) {
    echo "<MAP name=\"" . $resourcename . "\">\n";
    $width = getimagewidth();
    $height = getimageheight();
    $total_secs = $end_time - $start_time;
    $secs_per_pixel = ((float) $total_secs) / ((float) $width);
    if ($secs_per_pixel == 0.0)
      $secs_per_pixel = 0.0001;
    $top = 2;
    $bottom = $height - 3;
    $multi2 = $isgrouped || $ismultitask;
  
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select * from " . ($multi2 ? "multitask" : "") .
                "assignments where resource_key = \"" . $resourcename . "\";");
    while ($value = mysql_fetch_array ($result)) {
      $left = (int) ((maketime ($value["setup_time"]) - $start_time) /
                     $secs_per_pixel);
      $right = (int) ((maketime ($value["wrapup_time"]) - $start_time) /
                      $secs_per_pixel);
      $multi = $multi2;
      if (! $multi)
        $taskname = $value["task_key"];
      else if ($isgrouped) {
        $multi = strpos ($value["task_keys"], "*%*");
        if (! $multi)
          $taskname = $value["task_keys"];
      }
      $str = "?problem=" . $problem . "&taskobject=" . $taskobject .
             "&taskkey=" . $taskkey . "&resourceobject=" .
             $resourceobject . "&resourcekey=" . $resourcekey;
      $str .= (! $multi) ?
              ("&taskname=" . urlencode ($taskname) . "\">\n") :
              ("&resourcename=" . urlencode ($resourcename) .
               "&start=" . urlencode ($value["start_time"]) . "\">\n");
      echo "<AREA shape=\"rect\" coords=\"" . $left . "," . $top . "," .
           $right . "," . $bottom . "\" href=\"" .
           ($multi ? "multiblock" : "task") . ".php" . $str;
    }
    echo "</MAP>\n";
    mysql_free_result ($result);
  }



  // find the placements of the tic marks for an image
  function getticmarks ($start, $end) {
    $width = getimagewidth();
    $poss_secs = array (2, 5, 10, 15, 30);
    $poss_mins = array (1, 2, 5, 10, 15, 30);
    $poss_hours = array (1, 2, 4, 8, 12);
    $poss_days = array (1, 2, 4, 7, 14, 30, 60, 120);

    $total = $end - $start;
    ($numsecs = getinterval ($total, 1, $poss_secs)) ||
    ($nummins = getinterval ($total, 60, $poss_mins)) ||
    ($numhours = getinterval ($total, 3600, $poss_hours)) ||
    ($numdays = getinterval ($total, 24 * 3600, $poss_days));

    $time = $start;
    $tics = array();
    $date = getdate ($time - 1);
    $secs = $numsecs ? $numsecs : 60;
    $time += $secs - ($date["seconds"] % $secs) - 1;

    if ($numsecs) {
      for ($i = $time; $i <= $end; $i += $numsecs)
        $tics[] = array ((int) (($width * ($i - $start)) / $total),
                         date ("i:s", $i));
      return $tics;
    }

    $date = getdate ($time - 60);
    $mins = $nummins ? $nummins : 60;
    $time += 60 * ($mins - ($date["minutes"] % $mins) - 1);

    if ($nummins) {
      for ($i = $time; $i <= $end; $i += 60 * $nummins)
        $tics[] = array ((int) (($width * ($i - $start)) / $total),
                         date ("H:i", $i));
      return $tics;
    }

    $date = getdate ($time - 3600);
    $hours = $numhours ? $numhours : 24;
    $time += 3600 * ($hours - ($date["hours"] % $hours) - 1);

    if ($numhours) {
      for ($i = $time; $i <= $end; $i += 3600 * $numhours)
        $tics[] = array ((int) (($width * ($i - $start)) / $total),
                         date ("n/j H:i", $i));
      return $tics;
    }

    $date = getdate ($time - 86400);
    $days = $numdays ? $numdays : 365;
    $time += 86400 * ($days - ($date["days"] % $days) - 1);

    if ($numdays) {
      for ($i = $time; $i <= $end; $i += 86400 * $numdays)
        $tics[] = array ((int) (($width * ($i - $start)) / $total),
                         date ("n/j", $i));
      return $tics;
    }
  }

  function getinterval ($total, $numsecs, $poss) {
    for ($i = 0; $i < sizeof($poss); $i++)
      if (($total / ($numsecs * $poss[$i])) < 10)
        return $poss[$i];
    return $unsetvariable;
  }


  function assignmenttable ($problem, $taskobject, $taskkey,
                            $resourceobject, $resourcekey, $resourcename) {
    $tasksperline = 8;
    $page = "task.php?problem=" . $problem . "&taskobject=" .
            $taskobject . "&taskkey=" . $taskkey . "&resourceobject=" .
            $resourceobject . "&resourcekey=" . $resourcekey . "&taskname=";
    echo "<TABLE BORDER=1 CELLPADDING=2>\n<TR>";
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select task_key from assignments where resource_key = \"" .
                $resourcename . "\";");
    while ($value = mysql_fetch_array ($result)) {
      if (($i != 0) && (($i % $tasksperline) == 0))
        echo "</TR>\n<TR>";
      echo "<TD><A HREF=\"" . $page . urlencode ($value[0]) .
           "\">" . $value[0] . "</A></TD>";
    }
    echo "</TR></TABLE>\n";
    mysql_free_result ($result);
  }


  function getlegenddata ($problem) {
    $colorsused = array();
    $colorspos = array();
    $keystr = "";
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select color, title from color_tests;");
    while ($value = mysql_fetch_row ($result)) {
      $pos = $colorspos[$value[0]];
      if (! $pos) {
        $colorsused[] = $value[0];
        $pos = sizeof ($colorsused);
        $colorspos[$value[0]] = $pos;
      }
      $keystr .= $pos . " " . $value[1] . "qxy";
    }
    mysql_free_result ($result);

    $colors = array();
    $result = mysql_db_query ("vishnu_central", "select * from color_defs;");
    while ($value = mysql_fetch_array ($result))
      $colors[$value["name"]] =
        array ($value["red"], $value["green"], $value["blue"]);
    mysql_free_result ($result);

    $colorstr = "";
    for ($i = 0; $i < sizeof($colorsused); $i++) {
      $colorstr .= $colors[$colorsused[$i]][0] . " " .
                   $colors[$colorsused[$i]][1] . " " .
                   $colors[$colorsused[$i]][2] . " ";
    }

    return urlencode ($keystr . " " . $colorstr);
  }


  // draw a rectangle with stripes
  function stripedrectangle ($im, $left, $top, $right, $bottom,
                             $color, $drawboundary, $goleft) {
    $width = $right - $left;
    $height = $bottom - $top;
    $sum = $width + $height;
    $spacing = 5;
    if ($drawboundary)
      imagerectangle ($im, $left, $top, $right, $bottom, $color);
    $mindim = ($width < $height) ? $width : $height;
    for ($i = $spacing; $i < $mindim; $i += $spacing)
      imageline ($im, $left, $goleft ? ($height - $i) : $i,
                 $left + $i, $goleft ? $height : 0, $color);
    for ( ; $i < $height; $i += $spacing)
      imageline ($im, $left, $goleft ? ($height - $i) : $i, $left + $width,
                 $goleft ? ($sum - $i) : ($i - $width), $color);
    for ( ; $i < $width; $i += $spacing)
      imageline ($im, $left + $i - $height, $goleft ? 0 : $height,
                 $left + $i, $goleft ? $height : 0, $color);
    for ( ; $i < $sum; $i += $spacing)
      imageline ($im, $left + $i - $height, $goleft ? 0 : $height,
                 $left + $width, $goleft ? ($sum - $i) : ($i - $width),
                 $color);
  }


  // find how to draw setup and wrapup times
  function getdisplay ($problem, $type) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select " . $type . "_display from constraints;");
    $value = mysql_fetch_row ($result);
    mysql_free_result ($result);
    return $value[0];
  }


  // Buttons and links for zooming and panning
  function imageControls ($page, $problem, $resourceobject, $taskobject,
                          $resourcekey, $taskkey,
                          $resourcename, $start_time, $end_time,
                          $win_start, $win_end, $task_start, $task_end) {
    $text = "<A HREF=\"" . $page . ".php?problem=" . $problem .
            "&resourceobject=" . $resourceobject .
            "&taskobject=" . $taskobject . "&taskkey=" . $taskkey .
            "&resourcekey=" . $resourcekey;
?>
<FORM METHOD="get" ACTION="<? echo $page; ?>.php">
<?
    if ($resourcename != "")
      $text .= "&resourcename=" . urlencode($resourcename);
    $tdiff = $end_time - $start_time;
    $t2 = (int) ($tdiff / 2);
    $t4 = (int) ($tdiff / 4);
    echo $text . "&start_time=" . ($start_time + $t4) . "&end_time=" .
         ($end_time - $t4) . "\">" . "Zoom In" . "</A>\n";
    echo " | ";
    echo $text . "&start_time=" . ($start_time - $t2) . "&end_time=" .
         ($end_time + $t2) . "\">" . "Zoom Out" . "</A>\n";
    echo " | ";
    echo $text . "&start_time=" . ($start_time - $t2) . "&end_time=" .
         ($end_time - $t2) . "\">" . "Scroll Left" . "</A>\n";
    echo " | ";
    echo $text . "&start_time=" . ($start_time + $t2) . "&end_time=" .
         ($end_time + $t2) . "\">" . "Scroll Right" . "</A>\n";
    echo " | ";
    echo $text . "&start_time=" . $win_start . "&end_time=" .
         $win_end . "\">" . "Show Scheduling Window" . "</A>\n";
    echo " | ";
    echo $text . "&start_time=" . $task_start . "&end_time=" .
         $task_end . "\">" . "Show Assignment Range" . "</A>\n";
    echo "<br><br>";
?>
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="resourceobject" VALUE="<? echo $resourceobject ?>">
  <INPUT TYPE=hidden NAME="taskobject" VALUE="<? echo $taskobject ?>">
  <INPUT TYPE=hidden NAME="resourcekey" VALUE="<? echo $resourcekey ?>">
  <INPUT TYPE=hidden NAME="taskkey" VALUE="<? echo $taskkey ?>">
  <? if ($resourcename != "")
    echo "<INPUT TYPE=hidden NAME=\"resourcename\" VALUE=\"" .
         $resourcename ."\">\n"; ?>
  Start:
  <INPUT TYPE=text name="start_time2" size=19
         value="<? echo strftime ("%m/%d/%Y %T", $start_time); ?>">
  &nbsp;End:
  <INPUT TYPE=text name="end_time2" size=19
         value="<? echo strftime ("%m/%d/%Y %T", $end_time); ?>">
  &nbsp;
  <INPUT TYPE=submit VALUE="Select New Time Range">
</FORM>
<?
  }

  function ganttHints() {
?>
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