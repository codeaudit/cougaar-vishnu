<?
  require_once ("utilities.php");

  function setupform ($str, $objecttype, $objectname, $problem,
                      $action, $key, $global) {
    echo "<h2>Warning: lists of objects cannot be handled yet.</h2><br>\n";
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

  function onerow ($field, $key, $type, $default) {
    $textsize = 50;
    return "<TR><TD nowrap bgcolor=\"#dddddd\">" .
              $field . "<font color=\"#BB0000\">" . 
              (($field == $key) ? " (KEY)" : "") .
              " (" . $type . ")" . "</font>" .
              "</TD><TD>" . "<INPUT TYPE=text name=\"field".
              replaceSubstring ($field, ".", "qxy") .
              "\" value =\"" . $default .
              "\" size=" . $textsize . "></TD></TR>\n";
  }

  function createobject ($objecttype, $problem, $key, $global=0) {
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
      $str .= onerow ($fields[$i][0], $key, $fields[$i][1], "");
    setupform ($str, $objecttype, $objectname, $problem, "Create",
               $key, "");
  }

  function editobject ($objecttype, $objectname, $problem, $key, $global="") {
    $fields = array();
    fieldsforobject ($problem, $objecttype, $objectname, "", $key, 0,
                     $fields, $dummy, $dummy, $dummy, $objecttype,
                     $dummy);
    $str = "";
    for ($i = 0; $i < sizeof ($fields); $i++) {
      if (! $fields[$i]["islist"])
        $val = $fields[$i]["value"];
      else if (! $fields[$i]["subobjects"]) {
        $val = "";
        for ($j = 0; $j < sizeof ($fields[$i]["list"]); $j++)
          $val .= ($j ? "," : "") .
                  replaceSubstring ($fields[$i]["list"][$j],
                  ",", "&quot;,&quot;");
      }
      $str .= onerow ($fields[$i]["field_name"], $key,
                      $fields[$i]["datatype"], $val);
    }
    setupform ($str, $objecttype, $objectname, $problem, "Edit",
               $key, $global);
  }
?>
