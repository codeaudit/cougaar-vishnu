<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Top-level page

  require ("browserlink.php");
  require ("navigation.php");

  function getTitle () {
    echo "Vishnu Reconfigurable Scheduler Home Page";
  }

  function getHeader() {
    echo "Welcome to the <font color=\"000099\">Vishnu</font><br>" .
         " Reconfigurable Scheduling System.";
  }

  function getSubheader() {
    echo "(For help at any time, click on \"Hints for this page\".)";
  }

  function mainContent () {
    $width = 550;
?>
<TABLE WIDTH="<? echo $width; ?>" >
<TR><TD BGCOLOR="<? echo getcolor(); ?>">
<font size=+2>Select Loaded Problem</font></TD></TR>
</TABLE>

<TABLE WIDTH="<? echo $width; ?>" >
<?
    $result = mysql_db_query ("vishnu_central",
                "select name from problems order by name;");
    $numRows = mysql_num_rows ($result);
    while ($value = mysql_fetch_row ($result))
      $problem_list[] = $value;
  
    $half = ceil ($numRows / 2);
    for ($i = 0; $i < $numRows/2; $i++) {
      echo "<tr>";
      echo "<td width=50%><font size=+1><a href=\"problem.php?problem=" .
            $problem_list[$i][0] . "\">" . $problem_list[$i][0] .
            "</font></a></td>";
      if ($i+$half < $numRows)
        echo "<td width=50%><font size=+1><a href=\"problem.php?problem=" .
              $problem_list[$i + $half][0] . "\">" .
              $problem_list[$i + $half][0] . "</font></a></td>";
      echo "</tr>";
    }

    mysql_free_result ($result);
    mysql_close();
?>
</TABLE><BR>

<TABLE WIDTH="<? echo $width; ?>" >
<TR><TD BGCOLOR="<? echo getcolor(); ?>"><font size=+2>
Load Problem from File</font></TD></TR>
<TR><TD align="left"><br>
<FORM ENCTYPE="multipart/form-data" METHOD="post" ACTION="loadproblem.php">
  <INPUT TYPE=hidden NAME="MAX_FILE_SIZE" VALUE="10000000">
  <table cols=2 width=300>
  <tr><td align=right width=130><font size=+1>File Name:&nbsp;
  </td><td><font size=+1><nobr>
  <INPUT TYPE="file" NAME="userfile" size=25></nobr>
  </td></tr>
  <tr><td align=right width=130><font size=+1><nobr>Problem Name:&nbsp;
  </nobr></td><td><font size=+1><nobr>
  <input type=text name="specifiedname" size=25> 
  </font>(Omit to use default)</nobr>
  </td></tr>
  <tr><td align=center colspan=2><font size=+1>
  <INPUT TYPE=submit VALUE="Load Problem">
  </td></tr></table>
</FORM>
</TD></TR>
</TABLE>

<TABLE WIDTH="<? echo $width; ?>" COLS=2>
<TR><TD BGCOLOR="<? echo getcolor(); ?>" COLSPAN=2>
<font size=+2>Other Operations</font></TD></TR>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
<TR><TD align="center"><font size=+2>
<a href="newproblem.php"/>Create New Problem</a>
</font></TD>
<TD align="center"><font size=+2>
<a href="cleanup.php">Delete Old Problems</a>
</font></TD>
</TR>
<TR><TD align="center" colspan="2"><font size=+2>
<a href="vishnu.php?login=1">Login Again</a>
</font></TD></TR>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
</TABLE>

<?
  }

  function hintsForPage() {
?>
This is the top-level page.  While all other pages allow you
to interact with a particular scheduling problem, this page
gives you an overview of all the problems loaded in the server.
<p>
The actions you can take on this page are:
<ul>
<li> <b>Select a loaded problem -</b>
This is the most common action.  Just click on the name of the
scheduling problem that you want to view or edit, and you will go to the
main page for that problem.  There you will have a variety of
options for actions to take with respect to this particular
problem.
<li> <b>Load a problem from a file -</b>
You can reload into the database a problem that has been saved to
a file.  Examples of some such files are found in the
distribution.  You need just specify the filename and the name
that the problem will have once loaded.
If you do not specify a problem name, it will use the name of
the problem when it was saved.
Note that if you load a problem with the same problem name as
one that already exists, the old one will be deleted, and the
new one will take its place.
<li> <b>Create a new problem -</b>
This will create a brand new problem from scratch.
It will take you to a page where you will be prompted for
the name of the problem.
Note that if your problem is similar to another problem
it may be better just to copy that problem or to reload
that problem from file under a different problem name.
<li> <b>Delete a set of problems -</b>
This is a way to clean up so that the number of problems in
the database does not just keep growing.  This link brings
you to a screen where you can select the set of problems
to delete.  There is no way to recover a problem once
deleted, so if there is any chance that you may want to
use a problem again in the future, make sure it is saved
to file before deleting it from the database.
<li> <b>Login again -</b>
This allows you to log in again under a different username
and password.
At this point, there is no benefit to this, as all users can
access all problems.
</ul>
<?
  }
?>