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
  }

  function getSubheader() { 
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
    global $problem;

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

<font size=+3>Viewing problem<br>
<i><font color="000099"><? echo $problem ?></font></i><br>
<TABLE CELLPADDING=1><TR><TD><TD></TR></TABLE>

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
<a href="loadproblem2.php?problem=<? echo $problem; ?>"/>Upload</a>
</font>
</td>

<td ALIGN=CENTER>
<font size=+2>
<a href="saveproblem.php?problem=<? echo $problem; ?>"/>Download</a>
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

</table>
<TABLE CELLPADDING=0><TR><TD><TD></TR></TABLE>

<font size=+1><a href="vishnu.php"/>Home</a></font>

<? } ?>
