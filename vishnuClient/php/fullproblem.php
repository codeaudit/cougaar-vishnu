<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// This URL writes the problem specifications, or some portion of
// them, to a file.

  require ("browserlink.php");
  require ("specssupport.php");
  require ("gaparmssupport.php");
  require ("datasupport.php");

  Header("Content-Type: application/vishnu");
  echo "<?xml version='1.0'?>\n";

  if ($includeproblem) {
    echo "<PROBLEM name=\"" . $problem . "\" >\n";
    writedataformat ($problem);
    writeschedulingspecs ($problem);
    writegaparms ($problem);
  }

  if ($includedata)
    writedata ($problem);

  if ($includespecs)
    writeschedulingspecs ($problem);

  if ($includeproblem)
    echo "</PROBLEM>\n";

  mysql_close();
?>
