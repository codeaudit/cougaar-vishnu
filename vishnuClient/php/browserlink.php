<?
  // browserlink.php should be included in all other php files that
  // access the database and are meant to be accessed via a browser.
  // It performs basic authentication and establishes the database
  // connection.
  // The authentication is based on the ability to access the database
  // vishnu_central using the given user and password.
  // Cookies are set up so that the values are remembered between sessions.
  //
  // If the variable $login is set, then it automatically fails in order
  // to allow login under a different user and password.

  $cookieLifetime = 864000;   // 10 days
  $loginCookieLifetime = 120;

  function fail() {
    Header("HTTP/1.1 401 Unauthorized");
    Header("WWW-Authenticate: Basic Realm=\"Vishnu\"");
    setcookie ("VishnuUser");    
    setcookie ("VishnuPassword");    
    echo "<HTML><BODY><H1 align=center>" .
         "Invalid username and password</H1></BODY></HTML>";
    exit;
  }

  if ($login && (! $HTTP_COOKIE_VARS["VishnuLogin"])) {
    setcookie ("VishnuLogin", 1, time() + $loginCookieLifetime);
    fail();
  }

  $user = isset ($PHP_AUTH_USER) ? $PHP_AUTH_USER :
          $HTTP_COOKIE_VARS["VishnuUser"];
  $password = isset ($PHP_AUTH_PW) ? $PHP_AUTH_PW :
              $HTTP_COOKIE_VARS["VishnuPassword"];

  if (! isset ($user))
    fail();

  if (! @mysql_connect ("localhost", $user, $password))
    fail();

  mysql_select_db ("vishnu_central");
  if (mysql_errno())
    fail();

  if (! $nocookie) {
    setcookie ("VishnuUser", $user, time() + $cookieLifetime);
    setcookie ("VishnuPassword", $password, time() + $cookieLifetime);
    setcookie ("VishnuLogin");
  }

?>