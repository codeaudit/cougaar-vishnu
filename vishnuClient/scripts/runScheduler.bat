@ECHO OFF

REM "<copyright>"
REM " Copyright 2001 BBNT Solutions, LLC"
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


REM This script starts the Vishnu Scheduler
REM 
REM The Vishnu Scheduler polls the Vishnu web server looking for problems to schedule.
REM When it finds a request has been posted, it gets the problem and its scheduling specs
REM and produces a schedule.  This schedule is then posted back to the web server.

REM For values of properties 1-4, see vishnu_server.env.xml in this directory

REM CLASSPATH - the scheduler needs the vishnu jar and the xerces jar in the CLASSPATH,
REM e.g. d:/vishnu/lib/vishnu.jar;d:/vishnu/lib/xerces.jar 

REM PROPERTIES -
REM  1) host - Vishnu web server
REM  2) path - path on host to php files
REM  3) user - user on the web server (mysql user)
REM  4) password - password on the web server (mysql password)
REM  5) showAssignments - dump to stdout xml that shows task to resource assignments
REM  6) waitInterval    - scheduler poll period
REM  7) machines - (Very Important) list of machines where Vishnu clients are running.
REM     The scheduler will only try to do problems coming from these machines.
REM     If empty or undefined, scheduler will try to schedule all problems 
REM     posted to web server.  
REM
REM     Can be a comma separated list,
REM     e.g. -Dvishnu.Scheduler.machines="pumpernickle, hammet"
REM
REM	  The scheduler will print which problems it's scheduling, so if you see problems 
REM     that aren't yours, you may want to restrict your scheduler.
REM
REM  8) problems - Specific problems this scheduler is restricted to handle.  For
REM  instance, if there were two problems running on machine X, and you had schedulers
REM  on machines Y and Z, and you wanted to make sure the scheduler on machine Y was only
REM  doing problem #1 and the scheduler on Z only do problem #2.  In this case, 
REM   on Y, you'd set -Dvishnu.Scheduler.problems="problem_1" and
REM   on Z, you'd set -Dvishnu.Scheduler.problems="problem_2"
REM
REM  Debugging params (safe to ignore):
REM
REM  9) Scheduler.debug - specific debugging of Scheduler class
REM  10) TimeBlock.debug - debugging of TimeBlock
REM  11) debug - general debug
REM  12) debugXML - show XML sent and received over URLs 
REM      (scheduler will not actually process requests)

set PROPERTIES=-Dvishnu.host=alp-107.alp.isotic.org
set PROPERTIES=%PROPERTIES% -Dvishnu.path="/~demo/TOPS/vishnu/php/"
set PROPERTIES=%PROPERTIES% -Dvishnu.user=root
set PROPERTIES=%PROPERTIES% -Dvishnu.password=""
set PROPERTIES=%PROPERTIES% -Dvishnu.Scheduler.showAssignments=false
set PROPERTIES=%PROPERTIES% -Dvishnu.Scheduler.waitInterval=1000
set PROPERTIES=%PROPERTIES% -Dvishnu.Scheduler.machines=""
set PROPERTIES=%PROPERTIES% -Dvishnu.Scheduler.problems=""
set PROPERTIES=%PROPERTIES% -Dvishnu.Scheduler.debug=false
set PROPERTIES=%PROPERTIES% -Dvishnu.TimeBlock.debug=false
set PROPERTIES=%PROPERTIES% -Dvishnu.debug=false
set PROPERTIES=%PROPERTIES% -Dvishnu.debugXML=false

java %PROPERTIES% -Xms60m -Xmx100m org.cougaar.lib.vishnu.server.Scheduler 


