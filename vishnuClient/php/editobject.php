<?
  require_once ("utilities.php");

  $textsize = 50;

  function setupform ($str, $objecttype, $objectname, $problem,
                      $action, $key, $global) {
    echo "<FORM METHOD=post ACTION=\"updateobject.php\">\n";
    echo "<TABLE CELLPADDING=2>\n";
    echo $str;
    echo "</TABLE>\n";
    echo "<INPUT TYPE=hidden NAME=objectname VALUE=\"" .
         $objectname . "\">\n";
    echo "<INPUT TYPE=hidden NAME=objecttype VALUE=\"" .
         $objecttype . "\">\n";
    echo "<INPUT TYPE=hidden NAME=action VALUE=\"" . $action . "\">\n";
    echo "<INPUT TYPE=hidden NAME=key VALUE=\"" . $key . "\">\n";
    if ($global)
      echo "<INPUT TYPE=hidden NAME=global VALUE=\"" . $global . "\">\n";
    echo "<INPUT TYPE=hidden NAME=problem VALUE=\"" . $problem . "\">\n";
    echo "<br><br><INPUT TYPE=submit VALUE=\"" . $action . " Object\">\n";
    if ($action == "Edit")
      echo "<br><br><br><INPUT TYPE=submit VALUE=\"Delete Object\" " .
           "Name=\"delete\">\n";
    echo "</FORM>\n";
  }

  $atomictypes = array ("string", "number", "datetime", "boolean");
  $isatomic = array();
  while (list ($akey, $aval) = each ($atomictypes))
    $isatomic [$aval] = 1;

  function onerow ($field, $key, $type, $default, $islist, $isgptr,
                   $problem="", $prefix="") {
    global $textsize, $isatomic;
    if (substr ($type, 0, 5) == "list:") {
      $islist = 1;
      $type = substr ($type, 5);
    }
    $issub = (! $isatomic[$type]) && $islist;
    $type = ($isgptr ? "global ptr to " : "") .
            ($islist ? "list of " : "") . $type;
    $str = "<TR><TD nowrap bgcolor=\"#dddddd\">" . $field .
           "<font color=\"#BB0000\">" . (($field == $key) ? " (KEY)" : "") .
           " (" . $type . ")" . "</font>" . "</TD><TD>";
    $field2 = ($prefix ? $prefix : "field") .
              replaceSubstring ($field, ".", "qxy");
    if (! $issub)
      return $str . "<INPUT TYPE=text name=\"" . $field2 . "\" value =\"" .
             $default . "\" size=" . $textsize . "></TD></TR>\n";
    $str .= "<TABLE CELLPADDING=2>\n";
    $str .= "<TR><TD colspan=2 align=left><B>Number of elements to " .
            "add to list</B>&nbsp;&nbsp;&nbsp;<SELECT name=\"" .
            $field2 . "yxqadd\">\n";
    for ($i2 = 0; $i2 < 10; $i2++)
      $str .= "<OPTION" . ($i2 ? "" : " SELECTED") . "> $i2\n";
    $str .= "</SELECT></TD></TR>\n";
    $arr = (strlen ($default) > 0) ? explode (",", $default) : array();
    while (list ($key, $val) = each ($arr)) {
      $elemname = $field2 . "yxq" . $key . "x";
      $str .= "<TR><TD colspan=2 align=left><B>Element " . ($key + 1) .
              "&nbsp;&nbsp;&nbsp;</B><INPUT type=checkbox name=\"delete" .
              $elemname . "\">Mark as deleted</TD></TR>\n";
      $str .= editobject (substr ($type, 8), $val, $problem,
                          "internal_key", "", 0, $elemname);
    }
    return $str . "</TABLE></TD></TR>\n";
  }

  function createobject ($objecttype, $problem, $key, $global=0) {
    global $textsize;
    $str = "";
    if ($global) {
      $str .= "<tr><td bgcolor=\"#dddddd\">Name</td><td><input " .
           "type=text name=\"global\" size=" . $textsize . "></td></tr>\n";
      $str .= "<tr><td></td></tr>\n";
      $str .= "<tr><td></td></tr>\n";
      $str .= "<tr><td></td></tr>\n";
      $str .= "<tr><td></td></tr>\n";
    }
    $fields = array();
    fieldsfortype ($problem, $objecttype, "", $fields, array());
    for ($i = 0; $i < sizeof ($fields); $i++)
      $str .= onerow ($fields[$i][0], $key, $fields[$i][1], "",
                      0, $fields[$i][2] == "true");
    setupform ($str, $objecttype, $objectname, $problem, "Create",
               $key, "");
  }

  function editobject ($objecttype, $objectname, $problem, $key,
                       $global="", $doform=1, $prefix="") {
    $fields = array();
    fieldsforobject ($problem, $objecttype, $objectname, "", $key, 0,
                     $fields, $dummy, $dummy, $dummy, $objecttype,
                     $dummy);
    $str = "";
    for ($i = 0; $i < sizeof ($fields); $i++) {
      if (! $fields[$i]["islist"])
        $val = $fields[$i]["value"];
      else {
        $val = "";
        for ($j = 0; $j < sizeof ($fields[$i]["list"]); $j++)
          $val .= ($j ? "," : "") .
                  replaceSubstring ($fields[$i]["list"][$j],
                  ",", "&quot;,&quot;");
      }
      $str .= onerow ($fields[$i]["field_name"], $key,
                      $fields[$i]["datatype"], $val,
                      $fields[$i]["islist"], $fields[$i]["isglobalptr"],
                      $problem, $prefix);
    }
    if ($doform)
      setupform ($str, $objecttype, $objectname, $problem, "Edit",
                 $key, $global);
    else
      return $str;
  }
?>
