<?
  // After the scheduler has selected its problem, release the lock

  Header("Content-Type: text/plain");
  require ("clientlink.php");
  mysql_db_query ("vishnu_central", "delete from request_lock");
  mysql_close();
?>
