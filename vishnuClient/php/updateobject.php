<?
  require ("browserlink.php");
  require_once ("utilities.php");
  require ("parsedata.php");
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
    global $problem;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select field_name, datatype, is_list from object_fields " .
                "where object_name=\"" . $objecttype . "\";");
    $datatypes = array();
    $islists = array();
    while ($value = mysql_fetch_row ($result)) {
      $datatypes [$value[0]] = $value[1];
      $islists [$value[0]] = $value[2] == "true";
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
              if (! strpos ($xml2, "FIELD"))
                break;
              if (! $values ["delete" . $listobjname])
                $xml .= "<VALUE>\n" . $xml2 . "</VALUE>\n";
              $num++;
            }
            for ($i2 = 0; $i2 < $values[$prefix . $field2 . "yxqadd"]; $i2++)
              $xml .= "<VALUE>\n<OBJECT type=\"" . $datatypes [$field2] .
                      "\">\n</OBJECT>\n</VALUE>\n";
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
  }

  function mainContent () { 
    global $objectname, $objecttype, $action, $key;
    global $problem, $HTTP_POST_VARS, $delete, $global;

    if (! $delete) {
      $cxml = "";
      xmlForObject ($cxml, $HTTP_POST_VARS, "field", $objecttype);
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
      parsedata ($xml, $problem, 0, $user, $password);
    }

    if (! $delete) {
      $xml = "<DATA>\n<NEWOBJECTS>\n";
      if ($global)
        $xml .= "<GLOBAL name=\"" . $global . "\">\n";
      xmlForObject ($xml, $HTTP_POST_VARS, "field", $objecttype);
      if ($global)
        $xml .= "</GLOBAL>\n";
      $xml .= "</NEWOBJECTS>\n</DATA>\n";
      parsedata ($xml, $problem, 0, $user, $password);
    }

    echo "<h2>" . $action . " " . ($global ? $global : $objecttype) .
         " complete<h2>";
  }
?>
