<?
  Header("Content-Type: text/plain");
  require ("parseproblem.php");
	
  if ($user)
    echo parseproblem ($data, $user, $password) . "\n";
  else
    echo parseproblem ($data) . "\n";
?>
