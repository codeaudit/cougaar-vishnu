<?
  $norightbar = 1;
  require ("navigation.php");

  function getTitle () {
    echo "Vishnu Documentation";
  }
  function getHeader() {
    echo "Vishnu Documentation";
  }
  function getSubheader() { 
  }

  $sectioncounter = 0;
  $subsectioncounter = 0;
  $sectioncounter2 = 0;
  $subsectioncounter2 = 0;

  function refSection ($name, $label, $app="") {
    global $sectioncounter2, $subsectioncounter2;
    $sectioncounter2++;
    $subsectioncounter2 = 0;
    echo "<a href=\"fulldoc.php#" . $label . "\"><font size=+1>" .
         ($app ? ("Appendix " . $app) : $sectioncounter2) .
         ". " . $name . "</font></a><br>\n";
  }

  function refSubsection ($name, $label) {
    global $sectioncounter2, $subsectioncounter2;
    $subsectioncounter2++;
    echo "<a href=\"fulldoc.php#" . $label . "\"><font>" .
         $sectioncounter2 . "." . $subsectioncounter2 .
         ". " . $name . "</font></a><br>\n";
  }

  function makeSection ($name, $label, $app="") {
    global $sectioncounter, $subsectioncounter;
    $sectioncounter++;
    $subsectioncounter = 0;
    echo "<p><a name=\"" . $label . "\"><b><font size=+2>" .
         ($app ? ("Appendix " . $app) : $sectioncounter) .
         ". " . $name . "</font></b></a></p>\n";
  }

  function makeSubsection ($name, $label) {
    global $sectioncounter, $subsectioncounter;
    $subsectioncounter++;
    echo "<p><a name=\"" . $label . "\"><b><font size=+1>" .
         $sectioncounter . "." . $subsectioncounter .
         ". " . $name . "</font></b></a></p>\n";
  }

  function mainContent () {
    echo "<div align=left>\n";
    refSection ("Introduction", "intro");
    refSection ("Architecture", "arch");
    refSubsection ("Relational Database", "db");
    refSubsection ("Middle Tier (Dynamic HTML Pages and XML Data)", "mid");
    refSubsection ("Optimizing Scheduler", "optsched");
    refSubsection ("Expression (or Formula) Compiler", "comp");
    refSubsection ("GUI/Browser Clients", "guiclient");
    refSubsection ("Application Clients", "appclient");
    refSection ("Object Data", "data");
    refSubsection ("Atomic Data Types", "atomic");
    refSubsection ("Predefined Composite Data Types", "predefined");
    refSubsection ("User-defined Composite Data Types", "userdefined");
    refSubsection ("Tasks, Resources, and Other Data", "data2");
    refSection ("Scheduling Specifications", "specs");
    refSection ("Automated Scheduler Algorithm", "alg");
    refSection ("Using the Browser-Based GUI", "gui");
    refSection ("ALP-Vishnu Bridge", "bridge");
    refSection ("Currently Defined Functions", "a", "A");
    refSection ("XML Data Formats", "b", "B");
    refSection ("Test Problem Descriptions", "c", "C");
    refSection ("Installation Procedure", "d", "D");
    refSection ("To Do List", "e", "E");
?>

<? makeSection ("Introduction", "intro"); ?>

<p>
Vishnu is a reconfigurable, web-based, optimizing scheduling system.
It performs scheduling in the sense that it
assigns tasks to resources at particular times.
It is reconfigurable in that it is capable of being configured
purely by data specifications and not by recoding to handle a wide range of
different scheduling problems with different scheduling semantics.
It is optimizing insofar as it allows the
specification of a criterion for evaluating how good a legal
schedule is and
will try to find a schedule that is as good as possible (in many cases
actually finding an optimal or near optimal schedule).
It is web-based since the GUI runs completely from a browser and since
all interactions with the central database are via a web server.
</p>

<p>We now discuss some of the key aspects of Vishnu.</p>

<? makeSection ("Architecture", "arch"); ?>

<p>Vishnu has
essentially a client-server architecture.
The server consists of a relational database (MySQL) and a web server
(Apache) with PHP modules that provide dynamic content for the serviced
URLs. There are three types of clients:
browsers for display and user interaction, automated schedulers for generating
optimized schedules, and (optionally) application drivers that potentially
provide the data and read back the generated schedules.</p>

<div align=center>
PUT IMAGE HERE
</div>

<? makeSubsection ("Relational Database", "db"); ?>

<p>The database is
capable of holding an arbitrary number of problems (within disk space
limitations), with the provision that each problem must have a different
name.  There is one database instance
for every problem, each named vishnu_prob_[probname].
The database for each problem contains all the data formats (see
<a href="fulldoc.php#data">Section 3</a>),
data (see <a href="fulldoc.php#data">Section 3</a>),
scheduling specifications (see <a href="fulldoc.php#specs">Section 4</a>),
automated scheduler specification
(see <a href="fulldoc.php#alg">Section 5</a>) and the results from the
automated scheduler (see <a href="fulldoc.php#alg">Section 5</a>).</p>

<p>There is one additional database instance called vishnu_central that
serves as a central point.  It contains a list of all the problems and a
list of all requests for the automated scheduler to run.</p>

<? makeSubsection ("Middle Tier (Dynamic HTML Pages and XML Data)", "mid"); ?>

<p>All interactions of the clients with the database are via the web
server.  The client sends data to a URL, and the web server processes 
the request,
making the appropriate database interactions and returns data to the 
client.  For the URLs used by browser clients, the data returned is 
HTML data and other data (such as images) that the browser can display. 
For the URLs used by the automated schedulers and application clients, 
the data is in XML format.  The data sent to the URLs is in the 
form of typical URL arguments.  Any complex data is in XML format 
within the URL arguments.</p>

<? makeSubsection ("Optimizing Scheduler", "optsched"); ?>

<p>There can potentially be more than one automated scheduler.  They 
can either be on the same machine as the database or on a different machine
because all communication is via URLs.  Each automated scheduler queries 
the database at regular intervals to see if there are any new problems. 
When there is a new problem, the scheduler needs to query the database 
for the problem contents, solve the problem (i.e., create a new 
schedule), and
then write the schedule to the database.</p>

<p>There are six different URLs that the scheduler needs to access.
These are:
<ul>
<li> <b>currentrequest.php</b> - This URL allows the scheduler to
query whether there is a new problem to solve and what it is.
<li> <b>ackrequest.php</b> - This URL allows the scheduler to specify 
an integer between 0 and 100 (inclusive) telling how far along it is 
on solving the
   problem.  The scheduler is required to change this to a value 
between 0 and 100 (exclusive) when it is starting to work on the 
problem and 100
   when it has finished.  Currently, the scheduler changes the 
status to 1 when it starts work and 100 when it is finished but 
does not provide intermediate values.
<li> <b>data.php</b> - This URL queries for the metadata and 
data for a particular problem.
<li> <b>specs.php</b> - This URL queries for the scheduling specifications.
<li> <b>gaparms.php</b> -
 This URL queries for the genetic algorithm parameters.
<li> <b>postassignments.php</b> - This URL allows
the scheduler to write the schedule into the database.
</ul>
</p>

<? makeSubsection ("Expression (or Formula) Compiler", "comp"); ?>

<p>The purpose of the expression compiler is to allow users to enter 
the scheduling specifications in "expression" format 
(see see <a href="fulldoc.php#specs">Section 4</a>) and have them
automatically translated into the XML format that can be easily
parsed into the database.  The expression compiler is a separate
Java process that queries the database at regular intervals to see 
if there are any new expressions to compile. (There can potentially 
be more than one expression
compiler process, but in practice this should not be necessary.)  
If so, it reads the expression for the oldest request, validates 
that the expression is
correct syntactically, translates the expression into XML, 
and writes back the XML.</p>
 
<p>There are two different URLs that the expression compiler needs 
to access:
<ul>
<li> <b>compilerrequest.php</b> - This URL queries the database
for any outstanding requests for expression compilation, and if
one exists, returns the
expression plus all the context data required to perform the compilation.
<li> <b>postcompilerresult.php</b> -  This URL allows the 
expression compiler to write back the XML text or else an error 
message for what went wrong.
</ul>
</p>

<? makeSubsection ("GUI/Browser Clients", "guiclient"); ?>

<p>The client side of the GUI is just a standard web browser.  The 
server side of the GUI is PHP code that reads from the database 
and dynamically
serves up HTML to the browser.  Using the GUI, a user 
can load a problem or data for a problem from a file, request 
the scheduler to run, check the
scheduler's status, and view the data from a problem and the 
associated schedule in a variety of forms.</p>

<p>We do not list all the URLs that the GUI uses, as these are 
too numerous and easily deduced from the PHP code.  We leave until 
see <a href="fulldoc.php#gui">Section 6</a> a more
detailed explanation of what the GUI actually does.</p>

<? makeSubsection ("Application Clients", "appclient"); ?>

<p>An alternative to the browser-based approach to loading a problem 
and requesting the creation of a schedule for the problem is for 
an executing
application to do this.  The procedure is that the application 
should first write a new problem or update the data for an 
existing problem, then kickoff
the scheduler, then periodically read the status until the 
scheduler has completed, and finally read back the schedule 
that has been created.</p>

<p>The URLs used are:
<ul>
<li> <b>postproblem.php</b> - This URL allows the client to create or 
modify a problem.  The single argument is data, which should contain 
XML data of the
   format specified in <a href="fulldoc.php#b">Appendix B</a>.
<li> <b>postdata.php</b> - This URL allows the client to add, 
modify, or delete object data for an existing problem.  The two 
arguments are problem and data,
   where problem specifies the problem name and data contains 
XML data of the format specified in <a href="fulldoc.php#b">Appendix B</a>.
<li> <b>postkickoff.php</b> - This URL allows the client to 
request the scheduler to run on the data for a problem.  The 
two arguments are problem and
   username.
<li> <b>readstatus.php</b> - This URL allows the client to tell
 whether the scheduler is done generating the scheduler.  The 
single argument is problem.  The
   text sent back will have the form percent_complete=[value], 
where value will be 100 when the scheduler is finished.
<li> <b>assignments.php</b> - This URL allows the client to 
read the assignments that the automated scheduler made.  The 
single argument is problem.  The
   text sent back will be XML assignment data in the format 
specified in <a href="fulldoc.php#b">Appendix B</a>.
</ul>
</p>
 
<? makeSection ("Object Data", "data"); ?>

<p>Vishnu provides a variety of data types plus the ability to 
combine these predefined data types into more complex data types, 
called composite data
types or objects.  Some of the predefined data types are atomic, 
i.e. cannot be broken into smaller components, and some are 
composite.  We now
enumerate the different predefined data types and discuss 
how to define new composite data types.</p>

<? makeSubsection ("Atomic Data Types", "atomic"); ?>

<p>The atomic data types in Vishnu are:
<ul>
<li> <b>string</b> - A string is any combination of standard characters.
<li> <b>number</b> - A number can be an integer or a floating point number.
<li> <b>boolean</b> - A boolean has value either "true" or "false".
<li> <b>datetime</b> - A datetime is formatted as "YYYY-MM-DD HH:MM:SS".
<li> <b>list</b> - A list is a set of values of another type of 
unspecified length.  All the elements in a particular list should 
be of the same type.  The data type of
   the elements can be any atomic data type other than a list or 
a composite data type, i.e. an object.  If you need a list of 
lists, either use a matrix or
   define an object type to contain the inner lists.
</ul>
</p>

<? makeSubsection ("Predefined Composite Data Types", "predefined"); ?>

<p>Currently, the predefined data types in Vishnu are:
<ul>
<li> <b>interval</b> - An interval represents an interval of 
time and contains the fields:
<ol>
<li> <b>start</b> - A datetime specifying the start time of the interval
<li> <b>end</b> - A datetime specifying the end time of the interval
<li> <b>label1</b> - A string that can be null (but is usually 
used for resource unavailabilities, as discussed below)
<li> <b>label2</b> - A string that can be null
</ol>
<li> <b>xy_coord</b> - An xy_coord represents a point 
in x-y coordinates and contains the fields:
<ol>
<li> <b>x</b> - A number specifying the x coordinate
<li> <b>y</b> - A number specifying the y coordinate
</ol>
<li> <b>latlong</b> - A latlong represents a point on the 
earth's surface and contains the fields:
<ol>
<li> <b>latitude</b> - A number between -90 and 90 specifying the latitude
<li> <b>longitude</b> - A number between -180 and 180 specifying the longitude
</ol>
<li> <b>matrix</b> - A matrix is a two-dimensional array of 
numbers and contains the fields:
<ol>
<li> <b>numrows</b> - A number specifying the number of rows
<li> <b>numcols</b> - A number specifying the number of columns
<li> <b>values</b> - A list of numbers of length numrows * numcols to 
fill in the array by rows
</ol>
</ul>
</p>

<? makeSubsection ("User-defined Composite Data Types", "userdefined"); ?>

<p>When defining a problem, a user can define new composite data 
types for that problem.  At a minimum, the user is expected to 
define two new data
types, one for representing the tasks and the other for representing 
the resources.  There are two situations under which the user will 
need to define
additional data types.  First, there may be global data (see below) 
that requires a data type not yet defined.  Second, the tasks, 
resources, or global
data may require some "nested" objects.  For example, for a 
task to contain a list of labeled locations, where a labeled 
location is a label string plus and
x-y coordinate, the user would need to define a new data type 
called labeled_location.</p>
 
<p>The essential information for specifying a new composite data type is
<ul>
<li> A name for the new data type starting with a letter and containing only letters, numbers and underbars
<li> Whether this new data type represents tasks, resources or neither
<li> An arbitrary number of fields each having a name; data type; 
if the data type is a list the data type of the contained elements; 
if the outer data type is
   a task or resource data type, whether this field is the unique 
key for objects of this type.
</ul></p>

<? makeSubsection ("Tasks, Resources, and Other Data", "data2"); ?>

<p>Once the data types are specified, it is possible to provide data 
for a problem.  There are three basic types of data: tasks, resources, 
and global data. 
Every object of the data type that is specified as the task data type is 
assumed to be a task that needs to be scheduled.  Every object of the 
resource
data type is assumed to be a resource.  All other top-level objects 
(i.e., objects not contained within other objects) are global data.  
All tasks and
resources have their associated unique key for identification.  All 
global data objects must be assigned a name that serves as their 
unique identifier so
that they can be accessed in the scheduling specifications (see below).</p>

<? makeSection ("Scheduling Specifications", "specs"); ?>

<p>At the heart of the reconfigurability of the scheduler is the 
ability of the user to specify the behavior of the scheduler.  There 
are a variety of different
types of problem constraints that can be specified.  A few of these 
constraints are simply multiple choice among a set of options.  However, 
most of
these constraints are specified as an expression involving the 
following types of components:
</p>

<p><b>Constants</b> - There are three types of constants: numeric, 
string, and boolean.  An example of each of these are 21.3, 
"hello world", and true.  Note
that all string constants are quoted to distinguish them from variables.

<p><b>Variables</b> - There are three ways that variables are 
defined.  First, there are some variables that are predefined.  
These always include <i>tasks</i> (a list
of all tasks), <i>resources</i> (a list of all resources), <i>start_time</i> 
(the start of the scheduling window), and <i>end_time</i> (the end of the 
scheduling window or, if
that is not set, the "end of time").  Additionally, there can 
be predefined variables specific to each constraint.  In the 
table below that describes the
constraints, we list the associated predefined variables for each constraint.
 
<p>A second way to define variables is using global data.  The name 
associated with a global object is the variable name that references 
that object.  Note
that it is therefore important to ensure that the variable names do 
not conflict with the predefined variables.
 
<p>A third way to defined variables is using iteration functions 
such as loop, mapover, sumover, and maxover.  These functions take 
as an argument a
string which becomes the variable name that allows access to the 
iterated value (e.g., the current list entry for this iteration).

<p><b>Accessors</b> - Accessors provide the means to access the 
fields of an object.  To access a top-level field, use a '.' followed 
by the field name.  For
example, task.id will access the id field of the variable task.  
When the fields within an object are themselves objects, chaining 
together accessors will
access lower-level fields.  For example, resource.location.x will 
access the x field of the location field of the variable resource.
Global pointers act just like other fields in terms of chaining
of accessors.

<p><b>Operators</b> - There is a set of arithmetic operators 
(+, -, *, /) that add / subtract / multiply / divide two numbers.  
Addition can also add a datetime
and a number (of seconds) to get a new datetime, while 
subtraction can take the difference of two datetimes to 
get a number (of seconds) or the
difference of a datetime and a number to get a datetime.  
For example, taskstarttime(task) - start_time will give 
the number of seconds after the start of
the scheduling window that task has been scheduled.
 
<p>There is another set of comparison operators 
(=, !=, <, <=, >, >=) that compare two values of the same 
type and return a boolean.  In the case of <,
<=, >, and >=, the two values must be either two numbers or 
two datetimes.  For example, resource.location.x < 10 will 
return true if the value of the
referenced field is less than 10 and false otherwise.

<p><b>Functions</b> - There is a (growing) set of functions 
that can be used in expressions.  A function has the form fcn_name 
(arg1, ..., argn).  The
arguments to a function are themselves expressions that are evaluated 
as part of the process of evaluating the function.  An example of 
an expression
involving functions is
   if (task.use_resource, resourcefor (task), resource)
A list of available functions is given in
<a href="fulldoc.php#a">Appendix A</a>.
 
<p>Some sample expressions are:
<ul>
<li> abs (task.location.x) * (mod (task.location.y, 5) + 2)
<li> if (resource.name = "machine 1", "the one", resource.name)
<li> mapover (tasks, "task1", task1.prerequisites)
</ul>
<a href="fulldoc.php#c">Appendix C</a> provides a large number of 
additional examples of expressions, all of which have been used in 
actual scheduling problems.
 
<p>There are two mechanisms in place to ensure that expressions are 
robust under evaluation.  The first is type checking, which is 
performed by the
expression compiler. All the components of a expression are 
checked to validate that they are returning the right type for their 
context, including making
sure that the entire expression returns the correct type for its 
constraint.  (The correct type associated with a particular 
constraint is given in Table 1.)
 
<p>The second mechanism is handling of undefined values encountered 
during runtime execution.  It is sometimes possible for a function 
to have no valid
value to return. For example, taskstarttime has no valid value to 
return if the task that is its argument has not been assigned yet 
and therefore does not
have a start time.  In this case, the function returns the value 
null.  All functions, operators and accessors are capable of handling 
a null value by passing
along null as a result.  If the user wants to explicitly handle a 
null condition, there is a function hasvalue that tests whether a 
particular value is null.
 
<p>Each constraint, except for a few multiple choice constraints, are 
specified by an expression.  Default values for each constraint 
are given so that a user
does not need to specify an expression for all constraints.  
Table 1 lists all the scheduling constraints along with what data 
type the expression needs to
return, what variables other than <i>tasks</i>, <i>resources</i>, <i>start_time</i> and 
<i>end_time</i> are defined in its context, what is the default value, and a short
description of the purpose of the constraint.  Table 2 lists all 
the constraints that are used for specifying how items are 
displayed on the schedule graphic.

<p><div align=center>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td width=109 bgcolor=black align=center>
        <font color=white><b>Constraint</b></font></td>
  <td width=72 bgcolor=black align=center>
        <font color=white><b>Type</b></font></td>
  <td width=102 bgcolor=black align=center>
        <font color=white><b>Variables</b></font></td>
  <td width=66 bgcolor=black align=center>
        <font color=white><b>Default Value</b></font></td>
  <td width=241 bgcolor=black align=center>
        <font color=white><b>Description</b></font></td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Optimization Criterion</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>number</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>&nbsp;</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>0</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Numerical value indicating how good the current schedule is</td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Optimization Direction</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>multiple choice</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>N/A</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>minimize</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Must be either minimize or maximize
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Delta Criterion</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>number</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task, resouce</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>0</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Incremental contribution to optimization criterion 
        introduced by having resource perform task
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Capability</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task, resouce</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>true</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Whether resource has the required skills to perform task
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Duration</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>number</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task, resouce</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>0</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        How many seconds it takes resource to perform task
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Setup Duration</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>number</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task, previous, resouce</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>0</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        How many seconds it takes resource to prepare to perform task if it last performed previous
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Wrapup Duration</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>number</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task, next, resouce</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>0</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        How many seconds it takes resource to clean up after doing task if it will be performing next
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Prerequisites</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>list of strings</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>empty list</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Names of all the tasks that must be scheduled before scheduling task
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Unavailability</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>list of intervals</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task, resource, prerequisites</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>empty list</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        All intervals of time when task cannot be scheduled (label1 and label2 fields ignored)
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Resource Unavailability</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>list of intervals</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>resource</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>empty list</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        All intervals of time when resource is busy (label1 and label2 can be used for text and color)
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Capacity Contribution</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>number <b>or</b> list of numbers</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>0</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        How much task contributes towards filling each type of capacity
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Capacity Threshold</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>number <b>or</b> list of numbers</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>resource</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>0</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        How much capacity of each type that resource has
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Multitasking</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>multiple choice</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>N/A</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>none</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Ability of resources to perform more than one task at a time (must be none, ungrouped, grouped, or ignoring_time)
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Groupable</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task1, task2</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>false</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Whether task1 and task2 can be done as part of the same group
  </td>
 </tr>
</table>
<br><b>Table 1. The Scheduling Constraints</b></div>

<p><br><div align=center>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td width=109 bgcolor=black align=center>
        <font color=white><b>Constraint</b></font></td>
  <td width=72 bgcolor=black align=center>
        <font color=white><b>Type</b></font></td>
  <td width=102 bgcolor=black align=center>
        <font color=white><b>Variables</b></font></td>
  <td width=66 bgcolor=black align=center>
        <font color=white><b>Default Value</b></font></td>
  <td width=241 bgcolor=black align=center>
        <font color=white><b>Description</b></font></td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Text</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>string <b>or</b> number <b>or</b> boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>""</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Text to put in box for task on the schedule graphic
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Activity Text</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>string <b>or</b> number <b>or</b> boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>interval</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>""</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Text to put in box for the activity associated with interval on the schedule graphic
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Grouped Tasks Text</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>string <b>or</b> number <b>or</b> boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>tasks (overloaded)</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>""</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Text to put in box on the schedule graphic for the given group of tasks performed simultaneously
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Color (one for each possible color)</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>false</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Whether task should be displayed in the given color on the schedule graphic
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Activity Color (one for each possible color)</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>interval</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>false</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Whether activity of interval should be displayed in the given color on the schedule graphic
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Grouped Tasks Color (one for each possible color)</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>tasks (overloaded)</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>false</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Whether the set of grouped tasks should be displayed in the given color on the schedule graphic
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Setup/Wrapup Display</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>multiple choice</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>N/A</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>striped</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Must be striped (indicating diagonal striping) or line (indicating single dotted line)
  </td>
 </tr>
</table>
<br><b>Table 2. The Graphical Display Constraints</b><br>
</div>

<? makeSection ("Automated Scheduler Algorithm", "alg"); ?>

<p>The automated scheduler uses a genetic algorithm to optimize the schedule according to the optimization criterion given in the constraint.  The genetic
algorithm allows the user not only to specify parameters that control operation but also to specify code to be plugged in for the genetic operators, an
initial population generator, and a genotype-to-phenotype (i.e., chromosome-to-schedule) decoder.  For now, we have defined only a single type of
genetic algorithm, which is what we will describe here.
 
<p>The current genetic algorithm uses an order-based chromosome.  Each chromosome is a list of all the tasks that need to be scheduled in a particular
order.  The initial population generator creates random orderings of the tasks.  The mutation operator picks some of the elements of the parent's list
(that in general are not contiguous) and shuffles their order to create the child.  The crossover operator picks some of the elements of the first parent's
list and puts them in the order they are in the second parent.  A decoder (which is the complicated part and which we describe in more detail below)
translates each ordering of tasks into a schedule.  The optimization criterion is used to evaluate the schedule corresponding to each chromosome.
 
<p>The decoder iterates performing the following procedure until all tasks are scheduled (or deemed unscheduled).  Take the first element in the list that is
not yet scheduled (or marked unscheduled) and for which all of the tasks in its lists of prerequisites are already scheduled.  Try assigning this task to
each of the resources capable of performing this task at the earliest possible time, and evaluate how good this assignment is using the delta criterion. 
Keep the assignment to that resource that is the best (i.e., perform a greedy selection of resource).
 
<p>The decoder uses the constraints to ensure that the schedule conforms to the problem requirements.  The prerequisites constraint determines which
tasks need to be scheduled before a particular task.  The capability constraint determines which resources can perform a particular task.  The task
unavailability constraint determines which periods of time to block off in terms of not allowing the given task to be scheduled during those times.  The
resource unavailability constraint determines when a given resource cannot be scheduled for performing a task or for setting up for or wrapping up from
a task.  The task duration, setup duration, and wrapup duration constraints determine how much time must be allocated for the given activities.  The
multitasking constraint determines how resources handle multiple tasks at once.  A value of none implies that a resource handles only one task at a
time.  A value of grouped implies that a resource can handle multiple tasks at once only if they start and end at the same times.  A value of ungrouped
implies that a resource can handle multiple tasks without the need to coordinate the start and end times.   The groupable constraint applies only for
grouped multitasking and determines when two tasks can be performed by a single resource at the same time.  The capacity contribution and capacity
threshold constraints apply differently depending on whether or not there is multitasking.  When there is multitasking, the capacity constraints ensure that
none of the different types of capacities are exceeded at any given time.  When there is no multitasking, these constraints ensure that the capacities are
not exceeded over the history of the resource.
 
<p>The scheduler stops running when any of the following four quantities exceed their specified limit: (1) the elapsed time for the run, (2) the total number
of individuals evaluated, (3) the number of consecutive evaluations without an improvement to the best individual, and (4) the number of duplicate
individuals generated.
 
<p>When the scheduler stops running, it writes the following information back to the database: (1) the set of all assignments of tasks to resources, including
the times (setup start, task start, task end, and wrapup end) and the color and text to be displayed and (2) the set of non-task activities for each
resource, including times, color and text.

<? makeSection ("Using the Browser-Based GUI", "gui"); ?>

<p>The GUI allows a user to see all the information about a problem including the data, scheduling specifications, and the schedule created.  The initial
access to the GUI should always be via the top-level page, currently called vishnu.php and contained (like all the GUI code) in the directory
vishnu/php.  This page allows the user to select the problem of interest, with the option of first loading a problem from a file or (sometime in the future)
creating a problem from scratch.  Selecting a problem takes the user to the main page for that problem.
 
<p>All the information about the problem is easily accessible from its main page.  This includes links to any individual task or resource with its
assignment/schedule data, a link to a view of the scheduling specifications, and a link to a graphic displaying all the schedule data for all the resources. 
The main page for a problem also includes a link for starting the scheduler on the problem and a link to see whether the scheduler has completed. 
Additionally, there are links for saving the problem data and/or specifications to a file and for loading the problem data from a file.  Editing the
scheduling specifications requires first going to the page for viewing these specifications.

<? makeSection ("ALP-Vishnu Bridge", "bridge"); ?>

<? makeSection ("Currently Defined Functions", "a", "A"); ?>

<div align=center>
<TABLE BORDER CELLSPACING=1 BORDERCOLOR="#000000">
<TR><TD WIDTH=90 VALIGN="TOP" BGCOLOR="#000000" align=center>
<B><FONT COLOR="#ffffff">Function</B></FONT></TD>
<TD WIDTH=180 VALIGN="TOP" BGCOLOR="#000000" align=center>
<B><FONT COLOR="#ffffff">Data Types</B></FONT></TD>
<TD WIDTH=320 VALIGN="TOP" BGCOLOR="#000000" align=center>
<B><FONT COLOR="#ffffff">Description</B></FONT></TD>
</TR>
<TR><TD WIDTH=90 VALIGN="TOP" style='padding:0in 5.4pt 0in 5.4pt'>
if</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(boolean, <I>type, &lt;type&gt;</I>)
=&gt; <I>type </I></TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
If the first argument is true, returns the second argument; otherwise, the third argument (or null)</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
and</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(boolean, &lt;boolean&gt;<I>, …</I>)
=&gt; boolean</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Logical and of arguments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
or</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(boolean, &lt;boolean&gt;<I>, …</I>)
=&gt; boolean</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Logical or of arguments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
not</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(boolean) =&gt; boolean</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Logical not of argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
mod</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(number, number)
=&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Remainder when dividing the first argument by the second argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
abs</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(number)
=&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Absolute value of a number</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
max</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(number, &lt;number&gt;<I>, …</I>)
=&gt; number  <B>or
</B><br>(datetime, &lt;datetime&gt;<I>, …</I>)
=&gt; datetime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Maximum value of arguments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
min</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(number, &lt;number&gt;<I>, …</I>)
=&gt; number  <B>or
</B><br>(datetime, &lt;datetime&gt;<I>, …</I>)
=&gt; datetime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Minimum value of arguments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
string</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(<I>type</I>)
=&gt; string</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Convert any object into a string</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
append</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(string, string)
=&gt; string  <B>or
</B><br>(list, list)
=&gt; list</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Appends two strings/lists into a longer string/list</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
list</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(&lt;<I>type&gt;, </I>&lt;<I>type&gt;, …</I>)
=&gt; list</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Makes a list out of all the arguments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
entry</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, number) =&gt; <I>type</I></TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the i<SUP>th</SUP> element (starting from 1) of the list, where i is the second argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
matentry</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(matrix, number, number)
=&gt; <I>type</I></TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the i-j<SUP>th</SUP> element (starting from 1) of the matrix, where i and j are the second and third arguments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
length</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list) =&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the length of a list</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
find</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string, boolean) =&gt; <i>type</i></TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the first element in the list such that when the variable named
by the second argument is set to this element the boolean expression
given by the third argument is true</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
position</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, <i>type</i>) =&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the first position in the list (with the first element being 1)
of the given element</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
mapover</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string, <I>type</I>)
=&gt; list</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Iterates over each element of the first argument, setting the variable given by the second argument to it, accumulating the value of the third argument into a new list</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
sumover</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string, number)
=&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Iterates over each element of the first argument, setting the variable given by the second argument to it, summing the values of the third argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
maxover</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string, number)
=&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Iterates over each element of the first argument, setting the variable given by the second argument to it, maximizing over the values of the third argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
minover</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string, number)
=&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Iterates over each element of the first argument, setting the variable given by the second argument to it, minimizing over the values of the third argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
andover</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string, boolean)
=&gt; boolean</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Iterates over each element of the first argument, setting the variable given by the second argument to it, doing a logical and of the values of the third argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
orover</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string, boolean)
=&gt; boolean</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Iterates over each element of the first argument, setting the variable given by the second argument to it, doing a logical or of the values of the third argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
loop</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(number, string, <I>type</I>)
=&gt; list</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Iterates, setting the variable named by the second argument equal to all integers between 1 and the first argument inclusive, accumulating the third argument into a list</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
dist</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(latlong, latlong)
=&gt; number  <B>or
</B>(xy_coord, xy_coord)
=&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the distance (in nautical miles if using latlong's) between the two arguments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
latlong</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(number, number)
=&gt; latlong</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Return a latlong object with latitude and longitude set to the first and second arguments respectively</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
xy_coord</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(number, number)
=&gt; xy_coord</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Return a xy_coord object with x and y set to the first and second arguments respectively</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
interval</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(datetime, datetime,
 &lt;string&gt;, &lt;string&gt;)
=&gt; interval</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Return an interval object with start and end times set to the first and second arguments and label1 and label2 set to the third and fourth arguments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
findtask</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string) =&gt; task</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Return the task in a list whose key is equal to the second argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
findresource</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(list, string) =&gt; resource</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Return the resource in a list whose key is equal to the second argument</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
taskstarttime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(task) =&gt; datetime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the assigned start time of a task, or null if not yet assigned</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
taskendtime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(task) =&gt; datetime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the assigned end time of a task, or null if not yet assigned</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
resourcefor</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(task) =&gt; resource</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the resource assigned to a task, or null if not yet assigned</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
tasksfor</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(resource) =&gt; list</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the list of tasks assigned to this resource</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
complete</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(resource) =&gt; datetime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the time when a resource has finished all its assignments</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
busytime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(resource, &lt;datetime&gt;,
 &lt;datetime&gt;)
=&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the number of seconds that a resource has spent performing tasks in the time interval between the second and third arguments (or for all time)</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
preptime</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(resource) =&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the number of seconds that a resource has spent doing setup and wrapup</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
hasvalue</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(<I>type</I>) =&gt; boolean</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns true if the argument is not null</TD>
</TR>
<TR><TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=90 VALIGN="TOP">
previousdelta</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=180 VALIGN="TOP">
(resource) =&gt; number</TD>
<TD style='padding:0in 5.4pt 0in 5.4pt' WIDTH=320 VALIGN="TOP">
Returns the sum of all delta evaluations for all the tasks already assigned to a resource</TD>
</TR>
</TABLE></div>

<? makeSection ("XML Data Formats", "b", "B"); ?>

<? makeSection ("Test Problem Descriptions", "c", "C"); ?>

<p>We have applied Vishnu to a variety of classic scheduling/assignment problems.  Loadable files containing the specifications and data for these
problems are contained in the testdata directory.  We also list the specifications here, since they are good and simple examples of how to configure
Vishnu for a particular problem.
 
<b>C.1 Job-Shop Scheduling Problem (testdata/jobshop/mt06.vsh)</b>
 
<p>The classic NxM research problem is as follows.  There are M machines and N manufacturing jobs to be completed.  Each job has M tasks/stages,
with each stage corresponding to a different specified machine.  There is a specified order in which the tasks for a certain job must be performed, with
one task not able to start until the previous task has ended.  The criterion to minimize is the makespan, which is defined as the end time of the last task
completed.  (Note that this research problem bears little resemblance to the problem that real job shops face.  Unlike other systems, our reconfigurable
scheduler can be easily modified to the constraints of a particular real-world job shop.)
 
<p>The resources for this problem are of type <i>machine</i>, and the tasks for this problem are of type <i>step</i>.  The metadata for these two object types are:

<br><div align=center>
<table cellspacing=0>
<tr>
<td align=center><font size=+1><b>step</b></font></td>
<td align=center><font size=+1><b>machine</b></font></td>
</tr>
<tr><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>id</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>job</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>step</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>duration_in_seconds</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>preceeding_steps</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>list of string</td>
 </tr>
</table>
</td><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>id</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
</table>
</td></tr>
</table>
</div>

<p>The (non-default) scheduling specifications for this problem are:<br><br>
<div align=center>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td width=160 bgcolor=black align=center>
        <font color=white><b>Constraint</b></font></td>
  <td width=420 bgcolor=black align=center>
        <font color=white><b>Expression</b></font></td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Optimization Criterion</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        maxover (resources, &quot;resource&quot;, complete (resource)) - start_time
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Capability Criterion</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.assigned_machine = resource.id
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Duration</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.duration_in_seconds
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Prerequisites</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.preceeding_steps
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Unavailable Times</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        mapover (prerequisites, &quot;preceeding_task&quot;,
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interval (start_time, taskendtime (preceeding_task)))
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Text</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.step
  </td>
 </tr>
</table>
</div>

<p>Here are a few points to note about the scheduling specifications.  First, the optimization criterion needs to be a number; subtracting the start time of the
scheduling window (a constant) from the end time of the final task provides a number that is the difference between these two times in seconds. 
Second, the preceeding_steps field of each step object need only contain its immediate predecessor; the rest of the steps that must be completed
before it will be enforced implicitly.  Third, the prerequisites constraint only specifies constraints in which order the decoding can be done; the task
unavailable times constraint is required to constrain the task to have a start time not earlier than its prerequisites' end times.

<p>The color specifications are:<br><br>
<div align=center>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td width=80 bgcolor=black align=center>
        <font color=white><b>Color</b></font></td>
  <td width=80 bgcolor=black align=center>
        <font color=white><b>Type</b></font></td>
  <td width=80 bgcolor=black align=center>
        <font color=white><b>Title</b></font></td>
  <td width=200 bgcolor=black align=center>
        <font color=white><b>Expression</b></font></td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        red</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Job 1</td>
  <td width=200 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.job = "1"
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        green</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Job 2</td>
  <td width=200 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.job = "2"
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        blue</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Job 3</td>
  <td width=200 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.job = "3"
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        yellow</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Job 4</td>
  <td width=200 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.job = "4"
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        cyan</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Job 5</td>
  <td width=200 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.job = "5"
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        magenta</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task</td>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Job 6</td>
  <td width=200 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.job = "6"
  </td>
 </tr>
</table>
</div>
 
<p>This color coding will allow easy visual separation of steps by job.

<p><b>C.2 Traveling Salesman Problem (testdata/TSP/bays29.vsh)</b>

<p>The traveling salesman problem is as follows.  There is a salesman who needs to start at a given city, travel to a set of other cities visiting each city
once, and then return to the starting city.  The distances from any city to any other city is provided.  The objective is to minimize the total distance
traveled.
 
<p>There are two different approaches we have used to configure Vishnu for the traveling salesman problem.  Both approaches consider each city other
than the starting city to be a task.  The first approach considers starting from the starting city to be a zero-duration task that must be performed first and
returning to the starting city to be a task that must be performed last.  The second approach (which is probably the superior one) instead has the setup
time for the first city calculate its distance automatically from the starting city and has a wrapup time for the last city based on distance to the starting
city.  We use the second approach for the vehicle routing problem (which is largely just a multiple traveling salesman problem) because it extends easily
to the multiple salesman case.  So, we provide the first approach here to provide more variety.
 
<p>The resource for this problem is of type <i>salesman</i>, and the tasks for this problem are of type <i>city</i>.  The metadata for these two object types are:

<br><div align=center>
<table cellspacing=0>
<tr>
<td align=center><font size=+1><b>city</b></font></td>
<td align=center><font size=+1><b>salesman</b></font></td>
</tr>
<tr><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>id</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>index</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
</table>
</td><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>id</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
</table>
</td></tr>
</table>
</div>

<p>A global variable <i>distances</i> of type matrix is defined that contains all the distances between cities.  The (non-default) scheduling specifications for this
problem are:<br><br>
<div align=center>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td width=160 bgcolor=black align=center>
        <font color=white><b>Constraint</b></font></td>
  <td width=420 bgcolor=black align=center>
        <font color=white><b>Expression</b></font></td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Optimization Criterion</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        maxover (resources, "resource", complete (resource)) - start_time
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Setup Duration</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        matentry (distances, task.index, previous.index)
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Prerequisites</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        if (task.id != "Start",
<br>&nbsp;&nbsp;&nbsp;&nbsp;if (task.id = "City 1",
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mapover (tasks, "task2", if (task2.id != "City 1", task2.id)),
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;list ("Start")))
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Text</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.index
  </td>
 </tr>
</table>
</div>
 
<p>One thing to note is that distances and durations are treated interchangeably, basically assuming that the salesman travels one unit of distance in a
second.

<p><b>C.3. Vehicle Routing Problem with Time Windows (testdata/VRP/solomon101.vsh)</b>

<p>The vehicle routing problem with time windows (VRPTW) is an extension of the capacitated vehicle routing problem (CVRP).  In CVRP, there are M
vehicles and N customers from whom to pick up cargo.  Each vehicle has a limited capacity for cargo, and each piece of cargo contributes different
amounts towards this capacity.  Each vehicle that is utilized starts at a central depot, makes a circuit of all its customers, and then returns to the depot. 
The objective is to minimize the total distance traveled by the vehicles.  In VRPTW, an extra constraint is added that there is a certain window of time
in which each pickup must be initiated.  The pickups require a certain non-zero time (for loading of the cargo).
 
<p>The resources for this problem are of type vehicle, and the tasks for this problem are of type customer.  Another object type, extradata, holds all the
global data.  The metadata for these object types are:
 
<br><div align=center>
<table cellspacing=0>
<tr>
<td align=center><font size=+1><b>customer</b></font></td>
<td align=center><font size=+1><b>vehicle</b></font></td>
<td align=center><font size=+1><b>extradata</b></font></td>
</tr>
<tr><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>id</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>load</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>ready_time</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>due_date</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>location</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>xy_coord</td>
 </tr>
</table>
</td><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>id</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
</table>
</td><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>capacity</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>service_time</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>depot_location</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>xy_coord</td>
 </tr>
</table>
</td></tr>
</table>
</div>
 
<p>There is a single global variable of type <i>extradata</i> called extradata.  The (non-default) scheduling specifications for this problem are:<br><br>
<div align=center>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td width=160 bgcolor=black align=center>
        <font color=white><b>Constraint</b></font></td>
  <td width=420 bgcolor=black align=center>
        <font color=white><b>Expression</b></font></td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Optimization Criterion</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        sumover (resources, "resource", preptime (resource)) +<br>
        sumover (tasks, "task", if (hasvalue (resourcefor (task)), 0, 1000))
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Delta Criterion</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        preptime (resource) - previousdelta (resource)
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Duration</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        extradata.service_time
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Wrapup Duration</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        if (hasvalue (next), 0,
            dist (task.location, extradata.depot_location))
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Unavailable Times</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        list (interval (start_time, start_time + task.ready_time),<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interval (start_time + task.due_date +
                     extradata.service_time),<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;end_time))
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Capacity Contributions</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.load
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Capacity Thresholds</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        extradata.capacity
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Task Text</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.load
  </td>
 </tr>
</table>
</div>
 
<p>One thing to note is how the delta criterion tells the incremental increase in the optimization criterion due to adding a task to a resource.

<p><b>C. 4 Generalized Assignment Problem (testdata/assignment/c515-1.vsh)</b>

<p>The generalized assignment problem is not a true scheduling problem in that there are no times associated with the assignments of tasks to resources. 
There are N jobs to be assigned to M agents.  There is a predefined set of assignment costs associated, one associated with each pairing of a job and
an agent.  Each agent also has a defined capacity, and each job contributes a defined amount towards the capacity of each agent (with this amount
depending on the agent).  The objective is to maximize the total costs.
 
The metadata are:
 
<br><div align=center>
<table cellspacing=0>
<tr>
<td align=center><font size=+1><b>job</b></font></td>
<td align=center><font size=+1><b>agent</b></font></td>
</tr>
<tr><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>id</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>index</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>costs</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>list of number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>loads</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>list of number</td>
 </tr>
</table>
</td><td nowrap valign=top style='padding:0in 0.25in 0in 0.25in'>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Name&nbsp;&nbsp;</b></font></td>
  <td bgcolor=black align=center style='padding:0in 5.4pt 0in 5.4pt'>
        <font color=white><b>Field Type&nbsp;&nbsp;</b></font></td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>id</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>string</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>index</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
 <tr>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>capacity</td>
  <td style='padding:0in 5.4pt 0in 5.4pt' valign=top>number</td>
 </tr>
</table>
</td></tr>
</table>
</div>
 
<p>The (non-default) scheduling specifications for this problem are:<br><br>
<div align=center>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td width=160 bgcolor=black align=center>
        <font color=white><b>Constraint</b></font></td>
  <td width=420 bgcolor=black align=center>
        <font color=white><b>Expression</b></font></td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Optimization Criterion</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        sumover (tasks, "task", entry (task.costs, resourcefor (task).index))
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Delta Criterion</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        entry (task.costs, resource.index)
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Capacity Contributions</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        task.loads
  </td>
 </tr>
 <tr>
  <td width=160 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Capacity Thresholds</td>
  <td width=420 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        loop (length (resources), "i",<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        if (i = resource.index, resource.capacity, 100000))
  </td>
 </tr>
</table>
</div>

<? makeSection ("Installation Procedure", "d", "D"); ?>

By far, the easiest way to install the required web server setup is
to use the product AbriaSQL Standard from
<a href="http://www.abriasoft.com">Abriasoft</a>.
However, if you do not wish to pay for this product, or it does not
work for your particular configuration, here is the step-by-step
approach for a UNIX machine.
<p>
<b>Goal:</b>
Install an apache web server (DSO), with php4, which talks to
mysql & gd.  
<p>
<b>Versions:</b><br>
mysql-3.22.32-pc-linux-gnu-i686.tar.gz (Binary) (USE Gnu tar !!!)<br>
apache_1.3.14<br>
php-4.0.3pl1 <br>
zlib-1.1.3<br>
libpng-1.0.8<br>
jpeg-6b<br>
gd-1.8.3<br>
<p>
<b>Assumptions:</b>
Linux box. (Not too differant) Install to /usr/local/*  from /usr/local/src/*
<p>
<b>mysql binary:</b><br>
% su  # Become root.<br>
% cd /usr/local    # location of mysql dir<br>
% gzip -dc mysql-VERSION-OS.tar.gz | tar xvf -<br>
% ln -s mysql-VERSION-OS mysql<br>
% cd mysql<br>
% ./scripts/mysql_install_db<br>
% ./bin/safe_mysqld &  # FOR TESTING <br>
<br>
# System startup...<br>
% cp support-files/mysql.server /etc/rc.d/init.d   # (Lose rc.d for Solaris)<br>
% chmod 755 /etc/rc.d/init.d/mysql.server <br>
# -> Create links in rc3.d to start/stop the server.<br>
<br>
# Start server.<br>
# -> Kill safe_mysqld<br>
% /etc/rc.d/init.d/mysql.server start   # (Lose rc.d for Solaris)<br>
<br>
# Set the root password.<br>
% /usr/local/mysqladmin -u root password abc123<br>
% /usr/local/mysql/bin/mysql -u root -pabc123 mysql<br>
mysql> USE mysql<br>
mysql> UPDATE user SET Password=password('abc123')  WHERE User='root';<br>
<p>
<b>zlib:</b><br>
% cd /usr/local/src/<br>
% gzip -dc zlib-1.1.3.tar.gz | tar xvf -<br>
% cd zlib-1.1.3<br>
% ./configure<br>
% make<br>
% make install<br>
<p>
<b>libpng:</b><br>
# Note: zlib MUST already be built.<br>
% cd /usr/local/src<br>
% gzip -dc libpng-1.0.8 | tar xvf -<br>
% cd libpng<br>
% cp scripts/makefile.linux Makefile     # Choose appropriate make file.<br>
% make<br>
% make install<br>
<p>
<b>jpeg:</b><br>
% cd /usr/local/src<br>
% gzip -dc jpeg-6b.tar.gz | tar xvf -<br>
% cd jpeg-6b<br>
% ./configure<br>
% make<br>
% make install<br>
<p>
<b>gd (Depends upon libpng and jpeg):</b><br>
% cd /usr/local/src<br>
% gzip -dc gd-1.8.3.tar.gz | tar xvf -<br>
% cd gd-1.8.3<br>
# Read Makefile<br>
% make<br>
% make install<br>
<p>
<b>Apache 1.3.14</b><br>
% cd /usr/local/src<br>
% gzip -dc apache_1.3.14.tar.gz | tar xvf -<br>
% cd /usr/local/src/apache_1.3.14<br>
% ./configure \<br>
&nbsp;&nbsp;       --prefix=/usr/local/http-80 \<br>
&nbsp;&nbsp;       --with-layout=Apache \<br>
&nbsp;&nbsp;       --enable-rule=SHARED_CORE \<br>
&nbsp;&nbsp;       --enable-module=so \<br>
&nbsp;&nbsp;       --enable-module=info \<br>
&nbsp;&nbsp;       --enable-module=rewrite \<br>
&nbsp;&nbsp;       --enable-module=headers \<br>
&nbsp;&nbsp;       --enable-module=usertrack<br>
% make<br>
% make install<br>
<p>
<b>PHP4</b><br>
% cd /usr/local/src<br>
% gzip -dc php-4.0.3pl1.tar.gz | tar xvf - <br>
% cd /usr/local/src/php-4.0.3pl1<br>
% cat INSTALL   # !!!!<br>
% vi /etc/ld.so.conf<br>
vi>  Add:   /usr/local/lib<br>
vi>  Add:   /usr/local/mysql/lib<br>
% ldconfig<br>
% rm config.cache<br>
% ./configure \<br>
&nbsp;&nbsp;     --with-apxs=/usr/local/http-80/bin/apxs \<br>
&nbsp;&nbsp;     --with-mysql=/usr/local/mysql \<br>
&nbsp;&nbsp;     --with-zlib=/usr/local/ \<br>
&nbsp;&nbsp;     --with-gd=/usr/local/ \<br>
&nbsp;&nbsp;     --with-jpeg-dir=/usr/local/bin \ <br>
&nbsp;&nbsp;     --with-libpng=/usr/local/ \<br>
&nbsp;&nbsp;     --with-config-file-path=/usr/local/lib \<br>
&nbsp;&nbsp;     --with-xml \<br>
&nbsp;&nbsp;     --enable-track-vars<br>
<br>
% make<br>
% make install<br>
% cp php.ini-dist /usr/local/lib/php.ini  # To path specified above.<br>
# Notes:  --with-zlib, --with-jepeg-dir --withlibpng are all questionable.<br>
<p>
<b>Configure Apache:</b><br>
% cd /usr/local/http-80/config<br>
% vi httpd.conf<br>
   - Change/Uncomment: <br>
        DirectoryIndex index.html index.htm index.shtml index.cgi index.php index.php3 index.phtml<br>
        AddType application/x-httpd-php .html .php .php3 .phtml<br>
        AddType application/x-httpd-php-source .phps<br>
   - Other non-php configs...<br>
      ie: hostname, cgi, includes, logs, ...<br>
   - Group -> www<br>
% /usr/local/http-80/bin/httpd -t   # Test the syntax of the the config files.<br>
<br>
# System startup...<br>
% cd /etc/rc.d/init.d   (/etc/init.d for Solaris)<br>
% ln -s /usr/local/http-80/bin/apachectl httpd-80<br>
% ../rc3.d<br>
% ln -s ../init.d/httpd-80 S80httpd-80<br>
% cd ../rc5.d<br>
% ln -s ../init.d/httpd-80 S80httpd-80<br>
% cd ../rc1.d<br>
% ln -s ../init.d/httpd-80 K15httpd-80<br>
% cd ../rc2.d<br>
% ln -s ../init.d/httpd-80 K15httpd-80<br>
% cd ../rc6.d<br>
% ln -s ../init.d/httpd-80 K15httpd-80<br>
# - Remove the existing apache S and K files if needed.<br>
# - Stop the old server if running.<br>
# - Start the new server.<br>
# - Check Errors in /usr/local/http-80/logs/errors<br>
<p>
<b>Misc:</b><br>
# Create a local 'www' group. <br>
# Let the userver run as nobody.www. <br>
# Change dir permissions.<br>
# Give acces to trusted users.<br>
#--<br>
% vi /etc/group<br>
      www:x:8080:jglockli,jadams,rryder,jadams,gvidaver,dmontana,hkieserm<br>
% cd /usr/local<br>
% chgrp -R www mysql<br>
% chgrp -R www http-80<br>
% cd /usr/local/http-80<br>
% chmod 775 htdocs<br>
% chmod u+s htdocs<br>
<p>
<b>Sources:</b><br>
Apache 1.3.14   -  http://www.apache.org/dist/apache_1.3.14.tar.gz<br>
PHP v. 4.0.3pl1 -  http://www.php.net/downloads.php<br>
Zlib            -  ftp://ftp.uu.net/graphics/png/src/zlib-1.1.3.tar.gz<br>
Gd              -  http://www.boutell.com/gd/http/<VERSION><br>
MySQL           -  http://www.mysql.com/downloads/index.html<br>
Libpng          -  http://www.libpng.org/pub/png/src/libpng-1.0.8.tar.gz<br>
JPEG-6b         -  http://cygutils.netpedia.net/V1.1/jpeg-6b/jpegsrc.v6b.tar.gz<br>
<p>
<b>Dependancies:</b><br>

<? makeSection ("To Do List", "e", "E"); ?>

<p>Vishnu is still in its early stages.  There are many improvements to be made and holes to be filled.  Here is a list of some of the enhancements we are
considering:
<ul>
<li> <b>Manual Assignments</b> - The user should be able to perform an assignment or unassignment of a task to a resource.
<li> <b>Better Capacity Logic</b> - The current logic does not allow for resetting of capacity (due to unloading or the end of a time interval).
<li> <b>Function Definition</b> - The user should be able to define new functions much easier than is now possible.
<li> <b>Synchronization of Multiple Clients</b> - There should be better locking of database tables to ensure that no inconsistencies arise when we start using
   multiple clients, particularly multiple schedulers.
<li> <b>Sparse Distance Matrices</b> - The user should be able to specify distances only between nearby locations, and the scheduler should be able to fill
   out the full set of distances between a set of locations by finding minimum paths through the network.
<li> <b>Rollback for Data Error</b> - When there is an error loading data, the database should roll back to a state where it was consistent rather than be in an
   inconsistent state.  This will necessitate using Berkeley BDB tables to provide rollback capability.  Remember to delete the problem name if there is
   an error loading the problem definition.
<li> <b>Geographic Display</b> - When a latlong or xy_coord can be defined for each task, we should provide a simple graphical representation of the route
   of each resource.
<li> <b>Access and Security</b> - We should use
   https instead of http for greater security.  We should consider defining the concept of privileges so that certain users can perform certain operations
   and access certain problems.
<li> <b>Circularity Check</b> - We should ensure that the scheduler does not get stuck in an infinite loop due to circularities in the prerequisites of tasks.
<li> <b>Multiple Resources Per Task</b> - It should be possible for a task to require multiple resources and hence have multiple assignments.
<li> <b>Schedule Stability Soft Constraint</b> - It should be possible to express a preference for keeping the schedule the same as much as possible without
   freezing the assignments.
<li> <b>Unassigned Tasks Display</b> - When displaying the full schedule, make a little note at the bottom about tasks that were not able to be scheduled.
<li> <b>Faster Execution of Formulas</b> - Instead of recursing through the parse trees of the formulas, the scheduler should create linear representations that it can iterate through.
<ul>
</div>

<? } ?>

<? /*

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>A global variable <i
style='mso-bidi-font-style:normal'>distances</i> of type matrix is defined that
contains all the distances between cities.<span style="mso-spacerun: yes">б
</span>The (non-default) scheduling specifications for this problem are:<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<table border=1 cellspacing=0 cellpadding=0 style='margin-left:18.9pt;
 border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  background:black;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Constraint<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border:solid windowtext .5pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;background:black;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Expression<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Optimization
  Criterion<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>maxover
  (resources, &quot;resource&quot;,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">ббббббббббббббб </span>complete (resource)) -
  start_time<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>SetupDuration<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>matentry (distances,
  task.index, previous.index)<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Prerequisites<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>if (task.id !=
  &quot;Start&quot;,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">ббб </span>if (task.id = &quot;City 1&quot;,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">бббббббб </span>mapover (tasks, &quot;task2&quot;,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">бббббббббббббббббббббббб </span>if (task2.id !=
  &quot;City 1&quot;, task2.id)),<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">бббббббб </span>list (&quot;Start&quot;)))<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Task Text<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>task.index<o:p></o:p></span></p>
  </td>
 </tr>
</table>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>One thing to note
is that distances and durations are treated interchangeably, basically assuming
that the salesman travels one unit of distance in a second.<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt'>C.
3 Vehicle Routing Problem with Time Windows (testdata/VRP/solomon101.vsh)<o:p></o:p></span></p>

<p><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>The vehicle
routing problem with time windows (VRPTW) is an extension of the capacitated
vehicle routing problem (CVRP).<span style="mso-spacerun: yes">б </span>In
CVRP, there are M vehicles and N customers from whom to pick up cargo.<span
style="mso-spacerun: yes">б </span>Each vehicle has a limited capacity for
cargo, and each piece of cargo contributes different amounts towards this
capacity.<span style="mso-spacerun: yes">б </span>Each vehicle that is utilized
starts at a central depot, makes a circuit of all its customers, and then
returns to the depot.<span style="mso-spacerun: yes">б </span>The objective is
to minimize the total distance traveled by the vehicles.<span
style="mso-spacerun: yes">б </span>In VRPTW, an extra constraint is added that
there is a certain window of time in which each pickup must be initiated.<span
style="mso-spacerun: yes">б </span>The pickups require a certain non-zero time
(for loading of the cargo).<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>The resources for
this problem are of type <i style='mso-bidi-font-style:normal'>vehicle</i>, and
the tasks for this problem are of type<i style='mso-bidi-font-style:normal'>
customer</i>.<span style="mso-spacerun: yes">б </span>Another object type, <i
style='mso-bidi-font-style:normal'>extradata, </i>holds all the global
data.<span style="mso-spacerun: yes">б </span>The metadata for these object
types are:<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<table border=1 cellspacing=0 cellpadding=0 style='margin-left:9.9pt;
 border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr>
  <td width=186 colspan=2 valign=top style='width:139.5pt;border:solid windowtext 3.0pt;
  background:black;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle align=center style='text-align:center'><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;text-decoration:none;
  text-underline:none'>customer<o:p></o:p></span></p>
  </td>
  <td width=186 colspan=2 valign=top style='width:139.5pt;border:solid windowtext 3.0pt;
  border-left:none;mso-border-left-alt:solid windowtext 3.0pt;background:black;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle align=center style='text-align:center'><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;text-decoration:none;
  text-underline:none'>vehicle<o:p></o:p></span></p>
  </td>
  <td width=204 colspan=2 valign=top style='width:153.0pt;border:solid windowtext .5pt;
  border-left:none;background:black;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle align=center style='text-align:center'><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;text-decoration:none;
  text-underline:none'>extradata<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=96 valign=top style='width:1.0in;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Field Name<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Data Type<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Field Name<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Data Type<o:p></o:p></span></p>
  </td>
  <td width=114 valign=top style='width:85.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 3.0pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Field Name<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Data Type<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=96 valign=top style='width:1.0in;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>id<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>string<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>id<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>string<o:p></o:p></span></p>
  </td>
  <td width=114 valign=top style='width:85.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>capacity<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle style='margin-right:-27.9pt'><span style='font-size:
  12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;text-decoration:none;
  text-underline:none'>number<o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='height:13.9pt'>
  <td width=96 valign=top style='width:1.0in;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:13.9pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>load<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>number<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=114 valign=top style='width:85.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt;
  height:13.9pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>service_time<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt;height:13.9pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>number<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=96 valign=top style='width:1.0in;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>ready_time<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>number<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=114 valign=top style='width:85.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>depot_location<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>xy_coord<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=96 valign=top style='width:1.0in;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>due_date<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>number<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=114 valign=top style='width:85.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=96 valign=top style='width:1.0in;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>location<o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>xy_coord<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=114 valign=top style='width:85.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=90 valign=top style='width:67.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
 </tr>
</table>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>There is single
global variable of type extradata called extradata.<span style="mso-spacerun:
yes">б </span>The (non-default) scheduling specifications for this problem are:<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<table border=1 cellspacing=0 cellpadding=0 style='margin-left:18.9pt;
 border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  background:black;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Constraint<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border:solid windowtext .5pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;background:black;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Expression<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Optimization
  Criterion<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>sumover
  (resources, &quot;resource&quot;, preptime (resource)) + sumover (tasks,
  &quot;task&quot;,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">ббббббббббббббб </span>if (hasvalue (resourcefor
  (task)), 0, 1000))<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Delta Criterion<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>preptime
  (resource) - previousdelta (resource)<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Task Duration<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>extradata.service_time<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>SetupDuration<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>dist
  (task.location, if (hasvalue (previous), previous.location,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">бббббббббббббббббббббббббббббббббб
  </span>extradata.depot_location))<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Wrapup Duration<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>if (hasvalue
  (next), 0,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">ббб </span>dist (task.location, extradata.depot_location))<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Task Unavailable
  Times<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>list (interval
  (start_time, start_time + task.ready_time),<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">бббббб </span>interval (start_time + task.due_date
  +<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">бббббббббббббббббббббб
  </span>extradata.service_time), end_time))<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Capacity
  Contributions<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>task.load<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Capacity Thresholds<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>extradata.capacity<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Task Text<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>task.load<o:p></o:p></span></p>
  </td>
 </tr>
</table>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>One thing to note
is how the delta criterion tells the incremental increase in the optimization
criterion due to adding a task to a resource.<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt'>C.
4 Generalized Assignment Problem (testdata/assignment/c515-1.vsh)<o:p></o:p></span></p>

<p><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>The generalized
assignment problem is not a true scheduling problem in that there are no times
associated with the assignments of tasks to resources.<span
style="mso-spacerun: yes">б </span>There are N jobs to be assigned to M agents.<span
style="mso-spacerun: yes">б </span>There is a predefined set of assignment
costs associated, one associated with each pairing of a job and an agent.<span
style="mso-spacerun: yes">б </span>Each agent also has a defined capacity, and
each job contributes a defined amount towards the capacity of each agent (with
this amount depending on the agent).<span style="mso-spacerun: yes">б
</span>The objective is to maximize the total costs.<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>The metadata are:<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<table border=1 cellspacing=0 cellpadding=0 style='margin-left:18.9pt;
 border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr>
  <td width=210 colspan=2 valign=top style='width:157.5pt;border:solid windowtext 3.0pt;
  background:black;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle align=center style='text-align:center'><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;text-decoration:none;
  text-underline:none'>job<o:p></o:p></span></p>
  </td>
  <td width=204 colspan=2 valign=top style='width:153.0pt;border:solid windowtext 3.0pt;
  border-left:none;mso-border-left-alt:solid windowtext 3.0pt;background:black;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle align=center style='text-align:center'><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;text-decoration:none;
  text-underline:none'>agent<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=102 valign=top style='width:76.5pt;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Field Name<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Data Type<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 3.0pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Field Name<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext 3.0pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Data Type<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=102 valign=top style='width:76.5pt;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>id<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>string<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>id<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle style='margin-right:-27.9pt'><span style='font-size:
  12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;text-decoration:none;
  text-underline:none'>string<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=102 valign=top style='width:76.5pt;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>index<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>number<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>index<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>number<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=102 valign=top style='width:76.5pt;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>costs<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>list:number<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>capacity<o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>number<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=102 valign=top style='width:76.5pt;border:solid windowtext 3.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 3.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>loads<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 3.0pt;border-right:solid windowtext 3.0pt;
  mso-border-top-alt:solid windowtext 3.0pt;mso-border-left-alt:solid windowtext 3.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>list:number<o:p></o:p></span></p>
  </td>
  <td width=108 valign=top style='width:81.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
  <td width=96 valign=top style='width:1.0in;border-top:none;border-left:none;
  border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><span
  style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
  text-decoration:none;text-underline:none'><o:p></o:p></span></p>
  </td>
 </tr>
</table>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>The (non-default)
scheduling specifications for this problem are:<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<table border=1 cellspacing=0 cellpadding=0 style='margin-left:18.9pt;
 border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-padding-alt:0in 5.4pt 0in 5.4pt'>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  background:black;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Constraint<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border:solid windowtext .5pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;background:black;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  text-decoration:none;text-underline:none'>Expression<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Optimization
  Criterion<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>sumover (tasks,
  &quot;task&quot;,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">ббббббббббббббб </span>entry (task.costs,
  resourcefor (task).index))<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Delta Criterion<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>entry
  (task.costs, resource.index)<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Capacity
  Contributions<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>task.loads<o:p></o:p></span></p>
  </td>
 </tr>
 <tr>
  <td width=144 valign=top style='width:1.5in;border:solid windowtext .5pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>Capacity
  Thresholds<o:p></o:p></span></p>
  </td>
  <td width=420 valign=top style='width:315.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext .5pt;border-right:solid windowtext .5pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'>loop (length (resources),
  &quot;i&quot;,<o:p></o:p></span></p>
  <p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
  font-weight:normal;text-decoration:none;text-underline:none'><span
  style="mso-spacerun: yes">бббббббб </span>if (i = resource.index,
  resource.capacity, 100000))<o:p></o:p></span></p>
  </td>
 </tr>
</table>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></p>

<p class=MsoSubtitle>Appendix D. Installation Procedure</p>

<p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></p>

<p class=MsoSubtitle>Appendix E. To Do List</p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'>Vishnu is still in
its early stages.<span style="mso-spacerun: yes">б </span>There are many
improvements to be made and holes to be filled.<span style="mso-spacerun:
yes">б </span>Here is a list of some of the enhancements we are planning:<o:p></o:p></span></p>

<p class=MsoSubtitle><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Best time, not earliest: </span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'>Currently the decoder always places a
task at the earliest possible time for a resource.<span style="mso-spacerun:
yes">б </span>Instead, the decoder should be able to place a task at a later
but better time.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Scrolling/scaling of schedule
graphics:</span><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'> The PHP code
currently figures out a single start and end time for the schedule graphics,
and there is no way of changing this to allow a user, for example, to zoom in
and see greater detail.<span style="mso-spacerun: yes">б </span>We should add
this capability.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Function Definition:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> The user should be able to define
new functions much easier than is now possible.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Control of Scheduler Operation:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> The user should have greater
visibility into the progress that the scheduler is making on a particular
problem and should be able to cancel a run.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Synchronization of Multiple Clients:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> There should be better locking of
database tables to ensure that no inconsistencies arise when we start using
multiple clients, particularly multiple schedulers.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Sparse Distance Matrices:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> The user should be able to specify
distances only between nearby locations, and the scheduler should be able to
fill out the full set of distances between a set of locations by finding
minimum paths through the network.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Rollback for Data Error: </span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'>When there is an error loading data,
the database should roll back to a state where it was consistent rather than be
in an inconsistent state.<span style="mso-spacerun: yes">б </span>This will
necessitate using Berkeley BDB tables to provide rollback capability.<span
style="mso-spacerun: yes">б </span>Remember to delete the problem name if there
is an error loading the problem definition.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Geographic Display:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> When a latlong or xy_coord can be
defined for each task, we should provide a simple graphical representation of
the route of each resource.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Editing of Data, Metadata and GA
Parameters:</span><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
font-weight:normal;text-decoration:none;text-underline:none'> We should allow
the user to enter the data, metadata and genetic algorithm parameters from the
browser instead of only from an external client.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Login, Authorization and Security:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> We should force users to provide a
username and password to access any of the pages.<span style="mso-spacerun:
yes">б </span>We should also use https instead of http for greater
security.<span style="mso-spacerun: yes">б </span>We should consider defining
the concept of privileges so that certain users can perform certain operations
and access certain problems.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Circularity Check:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> We should ensure that the scheduler
does not get stuck in an infinite loop due to circularities in the
prerequisites of tasks.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Multiple Resources Per Task:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> It should be possible for a task to
require multiple resources and hence have multiple assignments.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Schedule Stability Soft Constraint:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> It should be possible to express a
preference for keeping the schedule the same as much as possible without
freezing the assignments.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Direct Plugin: </span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'>Make a version of the scheduler that
operates in the same virtual machine as an ALP plugin and hence does not require
the intermediary web server.<o:p></o:p></span></p>

<p class=MsoSubtitle style='margin-left:13.5pt;text-indent:-13.5pt;mso-list:
l13 level1 lfo12;tab-stops:list 13.5pt'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Symbol;font-weight:normal;text-decoration:
none;text-underline:none'>ё<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span><![endif]><span style='font-size:12.0pt;mso-bidi-font-size:10.0pt;
text-decoration:none;text-underline:none'>Unassigned Tasks Display:</span><span
style='font-size:12.0pt;mso-bidi-font-size:10.0pt;font-weight:normal;
text-decoration:none;text-underline:none'> When displaying the full schedule,
make a little note at the bottom about tasks that were not able to be
scheduled.<o:p></o:p></span></p>

<p class=MsoSubtitle><![if !supportEmptyParas]>&nbsp;<![endif]><o:p></o:p></p>

</div>

</body>

</html>
*/ ?>