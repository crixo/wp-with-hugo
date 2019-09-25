<?php
$zip = new ZipArchive;
$zip_file_name=$_GET["zip_file_name"];
$res = $zip->open("../tmp/$zip_file_name");
if ($res === TRUE) {
  $dir='./public/';
  // echo "before rm:" . is_dir($dir)."\n";
  rrmdir($dir);
  // echo "after rm:" . is_dir($dir)."\n";
  $zip->extractTo('.');
  $zip->close();
  echo 'ok';
} else {
  echo 'ko';
}

function rrmdir($dir) { 
  if (is_dir($dir)) { 
    $objects = scandir($dir); 
    foreach ($objects as $object) { 
      if ($object != "." && $object != "..") { 
        if (is_dir($dir."/".$object))
          rrmdir($dir."/".$object);
        else
          unlink($dir."/".$object); 
      } 
    }
    rmdir($dir); 
  } 
}
?>