<?
  // Creates an image that is the schedule graphic.
  // Include the variables problem, resourcename, start_time, and
  // end_time in the arguments of the URL

  require ("browserlink.php");
  require ("utilities.php");
  Header("Content-Type: image/png");
  $width = getimagewidth();
  $height = getimageheight();
  $font = 3;
  $fontwidth = imagefontwidth ($font);
  $total_secs = $end_time - $start_time;
  $secs_per_pixel = ((float) $total_secs) / ((float) $width);

  $im = imagecreate ($width, $height);
  $black = imagecolorallocate ($im, 0, 0, 0);
  $lightgray = imagecolorallocate ($im, 225, 225, 230);
  imagefill ($im, 3, 3, $lightgray);

  $colors = array();
  $result = mysql_db_query ("vishnu_central", "select * from color_defs;");
  while ($value = mysql_fetch_array ($result))
    $colors[$value["name"]] =
      array ($value["red"], $value["green"], $value["blue"]);
  mysql_free_result ($result);
  $colorsused = array();

  function displayblock ($value, $inner) {
    global $width, $height, $font, $fontwidth, $secs_per_pixel;
    global $im, $black, $colors, $colorsused, $start_time, $end_time;
    global $setupdisplay;

    $tleft = (int) ((maketime ($value["start_time"]) - $start_time) /
                    $secs_per_pixel);
    $tright = (int) ((maketime ($value["end_time"]) - $start_time) /
                     $secs_per_pixel);
    if ($inner) {
      $left = (int) ((maketime ($value["setup_time"]) - $start_time) /
                     $secs_per_pixel);
      $right = (int) ((maketime ($value["wrapup_time"]) - $start_time) /
                      $secs_per_pixel);
    }
    else {
      $left = $tleft;
      $right = $tright;
    }
    $color = $value["color"];
    if ($colorsused [$color])
      $cnum = $colorsused [$color];
    else {
      $cnum = imagecolorallocate ($im, $colors[$color][0],
                                  $colors[$color][1], $colors[$color][2]);
      $colorsused [$color] = $cnum;
    }
    if (($left >= $width) || ($right < 0))
      return;
    if ($left < 0)
      $left = 0;
    if ($right >= $width)
      $right = $width - 1;
    imagefilledrectangle ($im, $left, 0, $right, $height - 1, $black);
    imagefilledrectangle ($im, $left + 2, 2, $right - 2, $height - 3, $cnum);
    if ($tleft > $left) {
      if (($setupdisplay == "striped") && (($tleft - 1) > $left))
        stripedrectangle ($im, $left, 0, $tleft - 1, $height - 1, $black, 0);
      imagedashedline ($im, $tleft, 0, $tleft, $height - 1, $black);
    }
    if ($tright < $right) {
      if (($setupdisplay == "striped") && (($right - 1) > $tright))
        stripedrectangle ($im, $tright, 0, $right - 1, $height - 1, $black, 0);
      imagedashedline ($im, $tright, 0, $tright, $height - 1, $black);
    }
    $text = $value["text"];
    $len = $right - $left - strlen ($text) * $fontwidth;
    if ($len > 4)
      imagestring ($im, $font, $left + (int) ($len / 2), 4, $text, $black);
  }

  $result = mysql_db_query ("vishnu_prob_" . $problem,
              "select * from " . ($isgrouped ? "multitask" : "") .
              "assignments where resource_key = \"" . $resourcename . "\";");
  while ($value = mysql_fetch_array ($result)) {
    displayblock ($value, 1);
  }
  mysql_free_result ($result);
  $result = mysql_db_query ("vishnu_prob_" . $problem,
              "select * from activities where resource_key = \"" .
              $resourcename . "\";");
  while ($value = mysql_fetch_array ($result)) {
    displayblock ($value, 0);
  }
  mysql_free_result ($result);

  imagepng ($im);
?>
