<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Accept the edits on an object and write to database

  require ("browserlink.php");
  require_once ("utilities.php");
  require ("parsedata.php");
  require ("editobject.php");
  require ("navigation.php");

  function getTitle () {
    global $action, $objectname;
    if ($action == "Edit")
      echo "Results of editing " . $objectname;
    else if ($action == "Create")
      echo "Results of creation";
  }

  function getHeader () {
    global $objectname, $objecttype, $action, $global;
    if ($global)
      echo "Results of " . (($action == "Edit") ? "editing" : "creating") .
           " " . $global;
    else if ($action == "Edit")
      echo "Results of editing " . $objecttype . " - " . $objectname;
    else if ($action == "Create")
      echo "Results of creating new " . $objecttype;
  } 

  function getSubheader() { 
  }

  function xmlForObject (&$xml, $values, $prefix, $objecttype) {
    global $problem, $added;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select field_name, datatype, is_list, is_key from " .
                "object_fields where object_name=\"$objecttype\";");
    $datatypes = array();
    $islists = array();
    $iskeys = array();
    while ($value = mysql_fetch_row ($result)) {
      $datatypes [$value[0]] = $value[1];
      $islists [$value[0]] = $value[2] == "true";
      $iskeys [$value[0]] = $value[3] == "true";
    }
    $subobjects = array();
    $psize = strlen ($prefix);
    $xml .= "<OBJECT type=\"" . $objecttype . "\">\n";
    while (list ($key, $val) = each ($values)) {
      if (substr ($key, 0, $psize) == $prefix) {
        $field = substr ($key, $psize);
        $pos = strpos ($field, "qxy");
        $pos2 = strpos ($field, "yxq");
        if ($pos2 && ((! $pos) || ($pos2 < $pos))) {
          $field2 = substr ($field, 0, $pos2);
          if (! $subobjects [$field2]) {
            $subobjects [$field2] = 1;
            $xml .= "<FIELD name=\"" . $field2 . "\">\n<LIST>\n";
            $num = 0;
            while (1) {
              $listobjname = $prefix . $field2 . "yxq" . $num . "x";
              $xml2 = "";
              xmlForObject ($xml2, $values, $listobjname,
                            $datatypes [$field2]);
              if (substr ($xml2, 0, 5) == "Error") {
                $xml = $xml2;
                return;
              }
              if (! strpos ($xml2, "FIELD"))
                break;
              if (! $values ["delete" . $listobjname])
                $xml .= "<VALUE>\n" . $xml2 . "</VALUE>\n";
              $num++;
            }
            for ($i2 = 0; $i2 < $values[$prefix . $field2 . "yxqadd"]; $i2++) {
              $added = 1;
              $xml .= "<VALUE>\n<OBJECT type=\"" . $datatypes [$field2] .
                      "\">\n</OBJECT>\n</VALUE>\n";
            }
            $xml .= "</LIST>\n</FIELD>\n";
          }
        }
        else if (! $pos) {
          if ($islists[$field]) {
            $val = replaceSubstring ($val, "\\\",\\\"", "%*%");
            while ($val != $val2) {
              $val2 = $val;
              $val = replaceSubstring ($val, ", ", ",");
              $val = replaceSubstring ($val, " ,", ",");
            }
            $val = replaceSubstring ($val, ",", "*%*");
            $val = replaceSubstring ($val, "%*%", ",");
            $arr = explode ("*%*", $val);
            while (list ($key, $v) = each ($arr)) {
              if (! checkValid ($v, $datatypes[$field])) {
                $xml = "Error in field " . $field;
                return;
              }
            }
          }
          else {
            if (! checkValid ($val, $datatypes[$field])) {
              $xml = "Error in field " . $field;
              return;
            }
          }
          $xml .= "<FIELD name=\"" . $field . "\" value=\"" .
                  $val . "\" />\n";
          if ($iskeys[$field])
            $newname = $val;
        }
        else {
          $field2 = substr ($field, 0, $pos);
          if (! $subobjects [$field2]) {
            $subobjects [$field2] = 1;
            $xml .= "<FIELD name=\"" . $field2 . "\">\n";
            xmlForObject ($xml, $values, $prefix . $field2 . "qxy",
                          $datatypes[$field2]);
            if (substr ($xml, 0, 5) == "Error")
              return;
            $xml .= "</FIELD>\n";
          }
        }
      }
    }
    $xml .= "</OBJECT>\n";
    return $newname;
  }

  function mainContent () { 
    global $objectname, $objecttype, $action, $key;
    global $problem, $HTTP_POST_VARS, $delete, $global, $added;

    if (! $delete) {
      $cxml = "";
      $newname = xmlForObject ($cxml, $HTTP_POST_VARS, "field", $objecttype);
      if (substr ($cxml, 0, 5) == "Error") {
        echo "<h1>" . $cxml . "</h1>";
        return;
      }
    } 

    if ($action == "Edit") {
      $xml = "<DATA>\n<DELETEDOBJECTS>\n";
      if ($global)
        $xml .= "<GLOBAL name=\"" . $global . "\" />";
      else
        $xml .= "<OBJECT type=\"" . $objecttype . "\">\n<FIELD name=\"" .
                $key . "\" value=\"" . $objectname . "\" />\n</OBJECT>\n";
      $xml .= "</DELETEDOBJECTS>\n</DATA>\n";
      parsedata ($xml, $problem, 0);
    }

    if (! $delete) {
      $xml = "<DATA>\n<NEWOBJECTS>\n";
      if ($global)
        $xml .= "<GLOBAL name=\"" . $global . "\">\n";
      xmlForObject ($xml, $HTTP_POST_VARS, "field", $objecttype);
      if ($global)
        $xml .= "</GLOBAL>\n";
      $xml .= "</NEWOBJECTS>\n</DATA>\n";
      parsedata ($xml, $problem, 0);
    }

    if (! $added)
      echo "<h2>" . $action . " " . ($global ? $global : $objecttype) .
           " complete</h2>";
    else {
      echo "<h2>Need to fill in new list objects</h2>";
      editobject ($objecttype, $newname, $problem, $key, $global);
    }
  }
?>
