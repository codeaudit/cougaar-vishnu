<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// The schedule graphic for the case when there is ungrouped multitasking.
// Displays the percent of capacity versus time for each resource.

  require ("browserlink.php");
  require ("utilities.php");
  Header("Content-Type: image/png");
  $width = getimagewidth();
  $height = getimageheight();
  $total_secs = $end_time - $start_time;
  $secs_per_pixel = ((float) $total_secs) / ((float) $width);

  $im = imagecreate ($width, $height);
  $black = imagecolorallocate ($im, 0, 0, 0);
  $red = imagecolorallocate ($im, 255, 0, 0);
  $lightgray = imagecolorallocate ($im, 225, 225, 230);
  imagefill ($im, 3, 3, $lightgray);

  $result = mysql_db_query ("vishnu_prob_" . $problem,
              "select * from multitaskassignments where " .
              "resource_key = \"" . $resourcename . "\";");
  while ($value = mysql_fetch_array ($result)) {
    $cap_used = explode ("*%*", $value["capacities_used"]);
    $cap = explode ("*%*", $value["capacities"]);
    $left = (int) ((maketime ($value["start_time"]) - $start_time) /
                   $secs_per_pixel);
    $right = (int) ((maketime ($value["end_time"]) - $start_time) /
                    $secs_per_pixel);
    $capacity = $cap[0];
    $used = $cap_used[0];
    if ($capacity)
      $top = ($capacity - $used) * $height / $capacity;
    else
      $top = 0;
    imagefilledrectangle ($im, $left, $top, $right, $height - 1, $black);
    imagefilledrectangle ($im, $left + 1, $top + 1, $right - 1, $height - 2,
                          $red);
  }

  imagepng ($im);
?>
