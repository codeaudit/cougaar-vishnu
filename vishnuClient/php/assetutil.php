<?
  /****************************************************************************
   *
   * This file contains utility functions for the asset utilization graph
   *
   * Author:  rwu@bbn
   * Last Modified: 09/18/00
   *
   ****************************************************************************/

  require ("utilities.php");

  /**
   * computeaverage() --
   *
   * Arguments: scheduling blocks to be averaged
   *            start and end time window
   * Return: weighted average (integer)
   */
  function computeaverage($blocks, $window) {
    $total = 0;
    $interval = $window["end_time"] - $window["start_time"];

    for (reset($blocks); $key = key($blocks); next($blocks)) {
      $curr = $blocks[$key];
      $total += $curr["cap_used"] * ($curr["end_time"] - $curr["start_time"]);
    }

    return ($total / $interval);
  }

  /**
   * combinerepeats() --
   *
   * Arguments:  the aggregate schedule
   * Return: a processed aggregate schedule with redundant lines removed
   */
  function combinerepeats($agg_schedule) {

    $agg = array();
    $block1 = reset($agg_schedule);
    while (1) {
      if (!($block2 = next($agg_schedule))) {
        break;
      }
      while ($block1["cap_used"] == $block2["cap_used"]) {
        $block1 = makeblock ($block1["start_time"],
                             $block2["end_time"],
	 		     $block1["cap_used"],
                             $block1["cap"]);
	if (!($block2 = next($agg_schedule))) {
	  break;
        }
      }
 
      $agg[$block1["start_time"]] = $block1;
      $block1 = $block2;
    }

    $agg[$block1["start_time"]] = $block1;
    return $agg;    
  }

  /**
   * aggregateblocks() --
   *
   * Arguments: array of schedules to be aggregated
   *            whether capacity utilization is being considered
   *            start and end times of schedule
   * Return: an aggregate schedule consisting of the composite scheduling blocks
   *         of all assets
   */
  function aggregateblocks($allschedules, $iscap, $window, $problem) {

    $agg = array();
    $agg[$window["start_time"]] = 
      makeblock($window["start_time"], $window["end_time"], 0, 0);
    // echo "<BR><B>Initial Aggregate is:</B><BR>";
    // printschedule ($agg, 1);

    for (reset($allschedules); $key = key($allschedules); next($allschedules)) {
      $curr = $allschedules[$key];

      // echo "<BR><B>Merging with schedule:</B><BR>";
      // printschedule ($curr, 0);

      if (!$curr) {
        $agg = dummymerge ($agg, $key, $problem, $iscap);
      } else {
        $agg = merge ($agg, $curr, $iscap);
      }

      // echo "<BR><B>Obtained aggregate schedule:</B><BR>";
      // printschedule ($agg, 1);
    }

    return combinerepeats($agg);
  }

  /**
   * merge() --
   *
   * Arguments: two schedules to be merged
   * Return:    merged schedule
   *
   * Note: All schedule times are converted into the UNIX time format
   * with maketime before processing.  
   */
  function merge($agg_schedule, $schedule, $iscap) {

    $agg_block = reset($agg_schedule);
    $sch_block = reset($schedule);
    $agg_break = $agg_block["end_time"];
    $sch_break = maketime ($sch_block["start_time"]);
    $curr_break = $agg_block["start_time"];    
    $newcap = $sch_block["cap"];
    $in_block = 0;

    $agg = array();
    while(1) {
      if ($in_block != 0) {
	if ($sch_break < $agg_break) {
	  $agg[$curr_break] = makeblock($curr_break, 
					$sch_break, 
					$agg_block["cap_used"] + ($iscap ? $sch_block["cap_used"] : 1),
					($agg_block["cap"] + ($iscap ? $sch_block["cap"] : 1)));
	  $curr_break = $sch_break;
	  if (!($sch_block = next($schedule))) break;
	  $sch_break = maketime ($sch_block["start_time"]);
          $in_block = 0;
        } else if ($sch_break > $agg_break) {
	  $agg[$curr_break] = makeblock($curr_break, 
					$agg_break, 
					$agg_block["cap_used"] + ($iscap ? $sch_block["cap_used"] : 1),
					($agg_block["cap"] + ($iscap ? $sch_block["cap"] : 1)));
	  $curr_break = $agg_break;
	  if (!($agg_block = next($agg_schedule))) break;
	  $agg_break = $agg_block["end_time"];
	  $in_block = 1;
	} else { // ($sch_break == $agg_break)
	  $agg[$curr_break] = makeblock($curr_break, 
					$sch_break, 
					$agg_block["cap_used"] + ($iscap ? $sch_block["cap_used"] : 1),
					($agg_block["cap"] + ($iscap ? $sch_block["cap"] : 1)));
	  $curr_break = $sch_break;
	  if (!($agg_block = next($agg_schedule))) break;
	  $agg_break = $agg_block["end_time"];
	  if (!($sch_block = next($schedule))) break;
	  $sch_break = maketime($sch_block["start_time"]);
          $in_block = 0;
	}

      } else { // (!in_block)
        if ($sch_break < $agg_break) {
	  $agg[$curr_break] = makeblock($curr_break, 
					$sch_break, 
					$agg_block["cap_used"],
					($agg_block["cap"] + ($iscap ? $sch_block["cap"] : 1)));
	  $curr_break = $sch_break;
	  $sch_break = maketime($sch_block["end_time"]);
	  $in_block = 1;
        } else if ($sch_break > $agg_break) {
	  $agg[$curr_break] = makeblock($curr_break, 
					$agg_break, 
					$agg_block["cap_used"],
					($agg_block["cap"] + ($iscap ? $sch_block["cap"] : 1)));
	  $curr_break = $agg_break;
	  if (!($agg_block = next($agg_schedule))) break;
	  $agg_break = $agg_block["end_time"];
          $in_block = 0;
	} else { // ($sch_break == $agg_break)
	  $agg[$curr_break] = makeblock($curr_break, 
					$sch_break, 
					$agg_block["cap_used"],
					($agg_block["cap"] + ($iscap ? $sch_block["cap"] : 1)));
	  $curr_break = $sch_break;
	  if (!($agg_block = next($agg_schedule))) break;
	  $agg_break = $agg_block["end_time"];
	  $sch_break = maketime($sch_block["end_time"]);
	  $in_block = 1;
	}
      }
    }

    // Run out of schedule blocks.  Just copy rest of aggregate blocks
    if (!$sch_block) {
      // Copy the first block from the current break point
      $agg[$curr_break] = makeblock($curr_break, 
				    $agg_break, 
				    $agg_block["cap_used"], 
				    $agg_block["cap"] + ($iscap? $newcap : 1));
      // Copy all the other blocks in aggregate
      while ($remain = next($agg_schedule)) {
	$agg[$remain["start_time"]] = makeblock($remain["start_time"],
					        $remain["end_time"],
					        $remain["cap_used"],
					        $remain["cap"] + ($iscap? $newcap : 1));
      }

    // Run out of aggregate blocks.  
    // The only time when this will happen is when the end time of
    // the schedule coincides with that of the aggregate schedule.
    // In such cases, nothing needs to be done.
    } else { // (!$agg_block)
    }

    ksort($agg);
    return($agg);
  }

  /**
   * This dummy routine is called when the next asset's schedule is null
   * In this case, just increment the total_assets count of each block.
   */
  function dummymerge($agg_schedule, $resourcename, $problem, $iscap) {

    $result = mysql_db_query ("vishnu_prob_" . $problem,
			      "select * from capacities where ID = \"" . 
                              $resourcename . "\";");

    $value = mysql_fetch_array ($result);
    $cap = $value["value"];

    $agg = array();
    for (reset($agg_schedule); $key = key ($agg_schedule); next ($agg_schedule)) {
      $curr = $agg_schedule[$key];
      $agg[$curr["start_time"]] = makeblock($curr["start_time"],
					      $curr["end_time"],
					      $curr["cap_used"],
					      $curr["cap"] + ($iscap ? $cap : 1));
    }
    return $agg;
  }

  /**
   * Creates a single scheduling block containing the start time,
   * end time, capacity used, and total capacity.
   */
  function makeblock($start_time, $end_time, $cap_used, $cap) {
    $a = array ("start_time"=>$start_time,
	        "end_time"=>$end_time,
	        "cap_used"=>$cap_used,
	        "cap"=>$cap);

    return $a;
  }

  /**
   * returns width of asset utilization graph
   */
  function getassetutilimagewidth() {
    return getimagewidth();
  }

  /**
   * returns height of asset utilization graph
   */
  function getassetutilimageheight() {
    return 400;
  }

  /**
   * getvertscaledata() --
   *
   * Gets the positions of the vertical scale in the asset utilization display.
   *
   * Returns an associative array containing the numerical labels and their 
   * height positions in pixels.  
   */
  function getvertscaledata ($cap, $ispercentage) {
    if ($ispercentage) $cap = 100;
    $height = getassetutilimageheight();
    $minheightperlabel = 20;
    $maxtics = $height / $minheightperlabel;
    $pixelsperasset = $height / $cap;

    $interval = getvertinterval($cap, $maxtics);

    $positions = array();
    for ($i = $interval; $i < $cap; $i += $interval) {
      $pixelheight = (int) ($height - $pixelsperasset * $i);
      if ($ispercentage) {
        $index = $i . "%";
        $positions[$index] = $pixelheight;
      } else {
        $positions[$i] = $pixelheight;
      }
    }
    ksort($positions);
  
    return $positions;
  }

  /**
   * getvertinterval() --
   *
   * Returns a reasonably "nice" number to be used as the vertical
   * display interval.
   */
  function getvertinterval($cap, $maxtics) {
    $interval = ($cap / $maxtics);
    $poss = array(1, 2, 5);

    while (1) {
      for ($i = 0; $i < 3; $i++) {
        if ($interval <= $poss[$i])
          return $poss[$i];
      }
      for ($j = 0; $j < 3; $j++) {
        $poss[$j] *= 10;
      }
    }
  }

  /**
   * countassets() --
   *
   *
   * Counts up the total number of assets or the total capacity of all assets.
   */
  function countassets($problem, $iscapacity) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
                              "select value from capacities;");
    $total = 0;
    while ($value = mysql_fetch_row ($result))
      $total += $iscapacity ? $value[0] : 1;
    return $total;
  }

  /**
   * countaverage() --
   *
   * Computes the time_weighted average asset/capacity utilization.
   */
  function countaverage($problem, $resourcekey, $resourceobject, $isgroupedormulti, $totaltime, $iscapacity) {
    $result = mysql_db_query ("vishnu_prob_" . $problem,
               "select obj_" . $resourcekey . " from obj_" .
               $resourceobject . ";");

    $total = 0;
    while ($value = mysql_fetch_row($result)) {
      $resourcename = $value[0];
      $res = mysql_db_query ("vishnu_prob_" . $problem,
                "select * from " . ($isgroupedormulti ? "multitask" : "") .
                "assignments where resource_key = \"" .
                $resourcename . "\";");
      $thistotal = 0;
      while ($val = mysql_fetch_array($res)) {
	$starttime = maketime($val["setup_time"]);
        $endtime = maketime($val["wrapup_time"]);
	$cap_used = ($isgroupedormulti && $iscapacity) ? $val["capacities_used"] : 1;
        $thistotal +=  $cap_used * ($endtime - $starttime);
      }
      mysql_free_result($res);

      $total += (double) $thistotal / (double) $totaltime;
    }
    mysql_free_result($result);

    return $total;
  }

  /**
   * createblocks() --
   *
   * Looks up all the scheduling blocks of all resources and puts them in one big array.
   */
  function createblocks ($problem, $resources, $ismultitask, $isgrouped) {
    $blocksarray = array();
    for ($i = 0; $i < sizeof ($resources); $i++) {
      $resourcename = $resources[$i];
      $result = mysql_db_query ("vishnu_prob_" . $problem,
                  "select * from " . (($isgrouped || $ismultitask) ? "multitask" : "") .
                  "assignments where resource_key = \"" .
                  $resourcename . "\";");

      $blocks = array();
      while ($value = mysql_fetch_array ($result)) {
        if ($isgrouped) {
          $cap_used = explode ("*%*", $value["capacities_used"]);
          $cap = explode ("*%*", $value["capacities"]);      
        }
        $blocks[$value["setup_time"]] =
          array ("start_time"=>$value["setup_time"],
                 "end_time"=>$value["wrapup_time"],
                 "cap_used"=>($isgrouped ? $cap_used[0] : 1),
                 "cap"=>($isgrouped ? $cap[0] : 1));
      }
      mysql_free_result ($result);
      ksort ($blocks);
      $blocksarray[$resourcename] = $blocks;
    }
    ksort ($blocksarray);

    return $blocksarray;
  }

  // printschedule() -- debug function
  function printschedule($schedule, $isagg) {
    for (reset($schedule); $k = key ($schedule); next($schedule)) {
      $block = $schedule[$k];

      $key = $isagg ? ("[" . (key($schedule) - 988689600) . "]") : "";
      $capacity = $isagg ? ("<" . $block["cap_used"] . "," . $block["cap"] . ">") : "";
      $start_time = $isagg ? $block["start_time"] : maketime($block["start_time"]);
      $start_time = $start_time - 988689600;
      $end_time = $isagg ? $block["end_time"] : maketime($block["end_time"]);
      $end_time = $end_time - 988689600;

      echo "|" . $key . $start_time . " - " . $end_time . $capacity . "|";
    }
  }

?>
