<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// expression compiler uses this URL to write back results

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
