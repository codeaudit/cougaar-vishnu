<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// This URL returns the problem specifications to a client

  require ("clientlink.php");
  require ("specssupport.php");
  require ("gaparmssupport.php");
  require ("datasupport.php");

  Header("Content-Type: text/xml");
  echo "<?xml version='1.0'?>\n";
  echo "<PROBLEM name=\"" . $problem . "\" >\n";
  writedataformat ($problem);
  writeschedulingspecs ($problem);
  writegaparms ($problem);
  writedata ($problem);
  echo "</PROBLEM>\n";

  mysql_close();
?>
