<?
  require ("browserlink.php");
  require ("assetutil.php");
?>
<HTML>
<HEAD>
   <TITLE><? echo "Asset Utilization Display for " . $problem ?></TITLE>
</HEAD>

<BODY>

<?
  if (! countassets($problem, 0))
    echo "<H2><DIV align=center>No assets are utilized</DIV></H2>";
  else
    displayassets($problem, $resourceobject, $resourcekey);

  echo "<DIV align=center>";
  linkToProblem ($problem); 
  echo "</DIV>";
  mysql_close();
?>

<?
function allschedulesnull($schedules) {
  for (reset($schedules); $key = key($schedules); next($schedules)) {
    $curr = $schedules[$key];
    if ($curr) 
      return 0;
  }
  return 1;
}

function displayassets($problem, $resourceobject, $resourcekey) {
  global $start_time, $end_time, $start_time2, $end_time2;

  $t = time();

  $ismultitask = ismultitask ($problem);
  $isgrouped = isgrouped ($problem);
  $resources = array();
  $result = mysql_db_query ("vishnu_prob_" . $problem,
               "select obj_" . $resourcekey . " from obj_" .
               $resourceobject . ";");
  while ($value = mysql_fetch_row ($result))
    $resources[] = $value[0];
  mysql_free_result ($result);

  if ($start_time2) {
    $start_time = strtotime ($start_time2);
    $end_time = strtotime ($end_time2);
  }
  if ((! $start_time) || (! $end_time)) {
    $window = getwindow ($problem);
    $start_time = maketime ($window["start_time"]);
    if ($window["end_time"]) {
      $end_time = maketime ($window["end_time"]);
    } else {
      $end_time = $start_time;
      for ($i = 0; $i < sizeof ($resources); $i++) {
        $window = resourcewindow ($problem, $ismultitask || $isgrouped,
                                  $resources[$i]);
        $t1 = $window["end_time"];
        if (($t1 != 0) && ($t1 > $end_time))
          $end_time = $t1;
      }
    }
  }

  $totalassets = countassets($problem, 0);
  $totalcapacity = countassets($problem, 1);
  $averageassets = countaverage($problem, $resourcekey, $resourceobject, 
                                ($isgrouped || $ismultitask), ($end_time - $start_time), 0);
  $averagecapacity = countaverage($problem, $resourcekey, $resourceobject, 
                                  ($isgrouped || $ismultitask), ($end_time - $start_time), 1);

  echo "<TABLE NUMCOLS=5>\n";

  echo "<TR><TD></TD><TD></TD><TD align=center>\n";
  imageControls ("assets", $problem, $resourceobject, $taskobject,
                 $resourcekey, $taskkey, $resourcename, $start_time,
                 $end_time);
  echo "</TD><TD></TD><TD></TD></TR>\n";

  // Display the title
  echo "<TR><TD></TD><TD></TD><TD>\n";
  echo "<H2 ALIGN=center>\n";
  echo "Asset Utilization Summary for " . $problem;
  echo "</H2>\n";
  echo "</TD><TD></TD><TD></TD></TR>\n";

  // Display the asset utilization vertical scale
  echo "<TR valign=bottom>";
  echo "<TD align=right><IMG SRC=\"vertlabels.php?cap=" . $totalassets . "&ispercentage=0&t=" . $t . "\"></TD>\n";
  echo "<TD align=right><IMG SRC=\"verttics.php?cap=" . $totalassets . "&ispercentage=0&t=" . $t . "\"></TD>\n";

  // Display the utilization graph overlays
  echo "<TD align=center>";
  echo "<IMG SRC=\"assetutilimage.php?problem=" . $problem . 
	  			   "&resourcekey=" . $resourcekey . 
	  			   "&resourceobject=" . $resourceobject . 
	  			   "&start_time=" . $start_time . 
	  			   "&end_time=" . $end_time . 
	  			   "&t=" . $t . "\"><BR>\n";
  echo "</TD>";

  // Display capacity utilization scale
  echo "<TD align=left><IMG SRC=\"verttics.php?cap=" . $totalcapacity . "&ispercentage=1&t=" . $t . "\"></TD>\n";
  echo "<TD align=left><IMG SRC=\"vertlabels.php?cap=" . $totalcapacity . "&ispercentage=1&t=" . $t . "\"></TD>\n";
  echo "</TR>";


  // Display tic marks and legend below utilization graph
  echo "<TR><TD></TD><TD></TD><TD align=center>";
  echo "<IMG SRC=\"tics.php?start_time=" . $start_time .
       "&end_time=" . $end_time . "&t=" . $t . "\"><BR>\n";
  echo "</TD></TR><TR><TD></TD><TD></TD><TD align=center>";
  echo "<IMG SRC=\"labels.php?start_time=" . $start_time .
       "&end_time=" . $end_time . "&t=" . $t . "\"><BR>\n";
  echo "</TD></TR>";


  // Display average information in nested table
  echo "<TR><TD></TD><TD></TD><TD align=center>";
    echo "<TABLE border=0>";
    echo "<TR>";
    echo "<TD><I>left scale - </I>&nbsp&nbsp&nbsp&nbsp&nbsp</TD>";
    echo "<TD><IMG SRC=\"rect.php?height=10&width=10&red=155&green=0&blue=155\">&nbsp&nbsp</TD>";
    echo "<TD><B>Number of assets in use </B></TD>";
    if ($totalassets > 0)
      printf("<TD><B>Average: %8.2f of %8d (%4.2f%%)</B></TD>", $averageassets, $totalassets, (100 * $averageassets / $totalassets));
    echo "</TR>";
    echo "<TR>";
    echo "<TD><I>right scale - </I>&nbsp&nbsp&nbsp&nbsp&nbsp</TD>";
    echo "<TD><IMG SRC=\"rect.php?height=10&width=10&red=0&green=0&blue=255\">&nbsp&nbsp</TD>";
    echo "<TD><B>Percentage asset capacity used </B>&nbsp&nbsp&nbsp&nbsp&nbsp</TD>";
    // printf("<B>Average: %8.2f of %8.2f (%4.2f%%)</B><BR>", $averagecapacity, $totalcapacity, (100 * $averagecapacity / $totalcapacity));
    if ($totalcapacity > 0)
      printf("<TD><B>Average: %4.2f%%</B></TD>", (100 * $averagecapacity / $totalcapacity));
    echo "</TR>";
    echo "</TABLE>";
  echo "</TD><TD></TD><TD></TD></TR>";

echo "</table>\n";

}
?>

</BODY>
</HTML>