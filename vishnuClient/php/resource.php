<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// View the data and assignments for a particular resource

  require ("browserlink.php");
  require ("gantt.php");
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
             "&setupdisplay=" . getdisplay ($problem, "setup") .
             "&wrapupdisplay=" . getdisplay ($problem, "wrapup") .
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

  function hintsForPage () {
    global $action;
    if ($action == "View") {
?>
This page shows both the Gantt chart for the given resource
as well as the internal data for this resource.  With the
"view" option, there are no actions with the internal data.
(To edit this data, use the "edit" option.)
However, there are a variety of actions associated with
the assignment/Gantt data.
<p>
<? ganttHints(); ?>
<p>
The tasks/assignments displayed in the Gantt chart are
selectable as links.  Clicking on one of the
colored assignment regions will display the
information associated with this assignment.  If the assignment
is a single task, it will show the page for that task, and if
the assignment has multiple tasks, it will display a list of
these tasks along with the times.
<p>
<b>Note:</b> If this problem is an assignment problem rather than
a scheduling problem (i.e., it has no concept of time), instead
of the Gantt chart display will be just a list of all the tasks
assigned to the resource.
<?
    } else if ($action == "View All")
      showHints();
    else if ($action == "Create")
      hintsForCreate();
    else if ($action == "Edit")
      hintsForEdit();
  }
?>
