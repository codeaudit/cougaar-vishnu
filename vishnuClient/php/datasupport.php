<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// This file provides functions for writing of metadata and data.
// It is in the form fed into the web server, not the format fed
// into the scheduler.

  function writedataformat ($problem) {
    echo "<DATAFORMAT>\n";
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select * from objects where is_predefined=\"false\";");
    while ($value = mysql_fetch_array ($result)) {
      echo "<OBJECTFORMAT name=\"" . $value["name"] . "\" is_task=\"" .
           $value["is_task"] . "\" is_resource=\"" . $value["is_resource"] .
           "\" >\n";
      $result2 = mysql_db_query ("vishnu_prob_" . $problem,
                                 "select * from object_fields where " .
                                 "object_name = \"" . $value["name"] . "\";");
      while ($value2 = mysql_fetch_array ($result2)) {
        if ($value2["field_name"] != "internal_key")
          echo "<FIELDFORMAT name=\"" . $value2["field_name"] .
               "\" datatype=\"" . $value2["datatype"] .
               "\" is_subobject=\"" . $value2["is_subobject"] .
               "\" is_globalptr=\"" . $value2["is_globalptr"] .
               "\" is_list=\"" . $value2["is_list"] .
               "\" is_key=\"" . $value2["is_key"] . "\" />\n";
      }
      mysql_free_result ($result2);
      echo "</OBJECTFORMAT>\n";
    }
    mysql_free_result ($result);
    echo "</DATAFORMAT>\n";
  }

  function writeobject ($type, $key, $problem) {
    echo "<OBJECT type=\"" . $type . "\" >\n";
    $result2 = mysql_db_query ("vishnu_prob_" . $problem,
                  "select * from obj_" . $type . " where obj_" .
                  keyfortype2 ($type, $problem) . " = \"" . $key . "\";");
    $value2 = mysql_fetch_array ($result2);
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select * from object_fields where object_name = \"" .
                  $type . "\";");
    while ($value = mysql_fetch_array ($result)) {
      $name = $value["field_name"];
      if ($name == "internal_key")
        continue;
      $fvalue = $value2["obj_" . $name];
      if ($value["is_list"] == "true") {
        echo "<FIELD name=\"" . $name . "\" >\n<LIST>\n";
        $values = $fvalue ? explode ("*%*", $fvalue) : array();
        for ($i = 0; $i < sizeof ($values); $i++) {
          if ($value["is_subobject"] == "false")
            echo "<VALUE value=\"" . $values[$i] . "\" />\n";
          else {
            echo "<VALUE>\n";
            writeobject ($value["datatype"], $values[$i], $problem);
            echo "</VALUE>\n";
          }
        }
        echo "</LIST>\n</FIELD>\n";
      } else if ($value["is_subobject"] == "false") {
        echo "<FIELD name=\"" . $name . "\" value=\"" . $fvalue . "\" />\n";
      } else {
        echo "<FIELD name=\"" . $name . "\" >\n";
        writeobject ($value["datatype"], $fvalue, $problem);
        echo "</FIELD>\n";
      }
    }
    mysql_free_result ($result);
    mysql_free_result ($result2);
    echo "</OBJECT>\n";
  }

  function gettoptypes ($problem) {
    $types = array();
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select name from objects where is_task=\"true\";");
    while ($value = mysql_fetch_array ($result))
      $types[] = $value["name"];
    mysql_free_result ($result);
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select name from objects where is_resource=\"true\";");
    while ($value = mysql_fetch_array ($result))
      $types[] = $value["name"];
    mysql_free_result ($result);
    return $types;
  }

  $keys = array();

  function keyfortype2 ($type, $problem) {
    global $keys;
    if ($key = $keys["type"])
      return $key;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select field_name from " .
                              "object_fields where object_name=\"" .
                              $type . "\" and is_key=\"true\";");
    $value = mysql_fetch_row ($result);
    $key = $value[0];
    $keys[$type] = $key;
    mysql_free_result ($result);
    return $key;
  }

  function writedata ($problem) {
    echo "<DATA>\n";
    echo "<CLEARDATABASE />\n";

    // do window
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from window;");
    $value = mysql_fetch_array ($result);
    echo "<WINDOW ";
    if ($value["start_time"])
      echo "starttime=\"" . $value["start_time"] . "\" ";
    if ($value["end_time"])
      echo "endtime=\"" . $value["end_time"] . "\" ";
    echo "/>\n";
    mysql_free_result ($result);

    // do objects
    echo "<NEWOBJECTS>\n";
    $types = gettoptypes ($problem);
    for ($i = 0; $i < sizeof ($types); $i++) {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                     "select obj_" . keyfortype2 ($types[$i], $problem) .
                     " from obj_" . $types[$i] . ";");
      while ($value = mysql_fetch_row ($result))
        writeobject ($types[$i], $value[0], $problem);
      mysql_free_result ($result);
    }
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from globals;");
    while ($value = mysql_fetch_array ($result)) {
      echo "<GLOBAL name=\"" . $value["name"] . "\" >\n";
      writeobject ($value["datatype"], $value["id"], $problem);
      echo "</GLOBAL>\n";
    }
    mysql_free_result ($result);
    echo "</NEWOBJECTS>\n";

    echo "</DATA>\n";
  }
?>
