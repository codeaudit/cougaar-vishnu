<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Accept the updates on a scheduling constraint and write to the database

  require ("browserlink.php");
  require ("parseproblem.php");

  if (! $spec) {
    if (($objtype == "task") || ($objtype == "setup") ||
        ($objtype == "wrapup")) {
      $spec = "task_color";
      $name = "task color: " . $color;
    }
    else if ($objtype == "activity") {
      $spec = "activity_color";
      $name = "activity color: " . $color;
    }
    else if (($objtype == "grouped_tasks") || ($objtype == "grouped_setup") ||
             ($objtype == "grouped_wrapup")) {
      $spec = "grouped_color";
      $name = "grouped tasks color: " . $color;
    }
  }

  require ("navigation.php");

  function getTitle () {
    global $name;
    echo "Updating spec $name";
  }

  function getHeader() {
    global $problem;
    echo "Problem <font color=\"green\">" . $problem . "</font>\n";
  }

  function getSubheader() { 
    global $name;
    echo "Updating the specification for <font color=\"green\">" .
         $name . "</font><br>\n";
  }

  function mainContent () {
    global $problem, $color, $objtype, $oldcolor, $text, $title;
    global $spec, $choice, $name;

    $xml = "";

    if ($choice) {
      mysql_db_query ("vishnu_prob_" . $problem, 
                      "update constraints set $spec=\"$choice\";");
      echo "<H2>Update complete</H2>\n";
    }
    else {
      $date = makedate(time());
      $text = stripslashes ($text);
      $result = mysql_db_query ("vishnu_central",
                  "insert into compiler_request values (\"" . $problem .
                  "\", \"" . addslashes($text) . "\", \"" . $date .
                  "\", \"" . $user . "\", \"" . $spec .
                  "\", NULL, NULL, \"outstanding\");");
      while (1) {
        sleep (1);
        $result = mysql_db_query ("vishnu_central",
                    "select response_text, error_text from compiler_request " .
                    "where request_time=\"" . $date . "\" and requester=\"" .
                    $user . "\";");
        if (! $result) {
          echo "Problem with database access\n";
          break;
        }
        $value = mysql_fetch_row ($result);
        if ($value[0] || $value[1])
          break;
      }
      if ($value[1]) {
        echo "<H2>" . stripslashes ($value[1]) . "</H2>\n";
      }
      else if ($objtype) {
        $xml = $value[0];
        if ((! $color) && (! $oldcolor))
          echo "<H2>Error: Need to specify a color</H2>\n";
        else if (($xml == "NULL") && (! $oldcolor))
          echo "<H2>Error: Need to specify expression for new color</H2>\n";
        else {
          $report = parsecolortest ($xml, $problem, $oldcolor, $color,
                                     $objtype, $title);
          if (strcmp ($report, "SUCCESS") != 0)
            echo "<H2>" . "Error? Got back:<br>" . $report . "</H2>\n";
          else if ($xml == "NULL")
            echo "<H2>" . "Deleted from database" . "</H2>\n";
          else
            echo "<H2>" . "Added to database" . "</H2>\n";
        }
      }
      else if ($value[0] == "NULL") {
        mysql_db_query ("vishnu_prob_" . $problem, 
                        "update constraints set " . $spec . "_index=NULL, " .
                        $spec . "_type=NULL;");
        echo "<H2>" . "Returned to default in database" . "</H2>\n";
      }
      else {
        $xml = $value[0];
        $report = parseconstraint ($xml, $problem, $spec);
        if (strcmp ($report, "SUCCESS") != 0)
          echo "<H2>" . "Error? Got back:<br>" . $report . "</H2>\n";
        else
          echo "<H2>" . "Added to database" . "</H2>\n";
      }
      $result = mysql_db_query ("vishnu_central",
                  "delete from compiler_request " .
                  "where request_time=\"" . $date . "\" and requester=\"" .
                  $user . "\";");
    }

    mysql_close();

    echo "<h2><a href=\"saveproblem.php?problem=" . $problem .
         "\">Save to file</a></h2>\n";

    echo "</DIV>\n";
//  if ($xml != "") {
//    echo "<BR><BR>The XML is<BR>\n";
//    $arr = explode ("\n", $xml);
//    for ($i = 0; $i < sizeof ($arr); $i++)
//      echo stripslashes (htmlentities ($arr[$i])) . "<BR>\n";
//  }
    echo "<DIV align=CENTER><H2><a href=\"viewspecs.php" . 
         "?problem=" . $problem . "\">" . "Return to specs</DIV></H2>";
  }
?>

