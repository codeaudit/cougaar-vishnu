<?
  require ("utilities.php");

  $mysql_link = mysql_connect ("localhost",$user,$password);
  $result = mysql_db_query ("vishnu_central",
              "select percent_complete from scheduler_request where " .
              "problem = \"" . $problem ."\" and number = $number;");
  $value = mysql_fetch_row ($result);
  if ((! $value) || ($value[0] == -1))
    echo "canceled\n";
  else {
    mysql_db_query ("vishnu_central",
              "update scheduler_request set percent_complete=" .
              $percent_complete . ", error_message=" .
              ($message ? ("\"" . $message . "\"") : "NULL") .
              " where problem = \"" . $problem . "\";");
    if ($message) {
      mysql_db_query ("vishnu_central",
          "insert into stack_traces values (\"$problem\", " .
          "\"$localhost\", \"" . makedate (time()) .
          "\", \"$message\", \"$trace\");");
      $max_traces = 2;
      $result = mysql_db_query ("vishnu_central",
                    "select trace_time from stack_traces order by trace_time");
      $excess = mysql_num_rows ($result) - $max_traces;
      if ($excess > 0) {
        for ($i = 0; $i < $excess; $i++)
          $value = mysql_fetch_row ($result);
        mysql_db_query ("vishnu_central",
            "delete from stack_traces where unix_timestamp(trace_time) " .
            "<= " . maketime ($value[0]) . ";");
      }
    }
  }
?>
