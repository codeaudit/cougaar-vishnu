<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// The main page for viewing a particular problem

  require ("browserlink.php");
  require ("utilities.php");
  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Problem " . $problem;
  }

  function getHeader() {
    global $problem;
    echo "Main Page for <font color=\"000099\">$problem</font>";
  }

  function getSubheader() {
  }

  function hintsForPage() {
    global $problem;
?>
<H2>Working on it.</H2>
This is the main page for the problem <? echo $problem; ?>.
All the basic actions you can perform for this problem
are essentially one or two clicks away from this page, and the
navigation bar will allow you to return to this page with one
click from any page related to this problem.
<p>
The basic actions you can perform are:
<ul>
<li> <b>Edit/view the problem description -</b>
At the bottom of this page is a description of the problem.
Any changes you make to the description do not get written
back to the server (and hence become permanent) until you
click on "Update Description".
<li> <b>Edit/view the data -</b>
There are three types of data: tasks, resources, and other data
(or global data).
Each type of data has its own pick list.
To view or edit a particular data object, first select its name from
the appropriate pick list.
Then click on the corresponding "View" button to just view the
data in all the fields of this object or "Edit" to view this data
and potentially change the values in these fields.
When editing a data object, you will also have the option of deleting it.
The "View All" button bring you to a page with links to all the task
and resource objects rather than having them in pick list.  This is
a convenience for the case when there are a lot of tasks or resources
and the pick list gets very big.
To create a new data object, click on the appropriate "Create" button,
and you will create a new object and be brought to the editing page
in order to fill in the values for its fields.
<li> <b>Edit/view the data formats -</b>
<li> <b>View the schedule -</b>
<li> <b>Edit/view the problem-specific scheduling logic-</b>
<li> <b>Edit/view the parameter -</b>
<li> <b>Start the automated scheduler -</b>
<li> <b>Check the status of the automated scheduler -</b>
<li> <b>Load more data into the problem -</b>
<li> <b>Save the problem to a file -</b>
<li> <b>Make a copy of the problem -</b>
</ul>
<?
  }

  function selectBoxes ($viewall = 0) {
    global $problem;
?>
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=submit VALUE="View" NAME="action">
  <INPUT TYPE=submit VALUE="Edit" NAME="action">
&nbsp;&nbsp;&nbsp;
  <INPUT TYPE=submit VALUE="Create" NAME="action">
<?  if ($viewall) { ?>
  <INPUT TYPE=submit VALUE="View All" NAME="action">
<?  }
  }

  function mainContent () {
    global $problem, $description;

    if ($description)
      mysql_db_query ("vishnu_prob_$problem",
          "update description set d = \"$description\";");

    $arr = gettaskandresourcetypes ($problem);
    $taskobject = $arr[0];
    $resourceobject = $arr[1];

    $result = mysql_db_query ("vishnu_prob_" . $problem,
                 "select * from object_fields where is_key=\"true\";");
    while ($value = mysql_fetch_array ($result)) {
      if ($value["object_name"] == $taskobject)
        $taskkey = $value["field_name"];
      if ($value["object_name"] == $resourceobject)
        $resourcekey = $value["field_name"];
    }
    mysql_free_result ($result);
?>

<table COLS=2 WIDTH=700 >
<tr>
<td COLSPAN="2" BGCOLOR="<? echo getcolor(); ?>">
<font size=+2>View & Edit</font></td>
</tr>

<tr>
<td ALIGN=center><font size=+2>
<? if ($taskobject) echo $taskobject . " (Task)" ?></font></td>
<td ALIGN=center><font size=+2>
<? if ($resourceobject) echo $resourceobject . " (Resource)" ?></font></td>
</tr>
<tr>
<td ALIGN=center valign=top>
<?
   if ($taskobject) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select obj_" . $taskkey . " from obj_" . $taskobject .
                " order by obj_" . $taskkey . ";");
?>
<FORM METHOD="get" ACTION="task.php">
  <SELECT NAME="taskname">
    <?
    while ($value = mysql_fetch_row ($result))
      echo "<OPTION> $value[0]";
    ?>
  </SELECT>
  <INPUT TYPE=hidden NAME="taskobject" VALUE="<? echo $taskobject ?>">
  <INPUT TYPE=hidden NAME="taskkey" VALUE="<? echo $taskkey ?>">
  <INPUT TYPE=hidden NAME="resourceobject" VALUE="<? echo $resourceobject ?>">
  <INPUT TYPE=hidden NAME="resourcekey" VALUE="<? echo $resourcekey ?>">
<? selectBoxes (1); ?>
</FORM>

<?  mysql_free_result ($result);
 }
?>

</td>

<td ALIGN=center valign=top>
<?
   if ($resourceobject) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                   "select obj_" . $resourcekey . " from obj_" .
                   $resourceobject . " order by obj_" . $resourcekey . ";");
?>
<FORM METHOD="get" ACTION="resource.php">
  <SELECT NAME="resourcename">
    <?
    while ($value = mysql_fetch_row ($result))
      echo "<OPTION> $value[0]";
    ?>
  </SELECT>
  <INPUT TYPE=hidden NAME="resourceobject" VALUE="<? echo $resourceobject ?>">
  <INPUT TYPE=hidden NAME="taskobject" VALUE="<? echo $taskobject ?>">
  <INPUT TYPE=hidden NAME="resourcekey" VALUE="<? echo $resourcekey ?>">
  <INPUT TYPE=hidden NAME="taskkey" VALUE="<? echo $taskkey ?>">
<? selectBoxes (1); ?>
</FORM>
<?  mysql_free_result ($result);
 }
?>

</td>
</tr>

<?
    $showutil = isgrouped ($problem) || ismultitask($problem);
    // temporarily don't use asset utilization display
    $showutil = 0;
?>

<tr>
<td <? //if (! $showutil) echo "COLSPAN=2"; ?> align=center valign=top>
<table>
<tr><td ALIGN=center><font size=+2>Other Data</font></td></tr>
<tr><td ALIGN=center>
<FORM METHOD="get" ACTION="otherdata.php">
  <SELECT NAME="dataname">
    <?
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select name from globals order by name;");
    while ($value = mysql_fetch_row ($result))
      echo "<OPTION> $value[0]";
    mysql_free_result ($result);
    ?>
  </SELECT>
<? selectBoxes(); ?>
</FORM>
</td></tr>
</table>
</td>

<td align=center valign=top>
<table>
<tr><td ALIGN=center><font size=+2>Objects (Metadata)</font></td></tr>
<tr><td ALIGN=center>
<FORM METHOD="get" ACTION="editmeta.php">
  <SELECT NAME="object">
    <?
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                "select name from objects where is_predefined=" .
                "\"false\" order by name;");
    while ($value = mysql_fetch_row ($result))
      echo "<OPTION> $value[0]";
    mysql_free_result ($result);
    ?>
  </SELECT>
<? selectBoxes(); ?>
</FORM>
</td></tr>
</table>
</td>

<?
    if ($showutil) {
?>
<td ALIGN=CENTER>
<font size=+2>
<? 
      $url = "assets.php?";
      $url .= "problem=" . $problem . "&";
      $url .= "resourceobject=" . $resourceobject . "&";
      $url .= "taskobject=" . $taskobject . "&";
      $url .= "resourcekey=" . $resourcekey . "&";
      $url .= "taskkey=" . $taskkey;
  ?>
<a href="<? echo $url; ?>"/>Resource Utilization</a>
</font>
</td>
<?
    }
?>
</tr>

<tr>
<td ALIGN=CENTER>
<font size=+2>
<a href="viewspecs.php?problem=<? echo $problem; ?>"/>Scheduling Specs</a>
</font>
</td>

<td ALIGN=CENTER>
<font size=+2>
<? 
    $url = "schedule.php?";
    $url .= "problem=" . $problem . "&";
    $url .= "resourceobject=" . $resourceobject . "&";
    $url .= "taskobject=" . $taskobject . "&";
    $url .= "resourcekey=" . $resourcekey . "&";
    $url .= "taskkey=" . $taskkey;
?>
<a href="<? echo $url; ?>"/>Full Schedule</a>
</font>
</td>
</tr>

<tr>
<td ALIGN=CENTER colspan=2>
<font size=+2>
<a href="parameters.php?problem=<? echo $problem; ?>"/>Parameters</a>
</font>
</td>
</tr>

<tr>
<td ALIGN=RIGHT>&nbsp;</td>
<td ALIGN=RIGHT></td>
</tr>

<tr>
<td COLSPAN="2" BGCOLOR="<? echo getcolor(); ?>">
<font size=+2>Scheduler</font></td>
</tr>
<tr><td colspan=2><TABLE CELLPADDING=0><TR><TD><TD></TR></TABLE></td></tr>

<tr>
<td ALIGN=CENTER>
<font size=+2>
<a href="kickoff.php?problem=<? echo $problem; ?>"/>Start!</a>
</font>
</td>

<td ALIGN=CENTER>
<font size=+2>
<? 
    $url = "status.php?problem=" . $problem;
?>
<a href="<? echo $url; ?>"/>Status</a>
</font>
</td>
</tr>

<tr>
<td>&nbsp;</td>
<td></td>
</tr>

<tr>
<td COLSPAN="2" BGCOLOR="<? echo getcolor(); ?>">
<font size=+2>Problem Data</font></td>
</tr>
<tr><td colspan=2><TABLE CELLPADDING=0><TR><TD><TD></TR></TABLE></td></tr>

<tr>
<td ALIGN=CENTER>
<font size=+2>
<a href="loadproblem2.php?problem=<? echo $problem; ?>"/>
Update from File</a>
</font>
</td>

<td ALIGN=CENTER>
<font size=+2>
<a href="saveproblem.php?problem=<? echo $problem; ?>"/>Save to File</a>
</font>
</td>
</tr>

<tr>
<td ALIGN=CENTER colspan=2>
<font size=+2>
<a href="copyproblem.php?problem=<? echo $problem; ?>"/>Copy Problem</a>
</font>
</td>
</tr>

<tr>
<td>&nbsp;</td>
<td></td>
</tr>

<tr>
<td COLSPAN="2" BGCOLOR="<? echo getcolor(); ?>">
<font size=+2>Problem Description</font></td>
</tr>
<tr><td colspan=2><TABLE CELLPADDING=0><TR><TD><TD></TR></TABLE></td></tr>

<tr><td colspan="2" align=center>
<form method=post action="problem.php">
<textarea name="description" rows=4 cols=70>
<?
    $result = mysql_db_query ("vishnu_prob_$problem",
                              "select d from description;");
    if ($result) {
      $value = mysql_fetch_array ($result);
      echo $value[0];
    }
?>
</textarea></font><br>
<input type=hidden name=problem value="<? echo $problem; ?>">
<input type=submit value="Update Description">
</form>
</td></tr>

</table>

<? } ?>
