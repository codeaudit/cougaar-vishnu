<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// An external client uses this URL to request a scheduler to run

  Header("Content-Type: text/plain");
  require ("utilities.php");
  require ("clientlink.php");

  $value = getschedulerstatus ($problem);
  if ($value && ($value["percent_complete"] != 100) &&
      ($value["percent_complete"] != -1)) {
    $result = "FAILURE: username=" . $value["username"] .
         " percent_complete=" . $value["percent_complete"];
  } else {
    $number = -1;
    if ($value)
      $number = deletecurrentrequest ($problem);
    insertrequest ($problem, $username, $number + 1, $legalhosts);
    $result = "SUCCESS\n";
  }
  mysql_close();

  return $result;
?>
