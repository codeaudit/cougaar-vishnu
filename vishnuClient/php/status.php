<!-- reload the page every 5 seconds -->
<?
  $nocookie = 1;
  require ("browserlink.php");
  require ("utilities.php");

  $result = mysql_db_query ("vishnu_central",
                            "select * from scheduler_request where " .
                            "problem = \"" . $problem . "\";");
  $value = mysql_fetch_array ($result);

  if (! $value) {}
  else if (($value["percent_complete"] != 100) &&
      ($value["percent_complete"] != -1))
    echo "<META http-equiv=\"Refresh\" content=\"5\">";

  require ("navigation.php");

  function getTitle () {
    global $problem;
    echo "Scheduler Status: " . $problem;
  }
  function getHeader() {
    global $problem;
    echo "Problem <font color=\"green\">" . $problem . "</font>";
  }
  function mainContent () {
  }

  function reportTime () {
    $sec = getTimeDifference ();
    $min = floor($sec/60);
    echo "Difference : ". (($min > 0) ? ($min . " minutes ") : "") . 
	($sec-($min*60)) . " seconds. <br>"; 
  }

  function getTimeDifference () {
    global $value;
    $today = date("Y-m-d H:i:s"); 
    echo "Now : " . $today . "<br>";

    $date1=strtotime($value["request_time"]); 
    $date2=strtotime($today);
    $sec = $date2-$date1;
    return $sec;
  }

  function getSubheader() { 
    global $problem, $value, $result;
  echo "<br>\n";
  $str = "request";
  $timeDiff = getTimeDifference ();
	// for <br>problem <font color='green'>" . $problem . "</font>";
  if (! $value)
    echo "No scheduler " . $str . " yet submitted.";
  else {
    $str2 = $str . "<br>submitted by <font color='green'>" . $value["requester"] . "</font><br>" . 
	"at <font color='green'>" . $value["request_time"] . "</font>";
    if ($value["percent_complete"] == 0) {
      echo "Scheduler has not started processing " . $str2; 
      if ($timeDiff > 20)
	echo "<br><font size=-1>* Perhaps there is no scheduler running?</font>";
    } else if ($value["percent_complete"] == -1)
      echo "Scheduler request <font color='red'>canceled</font> for " . $str2;
    else if ($value["error_message"])
      echo "Scheduler has <font color='red'>aborted due to error: " . $value["error_message"] .
	"</font>";
    else if ($value["percent_complete"] == 100)
      echo "Scheduler has <font color='green'>finished</font> processing " . $str2;
    else
      echo "Scheduler is <font color='green'>currently</font> processing " .
         $str2 . "\n<br>It is " . $value["percent_complete"] . "% complete";
    echo "<br><br>";
    reportTime ();
  }
  mysql_free_result ($result);
  mysql_close();

  if ($value &&
      ($value["percent_complete"] != -1) &&
      ($value["percent_complete"] != 100)) {
?>

<FORM METHOD="get" ACTION="cancel.php">
  <INPUT TYPE=hidden NAME="problem" VALUE="<? echo $problem ?>">
  <INPUT TYPE=submit VALUE="Cancel request ">
</FORM>
<BR><BR>
  <? 
    if ($value["percent_complete"] == 0 && $timeDiff > 20) {
	echo "<font size=-1>";
	echo "* To run a scheduler, either use the runScheduler script in "; 
	echo "vishnu/scripts in the vishnu distribution.<br>";
	echo "See setup instructions at the top of the <b>runScheduler</b> script."; 
	echo "Also, for more information, see "; 
	echo "<a href=\"vishnu/php/fulldoc.php#d3\"/>Installing and Executing Vishnu</a> or<br>";
	echo "email <a href=\"mailto:gvidaver@bbn.com\"\>Gordon Vidaver</a> or";
	echo " <a href=\"mailto:dmontana@bbn.com\"\>Dave Montana</a>."; 
	echo "</font size=-1>";
    }
  } linkToProblem ($problem);

 }
?>





