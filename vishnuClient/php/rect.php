<?
// This software is to be used in accordance with the COUGAAR license
// agreement. The license agreement and other information can be found at
// http://www.cougaar.org.
//
// Copyright 2001 BBNT Solutions LLC
//
//
// An image that is all a single color

  Header("Content-Type: image/png");
  if (! $width)
    $width = 8;
  if (! $height)
    $height = 8;
  $im = imagecreate ($width, $height);
  $color = imagecolorallocate ($im, $red, $green, $blue);
  imagefill ($im, 0, 0, $color);
  imagepng ($im);
?>
