<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// Creates the labels for the time axis of the schedule graphic
// Set the variables start_time and end_time as arguments in the URL

  Header("Content-Type: image/png");
  require ("utilities.php");
  $tics = getticmarks ($start_time, $end_time);
  $numchars = $tics ? strlen ($tics[0][1]) : 5;
  $font = ($numchars > 5) ? 2 : 4;
  $extrawidth = (int) (imagefontwidth ($font) * ($numchars / 2.0) + 0.5);
  $width = getimagewidth() + 2 * $extrawidth;
  $height = imagefontheight ($font);

  $im = imagecreate ($width, $height);
  $black = imagecolorallocate ($im, 0, 0, 0);
  $white = imagecolorallocate ($im, 255, 255, 255);
  imagefill ($im, 3, 3, $white);

  for ($i = 0; $i < sizeof ($tics); $i++) {
    imagestring ($im, $font, $tics[$i][0], 0, $tics[$i][1], $black);
  }
  imagepng ($im);
?>
