<?
  Header("Content-Type: text/plain");

  if ($password == "nopassword")
    $password = "";

  require ("clientlink.php");

  function readstatus ($problem, $user="root", $password="") { 
    $result = mysql_db_query ("vishnu_central",
                              "select * from scheduler_request where " .
                              "problem = \"" . $problem . "\";");
    $value = mysql_fetch_array ($result);
    $retval = "percent_complete=" . ($value ? $value["percent_complete"] : -1) . "\n";
    mysql_free_result ($result);
    mysql_close();

    return $retval;
  }

  if ($user)
    echo readstatus ($problem, $user, $password);
  else 
    echo readstatus ($problem);
?>
