<?
  require ("parseproblem.php");
  require ("navigation.php");

  function getTitle () {
    echo "Result of loading problem";
  }
  function getHeader() {
  }
  function mainContent () {
  }

  function getSubheader() { 
    global $problem, $userfile, $userfile_name, $userfile_size;
    global $PHP_AUTH_USER, $PHP_AUTH_PW, $HTTP_COOKIE_VARS;
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
      $user = isset ($PHP_AUTH_USER) ? $PHP_AUTH_USER :
              $HTTP_COOKIE_VARS["VishnuUser"];
      $password = isset ($PHP_AUTH_PW) ? $PHP_AUTH_PW :
                  $HTTP_COOKIE_VARS["VishnuPassword"];
      $problem = parseproblem ($data, $user, $password);
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
