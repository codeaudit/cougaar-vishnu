<?
  // This URL returns the genetic algorithm parameters in XML format

  Header("Content-Type: text/xml");
  require ("gaparmssupport.php");
  require ("clientlink.php");
  echo "<?xml version='1.0'?>\n";
  writegaparms ($problem);
  mysql_close();
?>
