<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// A whole variety of functions used by other URLs

  // get the field names of a particular object type and put in $fields
  function fieldsfortype ($problem, $objecttype, $prefix,
                          &$fields, $predefined = -1, $level = 0) {
    if ($predefined == -1)
      $predefined = getpredefinedobjects ($problem);
    if ($level > 20)
      return;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select * from object_fields where object_name = \"" .
                $objecttype . "\";");
    while ($value = mysql_fetch_array ($result)) {
      $field_name = $value["field_name"];
      if ($field_name == "internal_key")
        continue;
      $field_name = $prefix . $field_name;
      $islist = $value["is_list"] == "true";
      $stop = $islist || ($value["is_subobject"] == "false");
      $type = $islist ? ("list:" . $value["datatype"]) : $value["datatype"];
      if ($stop || $predefined[$type]) {
        $fields[] = array ($field_name, $type, $value["is_globalptr"]);
      }
      if (! $stop) {
        fieldsfortype ($problem, $type, $field_name . ".", $fields,
                       $predefined, $level + 1);
      }
    }
    mysql_free_result ($result);
  }


  // return array where $arr[<objname>] tells whether <objname> predefined
  function getpredefinedobjects ($problem) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select name from objects where is_predefined=\"true\";");
    $arr = array();
    while ($value = mysql_fetch_row ($result))
      $arr[$value[0]] = 1;
    mysql_free_result ($result);
    return $arr;
  }


  // get all the field values of an object and put in $fields
  function fieldsforobject ($problem, $objecttype, $objectname,
                            $prefix, $key, $level, &$fields,
                            $doublyreport, $justfullobjects,
                            $restrictfields, $topleveltype,
                            &$cachedformats) {
    $restrict = $restrictfields[$topleveltype];
    $result2 = mysql_db_query ("vishnu_prob_" . $problem,
                  "select * from obj_" . $objecttype . " where obj_" .
                  $key . " = \"" . $objectname . "\";");
    if (!$result2) 
      return;
    $value2 = mysql_fetch_array ($result2);
    mysql_free_result ($result2);

    $format = $cachedformats [$objecttype];
    if (! $format) {
      $format = array();
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                    "select * from object_fields where object_name = \"" .
                    $objecttype . "\";");
      while ($value = mysql_fetch_array ($result))
        $format[] = $value;
      $cachedformats [$objecttype] = $format;
      mysql_free_result ($result);
    }

    for ($i = 0; $i < sizeof ($format); $i++) {
      $value = $format[$i];
      $field_name = $value["field_name"];
      if ($field_name == "internal_key")
        continue;
      $field_value = $value2["obj_" . $field_name];
      $field_name = $prefix . $field_name;
      $doreport = (! $restrictfields) || $restrict[$field_name] ||
                  ($field_name == $key) || $doublyreport[$topleveltype];
      if ($value["is_list"] == "true") {
        if (! $doreport)
          continue;
        $list = $field_value ? explode ("*%*", $field_value) : array();
        $fields[] = array ("field_name"=>$field_name,
                           "list"=>$list,
                           "islist"=>1,
                           "subobjects"=>($value["is_subobject"] == "true"),
                           "datatype"=>$value["datatype"],
                           "iskey"=>($field_name == $key),
                           "level"=>$level);
      } else if ($value["is_subobject"] == "false") {
        if ($doreport)
          $fields[] = array ("field_name"=>$field_name,
                             "value"=>$field_value,
                             "datatype"=>$value["datatype"],
                             "iskey"=>($field_name == $key),
                             "isglobalptr"=>($value["is_globalptr"] == "true"),
                             "level"=>$level);
      } else if ($field_value) {
        if ($doreport && ($doublyreport[$value["datatype"]] ||
                          $justfullobjects[$value["datatype"]]))
          $fields[] = array ("field_name"=>$field_name,
                             "objvalue"=>$field_value,
                             "datatype"=>$value["datatype"],
                             "iskey"=>($field_name == $key),
                             "level"=>$level);
        if (! $justfullobjects[$value["datatype"]])
          fieldsforobject ($problem, $value["datatype"], $field_value,
                           $field_name . ".", "internal_key", $level + 1,
                           $fields, $doublyreport, $justfullobjects,
                           $restrictfields, $topleveltype, $cachedformats);
      }
    }
  }


  // Which object types to display in non-standard way
  function specialdisplaytypes() {
    return array ("xy_coord"=>1, "latlong"=>1, "matrix"=>1);
  }


  // display the object fields inside a table
  function printobject ($problem, $objecttype, $objectname, $key) {
    $fields = array();
    $formats = array();
    $specialobjs = specialdisplaytypes();
    fieldsforobject ($problem, $objecttype, $objectname, "", $key, 0,
                     $fields, $empty, $specialobjs, $dummy, $objecttype,
                     $formats);
    if (($objecttype == "xy_coord") && (! $nospecial)) {
      echo "(" . $fields[0]["value"] . ", " . $fields[1]["value"] . ")" ;
    }
    else if (($objecttype == "latlong") && (! $nospecial)) {
      $lat = $fields[0]["value"];
      $long = $fields[1]["value"];
      echo abs($lat) . (($lat < 0) ? "S" : "N") . " " .
           abs($long) . (($long < 0) ? "W" : "E");
    }
    else if (($objecttype == "matrix") && (! $nospecial)) {
      echo "<TABLE BORDER=1>\n";
      $k = 0;
      for ($i = 0; $i < $fields[0]["value"]; $i++) {
        echo "<TR>\n";
        for ($j = 0; $j < $fields[1]["value"]; $j++) {
          echo "<TD>\n";
          echo $fields[2]["list"][$k++];
          echo "</TD>\n";
        }
        echo "</TR>\n";
      }
      echo "</TABLE>\n";
    }
    else {
      for ($i = 0; $i < sizeof ($fields); $i++) {
        echo "<TR><TD>" . $fields[$i]["field_name"] . "</TD><TD>";
        if ($fields[$i]["value"] && $fields[$i]["isglobalptr"])
          echo "<A HREF=\"otherdata.php?dataname=" . $fields[$i]["value"] .
               "&problem=" . $problem . "&action=View\" >" .
               $fields[$i]["value"] . "</A>";
        else if ($fields[$i]["objvalue"])
          printobject ($problem, $fields[$i]["datatype"],
                       $fields[$i]["objvalue"], "internal_key");
        else if (! $fields[$i]["islist"])
          echo $fields[$i]["value"];
        else if (sizeof ($fields[$i]["list"]) == 0)
          echo "&nbsp;";
        else if (! $fields[$i]["subobjects"]) {
//          echo "{" . $fields[$i]["list"][0];
//          for ($j = 1; $j < sizeof ($fields[$i]["list"]); $j++)
//            echo ", " . $fields[$i]["list"][$j];
//          echo "}";
          for ($j = 0; $j < sizeof ($fields[$i]["list"]); $j++)
            echo ($j ? ", " : "") . $fields[$i]["list"][$j];
        }
        else if ($specialobjs[$fields[$i]["datatype"]]) {
          echo "{";
          for ($j = 0; $j < sizeof ($fields[$i]["list"]); $j++) {
            if ($j != 0)
              echo ", ";
            printobject ($problem, $fields[$i]["datatype"],
                         $fields[$i]["list"][$j], "internal_key");
          }
          echo "}";
        }
        else {
          for ($j = 0; $j < sizeof ($fields[$i]["list"]); $j++) {
            echo "<TABLE BORDER=1>\n";
            printobject ($problem, $fields[$i]["datatype"],
                         $fields[$i]["list"][$j], "internal_key");
            echo "</TABLE>\n";
          }
        }
        echo  "</TD></TR>\n";
      }
    }
  }


  function replaceSubstring ($str, $sub1, $sub2) {
    $str2 = "";
    while ($pos = strpos ($str, $sub1)) {
      $str2 .= substr ($str, 0, $pos) . $sub2;
      $str = substr ($str, $pos + strlen ($sub1));
    }
    return $str2 . $str;
  }


  // return array size 2 containing the task object name and resource obj name
  function gettaskandresourcetypes ($problem) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select task_object, resource_object from constraints;");
    $value = mysql_fetch_array ($result);
    $taskobject = $value[0];
    $resourceobject = $value[1];
    mysql_free_result ($result);
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from objects;");
    while ($value = mysql_fetch_array ($result)) {
      if ($value["is_task"] == "true" && (! $taskobject))
        $taskobject = $value["name"];
      if ($value["is_resource"] == "true" && (! $resourceobject))
        $resourceobject = $value["name"];
    }
    mysql_free_result ($result);
    return array ($taskobject, $resourceobject);
  }


  // convert from datetime mysql format to UNIX timestamp (seconds since 1970)
  function maketime ($date) {
    return mktime (substr ($date, 11, 2), substr ($date, 14, 2),
                   substr ($date, 17, 2), substr ($date, 5, 2),
                   substr ($date, 8, 2), substr ($date, 0, 4));
  }

  // convert from UNIX timestamp to mysql format
  function makedate ($time) {
    return date ("Y-m-d H:i:s", $time);
  }


  // find start and end times for problem
  function getwindow ($problem) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from window;");
    $value = mysql_fetch_array ($result);
    if ((! $value) || (! $value["start_time"]) ||
        ($value["start_time"] == "NULL"))
      $window["start_time"] = makedate (time());
    else
      $window["start_time"] = $value["start_time"];
    if ($value && ($value["end_time"] != "NULL"))
      $window["end_time"] = $value["end_time"];
    mysql_free_result ($result);

    return $window;
  }


  // return array with values start_time and end_time
  function resourcewindow ($problem, $multi, $resourcename) {
    $mintime = 0;
    $maxtime = 0;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select setup_time, wrapup_time from " .
                ($multi ? "multitask" : "") . "assignments where " .
                "resource_key = \"" . $resourcename . "\";");
    while ($value = mysql_fetch_array ($result)) {
      $t0 = maketime ($value[0]);
      $t1 = maketime ($value[1]);
      if (($mintime == 0) || ($t0 < $mintime))
        $mintime = $t0;
      if (($maxtime == 0) || ($t1 > $maxtime))
        $maxtime = $t1;
    }
    mysql_free_result ($result);
    return array ("start_time"=>$mintime, "end_time"=>$maxtime);
  }


  // determine whether pure assignment problem
  function ignoringtime ($problem) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select task_duration_index, setup_duration_index, " .
                  "wrapup_duration_index, task_unavail_index " .
                  "from constraints;");
    $value = mysql_fetch_row ($result);
    mysql_free_result ($result);
    if ((! $value[0]) && (! $value[1]) && (! $value[2]) && (! $value[3]))
      return true;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select multitasking from constraints;");
    $value = mysql_fetch_row ($result);
    mysql_free_result ($result);
    return $value[0] == "ignoring_time";
  }


  function ismultitask ($problem) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select multitasking from constraints;");
    $value = mysql_fetch_row ($result);
    mysql_free_result ($result);
    return $value[0] == "ungrouped";
  }


  function isgrouped ($problem) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select multitasking from constraints;");
    $value = mysql_fetch_row ($result);
    mysql_free_result ($result);
    return $value[0] == "grouped";
  }


  function isNameLegal ($name) {
    $name = strtolower ($name);
    for ($i = 0; $i < strlen ($name); $i++) {
      $str = substr ($name, $i, 1);
      if (($str >= "a") && ($str <= "z"))
        continue;
      if ($str == "_")
        continue;
      if (($i != 0) && ($str >= "0") && ($str <= "9"))
        continue;
      return 0;
    }
    return 1;
  }


  function checkValid ($value, $type) {
    if ($type == "boolean")
      return ($value == "true") || ($value == "false");
    if ($type == "number") {
      if (strlen ($value) == 0)
        return 0;
      $count = 0;
      for ($i = 0; $i < strlen ($value); $i++) {
        $char = substr ($value, $i, 1);
        if ((! $i) && ($char == "-"))
          continue;
        if ($char == '.') {
          $count++;
          if ($count > 1)
            return 0;
          continue;
        }
        if (($char < "0") || ($char > "9"))
          return 0;
      }
    }
    if ($type == "datetime") {
      $val2 = makedate (maketime ($value));
      return ($val2 == $value) || ($val2 == ($value . " 00:00:00"));
    }
    return 1;
  }


  // query database for scheduler status
  function getschedulerstatus ($problem) {
    $result = mysql_db_query ("vishnu_central",
                              "select * from scheduler_request where " .
                              "problem = \"" . $problem . "\";");
    $errResult = reportSqlError ("vishnu_central",
                              "select * from scheduler_request where " .
                              "problem = \"" . $problem . "\";");
    if ($errResult != "")	
      return $errResult;

    $value = mysql_fetch_array ($result);
    mysql_free_result ($result);
    return $value;
  }

  // delete current scheduler request
  function deletecurrentrequest ($problem) {
    $result = mysql_db_query ("vishnu_central",
                  "select number from scheduler_request where " .
                  "problem = \"" . $problem . "\";");
    $value = mysql_fetch_row ($result);
    mysql_free_result ($result);
    mysql_db_query ("vishnu_central",
                    "delete from scheduler_request where " .
                    "problem = \"" . $problem . "\";");
    return $value ? $value[0] : -1;
  }

  // insert new scheduler request into database
  function insertrequest ($problem, $username, $number, $legalhosts = "") {
    mysql_db_query ("vishnu_central",
                    "insert into scheduler_request values (\"" .
                    $problem . "\", \"" . makedate (mktime()) .
                    "\", \"" . $username . "\", $number, 0, NULL, " .
                    "\"$legalhosts\");");
    return reportSqlError ("vishnu_central",
	                   "insert into scheduler_request values (\"" .
                           $problem . "\", \"" . makedate (mktime()) .
                           "\", \"" . $username . "\", $number, 0, NULL, " .
                           "\"$legalhosts\");");
  }

  function reportSqlError ($database, $sql) {
    if (mysql_errno()) {
      $report = "Sql error - ";
      $report .= mysql_errno () . ": " . mysql_error ();
      $report .= ", sql was (database = " . $database . ") " . $sql;
      return $report;
    }
    return "";
  }

  function linkToProblem ($problem) {
    $url = "problem.php?problem=" . $problem;
    echo "<H3><a href=\"" . $url . "\"/>Return to " . $problem . "</a></H3>";
  }
?>
