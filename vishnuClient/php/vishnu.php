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
 ?>