<?
  function db_connect ($user, $password) {
    $realuser = "vishnu";
    if ($user)
      $realuser = $user;

    $realpassword = "vishnu";
    if ($password) {
      $realpassword = $password;
      if ($password == "nopassword")
        $realpassword = "";
    }

	mysql_connect ("localhost", $realuser, $password);

    if (mysql_errno())
      return "Error: Could not connect to database, user = " .
             $user . ", password = " . $password . ", error = " .
             mysql_error();
  }


  // do database query catching errors if fails; if succeeds, return
  // array with result otherwise return array with error
  function safe_query ($db, $context, $action, $ident, $command) {
    $result = mysql_db_query ("vishnu_" . $db, $command);
    if (mysql_errno() == 0)
      return array ("result"=>$result);
    $text = "Error has occurred<BR>\n<DIV align=left>\nContext: " .
            $context . "<BR>\nAction: " . $action .
            "<BR>\nIdentifier: " . $ident . "<BR>\nCommand: " . $command .
            "<BR>\nDatabase: vishnu_" . $db .
            "<BR>\nError Text: " . mysql_error() . "<BR><BR>\n</DIV>\n";
    return array ("error"=>$text);
  }


  function setup_xml_parser ($startHandler, $endHandler) {
    $parser = xml_parser_create();
    if (! $parser) {
      echo "Could not create parser<BR>\n";
      return;
    }
    $result = xml_set_element_handler ($parser, $startHandler, $endHandler);
    if (! $result) {
      echo "Parser not valid<BR>\n";
      return;
    }
    return $parser;
  }
?>
