<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// create a copy of a problem with a different name

  require ("browserlink.php");
  require_once ("utilities.php");
  require ("parseproblem.php");
  require ("specssupport.php");
  require ("gaparmssupport.php");
  require ("datasupport.php");
  require ("navigation.php");

  function getTitle () {
    global $problem, $newproblem;
    if (! $newproblem)
      echo "Copying problem $problem";
    else
      echo "Created problem $newproblem";
  }

  function getHeader() {
    global $problem, $newproblem, $error, $user, $password;
    if (! $newproblem) {
      echo "Select name of new problem to which to copy " .
           "<nobr>$problem</nobr>\n";
      return;
    }
    if (! isNameLegal ($newproblem)) {
      $error = 1;
      echo "Error, illegal name for problem: <nobr>$newproblem</nobr>";
      return;
    }
    ob_start();

    echo "<PROBLEM name=\"" . $problem . "\" >\n";
    writedataformat ($problem);
    writeschedulingspecs ($problem);
    writegaparms ($problem);
    writedata ($problem);
    echo "</PROBLEM>\n";

    $str = ob_get_contents();
    ob_end_clean();
    parseproblem ($str, $newproblem);
    echo "Created problem $newproblem";
  }

  function mainContent () {
    global $problem, $newproblem, $error;
    if ($error)
      return;
    if (! $newproblem) {
?>
<FORM method=get action="copyproblem.php">
<INPUT type=text name=newproblem size=30>
<INPUT type=hidden name=problem value="<? echo $problem; ?>">
<INPUT type=submit value="Go">
</FORM>
<?
      return;
    }
    echo "<br><br><DIV align=center><a href=\"problem.php?problem=" .
         $newproblem . "\"/><font size=+2>Go to Problem " . $newproblem .
         "</font></a></DIV>";

  }
?>
