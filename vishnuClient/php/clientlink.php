<?
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