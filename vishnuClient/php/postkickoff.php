<?
  Header("Content-Type: text/plain");
  require ("utilities.php");

  if ($password == "nopassword")
    $password = "";

  $mysql_link = mysql_connect ("localhost",$username,$password);
  $value = getschedulerstatus ($problem);

  if ($value && ($value["percent_complete"] != 100) &&
      ($value["percent_complete"] != -1)) {
    $result = "FAILURE: username=" . $value["username"] .
         " percent_complete=" . $value["percent_complete"];
  } else {
    $number = -1;
    if ($value)
      $number = deletecurrentrequest ($problem);
    insertrequest ($problem, $username, $number + 1, $legalhosts);
    $result = "SUCCESS\n";
  }
  mysql_close();

  return $result;
?>
