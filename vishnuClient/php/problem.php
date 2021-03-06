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
<a href="viewspecs.php?problem=<? echo $problem; ?>"/>Scheduling Logic</a>
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

<?
  }

  function hintsForPage() {
    global $problem;
?>
This is the main page for the problem <? echo $problem; ?>.
All the basic actions you can perform for this problem
are essentially one or two clicks away from this page, and the
navigation bar will allow you to return to this page with one
click from any page related to this problem.
<p>
The basic actions you can perform are:
<ul>
<li> <b>View the schedule -</b>
Click on "Full Schedule" to see
the Gantt charts for all the resources aligned
to the same time axis.  This option is also available in the
navigation bar.
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
Clicking on the corresponding "View" button allows you to view the
data in all the fields of this object along with the assignment
data for that object (the assigned resource and time interval for
a task or a Gantt chart for a resource).
Clincking on "Edit" allows you to view the data in the fields of the object
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
The pick list under "Objects" contains the list of all object types
defined so far.  Selecting an object type and clicking the
corresponding "View" button will allow you to see all the data
fields in that object type along with their corresponding data types.
Selecting an object type and clicking the "Edit" button will allow
you not only to view the current definition of that object type
but also to add new fields, change the data types of existing
fields, rename fields, and delete fields.  Note that
changing the data type on a field or deleting a field causes
all existing instances of that object type to lose the data
in that field.
If you are creating a problem from scratch, the first thing
you need to do is create task and resource objects and define
their formats.  Until you have defined these formats, you cannot
create tasks and resources, nor can you start defining the
problem-specific scheduling logic.
<li> <b>Edit/view the problem-specific scheduling logic-</b>
Clicking on "Scheduling Logic" brings you to a page where you can
view all the available constraints/hooks along with their current
associated formulas. From there, you can edit any of the formulas.
<li> <b>Edit/view the parameters -</b>
Clicking on "Parameters" will allow you to view and modify the start and end
times of the scheduling window (i.e., the times before and after
which no task can be scheduled) as well as the genetic algorithm
parameters that control the behavior of the automated scheduler.
<li> <b>Start the automated scheduler -</b>
Clicking on "Start!" submits a request for the automated scheduler
to run on this problem and create a new schedule.
If the automated scheduler is not immediately available, the
request will be placed in a queue and handled as soon as possible.
<li> <b>Check the status of the automated scheduler -</b>
There are various states that the automated scheduler can be in
with respect to a particular problem:
<ul>
<li>There has been no scheduling request made.
<li>The most recent scheduling request has been completed.
<li>The most recent scheduling request has been canceled.
<li>The most recent scheduling request is still in the queue.
<li>The automated scheduler is currently computing a schedule.
</ul>
Clicking on "Status" will let you know which state it is in.  If
the scheduler is currently processing, it will give an estimate of
the percent complete the run is.
It will also let you know at what time the most recent request was
submitted.
The scheduler status page also contains the option of canceling
the current scheduler request.
<li> <b>Load more data into the problem -</b>
While the object formats and problem-specific logic should
remain constant, the data for a scheduling problem will often
change with time.  Clicking the "Update From File" button
will load an update to the data (additions of new objects as well
as modifications and deletions of old objects) from a file.
<li> <b>Save the problem to a file -</b>
This will save the entire problem or a portion of the problem
to a file.  This allows you to save a current snapshot of the
problem before it changes or gets deleted.  It also allows easy
transfer of problems between different Vishnu servers.
<li> <b>Make a copy of the problem -</b>
Clicking on "Copy the Problem" will make an exact copy of this
problem under a different problem name.  You will be prompted
for the problem name at the next page.
This is very useful for doing what-if analyses (since you can
copy a problem, change it a little, and see the results).
</ul>
<?
  }
?>
