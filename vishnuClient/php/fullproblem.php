<?
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
