@ECHO OFF

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
REM     e.g. -Dorg.cougaar.lib.vishnu.server.Scheduler.machines="pumpernickle, hammet"
REM
REM	  The scheduler will print which problems it's scheduling, so if you see problems 
REM     that aren't yours, you may want to restrict your scheduler.
REM
REM  8) problems - Specific problems this scheduler is restricted to handle.  For
REM  instance, if there were two problems running on machine X, and you had schedulers
REM  on machines Y and Z, and you wanted to make sure the scheduler on machine Y was only
REM  doing problem #1 and the scheduler on Z only do problem #2.  In this case, 
REM   on Y, you'd set -Dorg.cougaar.lib.vishnu.server.Scheduler.problems="problem_1" and
REM   on Z, you'd set -Dorg.cougaar.lib.vishnu.server.Scheduler.problems="problem_2"
REM
REM  Debugging params (safe to ignore):
REM
REM  9) Scheduler.debug - specific debugging of Scheduler class
REM  10) TimeBlock.debug - debugging of TimeBlock
REM  11) debug - general debug
REM  12) debugXML - show XML sent and received over URLs 
REM      (scheduler will not actually process requests)

set PROPERTIES=-Dorg.cougaar.lib.vishnu.server.host=alp-107.alp.isotic.org
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.path="/~demo/TOPS/vishnu/php/"
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.user=root
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.password=""
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.Scheduler.showAssignments=false
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.Scheduler.waitInterval=1000
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.Scheduler.machines=""
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.Scheduler.problems=""
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.Scheduler.debug=false
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.TimeBlock.debug=false
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.debug=false
set PROPERTIES=%PROPERTIES% -Dorg.cougaar.lib.vishnu.server.debugXML=false

java %PROPERTIES% -Xms60m -Xmx100m org.cougaar.lib.vishnu.server.Scheduler 


