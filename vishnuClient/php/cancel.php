<?
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
  mysql_close();
  }
?>
