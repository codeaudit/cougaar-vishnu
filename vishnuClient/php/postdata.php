<?
  // An external client uses this URL to add new data to an existing
  // problem.

  Header("Content-Type: text/plain");
  require ("parsedata.php");
  echo parsedata ($data, $problem, 1) . "\n";
?>
