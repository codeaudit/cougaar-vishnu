<?
  require ("browserlink.php");
  require ("navigation.php");

  function getTitle () {
    echo "Vishnu Reconfigurable Scheduler Home Page";
  }
  function getHeader() {
    echo "Welcome to the <br><font color=\"000099\">Vishnu</font>" .
         " Reconfigurable Scheduling System.";
  }
  function getSubheader() { 
  }

  function mainContent () { 
?>
<BR>
<TABLE WIDTH="600" >
<TR><TD BGCOLOR="<? echo getcolor(); ?>">
<font size=+2>Loaded Problems</font></TD></TR>
</TABLE>

<TABLE WIDTH="600" >
<?
  $result = mysql_db_query ("vishnu_central",
              "select name from problems order by name;");
  $numRows = mysql_num_rows ($result);
  while ($value = mysql_fetch_row ($result))
    $problem_list[] = $value;

  $half = ceil ($numRows / 2);
  for ($i = 0; $i < $numRows/2; $i++) {
    echo "<tr>";
    echo "<td width=50%><font size=+2><a href=\"problem.php?problem=" .
          $problem_list[$i][0] . "\">" . $problem_list[$i][0] .
          "</font></a></td>";
    if ($i+$half < $numRows)
      echo "<td width=50%><font size=+2><a href=\"problem.php?problem=" .
            $problem_list[$i + $half][0] . "\">" .
            $problem_list[$i + $half][0] . "</font></a></td>";
    echo "</tr>";
  }

  mysql_free_result ($result);
  mysql_close();
?>
</TABLE><BR>

<TABLE WIDTH="600" >
<TR><TD BGCOLOR="<? echo getcolor(); ?>"><font size=+2>Upload</font></TD></TR>
<TR><TD align="center"><font size=+2><BR>
<FORM ENCTYPE="multipart/form-data" METHOD="post" ACTION="loadproblem.php">
  <INPUT TYPE=hidden NAME="MAX_FILE_SIZE" VALUE="10000000">
  <INPUT TYPE="file" NAME="userfile">
  <INPUT TYPE=submit VALUE="Load problem from file">
</FORM>
</font></TD></TR>
</TABLE>

<TABLE WIDTH="600" COLS=2>
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
<TR><TD align="center" colspan=2><font size=+2>
<a href="vishnu.php?login=1">Login Again</a>
</font></TD></TR>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
</TABLE>

<TABLE WIDTH="600" COLS=2>
<TR><TD BGCOLOR="<? echo getcolor(); ?>" COLSPAN=2>
<font size=+2>Documentation</font></TD></TR>
<TR><TD></TD></TR>
<TR><TD></TD></TR>
<TR><TD align="center"><font size=+2>
<a href="vishnu_description.html"/>Full Vishnu Documentation</a>
</font></TD>
<TD align="center"><font size=+2>
<a href="ALP_Vishnu_Bridge.htm"/>Bridge Documentation</a>
</font></TD>
</TR>
</TABLE>

<?
 }
 ?>