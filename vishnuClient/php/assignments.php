<?
  // assignments.php returns an XML representation of the current
  // assignments of tasks to resources.
  // This is used by an external client to get back the results of
  // a scheduling request.

  Header("Content-Type: text/xml");
  require ("utilities.php");
  require ("clientlink.php");

  $grouped = isgrouped ($problem);
  echo "<?xml version='1.0'?>\n";
  echo "<ASSIGNMENTS>\n";
  $result = mysql_db_query ("vishnu_prob_" . $problem,
  	        "select * from " .
                ($grouped ? "multitaskassignments;" : "assignments;"));
  while ($value = mysql_fetch_array ($result)) {
    echo ($grouped ? "<MULTITASK " :
                     "<ASSIGNMENT task=\"" . $value["task_key"] . "\" ") .
         "resource=\"" . $value["resource_key"] .
         "\" start=\"" . $value["start_time"] .
         "\" end=\"" . $value["end_time"] .
         "\" setup=\"" . $value["setup_time"] .
         "\" wrapup=\"" . $value["wrapup_time"] .
         ($grouped ? "\" >\n" : "\" />\n");
    if ($grouped) {
      $tasks = explode ("*%*", $value["task_keys"]);
      for ($i = 0; $i < sizeof($tasks); $i++)
        echo "  <TASK task=\"" . $tasks[$i] . "\" />\n";
      echo "</MULTITASK>\n";
    }
  }
  echo "</ASSIGNMENTS>\n";

  mysql_free_result ($result);
  mysql_close();
?>
