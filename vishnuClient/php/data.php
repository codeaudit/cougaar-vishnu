<?
  // Returns the XML for the data in the form that the scheduler likes
  // to see it.  Note that this is different from how the database likes
  // to read it originally, which is why this cannot just use datasupport.php.

  Header("Content-Type: text/xml");
  require ("utilities.php");
  require ("clientlink.php");

  // get data about task/resource object (name and key to access)
  $arr = gettaskandresourcetypes ($problem);
  $taskobject = $arr[0];
  $resourceobject = $arr[1];
  $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select * from object_fields where is_key = \"true\";");
  while ($value = mysql_fetch_array ($result)) {
    if ($value["object_name"] == $taskobject)
      $taskkey = $value["field_name"];
    if ($value["object_name"] == $resourceobject)
      $resourcekey = $value["field_name"];
  }
  mysql_free_result ($result);

  // set up restricted fields array
  if ($fields) {
    $arr1 = explode (";", $fields);
    $restrictedfields = array();
    for ($i = 0; $i < sizeof ($arr1); $i++) {
      $pos = strpos ($arr1[$i], ":");
      $type = substr ($arr1[$i], 0, $pos);
      if ($type == "task")
        $type = $taskobject;
      if ($type == "resource")
        $type = $resourceobject;
      $arr2 = explode (":", substr ($arr1[$i], $pos + 1));
      $restrictedfields[$type] = array();
      for ($j = 0; $j < sizeof($arr2); $j++)
        $restrictedfields[$type][$arr2[$j]] = 1;
    }
  }

  $formats = array();

  echo "<?xml version='1.0'?>\n";
  echo "<DATA>\n";

  // write scheduling window
  $window = getwindow ($problem);
  echo "<WINDOW start=\"" . $window["start_time"] . "\" end=\"" .
       $window["end_time"] . "\" />\n";
  $predefined = getpredefinedobjects ($problem);

  function writeobject ($problem, $object, $keyvalue, $keyname) {
    global $predefined, $restrictedfields, $formats;
    $fields = array();
    fieldsforobject ($problem, $object, $keyvalue, "", $keyname, 0, $fields,
                     $predefined, $empty, $restrictedfields, $object,
                     $formats);
    for ($i = 0; $i < sizeof ($fields); $i++) {
      echo "<FIELD name=\"" . $fields[$i]["field_name"] .
           "\" type=\"" . $fields[$i]["datatype"] . "\" ";
      if ($fields[$i]["objvalue"]) {
        echo "obj=\"t\" >\n";
        echo "<OBJECT>\n";
        writeobject ($problem, $fields[$i]["datatype"],
                     $fields[$i]["objvalue"], "internal_key");
        echo "</OBJECT>\n";
        echo "</FIELD>\n";
      }
      else if (! $fields[$i]["islist"]) {
        echo "value=\"" . $fields[$i]["value"] . "\"";
        if ($fields[$i]["iskey"])
          echo " key=\"t\"";
        echo " />\n";
      }
      else {
        echo "list=\"t\" >\n";
        for ($j = 0; $j < sizeof ($fields[$i]["list"]); $j++)
          if (! $fields[$i]["subobjects"])
            echo "<VALUE value=\"" . $fields[$i]["list"][$j] . "\" />\n";
          else {
            echo "<VALUE2>\n";
            writeobject ($problem, $fields[$i]["datatype"],
                         $fields[$i]["list"][$j], "internal_key");
            echo "</VALUE2>\n";
          }
        echo "</FIELD>\n";
      }
    }
  }

  // write tasks
  $is_multitask = ismultitask ($problem);
  if ($is_multitask)
    $sql = "select obj_$taskkey from obj_$taskobject;";
  else {
    $sql = "select obj_$taskkey from obj_$taskobject left join " .
           "assignments on obj_$taskkey = task_key where " .
           "(frozen is null) or (frozen = \"no\") or ";
    if ($window["end_time"])
      $sql .= "((setup_time < \"" . $window["end_time"] . "\") and " .
              "(wrapup_time > \"" . $window["start_time"] . "\"));";
    else
      $sql .= "(wrapup_time > \"" . $window["start_time"] . "\");";
  }
  $result = mysql_db_query ("vishnu_prob_$problem", $sql);
  if (!$result)
    echo "data.php - error on query - " . mysql_error () . " sql=$sql";

  while ($value = mysql_fetch_row ($result)) {
    echo "<TASK>\n";
    writeobject ($problem, $taskobject, $value[0], $taskkey);
    echo "</TASK>\n";
  }
  mysql_free_result ($result);

  // write resources
  $result = mysql_db_query ("vishnu_prob_" . $problem,
               "select obj_" . $resourcekey . " from obj_" .
               $resourceobject . ";");

  if (!$result) {
    echo "data.php - error on query - " . mysql_error ();
    echo " sql=" . "select obj_" . $resourcekey . " from obj_" . $resourceobject;
  }

  while ($value = mysql_fetch_row ($result)) {
    echo "<RESOURCE>\n";
    writeobject ($problem, $resourceobject, $value[0], $resourcekey);
    echo "</RESOURCE>\n";
  }
  mysql_free_result ($result);

  // write globals
  $result = mysql_db_query ("vishnu_prob_" . $problem,
                            "select * from globals;");
  if (!$result) {
    echo "data.php - error on query - " . mysql_error ();
    echo " sql=" . "select * from globals;";
  }

  while ($value = mysql_fetch_array ($result)) {
    echo "<GLOBAL name=\"" . $value["name"] .
         "\" type =\"" . $value["datatype"] . "\" >\n";
    writeobject ($problem, $value["datatype"], $value["id"], "internal_key");
    echo "</GLOBAL>\n";
  }
  mysql_free_result ($result);

  // write frozen assignments
  if ($is_multitask)
    $sql = "select * from assignments where frozen = \"yes\";";
  else {
    $sql = "select * from assignments where frozen = \"yes\" and ";
    if ($window["end_time"])
      $sql .= "((setup_time < \"" . $window["end_time"] . "\") and " .
              "(wrapup_time > \"" . $window["start_time"] . "\"));";
    else
      $sql .= "(wrapup_time > \"" . $window["start_time"] . "\");";
  }
  $result = mysql_db_query ("vishnu_prob_$problem", $sql);
  while ($value = mysql_fetch_array ($result)) {
    echo "<FROZEN task=\"" . $value["task_key"] .
         "\" resource =\"" . $value["resource_key"] .
         "\" start =\"" . $value["start_time"] .
         "\" end =\"" . $value["end_time"] . "\" />\n";
  }

  echo "</DATA>\n";

  mysql_close();
?>
