<?
  Header("Content-Type: text/plain");
  require ("clientlink.php");

  $result = addslashes ($result);
  mysql_db_query ("vishnu_central",
               "update compiler_request set status=\"complete\", " .
               (strcasecmp ("error", substr ($result, 0, 5)) ?
                "response_text" : "error_text") . "=\"" . $result . "\" " .
               "where problem=\"" . $problem . "\" and which_spec=\"" .
               $spec . "\";");
  if (mysql_errno())
    echo "Error = " . mysql_error();
  else
    echo "SUCCESS\n";
?>
