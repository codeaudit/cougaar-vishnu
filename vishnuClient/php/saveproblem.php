<?
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
