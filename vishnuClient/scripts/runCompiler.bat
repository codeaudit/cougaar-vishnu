@ECHO OFF

REM "<copyright>"
REM " Copyright 2001-2003 BBNT Solutions, LLC"
REM " under sponsorship of the Defense Advanced Research Projects Agency (DARPA)."
REM ""
REM " This program is free software; you can redistribute it and/or modify"
REM " it under the terms of the Cougaar Open Source License as published by"
REM " DARPA on the Cougaar Open Source Website (www.cougaar.org)."
REM ""
REM " THE COUGAAR SOFTWARE AND ANY DERIVATIVE SUPPLIED BY LICENSOR IS"
REM " PROVIDED 'AS IS' WITHOUT WARRANTIES OF ANY KIND, WHETHER EXPRESS OR"
REM " IMPLIED, INCLUDING (BUT NOT LIMITED TO) ALL IMPLIED WARRANTIES OF"
REM " MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND WITHOUT"
REM " ANY WARRANTIES AS TO NON-INFRINGEMENT.  IN NO EVENT SHALL COPYRIGHT"
REM " HOLDER BE LIABLE FOR ANY DIRECT, SPECIAL, INDIRECT OR CONSEQUENTIAL"
REM " DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE OF DATA OR PROFITS,"
REM " TORTIOUS CONDUCT, ARISING OUT OF OR IN CONNECTION WITH THE USE OR"
REM " PERFORMANCE OF THE COUGAAR SOFTWARE."
REM "</copyright>"


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

set PROPERTIES=-Dcom.bbn.vishnu.host=localhost
set PROPERTIES=%PROPERTIES% -Dcom.bbn.vishnu.path="/php/"
set PROPERTIES=%PROPERTIES% -Dcom.bbn.vishnu.user=root
set PROPERTIES=%PROPERTIES% -Dcom.bbn.vishnu.password=""
set LIBPATHS= %VISHNU%\lib\xerces.jar;%VISHNU%\lib\vishnu.jar

java -classpath %LIBPATHS% %PROPERTIES% com.bbn.vishnu.scheduling.ExpressionCompiler

