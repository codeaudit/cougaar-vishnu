<?
  require ("database.php");
  Header("Content-Type: text/plain");
  $mysql_link = mysql_connect ("localhost", $user, $password);

  $result = addslashes ($result);

  $res = safe_query ("central",
               "posting expression compiler result to database",
	       "updating compiler request",
	       "problem was " . $problem,
               "update compiler_request set status=\"complete\", " .
               (strcasecmp ("error", substr ($result, 0, 5)) ?
                "response_text" : "error_text") . "=\"" . $result . "\" " .
               "where problem=\"" . $problem . "\" and which_spec=\"" .
               $spec . "\";");

 if ($res["error"])
   echo $res["error"];
 else    
   echo "SUCCESS\n";
?>
