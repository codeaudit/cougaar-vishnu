<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Write out an XML representation of the scheduling specifications

  function printobj ($type, $id) {
    global $problem;
    if ($type == "operator") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "select * from operator where id = $id;");
      $value = mysql_fetch_array ($result);
      if ($value) {
        echo "<OPERATOR operation=\"" .
             htmlspecialchars ($value["operation"]) . "\" >\n";
        printobj ($value["first_arg_type"], $value["first_arg_index"]);
        printobj ($value["second_arg_type"], $value["second_arg_index"]);
        printobj ($value["third_arg_type"], $value["third_arg_index"]);
        printobj ($value["fourth_arg_type"], $value["fourth_arg_index"]);
        echo "</OPERATOR>\n";
      }
      mysql_free_result ($result);
    } else if ($type == "literal") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "select * from literal where id = $id;");
      $value = mysql_fetch_array ($result);
      echo "<LITERAL " . "value=\"" . $value["value"] . "\" " .
           "type=\"" . $value["lit_type"] . "\" " .
           "datatype=\"" . $value["datatype"] . "\" />\n";
      mysql_free_result ($result);
    }
  }

  function printobj2 ($tag, $name, $value2) {
    $type = $value2[$name . "_type"];
    if ($type) {
      $id = $value2[$name . "_index"];
      echo "<" . $tag . ">\n";
      printobj ($type, $id);
      echo "</" . $tag . ">\n";
    }
  }

  function writeschedulingspecs ($theproblem) {
    global $problem;
    $problem = $theproblem;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from constraints;");
    $value = mysql_fetch_array ($result);
    mysql_free_result ($result);
  
    echo "<SPECS direction=\"" . $value["opt_direction"] .
           "\" multitasking=\"" . $value["multitasking"] . "\" >\n";
    printobj2 ("OPTCRITERION", "opt_criterion", $value);
    printobj2 ("DELTACRITERION", "delta_criterion", $value);
    printobj2 ("BESTTIME", "best_time", $value);
    printobj2 ("TASKDURATION", "task_duration", $value);
    printobj2 ("SETUPDURATION", "setup_duration", $value);
    printobj2 ("WRAPUPDURATION", "wrapup_duration", $value);
    printobj2 ("CAPABILITY", "capability", $value);
    printobj2 ("PREREQUISITES", "prerequisites", $value);
    printobj2 ("TASKUNAVAIL", "task_unavail", $value);
    printobj2 ("RESOURCEUNAVAIL", "resource_unavail", $value);
    printobj2 ("CAPACITYCONTRIB", "capacity_contrib", $value);
    printobj2 ("CAPACITYTHRESH", "capacity_thresh", $value);
    printobj2 ("GROUPABLE", "groupable", $value);
    printobj2 ("LINKED", "linked", $value);
    printobj2 ("LINKTIMEDIFF", "link_time_diff", $value);
    printobj2 ("TASKTEXT", "task_text", $value);
    printobj2 ("GROUPEDTEXT", "grouped_text", $value);
    printobj2 ("ACTIVITYTEXT", "activity_text", $value);
  
    echo "<COLORTESTS>\n";
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from color_tests;");
    while ($value = mysql_fetch_array ($result)) {
      echo "<COLORTEST color=\"" . $value["color"] .
           "\" obj_type=\"" . $value["obj_type"] .
           "\" title=\"" . $value["title"] . "\" >\n";
      printobj ($value["test_type"], $value["test_id"]);
      echo "</COLORTEST>\n";
    }
    mysql_free_result ($result);
    echo "</COLORTESTS>\n";
    echo "</SPECS>\n";
  }
?>
