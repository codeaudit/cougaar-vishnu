<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Scheduler uses this URL to write the capabilities used to the database

  Header("Content-Type: text/plain");
  require ("clientlink.php");

  $result = mysql_db_query ("vishnu_prob_" . $problem,
                            "delete from capabilities;");

  function startHandler ($parser, $name, $attribs) {
    global $problem;

    if ($name == "CAPABILITY") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "insert into capabilities values (\"" .
                                $attribs["TASK"] . "\", \"" .
                                $attribs["RESOURCE"] . "\");");
    }
  }

  $parser = xml_parser_create();
  xml_set_element_handler ($parser, "startHandler", "");
  xml_parse ($parser, StripSlashes($data));
  echo "SUCCESS\n";
?>
