<?
  Header("Content-Type: text/xml");
  require ("utilities.php");
  echo "<?xml version='1.0'?>\n";
  echo "<CURRENTREQUEST>\n";

  // user and password are global post variables
  $mysql_link = mysql_connect ("localhost",$user,$password);

  $result = mysql_db_query ("vishnu_central",
                            "select * from scheduler_request where " .
                            "percent_complete = 0 order by request_time;");
  $earliest = 0;
  if ($result == 0) {
    echo "<br>Error accessing database vishnu central.\n";
    echo "User : " . $user . "\n";
    echo "Pass : " . $password . "\n";
    echo "Sql  : " . "select * from scheduler_request where " .
         "'percent_complete = 0' order by request_time;\n"; 
  }
  else {
    while ($value = mysql_fetch_array ($result)) {
      $problem = $value["problem"];
      $number = $value["number"];
      echo "<PROBLEM name=\"" . $problem . "\" number=\"" .
           $number . "\" />\n";
    }
  }

  mysql_free_result ($result);

  echo "</CURRENTREQUEST>\n";
  mysql_close();
?>
