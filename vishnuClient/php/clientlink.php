<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Connect to database from non-browser client.
// This gets included in the file that needs it, and $user and
// $password must be set as global variables.

//  if ($password == "nopassword")
//    $password = "";

  if (! @mysql_connect ("localhost", $user, $password))
    die ("Could not connect to mysql with user $user and password $password");

  mysql_select_db ("vishnu_central");
  if (mysql_errno())
    die ("Could not connect to mysql with user $user and password $password");
?>