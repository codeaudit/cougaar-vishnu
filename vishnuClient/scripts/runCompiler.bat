@ECHO OFF

REM This script starts the Vishnu Spec Compiler
REM 
REM The Vishnu Spec Compiler polls the Vishnu web server looking for specs to compile.
REM When it finds a request has been posted, it gets the spec that's written in the 
REM spec language and compiles it into an xml format that is convenient for the web server
REM to handle.  This compiled spec is then posted back to the web server.

REM For values of properties 1-4, see vishnu_server.env.xml in this directory

REM CLASSPATH - the compiler needs the vishnu jar and the xerces jar in the CLASSPATH
REM e.g. d:/vishnu/lib/vishnu.jar;d:/vishnu/lib/xerces.jar 

REM PROPERTIES -
REM  1) host - Vishnu web server
REM  2) path - path on host to php files
REM  3) user - user on the web server (mysql user)
REM  4) password - password on the web server (mysql password)
REM
REM  Debugging params (safe to ignore):
REM
REM  5) debugXML - show XML sent and received over URLs 
REM      (scheduler will not actually process requests)

set PROPERTIES=-Dvishnu.host=alp-107.alp.isotic.org
set PROPERTIES=%PROPERTIES% -Dvishnu.path="/~demo/TOPS/vishnu/php/"
set PROPERTIES=%PROPERTIES% -Dvishnu.user=root
set PROPERTIES=%PROPERTIES% -Dvishnu.password=""

java %PROPERTIES% org.cougaar.lib.vishnu.server.ExpressionCompiler

