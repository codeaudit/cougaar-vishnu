<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// This URL returns the genetic algorithm parameters in XML format

  Header("Content-Type: text/xml");
  require ("gaparmssupport.php");
  require ("clientlink.php");
  echo "<?xml version='1.0'?>\n";
  writegaparms ($problem);
  mysql_close();
?>
