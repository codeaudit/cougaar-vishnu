<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// cleanup.php handles deleting of problems.
// It first displays a list to choose from and, after the user has
// made his/her selections, then does the deletions.

  require ("browserlink.php");
  require ("navigation.php");

  function getTitle () {
    global $HTTP_POST_VARS;
    echo sizeof ($HTTP_POST_VARS) ? "Deleted problems" : "Deleting problems";
  }

  function getHeader() {
    global $HTTP_POST_VARS;
    if (! sizeof ($HTTP_POST_VARS)) 
      echo "Select which problems to delete";
    while (list ($prob, $val) = each ($HTTP_POST_VARS)) {
      mysql_db_query ("vishnu_central",
          "delete from problems where name=\"" . $prob . "\";");
      mysql_db_query ("vishnu_central",
          "drop database vishnu_prob_" . $prob . ";");
    }
    echo "Deleted selected problems";
  }

  function getSubheader() { 
  }

  function mainContent () {
    global $HTTP_POST_VARS;
    if (sizeof ($HTTP_POST_VARS))
      return;
    echo "<FORM method=post action=\"cleanup.php\">\n";
    echo "<TABLE width=600>\n";
    $result = mysql_db_query ("vishnu_central",
                "select name from problems order by name;");
    while ($value = mysql_fetch_row ($result)) {
      echo ($end ? "" : "<TR>") . "<TD align=left width=50%><font size=+1>" .
           "<INPUT type=checkbox name=\"" . $value[0] . "\"> " .
           $value[0] . "</font></TD>\n" . ($end ? "</TR>\n" : "");
      $end = ! $end;
    }
    echo "</TABLE>\n";
    echo "<br><INPUT type=submit value=\"Delete Selected Problems\">\n";
    echo "</FORM>\n";
  }
?>
