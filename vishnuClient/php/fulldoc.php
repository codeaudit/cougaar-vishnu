<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Dynamic generation of full documentation.
// Note that to get the non-dynamic version, save the web page as
// faq.html, replace all references to faq.php and fulldoc.php
// with faq.html and fulldoc.html, and remove the reference to "Home".

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

  function refSubsection ($name, $label, $app="") {
    global $sectioncounter2, $subsectioncounter2;
    $subsectioncounter2++;
    echo "<a href=\"fulldoc.php#" . $label . "\"><font>" .
         ($app ? $app : $sectioncounter2) . "." . $subsectioncounter2 .
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

  function makeSubsection ($name, $label, $app="") {
    global $sectioncounter, $subsectioncounter;
    $subsectioncounter++;
    echo "<p><a name=\"" . $label . "\"><b><font size=+1>" .
         ($app ? $app : $sectioncounter) . "." . $subsectioncounter .
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
    refSection ("Cougaar-Vishnu Bridge", "bridge");
    refSubsection ("Overview", "br1");
    refSubsection ("Translation", "br2");
    refSubsection ("Assignment Freezing", "br3");
    refSubsection ("Parameters", "br4");
    refSection ("Currently Defined Functions", "a", "A");
    refSection ("XML Data Formats", "b", "B");
    refSection ("Test Problem Descriptions", "c", "C");
    refSubsection ("Job-Shop Scheduling Problem (testdata/jobshop/mt06.vsh)",
                   "c1", "C");
    refSubsection ("Traveling Salesman Problem (testdata/TSP/bays29.vsh)",
                   "c2", "C");
    refSubsection ("Vehicle Routing Problem with Time Windows (testdata/VRP/solomon101.vsh)",
                   "c3", "C");
    refSubsection ("Generalized Assignment Problem (testdata/assignment/c515-1.vsh)",
                   "c4", "C");
    refSection ("Installation and Setup Procedure", "d", "D");
    refSubsection ("Installing the Web Server", "d1", "D");
    refSubsection ("Installing Java", "d2", "D");
    refSubsection ("Installing and Executing Vishnu", "d3", "D");
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
<IMG SRC="arch.gif" width=564 height=161 >
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
        Best Time</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>datetime</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task, resouce, duration</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>start_time</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Optimal time for the task to begin
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
        valign=top>task, resource, prerequisites, duration</td>
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
        valign=top>true</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Whether task1 and task2 can be done as part of the same group
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Linked</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>boolean</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task1, task2</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>false</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Whether the start time of <i>task2</i> is linked to the start time of <i>task1</i>
  </td>
 </tr>
 <tr>
  <td width=109 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Link Time Difference</td>
  <td width=72 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>number</td>
  <td width=102 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>task1, task2</td>
  <td width=66 style='padding:0in 5.4pt 0in 5.4pt' align=center
        valign=top>0</td>
  <td width=241 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Number of seconds that the start time of <i>task2</i> must follow the start time of <i>task1</i>
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

<p>[NOTE: The fact that the decoder itself does a simple optimization
means that the genetic algorithm does not have to work as hard.  Even if
the genetic algorithm generates just a single individual, this
individual will generally always be a much-better-than-average schedule
and can potentially even be optimal if there is little or no contention
for resources.  This is important to keep in mind when choosing genetic
algorithm parameters.]
 
<p>The scheduler stops running when any of the following four quantities exceed their specified limit: (1) the elapsed time for the run, (2) the total number
of individuals evaluated, (3) the number of consecutive evaluations without an improvement to the best individual, and (4) the number of duplicate
individuals generated.
 
<p>When the scheduler stops running, it writes the following information back to the database: (1) the set of all assignments of tasks to resources, including
the times (setup start, task start, task end, and wrapup end) and the color and text to be displayed and (2) the set of non-task activities for each
resource, including times, color and text.

<a name="gaparameters"></a>
<p>The following table provides the parameters that can be varied to control
the genetic algorithm performance:

<p><div align=center>
<table border cellspacing=1 cellpadding=0>
 <tr>
  <td width=80 bgcolor=black align=center>
        <font color=white><b>Parameter Name</b></font></td>
  <td width=460 bgcolor=black align=center>
        <font color=white><b>Description</b></font></td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Population Size</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Number of individuals in the population at any one time; they are
        generated randomly for the initial population and then
        gradually replaced by their descendants; make this larger in
        order to run the genetic algorithm longer and find a better solution
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Parent Scalar</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        This parameter controls the fitness pressure; the k<sup>th</sup> best
        individual in the population is this times less likely than the
        (k-1)<sup>st</sup>
        to be selected as a parent; this should always be less than
        1; making this closer to 1 decreases the pressure and allows the
        genetic algorithm to search longer before converging on a single
        solution
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Maximum Evaluations</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Limit on the number of individuals that the genetic algorithm can
        generate before being forced to stop
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Maximum Time</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Limit on the number of seconds that the genetic algorithm can
        execute before being forced to stop
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Maximum Top Dog Age</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Limit on the number of consecutive individuals that the
        genetic algorithm can generate without generating one better than
        the current best individual before being forced to stop
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Crossover Probability</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Probability of choosing crossover as the genetic operator used
        to generate the next child (should sum to 1 with the mutation
        probability)
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Mutation Probability</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Probability of choosing mutation as the genetic operator used
        to generate the next child (should sum to 1 with the crossover
        probability)
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Maximum Fraction Mutated</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        The mutation operator will randomly choose some fraction of
        the chromosome to mutate, and this paramater sets the upper
        limit on this fraction
  </td>
 </tr>
 <tr>
  <td width=80 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        Report Interval</td>
  <td width=460 style='padding:0in 5.4pt 0in 5.4pt' valign=top>
        How often (in seconds) the genetic algorithm reports
        its percent complete status to the web server (0 means not
        until the end)
  </td>
 </tr>
</table>
</div>


<? makeSection ("Using the Browser-Based GUI", "gui"); ?>

<p>The GUI allows a user to see all the information about a problem including the data/metadata, scheduling specifications, and the schedule created.
It also allows a user to edit the data and metadata for a problem.

<p> The initial
access to the GUI should usually be via the home page,
currently called vishnu.php (the default index.html will send you there).
This will be in whatever directory on the server the Vishnu code was
installed in, but the recommendation is that it should be in the directory
vishnu.  This page allows the user to either select an already loaded
problem, load a problem from a file or
create a problem from scratch.
Selecting a problem takes the user to the main page for that problem.

<p>All the information about the problem and all the operations
to edit the problem can be accessed via links on the problem's main page.
The current set of links allow the user to:
<ul>
<li> view the assignment data and internal data for any
task object, edit the data in any task object, delete a task object,
or create a new task object
<li> view the assignment data and internal data for any
resource object, where the assignment data is displayed as a color-coded
schedule graphic, plue edit/create/delete resource objects
<li> edit/create/delete any global objects.
<li> view and/or edit the metadata, i.e. view
the fields for a given object type, edit the fields of an object type,
and create a new object type
<li> view the full set of the scheduling specifications,
including the color specifications, for the problem, and following
links from the specifications viewing page, editing the specification
for any constraint
<li> view a color-coded and labeled graphic displaying all
the schedule data for all the resources.
<li> view the scheduling window and genetic algorithm parameters and
change the values of these paramters
<li> start the scheduler executing on the problem
<li> see whether the scheduler has completed
<li> load some additional problem data from a file
<li> save the problem data and/or specifications to a file
</ul>
 
<? makeSection ("Cougaar-Vishnu Bridge", "bridge"); ?>

<p><a href="http://www.cougaar.org">Cougaar</a> is an architecture for construction
of large-scale, distributed multiagent systems.  Vishnu provides a way
to easily integrate one or more Vishnu schedulers into a multiagent system
based on <a href="http://www.cougaar.org">Cougaar</a>.  This section uses 
<a href="http://www.cougaar.org">Cougaar</a> terminology and concepts extensively,
so interested readers should first familiarize themselves with these
first before attempting to read this section.

<? makeSubsection ("Overview", "br1"); ?>

<P>The Cougaar-Vishnu Bridge is used to connect a <a href="http://www.cougaar.org">Cougaar</a> plugin to the Vishnu Scheduling System.  The bridge is instantiated in the usual plugin flavors: expander, allocator, and aggregator. Typically an allocator would be used for a one-to-one scheduling problem and an aggregator for a many-to-one problem.  Sometimes a task-to-resource assignment needs to be made in an expander and that assignment recorded in prepositions on the new subtask of the expansion.  Such an assignment might be a piece of necessary information for a downstream plugin.</P>

<P>The Bridge interfaces between a <a href="http://www.cougaar.org">Cougaar</a> plugin and Vishnu by mapping <a href="http://www.cougaar.org">Cougaar</a> tasks and assets to Vishnu tasks and resources.  LDM objects are translated into XML of a form that Vishnu understands, and Vishnu assignments, expressed in XML, are used to create plan elements.</P>

<P>Each instance of a bridge plugin maps to a problem in the Vishnu database. When a bridge plugin receives a task for the first time, it sends its problem definition to Vishnu.  The problem definition is composed of the object format of the tasks and resources, the scheduling specs, the GA parameters, the object format of any other data that is neither task nor resource, and that other data itself.</P>

<P>The object format of the tasks and resources is automatically generated from the plugin's tasks and assets, but the other parts of the problem definition are defined by files associated with the plugin.</P>

<P>The associated files are, by default, the name of the cluster, with a suffix identifying the type of file.  For instance, a cluster named Sample with a bridge plugin might have the following files:</P>

<div align=center>
<TABLE BORDER CELLSPACING=1 CELLPADDING=7>
<TR><TD WIDTH=120 VALIGN="TOP">
<B><P>File</B></TD>
<TD WIDTH=270 VALIGN="TOP">
<B><P>Description</B></TD>
<TD WIDTH=90 VALIGN="TOP">
<B><P>Required</B></TD>
</TR>
<TR><TD WIDTH=120 VALIGN="TOP">
<P>Sample.vsh.xml</TD>
<TD WIDTH=270 VALIGN="TOP">
<P>Scheduling specifications for the problem</TD>
<TD WIDTH=90 VALIGN="TOP">
<P>Yes</TD>
</TR>
<TR><TD WIDTH=120 VALIGN="TOP">
<P>Sample.ga.xml</TD>
<TD WIDTH=270 VALIGN="TOP">
<P>GA parameters for the problem</TD>
<TD WIDTH=90 VALIGN="TOP">
<P>Yes</TD>
</TR>
<TR><TD WIDTH=120 VALIGN="TOP">
<P>Sample.odf.xml</TD>
<TD WIDTH=270 VALIGN="TOP">
<P>Object format(s) for the other data</TD>
<TD WIDTH=90 VALIGN="TOP">
<P>Optional</TD>
</TR>
<TR><TD WIDTH=120 VALIGN="TOP" HEIGHT=14>
<P>Sample.odd.xml</TD>
<TD WIDTH=270 VALIGN="TOP" HEIGHT=14>
<P>Instance of the other data</TD>
<TD WIDTH=90 VALIGN="TOP" HEIGHT=14>
<P>Optional</TD>
</TR>
</TABLE>
</div>


<P>(The problem name can be changed by setting a plugin parameter.)</P>

<P>Once the problem definition is sent to Vishnu, the assets are translated into XML and sent as resource data for the problem.  This is only done the first time.  Then, the tasks are translated into XML and sent.  Now the problem is completely defined and ready to be solved.  The bridge then submits a request to Vishnu to create a schedule.  The bridge waits until a result is ready, and then parses the assignments that are returned to generate plan elements.</P>

<? makeSubsection ("Translation", "br2"); ?>

<P>The translation from Cougaar objects to Vishnu XML is done directly.  Two XML formats are created for Vishnu : the XML that describes the object format or meta-data and the object data itself.  The Cougaar objects are traversed twice, once to create the object format XML and once to create the data XML. (These two XML formats are described separately.)  A Format XMLizer traverses the Cougaar objects to create the format XML and a Data XMLizer traverses these same objects again to create the data XML.</P>
<div align=center>
<IMG SRC="Image1.gif" WIDTH=479 HEIGHT=359>
</div>
<font size=-1><B>Cougaar-Vishnu bridge implementation.</B> The bridge sends as input to Vishnu the object format, scheduling specs, genetic algorithm parameters, and other data (not pictured).  This defines the problem. Then, the data for the specific job is sent. When the scheduler is finished, XML assignments are returned, and used to create plan elements.</font>

<P><B>Tasks for setup and wrapup durations - </B>Also, note that if a setup or wrapup duration is defined in the specs, separate tasks are created to represent these durations.  These tasks need their allocation results handled differently than those for the task itself, since their time spans may well fall outside of the preferences of the original task.  For example, the time spent for a plane to fly back to base should not be included in the time spent performing the delivery of an item that was on the plane.  This is handled automatically by the Vishnu bridge with a special allocation result aggregator.</P>
<P>The creation of these wrapup and setup tasks is slightly different for each plugin flavor. For expanders, a one-to-one expansion becomes a one-to-two expansion if one of the specs is defined, and one-to-three if both are.  For aggregators, the MP task created by the aggregation is expanded.  And for allocators, there is a one-to-two or three expansion, and each subtask gets allocated to the assigned resource.  Plugins downstream of aggregators should note that the aggregator will produce either one MP task or multiple tasks depending on the existence of the wrapup or setup durations.</P>
<P><B>Post processing - </B>
The Format and Data XMLizers perform some post processing to give unique names to types and fields that have the same name in the corresponding Java object.  For instance, a preposition can have any type of object as an indirect object, so the bridge must figure out what types of indirect objects are present on the tasks and give them separate, unique field names.  In addition, commonly used property groups are given unique names and turned into global data.  These shared property groups are referenced by name in the tasks and resources.</P>

<? makeSubsection ("Assignment Freezing", "br3"); ?>

<P>There is another facility provided by the bridge for expanders and aggregators.  Since resource availability is represented in the role schedule, and since the role schedule does not reflect an assignment until an allocation is made, there is a gap of time between when an assignment is returned and when the resource's availability reflects the assignment.  During this period, a new task could come in and be scheduled against the asset during the interval of a previous assignment.  To protect against this, expanders and aggregators freeze task assignments until the plugin detects, through the allocation result, that an allocation has been made against the asset.  Once this happens, the assignment is unfrozen and can be cleared from the Vishnu database.</P>

<? makeSubsection ("Parameters", "br4"); ?>

<P>There are a number of parameters set in the Cluster's env.xml file that affect the behavior of the bridge.
<div align=center>
<br><B>Required Parameters</B><BR><BR>
<TABLE BORDER CELLSPACING=1 CELLPADDING=7 WIDTH=625>
<TR><TD WIDTH="21%" VALIGN="TOP">
<B><P>Parameter Name</B></TD>
<TD WIDTH="50%" VALIGN="TOP">
<B><P>Use</B></TD>
<TD WIDTH="29%" VALIGN="TOP">
<B><P>Default Value</B></TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>hostName</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>Host name of the web server</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>dante.bbn.com</TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>phpPath</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>Path to the php directory</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>~dmontana/vishnu</TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>user</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>User name for the mysql database</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>tops</TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>password</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>Password for the mysql database</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>tops</TD>
</TR>
</TABLE>
<br>

<BR><B>File Parameters</B><BR><BR>
<TABLE BORDER CELLSPACING=1 CELLPADDING=7 WIDTH=625>
<TR><TD WIDTH="21%" VALIGN="TOP">
<B><P>Parameter Name</B></TD>
<TD WIDTH="50%" VALIGN="TOP">
<B><P>Use</B></TD>
<TD WIDTH="29%" VALIGN="TOP">
<B><P>Default Value</B></TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>postProblemFile</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>Php file that’s part of the URL to post a problem</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>postproblem.php</TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>postDataFile</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>Php file that’s part of the URL to post the data for a problem</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>postdata.php</TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>kickoffFile</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>Php file that’s part of the URL to post a scheduling request</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>postkickoff.php</TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>readStatusFile</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>Php file that’s part of the URL to get the scheduler status</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>readstatus.php</TD>
</TR>
<TR><TD WIDTH="21%" VALIGN="TOP">
<P>assignmentsFile</TD>
<TD WIDTH="50%" VALIGN="TOP">
<P>Php file that’s part of the URL to get the generated assignments</TD>
<TD WIDTH="29%" VALIGN="TOP">
<P>assignments.php</TD>
</TR>
</TABLE>
<br>

<br><b>Misc Parameters</b><br><BR>
<TABLE BORDER CELLSPACING=1 CELLPADDING=7 WIDTH=619>
<TR><TD WIDTH="26%" VALIGN="TOP">
<B><P>Parameter Name</B></TD>
<TD WIDTH="54%" VALIGN="TOP">
<B><P>Use</B></TD>
<TD WIDTH="19%" VALIGN="TOP">
<B><P>Default Value</B></TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>runInternal</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Run using an internal scheduler.  Don't use the Vishnu web server.</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>false</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>makeSetupAndWrapupTasks</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Create separate tasks that correspond to the setup and wrapup durations of the original task.</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>true</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>vishnuEpochStartTime</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>The start of the Vishnu epoch.  Effects the width of the gantt chart display.</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>2000 01-01 00:00:00</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>vishnuEpochEndTime</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>The start of the Vishnu epoch.  Effects the gantt chart display.</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>2002 01-01 00:00:00</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>alwaysClearDatabase</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Clear the assets and tasks from previous jobs.</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>false</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>waitTime</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>How long to wait between polls</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>5 seconds</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>maxWaitCycles</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>How many times to poll. </TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>10</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>problemName</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Name of the problem. Defaults to "cluster name"_"machine name" .</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>cluster_machine</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>showTiming</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Show time necessary to complete scheduling.</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>true</TD>
</TR>
</TABLE>
<br>

<BR><B>Debugging Parameters</B><br><BR>
<TABLE BORDER CELLSPACING=1 CELLPADDING=7 WIDTH=619>
<TR><TD WIDTH="26%" VALIGN="TOP">
<B><P>Parameter Name</B></TD>
<TD WIDTH="54%" VALIGN="TOP">
<B><P>Use</B></TD>
<TD WIDTH="19%" VALIGN="TOP">
<B><P>Default Value</B></TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>testing</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Prints out XML that is sent to Vishnu</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>false</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>showALPXML</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Prints out output of XMLize</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>false</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP" HEIGHT=37>
<P>showFormatXML</TD>
<TD WIDTH="54%" VALIGN="TOP" HEIGHT=37>
<P>Prints out result of Format XMLizer</TD>
<TD WIDTH="19%" VALIGN="TOP" HEIGHT=37>
<P>false</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>showDataXML</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Prints out result of Data XMLizer</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>false</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>ignoreSpecsFile</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Don’t send the Cluster.vsh.xml file.  Useful if you don’t want to step on the specs on the server.</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>false</TD>
</TR>
<TR><TD WIDTH="26%" VALIGN="TOP">
<P>sendSpecsEveryTime</TD>
<TD WIDTH="54%" VALIGN="TOP">
<P>Send problem definition, including scheduling specs, every time.  Useful if you want to alter the specs from job to job.</TD>
<TD WIDTH="19%" VALIGN="TOP">
<P>false</TD>
</TR>
</TABLE>
<br><BR>
</div>

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

<p>The following is a DTD showing the expected XML data formats
for specifying a problem.<br>
<br><pre>
&lt;?xml version='1.0' standalone='yes' ?&gt;
&lt;!-- Vishnu Problem Specification --&gt;

&lt;!ELEMENT PROBLEM (DATAFORMAT, SPECS, GAPARMS, (DATA)?)&gt;
&lt;!ATTLIST PROBLEM
          name CDATA #REQUIRED >

&lt;!-- sets up the object formats, i.e. metadata --&gt;
&lt;!ELEMENT DATAFORMAT (OBJECTFORMAT)*&gt;
&lt;!ELEMENT OBJECTFORMAT (FIELDFORMAT)*&gt;
&lt;!ATTLIST OBJECTFORMAT
          name CDATA #REQUIRED
          is_task (true|false) #REQUIRED
          is_resource (true|false) #REQUIRED &gt;
&lt;!ELEMENT FIELDFORMAT EMPTY&gt;
&lt;!ATTLIST FIELDFORMAT
          name CDATA #REQUIRED
          datatype CDATA #REQUIRED
          is_subobject (true|false) "false"
          is_list (true|false) "false"
          is_key (true|false) "false"
          is_globalptr (true|false) "false" &gt;

&lt;!-- sets up scheduling specifications --&gt;
&lt;!ELEMENT SPECS (OPTCRITERION|DELTACRITERION|BESTTIME|CAPABILITY|
                 TASKDURATION|SETUPDURATION|WRAPUPDURATION|PREREQUISITES|
                 TASKUNAVAIL|RESOURCEUNAVAIL|CAPACITYCONTRIB|CAPACITYTHRESH|
                 GROUPABLE|TASKTEXT|GROUPEDTEXT|ACTIVITYTEXT|COLORTESTS)*&gt;
&lt;!ATTLIST SPECS
          direction (minimize|maximize) "minimize"
          multitasking (none|grouped|ungrouped|ignoring_time) "none"
          setupdisplay (striped|line) "striped"
          taskobject CDATA #IMPLIED
          resourceobject CDATA #IMPLIED >
&lt;!ELEMENT OPTCRITERION (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT DELTACRITERION (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT BESTTIME (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT CAPABILITY (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT TASKDURATION (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT SETUPDURATION (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT WRAPUPDURATION (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT PREREQUISITES (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT TASKUNAVAIL (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT RESOURCEUNAVAIL (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT CAPACITYCONTRIB (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT CAPACITYTHRESH (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT GROUPABLE (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT TASKTEXT (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT GROUPEDTEXT (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT ACTIVITYTEXT (OPERATOR|LITERAL) &gt;
&lt;!ELEMENT OPERATOR (OPERATOR|LITERAL)* &gt;
&lt;!ATTLIST OPERATOR
          operation CDATA #REQUIRED &gt;
&lt;!ELEMENT LITERAL EMPTY &gt;
&lt;!ATTLIST LITERAL
          value CDATA #REQUIRED
          type (constant|variable) #REQUIRED
          datatype CDATA #REQUIRED &gt;
&lt;!ELEMENT COLORTESTS (COLORTEST)* &gt;
&lt;!ELEMENT COLORTEST (OPERATOR|LITERAL) &gt;
&lt;!ATTLIST COLORTEST
          color CDATA #REQUIRED
          obj_type CDATA #REQUIRED
          title CDATA #REQUIRED &gt;

&lt;!-- sets up genetic algorithm specifications --&gt;
&lt;!ELEMENT GAPARMS (GAOPERATORS) &gt;
&lt;!ATTLIST GAPARMS
          pop_size CDATA #REQUIRED
          parent_scalar CDATA #REQUIRED
          max_evals CDATA #REQUIRED
          max_time CDATA #REQUIRED
          max_duplicates CDATA #REQUIRED
          max_top_dog_age CDATA #REQUIRED
          initializer CDATA #REQUIRED
          decoder CDATA #REQUIRED &gt;
&lt;!ELEMENT GAOPERATORS (GAOPERATOR)+ &gt;
&lt;!ELEMENT GAOPERATOR EMPTY &gt;
&lt;!ATTLIST GAOPERATOR
          name CDATA #REQUIRED
          prob CDATA #REQUIRED
          parms CDATA #IMPLIED &gt;

&lt;!-- sets up data --&gt;
&lt;!ELEMENT DATA (CLEARDATABASE?, WINDOW?, NEWOBJECTS?,
                CHANGEDOBJECTS?, DELETEDOBJECTS?) &gt;
&lt;!ELEMENT CLEARDATABASE EMPTY &gt;
&lt;!ELEMENT WINDOW EMPTY &gt;
&lt;!ATTLIST WINDOW
          starttime CDATA #IMPLIED
          endtime CDATA #IMPLIED &gt;
&lt;!ELEMENT NEWOBJECTS (OBJECT|GLOBAL)* &gt;
&lt;!ELEMENT CHANGEDOBJECTS (OBJECT|GLOBAL)* &gt;
&lt;!ELEMENT DELETEDOBJECTS (OBJECT|GLOBAL)* &gt;
&lt;!ELEMENT GLOBAL (OBJECT) &gt;
&lt;!ATTLIST GLOBAL
          name CDATA #REQUIRED &gt;
&lt;!ELEMENT OBJECT (FIELD)* &gt;
&lt;!ATTLIST OBJECT
          type CDATA #REQUIRED &gt;
&lt;!ELEMENT FIELD (OBJECT|LIST)? &gt;
&lt;!ATTLIST FIELD
          name CDATA #REQUIRED
          value CDATA #IMPLIED &gt;
&lt;!ELEMENT LIST (VALUE)* &gt;
&lt;!ELEMENT VALUE (OBJECT)? &gt;
&lt;!ATTLIST VALUE
          value CDATA #IMPLIED &gt;
</pre>

<? makeSection ("Test Problem Descriptions", "c", "C"); ?>

<p>We have applied Vishnu to a variety of classic scheduling/assignment problems.  Loadable files containing the specifications and data for these
problems are contained in the testdata directory.  We also list the specifications here, since they are good and simple examples of how to configure
Vishnu for a particular problem.
 
<? makeSubsection ("Job-Shop Scheduling Problem (testdata/jobshop/mt06.vsh)",
                   "c1", "C"); ?>
 
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

<? makeSubsection ("Traveling Salesman Problem (testdata/TSP/bays29.vsh)",
                   "c2", "C"); ?>

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

<? makeSubsection ("Vehicle Routing Problem with Time Windows (testdata/VRP/solomon101.vsh)",
                   "c3", "C"); ?>

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

<? makeSubsection ("Generalized Assignment Problem (testdata/assignment/c515-1.vsh)",
                   "c4", "C"); ?>

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

<? makeSection ("Installation and Setup Procedure", "d", "D"); ?>

There are two pieces of Vishnu.  One is (predominantly) PHP code
that runs on a web server.  The other is the Java code for the
scheduler and compiler that can run either on the web server or on
(an)other machine(s).  We start by describing how to get the base
code on the web server set up.  This requires a variety of open-source
applications (primarily Apache, MySQL, PHP and GD).  We then describe
how to get the Java runtime environment set up.  Finally, we describe
how to get the Vishnu code installed and executing.

<? makeSubsection ("Installing the Web Server", "d1", "D"); ?>

By far, the easiest way to install the required web server setup is
to use the product AbriaSQL Standard from
<a href="http://www.abriasoft.com">Abriasoft</a>, or alternatively
NuSphere MySQL from <a href="http://www.nusphere.com">NuSphere</a>.
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

<? makeSubsection ("Installing Java", "d2", "D"); ?>

We have used Sun's Java 1.2.2 as our environment.  This code is
available from Sun's <a href="http://www.javasoft.com/products/jdk/1.2/">
Javasoft web site</a>.

The other component of the Java environment that Vishnu requires is
an XML Java library.  We have used the Xerces library available at
<a href="http://xml.apache.org/xerces-j/index.html">this web site</a>.
For convenience, we have included the same xerces.jar file you would
get from this site in the Vishnu package in the directory lib.
After either downloading xerces.jar or copying it from lib,
you must add its full path to your CLASSPATH environment variable.

<? makeSubsection ("Installing and Executing Vishnu", "d3", "D"); ?>

<p>The tar file vishnu.tar.gz contains code/files that go in three
different places.
<ol>
<li> The php and sql directories go on the web server.  The sql directory
can go anywhere, but the php directory should go somewhere, or be linked
to from somewhere, that is visible via the web server.  Perhaps the
best way to do this on a UNIX machine is to type<br>
> ln -s &lt;fullpath&gt;/php &lt;/home/httpd&gt;/html/vishnu<br>
where &lt;fullpath&gt; is the full pathname of the parent directory of php
and &lt;/home/httpd&gt; should be replaced with the home directory of Apache
if /home/httpd is not the home directory.
<li> The vishnu.jar file should go on whatever machines are executing the
server and/or compiler.  On these machines, make sure to add
<fullpath>/vishnu.jar to your CLASSPATH environment variable.
<li> The testdata directory should go on whatever machine is going
to be used for running the web browser for testing the system.
</ol>

<p>On the web server, you should one time run the command<br>
> mysql -u[username] -p[password] &lt; initializesql<br>
This should initialize the tables in the MySQL database.
Once you have run this once, you should not need to run it again.

<p>To start the automated scheduler, execute the command<br>
        java -Dvishnu.host=[hostname]
        -Dvishnu.path=[pathname]
        -Dvishnu.user=[username]
        -Dvishnu.password=[password]
        -Dvishnu.port=[portnumber]
        org.cougaar.lib.vishnu.server.Scheduler<br>
        Start the formula compiler with the same command with
        ExpressionCompiler
        substituted for Scheduler.  Note that it is best to make a small
        script file for starting the scheduler and compiler.
        Some examples of such script files are given in the
        scripts directory.  Also note
        that the defaults are hostname=[localhost], path="/~vishnu/",
        user=vishnu, password="", and portnumber=80.

<p>You should now be set up to run.

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
<li> <b>Access Control and Security</b> - We should use
   https instead of http for greater security.  We should consider defining the concept of privileges so that certain users can perform certain operations
   and access certain problems.  We should consider some way of better
hiding the username and password used by the scheduler and compiler.
<li> <b>Circularity Check</b> - We should ensure that the scheduler does not get stuck in an infinite loop due to circularities in the prerequisites of tasks.
<li> <b>Schedule Stability Soft Constraint</b> - It should be possible to express a preference for keeping the schedule the same as much as possible without
   freezing the assignments.
<li> <b>Faster Execution of Formulas</b> - Instead of recursing through the parse trees of the formulas, the scheduler should create linear representations that it can iterate through.
<li> <b>Automatic Freezing of Past Assignments</b> - The automated
scheduler should automatically not modify any assignment earlier than
the start of the scheduler window.
<li> <b>Geographic Display</b> - For those problems where the tasks have
associated geographic data (latlongs or xy_coords), we should provide a way to
view this data graphically.
<li> <b>Evaluation of Specs in Browser</b> - To allow debugging of
scheduler specifications, provide a way for the user to evaluate a
formula for a constraint in a desired context (i.e., with the
variables and assignments set appropriately).
<li> <b>Internal Mode to Accept Objects Directly</b> - Currently, the
mode where the automated scheduler is run internal to another Java process
accepts the same XML input as the web-based mode.  It would give the
user the option of being more efficient if the scheduler were to
accept Java objects directly instead of parsing the XML into Java objects.
<li> <b>Recheck Constraints for Frozen Tasks</b> - Instead of just
assigning the frozen task to the same resource with the same start and
end time, first check to make sure that the task is still of the same
duration, that the task is still available, that the resource is still
available, etc.  Updating the frozen assignments can get complicated
if the effects ripple into other frozen assignments.
<li> <b>User-selectable Alerting</b> - Using formulas, let the user define
certain conditions under which he or she wants to be alerted.  Generally,
this will be when the assignment (or lack of assignment) for a particular
task is far enough from the ideal to warrant human intervention.
<li> <b>Improved in-line documentation</b> - Currently, there are not
enough comments in the code, so we need to add some.
<li> <b>Display reference field</b> - The key field for tasks and
resources that provides a unique internal reference is also used for
referencing these objects in the display.  We should consider adding
an option for a separate (or additional) field for referencing these
objects in the display.
<li> <b>Field Name Stability for Cougaar Bridge</b> - Currently,
the translated names of fields can change without actually changing
the field names on the Cougaar side.  The problem is that the Cougaar
side is truly object-oriented and can handle different data types
in a single field, while Vishnu is not object-oriented.  Hence,
for each data type in a particular field, there has to be a different
field in Vishnu.  We need a better scheme so that the names of the
fields in Vishnu do not change over time.
<li> <b>Command-Line Compiler</b> - Currently, there is now way to
execute the compiler without the web server.  We should implement
something analogous to the internal scheduler so that the compiler
can be run from a command line.
<li> <b>Runtime Check of Legality of Specs</b> - Since data structures
may have changed since the last compilation of the scheduling
specifications, do a quick check before scheduling that the specs
are still legal.
<li> <b>Resource Utilization Display</b> - Make functional again
the code that displays
the fraction of the resources and their capacities used as a function
of time.
<ul>
</div>

<? } ?>
