<?php
/** Because the php function shell_exec wouldn't work in a standard cronjob. I made a cronjob with WGET to get it work. **/
$debug = '1';

if ($_SERVER['SERVER_ADDR'] != $_SERVER['REMOTE_ADDR']){
  echo "No Remote Access Allowed";
  exit; //just for good measure
}


/*** Cron each minute ***/

set_include_path('/var/www/html');
require 'config.php';
require 'functions.php';

$sql		= "SELECT * FROM config WHERE id='1'";
$query		= mysqli_query($m_connect, $sql);
$conf		= mysqli_fetch_assoc($query);



/***** Check which one pin is on to record for used KWH *****/

$sql			= "SELECT * FROM relays WHERE id !='0'";
$query			= mysqli_query($m_connect, $sql);
while($relay	= mysqli_fetch_assoc($query)) {
	
if(ReadPin($relay['pin']) == 0)  {
mysqli_query($m_connect, "UPDATE relays SET minutes_power = minutes_power + 1 WHERE id = ".$relay['id']." LIMIT 1");       
}

if($debug == '1') { echo 'KWH recorder works. <br />'; }
}	
/*********/



/**** Save Temperature for each sensor in database ****/
$sql			= "SELECT * FROM sensors WHERE id !='0'";
$query			= mysqli_query($m_connect, $sql);
while($sensor	= mysqli_fetch_assoc($query)) {

$temp			= GetTemp($sensor['address']);

mysqli_query($m_connect, "UPDATE sensors SET temperature= $temp  WHERE id=".$sensor['id']." LIMIT 1");

if($debug == '1') { echo 'Update temperature works. <br />'; }	
}
/********/

/**** OVerHeat Protection *****/
if($conf['overheat_control'] == "1") {

if(GetTemp(sensor_id_address($conf['overheat_sensor'])) > $conf['overheat_temp'])  {
        WritePin($conf['pump_relay'],0);
}

}
/*******/


/***  Cleaning Mode , Turn All Off From Here ****/
if($conf['cleaning_mode'] == "1")  {
	exit;
}
/*********** Below won't work when cleaning mode is on ************/






/*** This part is to execute AUTOMATIC TEMPERATURE CONTROL *****/
$sql			= "SELECT * FROM temp_control WHERE id !='0'";
$query			= mysqli_query($m_connect, $sql);
while($temp		= mysqli_fetch_assoc($query)) {

	$eval = "
	if(GetTemp(sensor_id_address(".$temp['sensor_id'].")) ". $temp['mark'] . $temp['value'].")  {
        	WritePin(".$temp['switch'].",".$temp['state'].");
	}
	";

	eval($eval);

	$sensor_id = $temp['sensor_id'];
	$sensor_address = sensor_id_address($temp['sensor_id']);
	$mark = $temp['mark'];
	$value = $temp['value'];
	$switch = $temp['switch'];
	$state = $temp['state'];
	$temperature = GetTemp($sensor_address);

	if($debug == '1') { 
		echo 'Automatic temperature control works. <br />'; 
		echo "sensor id = $sensor_id. <br />";
		echo "sensor_address = $sensor_address. <br />";
		echo "mark = $mark. <br />";
		echo "value = $value. <br />";
		echo "switch = $switch. <br />";
		echo "state = $state. <br />";
		echo "temp = $temperature. <br />";
	}
}





/*** This part is to execute TIME SCHEDULE ****/
$current = date('H:i:00', $tijd);

$sql			= "SELECT * FROM schedule WHERE active='1'";
$query			= mysqli_query($m_connect, $sql);
while($schedule	= mysqli_fetch_assoc($query)) {

if($schedule['time'] == $current) {
		WritePin($schedule['pin'],$schedule['state']);
}

if($debug == '1') { echo 'Time schedule works. <br />'; }
}





/** This part is to controlling Automatic device Control **/
/** For example:  When heater goes on , then pump most go on as well **/

$sql			= "SELECT * FROM device_control WHERE id !='0'";
$query			= mysqli_query($m_connect, $sql);
while($device	= mysqli_fetch_assoc($query)) {

$eval = "
if(ReadPin(".$device['relay_pin'].") == ". $device['relay_state'].")  {
        WritePin(".$device['other_relay_pin'].",".$device['other_relay_state'].");
}
";

eval($eval);
if($debug == '1') { echo 'Automatic device control works. <br />'; }
}
/********/





/********* Frost Protection ********/

$sql		= "SELECT * FROM config WHERE id !='0' LIMIT 1";
$query		= mysqli_query($m_connect, $sql);
$config		= mysqli_fetch_assoc($query);

if($config['frost_protection'] == "1" && $config['heater_control'] == '0') {

if(GetTemp(sensor_id_address($config['frost_sensor']))  <  $config['frost_temp'])  {
        WritePin($config['heater_relay'],0);
	WritePin($config['pump_relay'],0);
}

$new_temp = $config['frost_temp'] + 1;

if(GetTemp(sensor_id_address($config['frost_sensor'])) >= $new_temp) {
        WritePin($config['heater_relay'],1);
		WritePin($config['pump_relay'],1);
}
	
if($debug == '1') { echo 'Frost protection works. <br />'; }
}
/***********************/






/**** Heater Control , to get you're pool nice and warm ****/
# turn on the heat after noon and on at midnight.
$current_hour = date("H");
$time_for_heat = 0;

if($current_hour > 16 || $current_hour < 2) {
	$time_for_heat = 1;
}
echo "current hour = $current_hour <br>";
#echo "set_temp = $config['set_temp'] <br>";
if($config['heater_control'] == '1') {

$eval2 = "
if(GetTemp(sensor_id_address(".$config['heater_sensor'].")) <  ".$config['set_temp']." && ".$time_for_heat." == 1)  {
	# turn on heat
        WritePin(".$config['heater_relay'].",0);		
	WritePin(".$config['pump_relay'].",0);
}
";

$eval3 = "
if(GetTemp(sensor_id_address(".$config['heater_sensor'].")) >  ".$config['set_temp']." || ".$time_for_heat." == 0)  {
	#turn off heat
        WritePin(".$config['heater_relay'].",1);
	if(".$config['pump_control']." == '1' && ".$time_for_heat." == 0) { 
		WritePin(".$config['pump_relay'].",1);
	}
}
";

eval($eval2);
eval($eval3);

if($debug == '1') { echo 'Heater Control works. <br />'; }
}
/************/



#refresh the page
header("Refresh:0");



?>
