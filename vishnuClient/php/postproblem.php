<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// An external client uses this URL to write a problem into the database

  Header("Content-Type: text/plain");
  require ("parseproblem.php");
  echo parseproblem ($data) . "\n";
?>
