<?
  $mysql_link = mysql_connect ("localhost",$user,$password);
  $result = mysql_db_query ("vishnu_central",
              "select percent_complete from scheduler_request where " .
              "problem = \"" . $problem ."\" and number = $number;");
  $value = mysql_fetch_row ($result);
  if ((! $value) || ($value[0] == -1))
    echo "canceled\n";
  else
    mysql_db_query ("vishnu_central",
              "update scheduler_request set percent_complete=" .
              $percent_complete . ", error_message=" .
              ($message ? ("\"" . $message . "\"") : "NULL") .
              " where problem = \"" . $problem . "\";");
?>
