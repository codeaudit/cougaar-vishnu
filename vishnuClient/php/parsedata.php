<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Parsing of XML specifying the data

  require_once ("utilities.php");

  // function to take data in XML format and put into database
  // everything else below is just support
  function parsedata ($data, $theproblem, $openconn) {
    global $problem, $user, $password;
    $problem = $theproblem;
    if ($openconn) {
      require ("clientlink.php");
    }
    $parser = setup_xml_parser ("startHandler", "endHandler");
    if (! $parser)
      return;

    $data = StripSlashes ($data);
    $result = xml_parse ($parser, $data);
    if (! $result) {
      echo "XML error on line " . xml_get_current_line_number ($parser) .
           ": " . xml_error_string (xml_get_error_code ($parser)) . "<BR>\n";
      return;
    }
    if ($openconn)
      mysql_close();

    return "SUCCESS";
  }


  function my_query ($db, $context, $action, $ident, $command) {
    global $continue;
    $result = safe_query ($db, $context, $action, $ident, $command);
    if ($result["error"])
      echo $result["error"];
    return $result["result"];
  }

  // do database query catching errors if fails; if succeeds, return
  // array with result otherwise return array with error
  function safe_query ($db, $context, $action, $ident, $command) {
    $result = mysql_db_query ("vishnu_" . $db, $command);
    if (mysql_errno() == 0)
      return array ("result"=>$result);
    $text = "Error has occurred<BR>\n<DIV align=left>\nContext: " .
            $context . "<BR>\nAction: " . $action .
            "<BR>\nIdentifier: " . $ident . "<BR>\nCommand: " . $command .
            "<BR>\nDatabase: vishnu_" . $db .
            "<BR>\nError Text: " . mysql_error() . "<BR><BR>\n</DIV>\n";
    return array ("error"=>$text);
  }


  function setup_xml_parser ($startHandler, $endHandler) {
    $parser = xml_parser_create();
    if (! $parser) {
      echo "Could not create parser<BR>\n";
      return;
    }
    $result = xml_set_element_handler ($parser, $startHandler, $endHandler);
    if (! $result) {
      echo "Parser not valid<BR>\n";
      return;
    }
    return $parser;
  }


  $doingnews = 0;
  $doingchanges = 0;
  $doingdeletes = 0;
  $fields = array();
  $objects = array();
  $listvalues = array();


  // tests names in order of prevalence in input
  function startHandler ($parser, $name, $attribs) {
    global $problem, $doingnews, $doingchanges, $doingdeletes;
    global $objects, $fields, $fieldvalue, $listvalues;
    global $globalname;

    if ($name == "FIELD") {
      $fields[] = $attribs["NAME"];
      $fieldvalue = $attribs["VALUE"];
    }
    else if ($name == "OBJECT") {
      $objects[] = array ("qqzzqwwq_type"=>$attribs["TYPE"]);
    }
    else if ($name == "VALUE") {
      $fieldvalue = $attribs["VALUE"];
    }
    else if ($name == "LIST") {
      $listvalues[] = array();
    }
    else if ($name == "CLEARDATABASE") {
      mysql_db_query ("vishnu_prob_" . $problem, "delete from assignments;");
      mysql_db_query ("vishnu_prob_" . $problem,
                      "delete from multitaskassignments;");
      mysql_db_query ("vishnu_prob_" . $problem, "delete from activities;");
      mysql_db_query ("vishnu_prob_" . $problem, "delete from window;");
      mysql_db_query ("vishnu_prob_" . $problem, "delete from globals;");
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "select name from objects;");
      while ($value = mysql_fetch_row ($result)) {
        $result2 = mysql_db_query ("vishnu_prob_" . $problem,
                                   "delete from obj_" . $value[0] . ";");
      }
      mysql_free_result ($result);
    }
    else if ($name == "CLEARUNFROZENTASKS") {
      $doingdeletes = 1;
      $taskobject = gettaskandresourcetypes ($problem);
      $taskobject = $taskobject[0];
      $taskstr = "obj_" . $taskobject;
      $keystr = $taskstr . ".obj_" . keyfortype ($taskobject);
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select $keystr from $taskstr left join assignments " .
                  "on $keystr = assignments.task_key where assignments" .
                  ".task_key is NULL or assignments.frozen = \"no\";");
      while ($value = mysql_fetch_row ($result)) {
        $objects[] = array (keyfortype ($taskobject) => $value[0],
                            "qqzzqwwq_type" => $taskobject);
        endHandler ($parser, "OBJECT");
      }
      mysql_free_result ($result);
      $doingdeletes = 0;
      mysql_db_query ("vishnu_prob_" . $problem,
        "delete from assignments where frozen = \"no\";");
    }
    else if ($name == "WINDOW") {
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                                "delete from window;");
      $str1 = $attribs["STARTTIME"];
      $str1 = ($str1 == "") ? "NULL" : "\"" . $str1 . "\"";
      $str2 = $attribs["ENDTIME"];
      $str2 = ($str2 == "") ? "NULL" : "\"" . $str2 . "\"";
      my_query ("prob_" . $problem, "setting window", "", "",
                "insert into window values ($str1, $str2);");
    }
    else if ($name == "NEWOBJECTS") {
      $doingnews = 1;
    }
    else if ($name == "CHANGEDOBJECTS") {
      $doingchanges = 1;
    }
    else if ($name == "DELETEDOBJECTS") {
      $doingdeletes = 1;
    }
    else if ($name == "GLOBAL") {
      $globalname = $attribs["NAME"];
    }
    else if ($name == "FREEZE") {
      my_query ("prob_" . $problem, "parsing data", "freeze",
                $attribs["TASK"],
                "update assignments set frozen = \"yes\" where " .
                "task_key = \"" . $attribs["TASK"] . "\";");
    }
    else if ($name == "UNFREEZE") {
      my_query ("prob_" . $problem, "parsing data", "unfreeze",
                $attribs["TASK"],
                "update assignments set frozen = \"no\" where " .
                "task_key = \"" . $attribs["TASK"] . "\";");
    }
    else if ($name == "FREEZEALL") {
      my_query ("prob_" . $problem, "parsing data", "freeze", "all",
                "update assignments set frozen = \"yes\";");
    }
    else if ($name == "UNFREEZEALL") {
      my_query ("prob_" . $problem, "parsing data", "unfreeze", "all",
                "update assignments set frozen = \"no\";");
    }
  }


  function endHandler ($parser, $name) {
    global $problem, $doingnews, $doingchanges, $doingdeletes;
    global $objects, $fieldvalue, $fields, $parentkeys;
    global $listvalues, $objecttype, $globalname;

    if ($name == "FIELD") {
      $field = end ($fields);
      $objects[sizeof($objects)-1][$field] = $fieldvalue;
      $fields = trimlast ($fields);
      if ($doingchanges) {
        $object = end ($objects);
        $type = $object["qqzzqwwq_type"];
        if ($field == keyfortype ($type)) {
          $parentkeys[] = array ($type, $field, $fieldvalue);
        }
      }
    }
    else if ($name == "OBJECT") {
      $object = end($objects);
      $objects = trimlast ($objects);
      $type = $object["qqzzqwwq_type"];
      $objecttype = $type;
      $keytype = keyfortype ($type);
      if ($doingchanges || $doingdeletes) {
        if ($keytype != "internal_key")
          deleteobject ($type, $object[$keytype]);
      }
      if ($doingnews || $doingchanges) {
        $first = 1;
        $format = formatfortype ($type);
        $str1 = "";
        $str2 = "";
        for ($i = 0; $i < sizeof ($format); $i++) {
          $value = $format[$i];
          $field = $value["field_name"];
          if (! $first) {
            $str1 .= ", ";
            $str2 .= ", ";
          }
          $first = 0;
          $str1 .= "obj_$field";
          $str2 .= (($field == "internal_key") ? "NULL" :
                    "\"" . $object[$field] . "\"");
        }
        $str = "insert into obj_$type ($str1) values ($str2);";
        my_query ("prob_" . $problem, "parsing data", "object",
                  $object[$keytype], $str);
        $result = my_query ("prob_" . $problem, "parsing data", "object",
                     $object[$keytype], "select last_insert_id();");
        $value = mysql_fetch_row ($result);
        $fieldvalue = $value[0]; 
        mysql_free_result ($result);
      }
      else if ($doingdeletes) {
        $result = my_query ("prob_" . $problem, "deleting", "object",
                            $object[$keytype],
                            "select is_task, is_resource from objects" .
                            " where name=\"" . $type . "\";");
        $value = mysql_fetch_array ($result);
        mysql_free_result ($result);
        if ($value["is_task"] == "true") {
          $result = my_query ("prob_" . $problem, "deleting", "object",
                         $object[$keytype],
                         "select resource_key, start_time from assignments " .
                         "where task_key=\"" . $object[$keytype] . "\";");
          $value = mysql_fetch_row ($result);
          mysql_free_result ($result);
          if ($value) {
            my_query ("prob_" . $problem, "deleting", "object",
                      $object[$keytype],
                      "delete from assignments where task_key=\"" .
                      $object[$keytype] . "\";");
            $result = my_query ("prob_" . $problem, "deleting", "object",
                           $object[$keytype],
                           "select task_keys from multitaskassignments " .
                           "where resource_key=\"" . $value[0] .
                           "\" and start_time =\"" . $value[1] . "\";");
            $value2 = mysql_fetch_row ($result);
            mysql_free_result ($result);
            if ($value2) {
              if ($value2[0] == $object[$keytype])
                my_query ("prob_" . $problem, "deleting", "object",
                     $object[$keytype], "delete from multitaskassignments " .
                     "where resource_key=\"" . $value[0] .
                     "\" and start_time =\"" . $value[1] . "\";");
              else {
                $pos = strpos ($value2[0], $object[$keytype]);
                if ($pos || ($pos == 0)) {
                  $len = strlen ($object[$keytype]);
                  if ($pos == 0)
                    $str = substr ($value2[0], $len + 3);
                  else
                    $str = substr ($value2[0], 0, $pos - 3) .
                           substr ($value2[0], $pos + $len);
                  my_query ("prob_" . $problem, "deleting", "object",
                       $object[$keytype], "update multitaskassignments " .
                       "set task_keys=\"" . $str . "\" " .
                       "where resource_key=\"" . $value[0] .
                       "\" and start_time =\"" . $value[1] . "\";");
                }
              }
            }
          }
        }
        if ($value["is_resource"] == "true") {
          my_query ("prob_" . $problem, "deleting", "object",
                    $object[$keytype],
                    "delete from assignments where " .
                    "resource_key=\"" . $object[$keytype] . "\";");
          my_query ("prob_" . $problem, "deleting", "object",
                    $object[$keytype],
                    "delete from activities where " .
                    "resource_key=\"" . $object[$keytype] . "\";");
        }
      }
    }
    else if ($name == "LIST") {
      $fieldvalue = implode ("*%*", $listvalues [sizeof ($listvalues) - 1]);
      $listvalues = trimlast ($listvalues);
    }
    else if ($name == "VALUE") {
      $listvalues[sizeof ($listvalues) - 1][] = $fieldvalue;
    }
    else if ($name == "NEWOBJECTS") {
      $doingnews = 0;
    }
    else if ($name == "CHANGEDOBJECTS") {
      $doingchanges = 0;
    }
    else if ($name == "DELETEDOBJECTS") {
      $doingdeletes = 0;
    }
    else if ($name == "GLOBAL") {
      if ($doingchanges || $doingdeletes) {
        $result = my_query ("prob_" . $problem, "parsing data", "global",
                            $globalname, "select * from globals " .
                            "where name=\"" . $globalname . "\";");
        $value = mysql_fetch_array ($result);
        if ($value) {
          my_query ("prob_" . $problem, "parsing data", "global",
                    $globalname, "delete from globals where name=\"" .
                    $globalname . "\";");
          deleteobject ($value["datatype"], $value["id"]);
        }
      }
      if ($doingnews || $doingchanges) {
        my_query ("prob_" . $problem, "parsing data", "global", $globalname,
                  "insert into globals values (\"" . $globalname .
                  "\", \"" . $objecttype . "\", $fieldvalue);");
      }
    }
  }


  $keys = array();

  function keyfortype ($type) {
    global $keys, $problem;
    if ($key = $keys["type"])
      return $key;
    $result = my_query ("prob_" . $problem, "parsing data", "get key", $type,
                        "select field_name from " .
                        "object_fields where object_name=\"" .
                        $type . "\" and is_key=\"true\";");
    $value = mysql_fetch_row ($result);
    $key = $value[0];
    $keys[$type] = $key;
    mysql_free_result ($result);
    return $key;
  }


  $formats = array();

  function formatfortype ($type) {
    global $formats, $problem;
    if ($format = $formats["type"])
      return $format;
    $result = my_query ("prob_" . $problem, "parsing data",
                        "get format", $type,
                        "select field_name from object_fields where " .
                        "object_name=\"" . $type . "\";");
    $format = array();
    while ($value = mysql_fetch_array ($result))
      $format[] = $value;
    $formats[$type] = $format;
    mysql_free_result ($result);
    return $format;
  }


  function deleteobject ($type, $key) {
    global $problem;
    $keytype = keyfortype ($type);
    $result2 = my_query ("prob_" . $problem, "parsing data", "delete", $key,
                         "select field_name, datatype, is_list from " .
                         "object_fields where object_name=\"" .
                         $type . "\" and is_subobject=\"true\";");
    while ($value2 = mysql_fetch_row ($result2)) {
      $result = my_query ("prob_" . $problem, "parsing data", "delete", $key,
                   "select obj_" . $value2[0] . " from obj_" . $type .
                   " where obj_" . $keytype . "=\"" . $key . "\";");
      $value = mysql_fetch_row ($result);
      if ($value2[2] == "false")
        deleteobject ($value2[1], $value[0]);
      else {
        $ids = explode ("*%*", $value[0]);
        for ($i = 0; $i < sizeof($ids); $i++)
          deleteobject ($value2[1], $ids[$i]);
      }
      mysql_free_result ($result);
    }
    mysql_free_result ($result2);
    my_query ("prob_" . $problem, "parsing data", "delete", $key,
              "delete from obj_" . $type . " where obj_" .
              $keytype . "=\"" . $key . "\";");
  }


  // when PHP 4 available, use array_pop instead
  function trimlast ($arr) {
    $arr2 = array();
    for ($i = 0; $i < (sizeof($arr) - 1); $i++)
      $arr2[$i] = $arr[$i];
    return $arr2;
  }
?>
