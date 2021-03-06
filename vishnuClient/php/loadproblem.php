<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Load a problem from file.

  require ("browserlink.php");
  require_once ("utilities.php");
  require ("parseproblem.php");
  require ("navigation.php");

  function getTitle () {
    echo "Result of loading problem";
  }

  function getSubheader() { 
    global $problem, $userfile, $userfile_name, $userfile_size;
    global $specifiedname;

    $specifiedname = trim ($specifiedname);
    if ($specifiedname && (! isNameLegal ($specifiedname))) {
      echo "Error, illegal name for problem $problem";
    }
    else if ($userfile == "none") {
      if ((! $userfile_name) || ($userfile_name == ""))
        echo "Error: Need to specify a file<br>\n";
      else
        echo "Error uploading file $userfile_name; " .
             "it was probably either nonexistent or too large.\n";
    }
    else if (! $userfile) {
      echo "Problem uploading file, probably due to earlier cached " .
           "file with same name.  Try changing name of file.";
    }
    else {
      $fp = fopen ($userfile, "r");
      $data = fread ($fp, $userfile_size);
      $problem = parseproblem ($data, $specifiedname);
      if ($problem) {
        echo "Problem $problem from file $userfile_name " .
             "loaded successfully.\n";
        echo "<br><br><DIV align=center><a href=\"problem.php?problem=" .
             $problem . "\"/>Go to Problem " . $problem . "</a></DIV>";
      }
      else
        echo "Failure loading data from file $userfile_name.\n";
    }    
  }
?>
