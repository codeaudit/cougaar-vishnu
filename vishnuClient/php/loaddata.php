<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Load additional data for an existing problem from a file

  require ("browserlink.php");
  require ("parsedata.php");
  require ("navigation.php");

  function getTitle () {
    echo "Result of loading data";
  }

  function getSubheader() { 
    global $problem, $userfile, $userfile_name, $userfile_size;
    if ($userfile == "none") {
      if ((! $userfile_name) || ($userfile_name == ""))
        echo "Error: Need to specify a file<br>\n";
      else
        echo "Error uploading file $userfile_name; " .
             "it was probably either nonexistant or too large.\n";
    }
    else if (! $userfile) {
      echo "Problem uploading file, probably due to earlier cached " .
           "file with same name.  Try changing name of file.";
    }
    else {
      $fp = fopen ($userfile, "r");
      $data = fread ($fp, $userfile_size);
      $result = parsedata ($data, $problem, 0);
      if ($result == "SUCCESS")
        echo "Data from file $userfile_name loaded successfully\n";
      else
        echo "Failure loading data from file $userfile_name \n";
    }    
  }
?>
