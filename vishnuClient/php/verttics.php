<?
  // Not currently in use

  Header("Content-Type: image/png");
  require ("assetutil.php");

  $height = getassetutilimageheight();
  $width = 5;

  $im = imagecreate ($width, $height);
  $black = imagecolorallocate ($im, 0, 0, 0);
  $white = imagecolorallocate ($im, 255, 255, 255);
  imagefill ($im, 1, 1, $white);

  $positions = getvertscaledata ($cap, $ispercentage);
  for (reset($positions); $key = key($positions); next($positions))
    imageline ($im, 0, $positions[$key], $width - 1, $positions[$key], $black);

  imagepng ($im);
?>


