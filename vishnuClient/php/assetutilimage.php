<?
  // assetutilimage.php is currently out of use.

  require ("browserlink.php");
  require ("assetutil.php");
  Header("Content-Type: image/png");

  $width = getassetutilimagewidth();
  $height = getassetutilimageheight();
  $total_secs = $end_time - $start_time;
  $secs_per_pixel = ((float) $total_secs) / ((float) $width);

  $im = imagecreate ($width, $height);
  $black = imagecolorallocate ($im, 0, 0, 0);
  $blue = imagecolorallocate ($im, 0, 0, 255);
  $purple = imagecolorallocate ($im, 155, 0, 155);
  $red = imagecolorallocate ($im, 255, 0, 0);
  $lightblue = imagecolorallocate ($im, 100, 100, 255);
  $lightpurple = imagecolorallocate ($im, 155, 100, 155);
  $lightgray = imagecolorallocate ($im, 225, 225, 230);
  imagefill ($im, 3, 3, $lightgray);

  $ismultitask = ismultitask ($problem);
  $isgrouped = isgrouped ($problem);
  $displaycap = $isgrouped || $ismultitask;

  $resources = array();
  $result = mysql_db_query ("vishnu_prob_" . $problem,
               "select obj_" . $resourcekey . " from obj_" .
               $resourceobject . ";");
  while ($value = mysql_fetch_row ($result))
    $resources[] = $value[0];
  mysql_free_result ($result);

  $window["start_time"] = $start_time;
  $window["end_time"] = $end_time;
  $arr = createblocks($problem, $resources, $ismultitask, $isgrouped);

  // Tabulate data for number of assets utilized
  $aggschedule = aggregateblocks($arr, 0, $window, $problem);  
  $average = computeaverage($aggschedule, $window);
  $capacity = countassets($problem, 0);
  $capacity2 = countassets($problem, 1);

  // Tabulate data for percent capacity used
  if ($displaycap) {
    $aggschedule2 = aggregateblocks($arr, 1, $window, $problem);
    $average2 = computeaverage($aggschedule2, $window);  
  } else {
    $average2 = $average;
  }

    for (reset ($aggschedule); $key = key ($aggschedule);
         next ($aggschedule)) {
      $block = $aggschedule[$key];

      $left = (int) (($block["start_time"] - $start_time) / $secs_per_pixel);
      $right = (int) (($block["end_time"] - $start_time) / $secs_per_pixel);
      $cap = ($capacity - $block["cap_used"]) * $height / $capacity;
      imagefilledrectangle ($im, $left, $cap, $right,
                            $height - 1, $purple);
    }

    for (reset ($aggschedule2); $key = key ($aggschedule2);
         next ($aggschedule2)) {
      $block = $aggschedule2[$key];

      $left = (int) (($block["start_time"] - $start_time) / $secs_per_pixel);
      $right = (int) (($block["end_time"] - $start_time) / $secs_per_pixel);
      $cap = ($capacity2 - $block["cap_used"]) * $height / $capacity2;
      imagefilledrectangle ($im, $left, $cap, $right, $height - 1, $blue);

    }

  // Draw the Average Lines
  $top = ($capacity - $average) * $height / $capacity;
  imageline($im, 0, $top, $width, $top, $lightpurple);

  $top = ($capacity2 - $average2) * $height / $capacity2;
  imageline($im, 0, $top, $width, $top, $lightblue);

  imagepng ($im);
?>
