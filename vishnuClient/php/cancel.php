<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// cancel.php cancels a scheduling request.

  require ("browserlink.php");
  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Canceling " . $problem;
  }

  function getSubheader() {
  }

  function mainContent () {
  }

  function getHeader() { 
    global $problem;
    mysql_db_query ("vishnu_central",
                    "update scheduler_request set percent_complete=-1 " .
                    "where  problem = \"" . $problem . "\";");
    echo "Canceled scheduling request for problem <font color='green'>" .
         $problem . "<BR>\n";
  }
?>
