<?
  Header("Content-Type: text/plain");
  $mysql_link = mysql_connect ("localhost", $user, $password);
  mysql_db_query ("vishnu_central", "delete from request_lock");
  mysql_close();
?>
