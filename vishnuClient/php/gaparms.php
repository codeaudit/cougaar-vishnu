<?
  Header("Content-Type: text/xml");
  require ("gaparmssupport.php");
  echo "<?xml version='1.0'?>\n";
  $mysql_link = mysql_connect ("localhost",$user,$password);
  writegaparms ($problem);
  mysql_close();
?>
