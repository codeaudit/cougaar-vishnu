<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// An external client uses this URL to add new data to an existing
// problem.

  Header("Content-Type: text/plain");
  require ("parsedata.php");
  echo parsedata ($data, $problem, 1) . "\n";
?>
