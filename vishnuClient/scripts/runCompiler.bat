@ECHO OFF

REM "<copyright>"
REM " "
REM " Copyright 2001-2004 BBNT Solutions, LLC"
REM " under sponsorship of the Defense Advanced Research Projects"
REM " Agency (DARPA)."
REM ""
REM " You can redistribute this software and/or modify it under the"
REM " terms of the Cougaar Open Source License as published on the"
REM " Cougaar Open Source Website (www.cougaar.org)."
REM ""
REM " THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS"
REM " "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT"
REM " LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR"
REM " A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT"
REM " OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,"
REM " SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT"
REM " LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,"
REM " DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY"
REM " THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT"
REM " (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE"
REM " OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
REM " "
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

