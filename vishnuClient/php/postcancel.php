<?
  Header("Content-Type: text/plain");
  require ("browserlink.php");
/*  require ("utilities.php"); */

//  if ($password == "nopassword")
//    $password = "";

  $mysql_link = mysql_connect ("localhost",$username,$password);
  mysql_db_query ("vishnu_central",
                  "update scheduler_request set percent_complete=-1 " .
                  "where  problem = \"" . $problem . "\";");
  mysql_close();
?>
