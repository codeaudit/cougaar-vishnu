<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Return XML representation of the scheduling specifications

  Header("Content-Type: text/xml");
  require ("specssupport.php");
  echo "<?xml version='1.0'?>\n";
  require ("clientlink.php");
  writeschedulingspecs ($problem);
  mysql_close();
?>
