<?
  require ("browserlink.php");
  require_once ("utilities.php");
  require ("parseproblem.php");

  $atomictypes = array ("string", "number", "datetime", "boolean");
  $isatomic = array();
  while (list ($akey, $aval) = each ($atomictypes))
    $isatomic [$aval] = 1;

  require ("navigation.php");

  function getTitle () {
    global $object, $action, $field;
    if ($action == "View")
      echo "Viewing $object";
    else if ($action == "Edit")
      echo "Editing $object";
    else if ($action == "Create")
      echo "Creating new object";
    else if ($action == "Create Object")
      echo "Created object $object";
    else if ($action == "Add Field")
      echo "Added field $field";
    else if ($action == "Delete Field")
      echo "Deleted field $field";
    else if ($action == "Rename Field")
      echo "Renamed field $field";
    else if ($action == "Change Field")
      echo "Changed field $field";
  }

  function errout ($message) {
    global $error;
    echo $message;
    $error = 1;
    return 0;
  }

  function checkFieldUnique ($field, $context) {
    global $object, $problem;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select * from object_fields where object_name = \"" .
                $object . "\" and field_name = \"" . $field . "\";");
    if (mysql_num_rows ($result))
      return errout
        ("Error $context, there already exists a field called $field.");
    return 1;
  }

  function checkNotEmpty ($field, $context, $name) {
    if (! $field)
      return errout ("Error $context, need to specify non-empty $name.");
    return 1;
  }

  function checkNameLegal ($name, $context) {
    if (! isNameLegal ($name))
      return errout ("Error $context, illegal name $name.");
    return 1;
  }

  function getHeader() {
    global $object, $action, $problem, $trtype, $user, $password;
    global $isatomic, $field, $datatype, $listglob;
    global $field2, $keyname;
    $list = $listglob == "list";
    $globalptr = $listglob == "glob";

    if ($action == "View")
      echo "Viewing structure of object $object";
    else if ($action == "Edit")
      echo "Editing structure of object $object";
    else if ($action == "Create")
      echo "Creating new object";

    else if ($action == "Create Object") {
      if (! checkNotEmpty ($object, "creating object", "object name"))
        return;
      if (! checkNameLegal ($object, "creating object"))
        return;
      if (($trtype == "task") || ($trtype == "resource")) {
        if (! checkNotEmpty ($keyname, "creating object",
                             "key name for $trtype"))
          return;
        if (! checkNameLegal ($keyname, "creating object"))
          return;
        $tr = gettaskandresourcetypes ($problem);
        if (($trtype == "task") && $tr[0])
          return errout ("Error, already have a task object defined.");
        if (($trtype == "resource") && $tr[1])
          return errout ("Error, already have a resource object defined.");
        $keystr = "<FIELDFORMAT name=\"" . $keyname . "\" datatype=" .
                  "\"string\" is_key=\"true\" />\n";
      }
      $xml = "<DATAFORMAT>\n" . "<OBJECTFORMAT name=\"" . $object .
             "\" is_task=\"" . (($trtype == "task") ? "true" : "false") .
             "\" is_resource=\"" .
             (($trtype == "resource") ? "true" : "false") . "\">\n" .
             $keystr . "</OBJECTFORMAT>\n</DATAFORMAT>\n";
      echo $xml;
      parseproblem ($xml, $user, $password);
      echo "Created object $object. Now specify the fields one at a time.";
    }

    else if ($action == "Add Field") {
      if (! checkNotEmpty ($field, "adding field", "field name"))
        return;
      if (! checkNotEmpty ($datatype, "adding field", "data type"))
        return;
      if (! checkNameLegal ($field, "adding field"))
        return;
      if (! checkFieldUnique ($field, "adding field"))
        return;
      if ($globalptr && $isatomic[$datatype])
        return errout ("Error, global pointer referencing an atomic type");
      $issub = (! $isatomic[$datatype]) && (! $globalptr);
      do_query ("prob_" . $problem, "Adding field", $object, $field,
                "insert into object_fields values (\"" . $field .
                "\", \"" . $object . "\", \"" . $datatype . "\", \"" .
                ($globalptr ? "true" : "false") . "\", \"" .
                ($issub ? "true" : "false") . "\", \"" .
                ($list ? "true" : "false") . "\", \"false\");");
      do_query ("prob_" . $problem, "Adding field", $object, $field,
                "alter table obj_" . $object . " add obj_" . $field . " " .
                sqlType ($datatype, $list, $issub, $globalptr) .
                " not null;");
      echo "Added field " . $field . " to object " . $object;
    }

    else if ($action == "Delete Field") {
      if (! checkNotEmpty ($field, "deleting field", "field name"))
        return;
      do_query ("prob_" . $problem, "Deleting field", $object, $field,
                "delete from object_fields where object_name=\"" .
                $object . "\" and field_name=\"" . $field . "\";");
      do_query ("prob_" . $problem, "Deleting field", $object, $field,
                "alter table obj_" . $object . " drop obj_" . $field . ";");
      echo "Deleted field " . $field . " from object " . $object;
    }

    else if ($action == "Rename Field") {
      if (! checkNotEmpty ($field, "renaming field", "field name"))
        return;
      if (! checkNotEmpty ($field2, "renaming field", "new field name"))
        return;
      if (! checkNameLegal ($field2, "renaming field"))
        return;
      if (! checkFieldUnique ($field2, "renaming field"))
        return;
      do_query ("prob_" . $problem, "Renaming field", $object, $field,
                "update object_fields set field_name=\"" . $field2 .
                "\" where object_name=\"" .
                $object . "\" and field_name=\"" . $field . "\";");
      $result = do_query ("prob_" . $problem, "Renaming", $object, $field,
                    "show columns from obj_" . $object . ";");
      while ($value = mysql_fetch_array ($result)) {
        if ($value["Field"] == ("obj_" . $field)) {
          $datatype = $value["Type"];
          break;
        }
      }
      do_query ("prob_" . $problem, "Renaming field", $object, $field,
                "alter table obj_" . $object . " change obj_" .
                $field . " obj_" . $field2 . " $datatype not null;");
      echo "Renamed field " . $field . " as " . $field2 .
           " in object " . $object;
    }

    else if ($action == "Change Field") {
      if (! checkNotEmpty ($field, "changing field", "field name"))
        return;
      if (! checkNotEmpty ($datatype, "changing field", "data type"))
        return;
      do_query ("prob_" . $problem, "Changing field", $object, $field,
                "delete from object_fields where object_name=\"" .
                $object . "\" and field_name=\"" . $field . "\";");
      do_query ("prob_" . $problem, "Changing field", $object, $field,
                "insert into object_fields values (\"" . $field .
                "\", \"" . $object . "\", \"" . $datatype . "\", \"" .
                ($globalptr ? "true" : "false") . "\", \"" .
                ($isatomic[$datatype] ? "false" : "true") . "\", \"" .
                ($list ? "true" : "false") . "\", \"false\");");
      do_query ("prob_" . $problem, "Changing field", $object, $field,
                "alter table obj_" . $object . " modify obj_" .
                $field . " " .
                sqlType ($datatype, $list, ! $isatomic[$datatype],
                         $globalptr) . " not null;");
      echo "Changed field " . $field . " in object " . $object;
    }

  }

  function getSubheader() { 
  }


  function newEntry ($fields, $alignleft = array()) {
    global $problem, $object;
?>
<FORM method=post action="editmeta.php">
<INPUT type=hidden name=object value="<? echo $object ?>">
<INPUT type=hidden name=problem value="<? echo $problem ?>">
<TABLE CELLPADDING=8 border=1 BGCOLOR="ddddff"><TR>
<?
    while (list ($key, $field) = each ($fields)) {
      if ($alignleft[$key])
        echo "<TD nowrap>" . $field . "</TD>\n";
      else
        echo "<TD nowrap align=center width=" . ($key ? 175 : 125) .
             ">\n" . $field . "\n</TD>\n";
    }
    echo "</TR></TABLE>\n</FORM>\n";
  }

  function selectField ($fields) {
    $str = "<SELECT name=field>\n<OPTION> \n";
    while (list ($field, $datatype) = each ($fields))
      $str .= "<OPTION> $field\n";
    return $str . "</SELECT>\n";
  }

  function selectType ($heading) {
    global $problem, $atomictypes;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select name from objects where is_task=\"false\" " .
                "and is_resource=\"false\" order by name;");
    $str = "<TABLE border=0 cellpadding=0 cellspacing=0><TR>" .
           "<TD align=center nowrap>" . $heading . "<br>\n" .
           "<SELECT name=datatype>\n<OPTION> \n";
    reset ($atomictypes);
    while (list ($akey, $aval) = each ($atomictypes))
      $str .= "<OPTION> $aval\n";
    while ($value = mysql_fetch_array ($result))
      $str .= "<OPTION> $value[0]\n";
    $str .= "</SELECT></TD><TD>&nbsp;&nbsp;&nbsp;</TD>" . 
            "<TD align=left nowrap>\n";
    $str .= "<INPUT type=radio name=listglob value=list> List<br>\n";
    $str .= "<INPUT type=radio name=listglob value=glob> Global Ptr<br>\n";
    $str .= "<INPUT type=radio name=listglob value=n checked> Neither<br>\n";
    $str .= "</TD></TR></TABLE>\n";
    return $str;
  }

  function mainContent () {
    global $problem, $object, $action, $error;

    if ($error)
      return;

    if ($action == "Create") {
      echo "<DIV align=left>";
      $a =array ("<INPUT type=submit name=action value=\"Create Object\">",
                 "Object Name<br>\n<INPUT type=text name=object size=20>",
                 "<INPUT type=radio name=trtype value=task> Task<br>\n" .
                 "<INPUT type=radio name=trtype value=resource> " .
                 "Resource<br>\n" .
                 "<INPUT type=radio name=trtype value=neither checked> " .
                 "Neither\n",
                 "Key Name<br>(only for task or resource)<br>\n" .
                 "<INPUT type=text name=keyname size=20>");
      newEntry ($a, array (0, 0, 1, 0));
      echo "</DIV>";
      return;
    }

    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select * from object_fields where object_name = \"" .
                $object . "\" order by field_name;");
    $fields = array();
    $fields2 = array();
    $flist = array();
    $glist = array();
    while ($value = mysql_fetch_array ($result)) {
      if ($value["field_name"] != "internal_key") {
        $fields[$value["field_name"]] = $value["datatype"];
        if ($value["is_key"] != "true")
          $fields2[$value["field_name"]] = 1;
        if ($value["is_list"] == "true")
          $flist[$value["field_name"]] = 1;
        if ($value["is_globalptr"] == "true")
          $glist[$value["field_name"]] = 1;
      }
    }
    if (sizeof ($fields)) {
      echo "<TABLE border=1 CELLPADDING=3 bgcolor=\"#dddddd\">\n";
      echo "<TR><TH>Field Name</TH><TH>Field Type</TH></TR>\n";
      while (list ($field, $datatype) = each ($fields))
        echo "<TR><TD nowrap>&nbsp;" . $field .
             ($fields2[$field] ? "" : " (KEY)") .
             "&nbsp;</TD><TD nowrap>&nbsp;" .
             ($glist[$field] ? "global ptr to " : "") .
             ($flist[$field] ? "list of " : "") .
             $datatype . "&nbsp;</TD></TR>\n";
      echo "</TABLE>\n";
    }

    if ($action == "View")
      return;

    echo "<DIV align=left>";

    $a =array ("<INPUT type=submit name=action value=\"Add Field\">",
               "Field Name<br>\n<INPUT type=text name=field size=20>",
               selectType ("Field Type"));
    newEntry ($a);

    if (sizeof ($fields2)) {
      $a =array ("<INPUT type=submit name=action value=\"Delete Field\">",
                 "Field Name<br>\n" . selectField ($fields2));
      newEntry ($a);
    }

    if (sizeof ($fields)) {
      $a =array ("<INPUT type=submit name=action value=\"Rename Field\">",
                 "Old Field Name<br>\n" . selectField ($fields),
                 "New Field Name<br>\n<INPUT type=text name=field2 size=20>");
      newEntry ($a);
    }

    if (sizeof ($fields2)) {
      $a =array ("<INPUT type=submit name=action value=\"Change Field\">",
                 "Field Name<br>\n" . selectField ($fields2),
                 selectType ("New Field Type"));
      newEntry ($a);
    }

    echo "</DIV>";
  }
?>
