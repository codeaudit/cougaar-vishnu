<?
  // Display the tic marks for the time axis of a schedule graphic

  Header("Content-Type: image/png");
  require ("utilities.php");
  $width = getimagewidth();
  $height = 4;
  $tics = getticmarks ($start_time, $end_time);

  $im = imagecreate ($width, $height);
  $black = imagecolorallocate ($im, 0, 0, 0);
  $white = imagecolorallocate ($im, 255, 255, 255);
  imagefill ($im, 1, 1, $white);

  for ($i = 0; $i < sizeof ($tics); $i++)
    imageline ($im, $tics[$i][0], 0, $tics[$i][0], $height - 1, $black);
  imagepng ($im);
?>
