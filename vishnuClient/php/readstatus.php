<?
  // An external client uses this URL to read the current status of
  // a request scheduler run

  Header("Content-Type: text/plain");
  require ("clientlink.php");
  $result = mysql_db_query ("vishnu_central",
                            "select * from scheduler_request where " .
                            "problem = \"" . $problem . "\";");
  $value = mysql_fetch_array ($result);
  echo "percent_complete=" .
       ($value ? $value["percent_complete"] : -1) . "\n";
  if ($value["error_message"])
    echo "error=" . $value["error_message"] . "\n";
  mysql_free_result ($result);
  mysql_close();
?>
