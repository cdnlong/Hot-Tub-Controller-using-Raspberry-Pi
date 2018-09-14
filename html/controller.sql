-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u2
-- http://www.phpmyadmin.net
--
-- Machine: localhost
-- Gegenereerd op: 02 okt 2016 om 14:38
-- Serverversie: 5.5.52-0+deb8u1
-- PHP-versie: 5.6.24-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databank: `controller`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `config`
--

CREATE TABLE IF NOT EXISTS `config` (
  `id` int(1) NOT NULL,
  `version` varchar(4) NOT NULL,
  `raspberry_type` varchar(10) NOT NULL,
  `token` varchar(255) NOT NULL,
  `api` int(1) NOT NULL,
  `set_temp` varchar(4) NOT NULL,
  `set_temp_dev` varchar(4) NOT NULL,
  `save_temp` int(1) NOT NULL,
  `heater_control` int(1) NOT NULL,
  `heater_relay` int(2) NOT NULL,
  `heater_sensor` int(6) NOT NULL,
  `overheat_control` int(1) NOT NULL,
  `overheat_sensor` int(4) NOT NULL,
  `overheat_temp` varchar(4) NOT NULL,
  `pump_control` int(1) NOT NULL,
  `pump_relay` int(2) NOT NULL,
  `frost_protection` int(1) NOT NULL,
  `frost_temp` varchar(4) NOT NULL,
  `frost_sensor` int(6) NOT NULL,
  `cleaning_mode` smallint(1) NOT NULL,
  `left_column` int(6) NOT NULL,
  `mid_column` varchar(52) NOT NULL,
  `right_column` int(6) NOT NULL,
  `used_power_date` date NOT NULL,
  `tablet_view` smallint(1) NOT NULL,
  `ip_check` smallint(1) NOT NULL,
  `ip_range` varchar(32) NOT NULL,
  `push_token` varchar(48) NOT NULL,
  `push_key` varchar(48) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `config`
--

INSERT INTO `config` (`id`, `version`, `raspberry_type`, `token`, `api`, `set_temp`, `set_temp_dev`, `save_temp`, `heater_control`, `heater_relay`, `heater_sensor`, `overheat_control`, `overheat_sensor`, `overheat_temp`, `pump_control`, `pump_relay`, `frost_protection`, `frost_temp`, `frost_sensor`, `cleaning_mode`, `left_column`, `mid_column`, `right_column`, `used_power_date`, `tablet_view`, `ip_check`, `ip_range`, `push_token`, `push_key`) VALUES
(1, '1.10', 'B+', 'Gdw34^%FHYDe', 1, '36.1', '0.3', 0, 0, 2, 2, 0, 2, '40', 0, 9, 0, '2', 2, 0, 3, '28-00000a292a13', 9, '0000-00-00', 1, 1, '192.168.x.x', '', '');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `device_control`
--

CREATE TABLE IF NOT EXISTS `device_control` (
`id` int(6) NOT NULL,
  `relay_pin` int(6) NOT NULL,
  `relay_state` int(1) NOT NULL,
  `other_relay_pin` int(6) NOT NULL,
  `other_relay_state` int(1) NOT NULL,
  `remarks` mediumtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `device_control`
--

INSERT INTO `device_control` (`id`, `relay_pin`, `relay_state`, `other_relay_pin`, `other_relay_state`, `remarks`) VALUES
(1, 2, 0, 9, 0, 'When heater goes on , pump must go on');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `login`
--

CREATE TABLE IF NOT EXISTS `login` (
`id` int(8) NOT NULL,
  `userid` int(10) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `time` bigint(15) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `login`
--

INSERT INTO `login` (`id`, `userid`, `ip`, `time`) VALUES
(1, 1, '192.168.2.18', 1475406286),
(2, 1, '192.168.2.18', 1475407854),
(3, 9, '192.168.2.18', 1475410982),
(4, 9, '192.168.2.18', 1475411067);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
`id` int(6) NOT NULL,
  `log` mediumtext NOT NULL,
  `time` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `logs`
--

INSERT INTO `logs` (`id`, `log`, `time`) VALUES
(1, 'admin tried to login, but failed. From Ip: 192.168.2.18', '2016-10-02 13:30:48');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `relays`
--

CREATE TABLE IF NOT EXISTS `relays` (
`id` int(4) NOT NULL,
  `pin` int(3) NOT NULL,
  `name` varchar(52) NOT NULL,
  `power` int(4) NOT NULL,
  `minutes_power` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `relays`
--

INSERT INTO `relays` (`id`, `pin`, `name`, `power`, `minutes_power`) VALUES
(1, 3, 'Uv Light', 9, 0),
(2, 2, 'Heater', 3000, 0),
(3, 9, 'Pump', 150, 2),
(4, 8, 'Pool Lights', 0, 10);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `schedule`
--

CREATE TABLE IF NOT EXISTS `schedule` (
`id` int(6) NOT NULL,
  `pin` int(2) NOT NULL,
  `state` int(1) NOT NULL,
  `time` time NOT NULL,
  `active` int(1) NOT NULL,
  `remarks` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `schedule`
--

INSERT INTO `schedule` (`id`, `pin`, `state`, `time`, `active`, `remarks`) VALUES
(2, 9, 0, '14:00:00', 1, ''),
(4, 9, 1, '18:00:00', 1, '');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `sensors`
--

CREATE TABLE IF NOT EXISTS `sensors` (
`id` int(6) NOT NULL,
  `address` varchar(125) NOT NULL,
  `name` varchar(52) NOT NULL,
  `type` varchar(25) NOT NULL,
  `pin` int(2) NOT NULL,
  `calibration_value` varchar(5) NOT NULL,
  `temperature` varchar(6) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `sensors`
--

INSERT INTO `sensors` (`id`, `address`, `name`, `type`, `pin`, `calibration_value`, `temperature`) VALUES
(2, '28-0000040d5895', 'Incomming Temperature ', '', 0, '', '18.4'),
(3, '28-0000043e2387', 'Outgoing Temperature ', '', 0, '-0.1', '18.5'),
(4, '28-0000045d809f', 'Hottub Temperature', '', 0, '', '17.2');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `temp_control`
--

CREATE TABLE IF NOT EXISTS `temp_control` (
`id` int(8) NOT NULL,
  `sensor_id` int(8) NOT NULL,
  `mark` varchar(1) NOT NULL,
  `value` varchar(5) NOT NULL,
  `switch` int(2) NOT NULL,
  `state` int(1) NOT NULL,
  `remarks` mediumtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `temp_control`
--

INSERT INTO `temp_control` (`id`, `sensor_id`, `mark`, `value`, `switch`, `state`, `remarks`) VALUES
(1, 2, '>', '55', 3, 1, ''),
(2, 4, '>', '35', 8, 0, '');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `temp_logger`
--

CREATE TABLE IF NOT EXISTS `temp_logger` (
`id` int(10) NOT NULL,
  `address` varchar(52) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `value` varchar(6) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `temp_logger`
--

INSERT INTO `temp_logger` (`id`, `address`, `date_time`, `value`) VALUES
(1, '28-0000040d5895', '2016-10-01 17:21:02', '36.4'),
(2, '28-0000043e2387', '2016-10-01 17:21:04', '37.8'),
(3, '28-0000045d809f', '2016-10-01 17:21:05', '32.5');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`id` int(6) NOT NULL,
  `username` varchar(52) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `rank` smallint(1) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `ip`, `rank`) VALUES
(9, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '', '192.168.2.18', 2);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `config`
--
ALTER TABLE `config`
 ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `device_control`
--
ALTER TABLE `device_control`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexen voor tabel `login`
--
ALTER TABLE `login`
 ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `logs`
--
ALTER TABLE `logs`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexen voor tabel `relays`
--
ALTER TABLE `relays`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexen voor tabel `schedule`
--
ALTER TABLE `schedule`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexen voor tabel `sensors`
--
ALTER TABLE `sensors`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexen voor tabel `temp_control`
--
ALTER TABLE `temp_control`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexen voor tabel `temp_logger`
--
ALTER TABLE `temp_logger`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `device_control`
--
ALTER TABLE `device_control`
MODIFY `id` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT voor een tabel `login`
--
ALTER TABLE `login`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT voor een tabel `logs`
--
ALTER TABLE `logs`
MODIFY `id` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT voor een tabel `relays`
--
ALTER TABLE `relays`
MODIFY `id` int(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT voor een tabel `schedule`
--
ALTER TABLE `schedule`
MODIFY `id` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT voor een tabel `sensors`
--
ALTER TABLE `sensors`
MODIFY `id` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT voor een tabel `temp_control`
--
ALTER TABLE `temp_control`
MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT voor een tabel `temp_logger`
--
ALTER TABLE `temp_logger`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
MODIFY `id` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
