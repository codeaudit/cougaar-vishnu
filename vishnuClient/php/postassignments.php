<?
  // Scheduler uses this URL to write its assignments to the database

  Header("Content-Type: text/plain");
  require ("clientlink.php");
  require ("utilities.php");

  function getsql ($a, $is_multitask, $window) {
    if ($is_multitask)
      return "delete from $a;";
    else {
      $sql = "delete from $a where (frozen = \"no\") or ";
      if ($window["end_time"])
        return $sql . "((setup_time < \"" . $window["end_time"] . "\") " .
               "and (wrapup_time > \"" . $window["start_time"] . "\"));";
      else
        return $sql . "(wrapup_time > \"" . $window["start_time"] . "\");";
    }
  }

  $is_multitask = ismultitask ($problem);
  $window = getwindow ($problem);
  $result = mysql_db_query ("vishnu_prob_" . $problem,
                getsql ("assignments", $is_multitask, $window));
  $result = mysql_db_query ("vishnu_prob_" . $problem,
                getsql ("multitaskassignments", $is_multitask, $window));
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

  function endHandler ($parser, $name) {
  }

  $parser = xml_parser_create();
  xml_set_element_handler ($parser, "startHandler", "endHandler");
  xml_parse ($parser, StripSlashes($data));
  echo "SUCCESS\n";
?>


