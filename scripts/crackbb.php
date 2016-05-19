<?php

$lic = file_get_contents('lic.txt');
$lic = base64_decode(substr($lic, 0, strrpos($lic, 'X')));
$verify = substr($lic, strrpos($lic, 'X') + 1);

$len = unpack("Nlen", $lic);
$len = $len['len'];
$licprop = substr($lic, 4, $len);
$licsig = substr($lic, 4 + $len);

strlen($licprop);
$prop = zlib_decode(substr($licprop, 5));
$prop = str_replace("Evaluation=true", "Evaluation=false", $prop);

$search = array(
    "/: Evaluation/",
    "/Evaluation=.*/",
    "/LicenseExpiryDate=[0-9]{4}-[0-9]{2}-[0-9]{2}/"
);
$repalce = array(
    ": Commercial",
    "Evaluation=false",
    "LicenseExpiryDate=2999-12-12"
);
$prop = preg_replace($search, $repalce, $prop);

$prop = zlib_encode($prop, 15);
$licprop = substr($licprop, 0, 5) . $prop;
$len = strlen($licprop);

$enc =  base64_encode(pack("N", $len) . $licprop . $licsig);
echo $enc . 'X02' . base_convert(strlen($enc), 10, 31);
