<?
  require ("browserlink.php");
  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Loading data for " . $problem;
  }
  function getHeader() {
  }
  function getSubheader() { 
    echo "Select file from which to load data";
  }

  function mainContent () {
    global $problem;
?>
<font size = +1>
<FORM ENCTYPE="multipart/form-data" METHOD="post" ACTION="loaddata.php">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=hidden NAME="MAX_FILE_SIZE" VALUE="10000000">
  <INPUT TYPE="file" NAME="userfile">
  <INPUT TYPE=submit VALUE="Load data from file">
</FORM>
</font>

<? } ?>
