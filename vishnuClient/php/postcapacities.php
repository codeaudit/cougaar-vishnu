<?
  Header("Content-Type: text/plain");
  $mysql_link = mysql_connect ("localhost",$user,$password);
  $result = mysql_db_query ("vishnu_prob_" . $problem,
                            "delete from capacities;");

  function startHandler ($parser, $name, $attribs) {
    global $problem;

    if ($name == "CAPACITY") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "insert into capacities values (\"" .
                                $attribs["ID"] . "\", \"" .
                                $attribs["VALUE"] . "\");");
    }
  }

  $parser = xml_parser_create();
  xml_set_element_handler ($parser, "startHandler", "");
  xml_parse ($parser, StripSlashes($data));
  echo "SUCCESS\n";
?>


