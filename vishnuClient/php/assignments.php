<?
  Header("Content-Type: text/xml");
  require ("utilities.php");
  if ($password == "nopassword")
    $password = "";
  require ("clientlink.php");

  function assignments ($problem, $user="vishnu", $password="vishnu") {
    $grouped = isgrouped ($problem);
    $retval = "<?xml version='1.0'?>\n";
//   $mysql_link = mysql_connect ("localhost",$user,$password);  
    $retval .= "<ASSIGNMENTS>\n";
    $result = mysql_db_query ("vishnu_prob_" . $problem,
    	        "select * from " . ($grouped ? "multitaskassignments;" :
                                               "assignments;"));
    while ($value = mysql_fetch_array ($result)) {
      $retval .= ($grouped ? "<MULTITASK " :
                  "<ASSIGNMENT task=\"" . $value["task_key"] . "\" ") .
                 "resource=\"" . $value["resource_key"] .
                 "\" start=\"" . $value["start_time"] .
	         "\" end=\"" . $value["end_time"] .
	         "\" setup=\"" . $value["setup_time"] .
	         "\" wrapup=\"" . $value["wrapup_time"] .
                 ($grouped ? "\" >\n" : "\" />\n");
      if ($grouped) {
        $tasks = explode ("*%*", $value["task_keys"]);
        for ($i = 0; $i < sizeof($tasks); $i++)
          $retval .= "  <TASK task=\"" . $tasks[$i] . "\" />\n";
        $retval .= "</MULTITASK>\n";
      }
    }
    mysql_free_result ($result);
    $retval .= "</ASSIGNMENTS>\n";
    mysql_close();
  
    return $retval;
  }

  if ($user)
    echo assignments ($problem, $user, $password);
  else
    echo assignments ($problem);
?>
