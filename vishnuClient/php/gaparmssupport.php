<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Call the function writegaparms to output the genetic algorithm
// parameters in XML format

  function printattr ($attr) {
    global $value;
    if ($value[$attr] && ($value[$attr] != "NULL"))
      echo $attr . "=\"" . $value[$attr] . "\" ";
  }

  function printop ($op) {
    global $value;
    $str1 = "operator" . $op . "_name";
    $str2 = "operator" . $op . "_prob";
    $str3 = "operator" . $op . "_parms";
    if ($value[$str1]) {
      echo "<GAOPERATOR name=\"" . $value[$str1] . "\" prob=\"" .
           $value[$str2] .
           ($value[$str3] ? "\" parms=\"" . $value[$str3] : "") . "\" />\n";
    }
  }

  function writegaparms ($problem) {
    global $value;
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select * from gaparms;");
    $value = mysql_fetch_array ($result);
    mysql_free_result ($result);
  
    echo "<GAPARMS ";
    printattr ("pop_size"); 
    printattr ("parent_scalar"); 
    printattr ("max_evals"); 
    printattr ("max_time"); 
    printattr ("max_duplicates"); 
    printattr ("max_top_dog_age"); 
    printattr ("report_interval"); 
    printattr ("initializer");
    printattr ("initializer_parms");
    printattr ("decoder"); 
    printattr ("decoder_parms"); 
    echo ">\n<GAOPERATORS>\n";
    printop ("1");
    printop ("2");
    printop ("3");
    printop ("4");
    echo "</GAOPERATORS>\n</GAPARMS>\n";
  }
?>
