<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// This URL returns to a scheduler a list of all outstanding
// scheduling requests which it is sanctioned to handle.
// They are in order from oldest to most recent request.
// While the scheduler is deciding which to take, a lock is set.

  Header("Content-Type: text/xml");
  require ("utilities.php");
  require ("clientlink.php");
  echo "<?xml version='1.0'?>\n";
  echo "<CURRENTREQUEST>\n";

  $locklife = 8;
  $t = time();
  $d = makedate ($t);
  $t2 = $t - $locklife;
  mysql_db_query ("vishnu_central",
      "delete from request_lock where unix_timestamp(lock_time) < $t2;");
  mysql_db_query ("vishnu_central",
      "insert into request_lock values (\"$localhost\", \"$d\");");
  if (! mysql_errno()) {
    $result = mysql_db_query ("vishnu_central",
                  "select lock_time from request_lock order by lock_time");
    if ($result) {
      $value = mysql_fetch_row ($result);
      if ($value[0] != $d) {
        mysql_db_query ("vishnu_central",
            "delete from request_lock where lock_time = \"$d\";");
      }
      else {
        $result = mysql_db_query ("vishnu_central",
                      "select * from scheduler_request where " .
                      "percent_complete = 0 order by request_time;");
        $earliest = 0;
        while ($value = mysql_fetch_array ($result)) {
          if ($value["legal_hosts"]) {
            $legalhosts = explode (",", $value["legal_hosts"]);
            $found = 0;
            while (list ($key, $host) = each ($legalhosts)) {
              $host = trim ($host);
              if ($host == substr ($localhost, 0, strlen ($host))) {
                $found = 1;
                break;
              }
            }
            if (! $found)
              continue;
          }
          echo "<PROBLEM name=\"" . $value["problem"] . "\" number=\"" .
               $value["number"] . "\" />\n";
        }
      }
    }
  }
  echo "</CURRENTREQUEST>\n";
  mysql_close();
?>
