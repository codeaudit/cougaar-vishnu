<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Creates the legend for the schedule graphic.
// The variable data should contain all the information needed
// to create the image.

  Header("Content-Type: image/png");
  require ("gantt.php");
  $width = getimagewidth();
  $keyheight = 14;
  $betweenheight = 3;
  $font = 5;

  function nexttoken ($sep = " ") {
    global $data;
    $pos = strpos ($data, $sep);
    $token = substr ($data, 0, $pos);
    $data = substr ($data, $pos + strlen ($sep));
    return $token;
  }

  $keys = array();
  while (substr ($data, 0, 1) != " ")
    $keys[] = array (nexttoken(), nexttoken("qxy"));
  $data = substr ($data, 1);
  $maxchars = 0;
  for ($i = 0; $i < sizeof ($keys); $i++)
    $maxchars = (strlen ($keys[$i][1]) > $maxchars) ?
                strlen ($keys[$i][1]) : $maxchars;
  $keywidth = $keyheight + 20 + $maxchars * imagefontwidth ($font);
  $maxperline = (int) ($width / $keywidth);
  $numlines = (int) ((sizeof ($keys) - 1) / $maxperline) + 1;
  $height = $keyheight * $numlines + $betweenheight * ($numlines - 1);
  $start = ($numlines == 1) ? (($width - sizeof($keys) * $keywidth) / 2) :
                              (($width - $maxperline * $keywidth) / 2);

  $im = imagecreate ($width, $height);
  $black = imagecolorallocate ($im, 0, 0, 0);
  $white = imagecolorallocate ($im, 255, 255, 255);
  $colors = array();
  while (strlen ($data))
    $colors[] = imagecolorallocate ($im, nexttoken(),
                                    nexttoken(), nexttoken());

  imagefill ($im, 3, 3, $white);
  $left = $start;
  $top = 0;
  for ($i = 0; $i < sizeof ($keys); $i++) {
    $key = $keys[$i];
    imagefilledrectangle ($im, $left, $top, $left + $keyheight - 1,
                          $top + $keyheight - 1, $black);
    imagefilledrectangle ($im, $left + 2, $top + 2, $left + $keyheight - 3,
                          $top + $keyheight - 3, $colors[$key[0] - 1]);
    imagestring ($im, $font, $left + $keyheight + 4, $top, $key[1], $black);
    $left += $keywidth;
    if ($left > ($width - $keywidth)) {
      $left = $start;
      $top += $keyheight + $betweenheight;
    }
  }
  imagepng ($im);
?>
