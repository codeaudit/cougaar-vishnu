<?
  require ("browserlink.php");
  require ("utilities.php");
  require ("navigation.php");

  function getTitle () {
    global $resourcename;
    echo "Assignments for " . $resourcename;
  }
  function getHeader() {
  }
  function getSubheader() { 
    global $resourcename;
    echo "Viewing simultaneous assignments for " . $resourcename;
  }

  function printlist ($list) {
    echo "{";
    for ($j = 0; $j < sizeof ($list); $j++) {
      if ($j != 0)
        echo ", ";
      echo $list[$j];
    }
    echo "}";
  }

  function mainContent () {
    global $problem, $resourceobject, $taskobject, $resourcekey, $taskkey;
    global $resourcename, $start;
  $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select * from multitaskassignments where resource_key = \"" .
                $resourcename . "\" and start_time = \"" . $start . "\";");
  $value = mysql_fetch_array ($result);
  mysql_free_result ($result);

  echo "<BR><TABLE BORDER=1 CELLPADDING=1>\n";
  echo "<TR><TD>Interval Start Time</TD><TD>" .
       $value["start_time"] . "</TD></TR>\n";
  echo "<TR><TD>Interval End Time</TD><TD>" .
       $value["end_time"] . "</TD></TR>\n";
  $page = "task.php?problem=" . $problem . "&taskobject=" .
          $taskobject . "&taskkey=" . $taskkey . "&resourceobject=" .
          $resourceobject . "&resourcekey=" . $resourcekey . 
	  "&taskname=";
  $tasks = explode ("*%*", $value["task_keys"]);
  $arr = array();
  for ($i = 0; $i < sizeof ($tasks); $i++)
    $arr[] = "<A HREF=\"" . $page . urlencode ($tasks[$i]) .
             "\">" . $tasks[$i] . "</A>";
  echo "<TR><TD>Assigned Tasks</TD><TD>";
  printlist ($arr);
  echo "</TD></TR>\n";
//  echo "<TR><TD>Capacities Used</TD><TD>";
//  printlist ($value["capacities_used"]);
//  echo "</TD></TR>\n";
//  echo "<TR><TD>Capacities</TD><TD>";
//  printlist ($value["capacities"]);
//  echo "</TD></TR>\n";
  echo "</TABLE>\n";
  mysql_close();
  }
?>

