<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// After the scheduler has selected its problem, release the lock

  Header("Content-Type: text/plain");
  require ("clientlink.php");
  mysql_db_query ("vishnu_central", "delete from request_lock");
  mysql_close();
?>
