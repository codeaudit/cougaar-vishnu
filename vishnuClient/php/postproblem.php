<?
  // An external client uses this URL to write a problem into the database

  Header("Content-Type: text/plain");
  require ("parseproblem.php");
  echo parseproblem ($data) . "\n";
?>
