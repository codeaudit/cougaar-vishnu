<?
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
    $capacity = $cap[0];
    $used = $cap_used[0];
    $left = (int) ((maketime ($value["start_time"]) - $start_time) /
                   $secs_per_pixel);
    $right = (int) ((maketime ($value["end_time"]) - $start_time) /
                    $secs_per_pixel);
    $top = ($capacity - $used) * $height / $capacity;
    imagefilledrectangle ($im, $left, $top, $right, $height - 1, $black);
    imagefilledrectangle ($im, $left + 1, $top + 1, $right - 1, $height - 2,
                          $red);
  }

  mysql_free_result ($result);
  imagepng ($im);
?>
