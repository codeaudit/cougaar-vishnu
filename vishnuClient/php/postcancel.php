<?
  Header("Content-Type: text/plain");
//  require ("browserlink.php");
 require ("utilities.php");

  if ($password == "nopassword")
    $password = "";

  $mysql_link = mysql_connect ("localhost",$username,$password);
  mysql_db_query ("vishnu_central",
                  "update scheduler_request set percent_complete=-1 " .
                  "where  problem = \"" . $problem . "\";");
  $result = mysql_db_query ("vishnu_central",
              "select percent_complete from scheduler_request where " .
              "problem = '" . $problem . "'");
  $value = mysql_fetch_row ($result);

  echo "<message>OK, for " . $problem . " now percent complete is " . $value[0] . "</message>";

  mysql_close();
?>
