<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Parsing of XML specifying all aspect of a problem

  require_once ("utilities.php");
  require ("parsedata.php");

  $continue = 1;

  // function to take problem specs in XML format and put into database
  // everything else below is just support
  function parseproblem ($data, $specifiedname="") {
    global $problem, $continue, $user, $password;
    if ($specifiedname)
      $problem = $specifiedname;

    $data = StripSlashes ($data);
    $data2 = strstr ($data, "<DATA>");
    if ($data2) {
      $data3 = strstr ($data2, "</DATA>");
      $data = substr ($data, 0, strlen($data) - strlen($data2)) .
              substr ($data3, 7);
      $data2 = substr ($data2, 0, strlen($data2) - strlen($data3) + 7);
    }

    require ("clientlink.php");

    $parser = setup_xml_parser ("probStartHandler", "probEndHandler");
    if (! $parser)
      return;
    $result = xml_parse ($parser, $data);
    if (! $result) {
      echo "XML error on line " . xml_get_current_line_number ($parser) .
           ": " . xml_error_string (xml_get_error_code ($parser)) . "<BR>\n";
      return;
    }
    if (! $continue)
      return;
    if ($data2)
      parsedata ($data2, $problem, 0);

    return $problem;
  }

  $stack = array (array());

  // function to parse the XML from a single constraint and put results
  // in the database
  function parseconstraint ($data, $problem, $constraint) {
    parseconstraint2 ($data, $problem);
    return updateconstraint ($constraint);
  }

  function parseconstraint2 ($data, $prob) {
    global $problem;
    $problem = $prob;
    $parser = xml_parser_create();
    xml_set_element_handler ($parser, "probStartHandler", "probEndHandler");
    $data = StripSlashes ($data);
    xml_parse ($parser, $data);
  }

  function parsecolortest ($data, $problem, $oldcolor, $color,
                           $objtype, $title) {
    global $stack, $continue;
    parseconstraint2 ($data, $problem);
    if (! $oldcolor) {
      do_query ("prob_" . $problem, "adding color test", "", $color,
                "insert into color_tests values (\"" . $color .
                "\", \"" . $objtype . "\", \"" . $title .
                "\", \"" . $stack[0][0] . "\", " . $stack[0][1] . ");");
    }
    else if ($data == "NULL") {
      do_query ("prob_" . $problem, "deleting color test", "", $oldcolor,
                "delete from color_tests where color=\"" .
                $oldcolor . "\";");
    }
    else {
      do_query ("prob_" . $problem, "updating color test", "", $color,
                "update color_tests set color=\"" . $color .
                "\", obj_type=\"" . $objtype . "\", title=\"" . $title .
                "\", test_type=\"" . $stack[0][0] . "\", test_id=" .
                $stack[0][1] . " where color=\"" . $oldcolor . "\";");
    }
    $stack[0] = array();
    return $continue ? "SUCCESS" : "";
  }

  function do_query ($db, $context, $action, $ident, $command) {
    global $continue;
    $result = safe_query ($db, $context, $action, $ident, $command);
    if ($result["error"]) {
      echo $result["error"];
      $continue = 0;
    }
    return $result["result"];
  }

  function createpredefinedobject ($name) {
    global $problem, $objectname, $needinc;
    $objectname = $name;
    $needinc = 1;
    do_query ("prob_" . $problem, "setting up",
              "creating predefined object", $name,
              "insert into objects values (\"" . $name .
              "\", \"true\", \"false\", \"false\");");
    createobjectfield ($name, "internal_key", "smallint", "true", "false");
  }

  function createobjectfield ($object, $field, $datatype, $is_key, $is_list) {
    global $problem;
    do_query ("prob_" . $problem, "parsing metadata",
              "creating object field", $field,
              "insert into object_fields values (\"" . $field .
              "\", \"" . $object . "\", \"" . $datatype .
              "\", \"false\", \"false\", \"" . $is_list . "\", \"" .
              $is_key . "\");");
  }

  function probStartHandler ($parser, $name, $attribs) {
    global $problem, $objectname, $operatornum, $stack, $colortest;
    global $continue, $needinc;

    if (! $continue)
      return;

    if ($name == "PROBLEM") {
      if (! $problem)
        $problem = $attribs["NAME"];
      safe_query ("central", "setting up", "", $problem,
                  "insert into problems values (\"" . $problem . "\");");
      $result = mysql_drop_db ("vishnu_prob_" . $problem);
      do_query ("central", "setting up", "", $problem,
                "create database vishnu_prob_" . $problem . ";");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table capacities (" .
                "ID varchar(255) not null, " .
                "value varchar(255) not null);");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table capabilities (" .
                "task_key varchar(255) not null, " .
                "resource_key varchar(255) not null);");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table objects (" .
                "name varchar(255) not null, " .
                "is_predefined enum (\"true\", \"false\") not null, " .
                "is_task enum (\"true\", \"false\") not null, " .
                "is_resource enum (\"true\", \"false\") not null, " .
                "primary key (name));");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table object_fields (" .
                "field_name varchar(255) not null, " .
                "object_name varchar(255) not null, " .
                "datatype varchar(255), " .
                "is_globalptr enum (\"false\", \"true\") not null, " .
                "is_subobject enum (\"false\", \"true\") not null, " .
                "is_list enum (\"false\", \"true\") not null, " .
                "is_key enum (\"false\", \"true\") not null);");
      createpredefinedobject ("interval");
      createobjectfield ("interval", "start", "datetime", "false", "false");
      createobjectfield ("interval", "end", "datetime", "false", "false");
      createobjectfield ("interval", "label1", "string", "false", "false");
      createobjectfield ("interval", "label2", "string", "false", "false");
      probEndHandler ("", "OBJECTFORMAT");
      createpredefinedobject ("xy_coord");
      createobjectfield ("xy_coord", "x", "number", "false", "false");
      createobjectfield ("xy_coord", "y", "number", "false", "false");
      probEndHandler ("", "OBJECTFORMAT");
      createpredefinedobject ("latlong");
      createobjectfield ("latlong", "latitude", "number", "false", "false");
      createobjectfield ("latlong", "longitude", "number", "false", "false");
      probEndHandler ("", "OBJECTFORMAT");
      createpredefinedobject ("matrix");
      createobjectfield ("matrix", "numrows", "number", "false", "false");
      createobjectfield ("matrix", "numcols", "number", "false", "false");
      createobjectfield ("matrix", "values", "number", "false", "true");
      probEndHandler ("", "OBJECTFORMAT");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table constraints (" .
                "opt_direction enum (\"minimize\", \"maximize\"), " .
                "multitasking enum (\"none\", \"grouped\", " .
                                    "\"ungrouped\", \"ignoring_time\"), " .
                "setup_wrapup_display enum (\"striped\", \"line\"), " .
                "task_object varchar(255), " .
                "resource_object varchar(255), " .
                "opt_criterion_type enum (\"operator\", \"literal\"), " .
                "opt_criterion_index smallint, " .
                "delta_criterion_type enum (\"operator\", \"literal\"), " .
                "delta_criterion_index smallint, " .
                "best_time_type enum (\"operator\", \"literal\"), " .
                "best_time_index smallint, " .
                "capability_type enum (\"operator\", \"literal\"), " .
                "capability_index smallint, " .
                "task_duration_type enum (\"operator\", \"literal\"), " .
                "task_duration_index smallint, " .
                "setup_duration_type enum (\"operator\", \"literal\"), " .
                "setup_duration_index smallint, " .
                "wrapup_duration_type enum (\"operator\", \"literal\"), " .
                "wrapup_duration_index smallint, " .
                "prerequisites_type enum (\"operator\", \"literal\"), " .
                "prerequisites_index smallint, " .
                "task_unavail_type enum (\"operator\", \"literal\"), " .
                "task_unavail_index smallint, " .
                "resource_unavail_type enum (\"operator\", \"literal\"), " .
                "resource_unavail_index smallint, " .
                "capacity_contrib_type enum (\"operator\", \"literal\"), " .
                "capacity_contrib_index smallint, " .
                "capacity_thresh_type enum (\"operator\", \"literal\"), " .
                "capacity_thresh_index smallint, " .
                "groupable_type enum (\"operator\", \"literal\"), " .
                "groupable_index smallint, " .
                "linked_type enum (\"operator\", \"literal\"), " .
                "linked_index smallint, " .
                "link_time_diff_type enum (\"operator\", \"literal\"), " .
                "link_time_diff_index smallint, " .
                "task_text_type enum (\"operator\", \"literal\"), " .
                "task_text_index smallint, " .
                "grouped_text_type enum (\"operator\", \"literal\"), " .
                "grouped_text_index smallint, " .
                "activity_text_type enum (\"operator\", \"literal\"), " .
                "activity_text_index smallint);");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table color_tests (" .
                "color varchar(255) not null, " .
                "obj_type enum (\"task\", \"grouped\", \"activity\") " .
                "not null, " .
                "title varchar(255) not null, " .
                "test_type enum (\"operator\", \"literal\") not null, " .
                "test_id smallint not null, " .
                "primary key (color));");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table literal (" .
                "id smallint not null auto_increment, " .
                "value varchar(255) not null, " .
                "lit_type enum (\"constant\", \"variable\") not null, " .
                "datatype varchar(255) not null, " .
                "primary key (id));");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table operator (" .
                "id smallint not null auto_increment, " .
                "operation varchar(255) not null, " .
                "first_arg_type enum (\"operator\", \"literal\"), " .
                "first_arg_index smallint, " .
                "second_arg_type enum (\"operator\", \"literal\"), " .
                "second_arg_index smallint, " .
                "third_arg_type enum (\"operator\", \"literal\"), " .
                "third_arg_index smallint, " .
                "fourth_arg_type enum (\"operator\", \"literal\"), " .
                "fourth_arg_index smallint, " .
                "primary key (id));");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table globals (" .
                "name varchar(255) not null, " .
                "datatype varchar(255) not null, " .
                "id smallint not null, " .
                "primary key (name));");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table assignments (" .
                "task_key varchar(255) not null, " .
                "resource_key varchar(255) not null, " .
                "setup_time datetime not null, " .
                "start_time datetime not null, " .
                "end_time datetime not null, " .
                "wrapup_time datetime not null, " .
                "frozen enum (\"yes\", \"no\"), " .
                "color varchar(255), " .
                "text varchar(255));");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table multitaskassignments (" .
                "task_keys text not null, " .
                "resource_key varchar(255) not null, " .
                "capacities_used text not null, " .
                "capacities text not null, " .
                "setup_time datetime, " .
                "start_time datetime not null, " .
                "end_time datetime not null, " .
                "wrapup_time datetime, " .
                "color varchar(255), " .
                "text varchar(255));");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table activities (" .
                "resource_key varchar(255) not null, " .
                "start_time datetime not null, " .
                "end_time datetime not null, " .
                "color varchar(255), " .
                "text varchar(255));");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table window (" .
                "start_time datetime, " .
                "end_time datetime);");
      do_query ("prob_" . $problem, "setting up", "", $problem,
                "create table gaparms (" .
                "pop_size int not null, " .
                "parent_scalar float(6,5) not null, " .
                "max_evals int not null, " .
                "max_time int not null, " .
                "max_duplicates int not null, " .
                "max_top_dog_age int not null, " .
                "report_interval int, " .
                "initializer varchar(255) not null, " .
                "initializer_parms varchar(255), " .
                "decoder varchar(255) not null, " .
                "decoder_parms varchar(255), " .
                "operator1_name varchar(255), " .
                "operator1_prob float, " .
                "operator1_parms varchar(255), " .
                "operator2_name varchar(255), " .
                "operator2_prob float, " .
                "operator2_parms varchar(255), " .
                "operator3_name varchar(255), " .
                "operator3_prob float, " .
                "operator3_parms varchar(255), " .
                "operator4_name varchar(255), " .
                "operator4_prob float, " .
                "operator4_parms varchar(255));");
    }
    else if ($name == "OBJECTFORMAT") {
      $objectname = $attribs["NAME"];
      do_query ("prob_" . $problem, "parsing metadata", "object format",
                $objectname,
                "insert into objects values (\"" . $attribs["NAME"] .
                "\", \"false\", \"" . $attribs["IS_TASK"] . "\", \"" .
                $attribs["IS_RESOURCE"] . "\");");
      $needinc = 0;
      if (($attribs["IS_TASK"] == "false") &&
          ($attribs["IS_RESOURCE"] == "false")) {
        $needinc = 1;
        createobjectfield ($objectname, "internal_key", "smallint",
                           "true", "false");
      }
    }
    else if ($name == "FIELDFORMAT") {
      $gptr = $attribs["IS_GLOBALPTR"];
      $subo = $attribs["IS_SUBOBJECT"];
      $islist = $attribs["IS_LIST"];
      $iskey = $attribs["IS_KEY"];
      $dt = $attribs["DATATYPE"];
      do_query ("prob_" . $problem, "parsing metadata", "field format",
                $attribs["NAME"],
                "insert into object_fields values (\"" .
                $attribs["NAME"] .
                "\", \"" . $objectname .
                "\", \"" . $dt .
                "\", \"" . ($gptr ? $gptr : "false") .
                "\", \"" . ($subo ? $subo : "false") .
                "\", \"" . ($islist ? $islist : "false") .
                "\", \"" . ($iskey ? $iskey : "false") . "\");");
    }
    else if ($name == "GAPARMS") {
      do_query ("prob_" . $problem, "parsing GA parms", "", "",
                "insert into gaparms values (\"" .
                $attribs["POP_SIZE"] .
                "\", \"" . $attribs["PARENT_SCALAR"] .
                "\", \"" . $attribs["MAX_EVALS"] .
                "\", \"" . $attribs["MAX_TIME"] .
                "\", \"" . $attribs["MAX_DUPLICATES"] .
                "\", \"" . $attribs["MAX_TOP_DOG_AGE"] .
                "\", \"" . $attribs["REPORT_INTERVAL"] .
                "\", \"" . $attribs["INITIALIZER"] .
                "\", \"" . ($attribs["INITIALIZER_PARMS"] ?
                            $attribs["INITIALIZER_PARMS"] : "NULL") .
                "\", \"" . $attribs["DECODER"] .
                "\", \"" . ($attribs["DECODER_PARMS"] ?
                            $attribs["DECODER_PARMS"] : "NULL") .
                "\", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL" .
                ", NULL, NULL, NULL, NULL);");
      $operatornum = 1;
    }
    else if ($name == "GAOPERATOR") {
      $op = "operator" . $operatornum . "_";
      do_query ("prob_" . $problem, "parsing GA operator", "",
                $attribs["NAME"],
                "update gaparms set " .
                $op . "name=\"" . $attribs["NAME"] . "\", " .
                $op . "prob=\"" . $attribs["PROB"] . "\", " .
                $op . "parms=\"" . $attribs["PARMS"] . "\";");
      $operatornum++;
    }
    else if ($name == "SPECS") {
      do_query ("prob_" . $problem, "setup scheduling specs", "", "",
                "insert into constraints values (\"" .
                ($attribs["DIRECTION"] ? $attribs["DIRECTION"] :
                                         "minimize") . "\", \"" . 
                ($attribs["MULTITASKING"] ? $attribs["MULTITASKING"] :
                                            "none") . "\", \"" . 
                ($attribs["SETUPDISPLAY"] ? $attribs["SETUPDISPLAY"] :
                                            "striped") . "\", " .
                ($attribs["TASKOBJECT"] ?
                  ("\"" . $attribs["TASKOBJECT"] . "\", ") :
                  "NULL, ") .
                ($attribs["RESOURCEOBJECT"] ?
                  ("\"" . $attribs["RESOURCEOBJECT"] . "\", ") :
                  "NULL, ") .
                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, " .
                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, " .
                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, " .
                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, " .
                "NULL, NULL, NULL, NULL);");
    }
    else if ($name == "OPERATOR") {
      $stack[] = array ($attribs["OPERATION"]);
    }
    else if ($name == "LITERAL") {
      do_query ("prob_" . $problem, "parsing specs", "new literal",
                $attribs["VALUE"],
                "insert into literal values (NULL, \"" .
                $attribs["VALUE"] .
                "\", \"" . $attribs["TYPE"] .
                "\", \"" . $attribs["DATATYPE"] . "\");");
      $result = do_query ("prob_" . $problem, "parsing specs",
                          "new literal", $attribs["VALUE"],
                          "select last_insert_id();");
      $value = mysql_fetch_row ($result);
      $stack[sizeof($stack) - 1][] = "literal";
      $stack[sizeof($stack) - 1][] = $value[0];
      mysql_free_result ($result);
    }
    else if ($name == "COLORTEST") {
      $colortest = array ($attribs["COLOR"], $attribs["OBJ_TYPE"],
                          $attribs["TITLE"]);
    }
  }


  function sqlType ($datatype, $islist, $issubobject, $isglobalptr) {
    if ($islist)
      return "text";
    else if ($issubobject)
      return "smallint";
    else if ($isglobalptr)
      return "varchar(255)";
    else if ($datatype == "string")
      return "varchar(255)";
    else if ($datatype == "number")
      return "float";
    else if ($datatype == "boolean")
      return "enum (\"true\", \"false\")";
    else
      return $datatype;
  }

  function probEndHandler ($parser, $name) {
    global $problem, $objectname, $stack, $colortest, $needinc, $continue;

    if (! $continue)
      return;

    if ($name == "OBJECTFORMAT") {
      $str = "create table obj_" . $objectname . "(";
      $result = do_query ("prob_" . $problem, "parsing metadata",
                          "object format", $objectname,
                   "select * from object_fields where object_name=\"" .
                   $objectname . "\";");
      $notfirst = 0;
      while ($value = mysql_fetch_array ($result)) {
        $datatype = sqlType ($value["datatype"],
                             $value["is_list"] == "true",
                             $value["is_subobject"] == "true",
                             $value["is_globalptr"] == "true");
        $str = $str . ($notfirst ? ", " : "") . "obj_" .
               $value["field_name"] . " " . $datatype . " not null" .
               (($notfirst || (! $needinc)) ? "" : " auto_increment");
        if ($value["is_key"] == "true")
          $keyfield = $value["field_name"];
        $notfirst = 1;
      }
      mysql_free_result ($result);
      $str = $str . ", primary key (obj_" . $keyfield . ")";
      do_query ("prob_" . $problem, "parsing metadata",
                "object format", $objectname, $str . ");");
    }
    else if ($name == "OPERATOR") {
      $op = end ($stack);
      $stack = trimlast ($stack);
      do_query ("prob_" . $problem, "parsing specs", "new operator", $op[0],
                "insert into operator values (NULL, \"" . $op[0] . "\""  .
                ((sizeof($op) > 1) ?
                  (", \"" . $op[1] . "\", " . $op[2]) : ", NULL, NULL") .
                ((sizeof($op) > 3) ?
                  (", \"" . $op[3] . "\", " . $op[4]) : ", NULL, NULL") .
                ((sizeof($op) > 5) ?
                  (", \"" . $op[5] . "\", " . $op[6]) : ", NULL, NULL") .
                ((sizeof($op) > 7) ?
                  (", \"" . $op[7] . "\", " . $op[8]) : ", NULL, NULL") .
                ");");
      $result = do_query ("prob_" . $problem, "parsing specs",
                   "new operator", $op[0], "select last_insert_id();");
      $value = mysql_fetch_row ($result);
      $stack[sizeof($stack) - 1][] = "operator";
      $stack[sizeof($stack) - 1][] = $value[0];
      mysql_free_result ($result);
    }
    else if ($name == "OPTCRITERION") {
      updateconstraint ("opt_criterion");
    }
    else if ($name == "DELTACRITERION") {
      updateconstraint ("delta_criterion");
    }
    else if ($name == "BESTTIME") {
      updateconstraint ("best_time");
    }
    else if ($name == "CAPABILITY") {
      updateconstraint ("capability");
    }
    else if ($name == "TASKDURATION") {
      updateconstraint ("task_duration");
    }
    else if ($name == "SETUPDURATION") {
      updateconstraint ("setup_duration");
    }
    else if ($name == "WRAPUPDURATION") {
      updateconstraint ("wrapup_duration");
    }
    else if ($name == "PREREQUISITES") {
      updateconstraint ("prerequisites");
    }
    else if ($name == "TASKUNAVAIL") {
      updateconstraint ("task_unavail");
    }
    else if ($name == "RESOURCEUNAVAIL") {
      updateconstraint ("resource_unavail");
    }
    else if ($name == "CAPACITYCONTRIB") {
      updateconstraint ("capacity_contrib");
    }
    else if ($name == "CAPACITYTHRESH") {
      updateconstraint ("capacity_thresh");
    }
    else if ($name == "GROUPABLE") {
      updateconstraint ("groupable");
    }
    else if ($name == "LINKED") {
      updateconstraint ("linked");
    }
    else if ($name == "LINKTIMEDIFF") {
      updateconstraint ("link_time_diff");
    }
    else if ($name == "TASKTEXT") {
      updateconstraint ("task_text");
    }
    else if ($name == "GROUPEDTEXT") {
      updateconstraint ("grouped_text");
    }
    else if ($name == "ACTIVITYTEXT") {
      updateconstraint ("activity_text");
    }
    else if ($name == "COLORTEST") {
      do_query ("prob_" . $problem, "parsing specs", "color test",
                $colortest[0],
                "insert into color_tests values (\"" . $colortest[0] .
                "\", \"" . $colortest[1] . "\", \"" . $colortest[2] .
                "\", \"" . $stack[0][0] .
                "\", " . $stack[0][1] . ");");
      $stack[0] = array();
    }
  }

  function updateconstraint ($name) {
    global $problem, $stack, $continue;

    $result = do_query ("prob_" . $problem, "checking existence of constraint",
                        "constraint", $name,
                        "select * from constraints where " . $name . "_type=\"" .
                        $stack[0][0] . "\"");

    if (mysql_num_rows ($result) == 0) {
      setupSchedulingSpecs ($problem);
    }			

    do_query ("prob_" . $problem, "updating specs", "constraint", $name,
              "update constraints set " . $name . "_type=\"" .
              $stack[0][0] . "\", " . $name . "_index=" .
              $stack[0][1] . ";");
    $stack[0] = array();
    return $continue ? "SUCCESS" : "";
  }

  function setupSchedulingSpecs ($problem) {
      do_query ("prob_" . $problem, "setup scheduling specs", "", "",
                "insert into constraints values (\"" .
                                                 "minimize" . "\", \"" . 
                                                 "none" . "\", \"" . 
                                                 "striped" . "\", " .
                                                 "NULL, " .
                "NULL, " .
                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, " .
                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, " .
                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, " .
                "NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, " .
                "NULL, NULL, NULL, NULL);");
  
  }
?>
