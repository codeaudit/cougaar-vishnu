<?
  require ("browserlink.php");
  require ("utilities.php");
  require ("editobject.php");

  if (! $action)
    $action = "View";
  if ($action == "View")
    $norightbar = 1;
  require ("navigation.php");

  function getTitle () {
    getSubheader();
  }
  function getHeader() {
    global $resourceobject, $resourcename, $action;
    if ($action == "Edit")
      echo "Editing " . $resourceobject . " - " . $resourcename;
    else if ($action == "Create")
      echo "Creating new " . $resourceobject;
  }
  function getSubheader() { 
    global $resourceobject, $resourcename, $action;
    if ($action == "View")
      echo "Viewing " . $resourceobject . " - " . $resourcename;
  }

  function mainContent () {
    global $problem, $resourceobject, $taskobject, $resourcekey, $taskkey;
    global $resourcename, $start_time, $end_time, $start_time2, $end_time2;
    global $action;

  if ($action == "Edit") {
    editobject ($resourceobject, $resourcename, $problem, $resourcekey);
    return;
  }
  if ($action == "Create") {
    createobject ($resourceobject, $problem, $resourcekey);
    return;
  }

  $ismultitask = ismultitask ($problem);
  $isgrouped = isgrouped ($problem);
  $ignoretime = ignoringtime ($problem);
  if ($start_time2) {
    $start_time = strtotime ($start_time2);
    $end_time = strtotime ($end_time2);
  }
  if ((! $ignoretime) && (! $start_time) && (! $end_time)) {
    $window = getwindow ($problem);
    $start_time = maketime ($window["start_time"]);
    if ($window["end_time"])
      $end_time = maketime ($window["end_time"]);
    else {
      $window = resourcewindow ($problem, $ismultitask || $isgrouped,
                                $resourcename);
      $end_time = $window["end_time"];
      if ($end_time == 0)
        $end_time = $start_time + 1000000;
      else if ($end_time == $window["start_time"])
        $ignoretime = 1;
    }
  }
  if (! $ignoretime) {
    imagemap ($problem, $taskobject, $taskkey, $resourceobject,
              $resourcekey, $end_time, $start_time,
              $resourcename, $isgrouped, $ismultitask);
  }        

  if ($ignoretime) {
    echo "<B>Assigned Tasks</B><BR><BR>\n";
    assignmenttable ($problem, $taskobject, $taskkey, $resourceobject,
                     $resourcekey, $resourcename);
  }
  else {
    $text1 = "problem=" . $problem .
             "&resourcename=" . urlencode($resourcename); 
    imageControls ("resource", $problem, $resourceobject, $taskobject,
                   $resourcekey, $taskkey, $resourcename, $start_time,
                   $end_time);
    $t = time();
    if (! $ismultitask) {
      echo "<IMG SRC=\"legend.php?data=" . getlegenddata ($problem) . 
           "&t=" . $t . "\"><BR><BR>\n";
    }
    $text2 = "start_time=" . $start_time .
             "&end_time=" . $end_time . "&t=" . $t;
    echo "<IMG SRC=\"labels.php?" . $text2 . "\"><BR>\n";
    echo "<IMG SRC=\"tics.php?" . $text2 . "\"><BR>\n";
    if ($ismultitask)
      echo "<IMG SRC=\"multitaskimage.php?" . $text1 . "&" . $text2 .
           "\" USEMAP=\"#" . $resourcename . "\">";
    else
      echo "<IMG SRC=\"image.php?" . $text1 . "&" . $text2 .
           "&setupdisplay=" . getsetupdisplay ($problem) .
           "&isgrouped=" . $isgrouped .
           "\" USEMAP=\"#" . $resourcename . "\">";
  }
?>

<BR><BR><BR><B>Internal Data</B>
<TABLE BORDER=1>
<TR>
  <TD><B>Field Name</B></TD>
  <TD><B>Value</B></TD>
</TR>
<?
  printobject ($problem, $resourceobject, $resourcename, $resourcekey);
  echo "</TABLE>\n";
  linkToProblem ($problem);
  mysql_close();
  }
?>
