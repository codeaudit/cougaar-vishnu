<?

  function fail() {
    Header("WWW-Authenticate: Basic Realm=\"Vishnu\"");
    Header("HTTP/1.0 401 Unauthorized");
    setcookie ("VishnuUser");    
    setcookie ("VishnuPassword");    
    echo "<HTML><BODY><H1 align=center>" .
         "Invalid username and password</H1></BODY></HTML>";
    exit;
  }

  if ($login && (! $HTTP_COOKIE_VARS["VishnuLogin"])) {
    setcookie ("VishnuLogin", 1, time() + 120);
    fail();
  }

  $user = isset ($PHP_AUTH_USER) ? $PHP_AUTH_USER :
          $HTTP_COOKIE_VARS["VishnuUser"];
  $password = isset ($PHP_AUTH_PW) ? $PHP_AUTH_PW :
              $HTTP_COOKIE_VARS["VishnuPassword"];

  if (! isset ($user))
    fail();

  $mysql_link = @mysql_connect ("localhost", $user, $password);
  if (! $mysql_link)
    fail();

  $result = mysql_select_db ("vishnu_central");
  if (mysql_errno())
    fail();

  if (! $nocookie) {
    setcookie ("VishnuUser", $user, time() + 864000);
    setcookie ("VishnuPassword", $password, time() + 864000);
    setcookie ("VishnuLogin");
  }

?>