<?
  // Return XML representation of the scheduling specifications

  Header("Content-Type: text/xml");
  require ("specssupport.php");
  echo "<?xml version='1.0'?>\n";
  require ("clientlink.php");
  writeschedulingspecs ($problem);
  mysql_close();
?>
