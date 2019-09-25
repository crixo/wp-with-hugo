<?php
$api_key = file_get_contents("../private/wp-api-key.txt");

if(!function_exists('getallheaders'))
{
 function getallheaders() 
 {
  foreach($_SERVER as $name => $value)
  {
   if(substr($name, 0, 5) == 'HTTP_')
   {
    $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
   }
   else
   {
     echo $name;
   }
  }
  return $headers;
 }
}

$headers = getallheaders();
//print_r($headers);
$header_key="X-Api-Key";
if(!isset($headers[$header_key]) || $headers[$header_key]!=$api_key){
  header("HTTP/1.1 401 Unauthorized");
  exit;
} 

$uploaddir = "../tmp/";
$uploadfile = $uploaddir . basename( $_FILES['FILE']['name']);


//print_r($_FILES);
//echo "uploadfile:$uploadfile";

if(move_uploaded_file($_FILES['FILE']['tmp_name'], $uploadfile))
{
  echo "The file has been uploaded successfully";
}
else
{
  echo "There was an error uploading the file";
}
?>