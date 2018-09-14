<?php

$sql 			= "SELECT * FROM config WHERE id ='1' LIMIT 1";
$query			= mysqli_query($m_connect,$sql);
$data			= mysqli_fetch_assoc($query);


echo "Hottub / Pool Controler. <br />";
echo "Server version: ".$data['version']."  <br />"; 

echo "<br /> <br/>";
echo "For futher information or new software releases contact rickfeenstra1@hotmail.com";


echo "<br/><p align=\"right\">  <a href=\"./manual.html#about\" target=\"_blank\"> <img src=\"./images/questionmark.png\"> </a> </p> ";


?>
