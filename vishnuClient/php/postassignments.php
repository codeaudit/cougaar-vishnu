<?
  // Scheduler uses this URL to write its assignments to the database

  Header("Content-Type: text/plain");
  require ("clientlink.php");

  $result = mysql_db_query ("vishnu_prob_" . $problem,
                            "delete from assignments;");
  $result = mysql_db_query ("vishnu_prob_" . $problem,
                            "delete from multitaskassignments;");
  $result = mysql_db_query ("vishnu_prob_" . $problem,
                            "delete from activities;");

  function startHandler ($parser, $name, $attribs) {
    global $problem;

    if ($name == "ASSIGNMENT") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "insert into assignments values (\"" .
                                $attribs["TASK"] . "\", \"" .
                                $attribs["RESOURCE"] . "\", \"" .
                                $attribs["START"] . "\", \"" .
                                $attribs["TASKSTART"] . "\", \"" .
                                $attribs["TASKEND"] . "\", \"" .
                                $attribs["END"] . "\", \"" .
                                $attribs["FROZEN"] . "\", \"" .
                                $attribs["COLOR"] . "\", \"" .
                                $attribs["TEXT"] . "\");");
    }
    else if ($name == "MULTITASK") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "insert into multitaskassignments values (\"" .
                                $attribs["TASKS"] . "\", \"" .
                                $attribs["RESOURCE"] . "\", \"" .
                                $attribs["CAPACITIES_USED"] . "\", \"" .
                                $attribs["CAPACITIES"] . "\", \"" .
                                $attribs["START"] . "\", \"" .
                                $attribs["TASKSTART"] . "\", \"" .
                                $attribs["TASKEND"] . "\", \"" .
                                $attribs["END"] . "\", \"" .
                                $attribs["COLOR"] . "\", \"" .
                                $attribs["TEXT"] . "\");");
    }
    else if ($name == "ACTIVITY") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "insert into activities values (\"" .
                                $attribs["RESOURCE"] . "\", \"" .
                                $attribs["START"] . "\", \"" .
                                $attribs["END"] . "\", \"" .
                                $attribs["COLOR"] . "\", \"" .
                                $attribs["TEXT"] . "\");");
    }
  }

  $parser = xml_parser_create();
  xml_set_element_handler ($parser, "startHandler", "");
  xml_parse ($parser, StripSlashes($data));
  echo "SUCCESS\n";
?>


