<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Set up which parts of a particular problem to download to a file

  require ("browserlink.php");
  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Saving " . $problem;
  }

  function getHeader() {
  }

  function getSubheader() { 
    global $problem;
    echo "Select what to save for problem " . $problem;
  }

  function mainContent () {
    global $problem;
?>
<font size = +1>
<FORM METHOD="get" ACTION="fullproblem.php">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="includeproblem" VALUE="true">
  <INPUT TYPE=hidden NAME="includedata" VALUE="true">
  <INPUT TYPE=submit VALUE="Problem definition and data">
</FORM>

<FORM METHOD="get" ACTION="fullproblem.php">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="includeproblem" VALUE="true">
  <INPUT TYPE=submit VALUE="Just problem definition">
</FORM>

<FORM METHOD="get" ACTION="fullproblem.php">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="includespecs" VALUE="true">
  <INPUT TYPE=submit VALUE="Just scheduling logic">
</FORM>

<FORM METHOD="get" ACTION="fullproblem.php">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="includedata" VALUE="true">
  <INPUT TYPE=submit VALUE="Just data">
</FORM>
</font>
<?
  }

  function hintsForPage() {
?>
This page allows you to save a problem.  This allows you to
reload the problem into either this server or another server
in the future.
There are four options for what to save:
<ul>
<li><b>Problem Definition and Data -</b>
This saves every aspect of the problem and allows a complete
restoration of the problem from the saved file.
<li><b>Just Problem Definition -</b>
When the data is being fed from another souce, e.g. a database,
you may want to save just the problem definition (object formats
and scheduling logic) but not the data.
This is also a good way to start the process of creating a new
problem of the same type with different data.
<li><b>Just Scheduling Logic -</b>
This allows saving just the scheduling logic for the case when
the data formats and the data are both coming from another source.
<li><b>Just Data -</b>
This allows saving just the data for those cases when we already
have the problem definition saved.
</ul>
<?
  }
?>
