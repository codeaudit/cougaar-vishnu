<?
  $mysql_link = @mysql_connect ("localhost",$user,$password) or
	die ("Could not connect to mysql with user " . $user . 
	     " and password " . $password);
?>