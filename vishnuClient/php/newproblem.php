<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Create a new problem from scratch.

  require ("browserlink.php");
  require ("utilities.php");
  require ("parseproblem.php");
  require ("navigation.php");

  function getTitle () {
    global $problem;
    if (! $problem)
      echo "Creating new problem";
    else
      echo "Created problem $problem";
  }

  function getHeader() {
    global $problem, $error;
    if (! $problem) {
      echo "Select name of new problem to create";
      return;
    }
    if (! isNameLegal ($problem)) {
      $error = 1;
      echo "Error, illegal name for problem $problem";
      return;
    }
    $str = "<PROBLEM name=\"" . $problem . "\">\n" .
           "<GAPARMS pop_size=\"20\" parent_scalar=\"0.70\" " . 
           "max_evals=\"4000\" max_time=\"20\" max_duplicates=\"300\" " .
           "max_top_dog_age=\"100\" initializer=" .
           "\"org.cougaar.lib.vishnu.server.OrderedInitializer\" " .
           "decoder=\"org.cougaar.lib.vishnu.server.OrderedDecoder\" >" .
           "\n<GAOPERATORS>\n<GAOPERATOR " .
           "name=\"org.cougaar.lib.vishnu.server.OrderedMutation\" " .
           "prob=\"0.50\" parms=\"1.0\" />\n<GAOPERATOR " .
           "name=\"org.cougaar.lib.vishnu.server.OrderedCrossover\" " .
           "prob=\"0.50\" />\n</GAOPERATORS>\n</GAPARMS>\n</PROBLEM>\n";
    parseproblem ($str);
    echo "Created problem $problem";
  }

  function mainContent () {
    global $problem, $error;
    if ($error)
      return;
    if (! $problem) {
?>
<FORM method=get action="newproblem.php">
<INPUT type=text name=problem size=30>
<INPUT type=submit value="Go">
</FORM>
<?
      return;
    }
    echo "<br><br><DIV align=center><a href=\"problem.php?problem=" .
         $problem . "\"/><font size=+2>Go to Problem " . $problem .
         "</font></a></DIV>";

  }
?>
