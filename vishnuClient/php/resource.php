<?
  // View the data and assignments for a particular resource

  require ("browserlink.php");
  require_once ("utilities.php");
  require ("editobject.php");
  require ("showobjects.php");

  if (! $action)
    $action = "View";
  if ($action == "View") {
    $norightbar = 1;
    $horizbar = 1;
  }
  require ("navigation.php");

  function getTitle () {
    global $action;
    if ($action == "View All")
      showTitle();
    else if ($action == "View")
      getSubheader();
    else
      getHeader();
  }

  function getHeader() {
    global $resourceobject, $resourcename, $action;
    if ($action == "Edit")
      echo "Editing " . $resourceobject . " - " . $resourcename;
    else if ($action == "Create")
      echo "Creating new " . $resourceobject;
    else if ($action == "View All")
      showHeader();
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

    if ($action == "View All") {
      showContent();
      return;
    }
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
    if (! $ignoretime) {
      $window = resourcewindow ($problem, $ismultitask || $isgrouped,
                                $resourcename);
      $task_start = $window["start_time"];
      $task_end = $window["end_time"];
      $window = getwindow ($problem);
      $win_start = maketime ($window["start_time"]);
      if ($window["end_time"])
        $win_end = maketime ($window["end_time"]);
      else
        $win_end = $task_end;
      if ((! $start_time) && (! $end_time)) {
        $start_time = $win_start;
        $end_time = $win_end;
      }
      if ($start_time == $end_time)
        $ignoretime = 1;

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
                     $end_time, $win_start, $win_end, $task_start, $task_end);
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
