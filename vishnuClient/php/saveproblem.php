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
  <INPUT TYPE=submit VALUE="Just problem specs">
</FORM>

<FORM METHOD="get" ACTION="fullproblem.php">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="includedata" VALUE="true">
  <INPUT TYPE=submit VALUE="Just data">
</FORM>
</font>

<? } ?>
