<?
  Header("Content-Type: text/xml");
  require ("specssupport.php");
  echo "<?xml version='1.0'?>\n";
  $mysql_link = mysql_connect ("localhost",$user,$password);
  writeschedulingspecs ($problem);
  mysql_close();
?>
