<?
  // Not currently in use

  Header("Content-Type: image/png");
  require ("assetutil.php");

  $font = 2;
  $fontheight = imagefontheight($font);
  $fontwidth = imagefontwidth($font);
  $height = getassetutilimageheight();
  $width = 5 * $fontwidth;

  $im = imagecreate ($width, $height);
  $black = imagecolorallocate ($im, 0, 0, 0);
  $white = imagecolorallocate ($im, 255, 255, 255);
  imagefill ($im, 1, 1, $white);

  $heightoffset = (int) ($fontheight / 2);

  $positions = getvertscaledata ($cap, $ispercentage);
  for (reset($positions); $key = key($positions); next($positions)) {
    imagestring ($im, $font, 
		 0, $positions[$key] - $heightoffset,
		 $key, $black);
  }

  imagepng ($im);
?>


