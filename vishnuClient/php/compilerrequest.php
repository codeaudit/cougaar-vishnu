<?
  Header("Content-Type: text/xml");
  require ("utilities.php");
  echo "<?xml version='1.0'?>\n";
  echo "<COMPILERREQUEST>\n";

  // user and password are global post variables
  $mysql_link = mysql_connect ("localhost", $user, $password);

  $result = mysql_db_query ("vishnu_central",
                            "select * from compiler_request where " .
                            "status = \"outstanding\";");
    if (mysql_errno()) {
	$report = "Could not connect to database, ";
	$report .= mysql_errno () . ": " . mysql_error ();
	$report .= ", user=" . $user . " password=" . $password;
	$report .= ", sql was (database = " . "vishnu_central" . ") " .
                   "select * from compiler_request where " .
                   "status = \"outstanding\";";

	return $report;
    }

  $earliest = 0;
  while ($value = mysql_fetch_array ($result)) {
    $timestamp = maketime ($value["request_time"]);
    if (($earliest == 0) || ($timestamp < $earliest)) {
      $earliest = $timestamp;
      $problem = $value["problem"];
      $expression = $value["expression"];
      $spec = $value["which_spec"];
    }
  }
  mysql_free_result ($result);

  if ($earliest != 0) {
    echo "<PROBLEM name=\"" . $problem . "\" spec=\"" . $spec .
         "\" expression=\"" . htmlspecialchars($expression) . "\" />\n";
    $result = mysql_db_query ("vishnu_central",
                  "update compiler_request set status = \"processing\"" .
                  " where " . "problem = \"" . $problem . "\";");

    // write globals
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select name, datatype from globals;");
    while ($value = mysql_fetch_array ($result)) {
      echo "<GLOBAL name=\"" . $value[0] . "\" datatype=\"" .
           $value[1] . "\" />\n";
    }
    mysql_free_result ($result);

    // write object structure data
    $arr = gettaskandresourcetypes ($problem);
    echo "<TASKOBJECT name=\"" . $arr[0] . "\" />\n";
    echo "<RESOURCEOBJECT name=\"" . $arr[1] . "\" />\n";
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from objects;");
    while ($value = mysql_fetch_array ($result)) {
      echo "<OBJECT name=\"" . $value["name"] . "\" >\n";
      $fields = array();
      fieldsfortype ($problem, $value["name"], "", $fields);
      for ($i = 0; $i < sizeof($fields); $i++) {
        $globptr = ($fields[$i][2] == "true") ? "globalptr=\"t\"" : "";
        echo "<FIELD name=\"" . $fields[$i][0] . "\" type=\"" .
             $fields[$i][1] . "\" $globptr />\n";
      }
      echo "</OBJECT>\n";
    }
    mysql_free_result ($result);
  }

  echo "</COMPILERREQUEST>\n";
  mysql_close();
?>
