<?
  require ("browserlink.php");
  require_once ("utilities.php");
  require ("editobject.php");

  if (! $action)
    $action = "View";
  require ("navigation.php");

  function getTitle () {
    global $dataname, $action;
    if ($action == "View")
      echo "Viewing $dataname";
    else if ($action == "Edit")
      echo "Editing $dataname";
    else if ($action == "Create")
      echo "Creating new object";
  }
  function getHeader() {
    global $dataname, $action, $objecttype;
    if ($action == "View")
      echo "Viewing data for object $dataname";
    else if ($action == "Edit")
      echo "Editing data for object $dataname";
    else if ($action == "Create")
      echo "Creating new object" .
           ($objecttype ? (" of type " . $objecttype) : "");
  }
  function getSubheader() { 
  }

  function mainContent () {
    global $problem, $dataname, $action, $objecttype;

    if ($action == "Create") {
      if (! $objecttype) {
?>
<h2>Select type of object to create</h2><br>
<FORM METHOD=post ACTION="otherdata.php">
<SELECT NAME="objecttype">
<?
        $result = mysql_db_query ("vishnu_prob_" . $problem,
                    "select name from objects where is_task=\"false\" " .
                    "and is_resource=\"false\" order by name;");
        while ($value = mysql_fetch_row ($result))
          echo "<OPTION> $value[0]\n";
?>
</SELECT>
<INPUT TYPE=submit VALUE="Go">
<INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
<INPUT TYPE=hidden NAME="action" VALUE="Create">
</FORM>
<?
        return;
      }

      createobject ($objecttype, $problem, "", 1);
      return;
    }

    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select * from globals where name = \"" . $dataname . "\";");
    $value = mysql_fetch_array ($result);
    mysql_free_result ($result);
    if (! $value) {
      echo "No global variable named $dataname";
      return;
    }

    if ($action == "Edit") {
      editobject ($value["datatype"], $value["id"], $problem,
                  "internal_key", $dataname);
      return;
    }

    $specialobjs = specialdisplaytypes();
    echo "<TABLE BORDER=1>\n<TR>\n<TD><B>";
    if (! $specialobjs [$value["datatype"]])
      echo "Field Name</B></TD>\n<TD><B>Value</B></TD>\n</TR>";
    printobject ($problem, $value["datatype"], $value["id"],
                 "internal_key");
    if ($specialobjs [$value["datatype"]])
      echo "</B></TD>\n</TR>";
    echo "</TABLE>\n";

    mysql_close();
  }
?>
