<?
  Header("Content-Type: text/plain");
  require ("parsedata.php");

  // user and password are global post variables
  if ($user)
    echo parsedata ($data, $problem, 1, $user, $password) . "\n";
  else
    echo parsedata ($data, $problem, 1) . "\n";
?>
