<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// The expression compiler accesses this URL to find out the next
// expression for it to compile.
// Along with the expression is the context of the problem.
// It is all specified in XML format.

  Header("Content-Type: text/xml");
  require ("utilities.php");
  require ("clientlink.php");
  echo "<?xml version='1.0'?>\n";
  echo "<COMPILERREQUEST>\n";

  $result = mysql_db_query ("vishnu_central",
                            "select * from compiler_request where " .
                            "status = \"outstanding\";");
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
