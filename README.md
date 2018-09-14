# Hot-Tub-Controller-using-Raspberry-Pi
This PHP code was adapted/modified by me  from the https://www.instructables.com/id/Hottub-Pool-Controller-Web-Interface project, and I have permission to upload it here by the author, Rickiewickie. I modified the code to work with PHP 7, and to work with my hot tub.
The file hierarchies in this repo belong in /var/www in the Pi.
I customized cron_min.php to turn on and off the heat at fixed times, and to handle the turning on and off of the jets. (since this is a 120v 20 A circuit, when the jets are on, the heater and low power pump must be off.)
An enhancement I am thinking about is to use GPIO event handlers to handle the jets on/off switch instead of waiting for the cron to do it.
I have been using the html/tablet/index.php page for web control rather than the html/index.php page, because it is better for a few reasons. Enhancements would be to make it auto-refresh, and to add the ability to adjust the heat start/stop times.
