<?
  require ("browserlink.php");
  require ("parsedata.php");
  require ("navigation.php");

  function getTitle () {
    echo "Result of loading data";
  }
  function getHeader() {
  }
  function mainContent () {
  }

  function getSubheader() { 
    global $problem, $userfile, $userfile_size, $userfile_name;
    if ($userfile) {
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
