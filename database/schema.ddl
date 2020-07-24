##Database Name -> cargotracker (user: cargotracker / pw: cargotracker)
CREATE SCHEMA `cargotracker` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
use cargotracker;

CREATE USER 'cargotracker'@'%' IDENTIFIED BY 'cargotracker';
GRANT ALL PRIVILEGES ON cargotracker.* TO 'cargotracker'@'%';

##Tables ->

##Cargo Table DDL
CREATE TABLE `CARGO` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BOOKING_ID` varchar(20) NOT NULL,
  `TRANSPORT_STATUS` varchar(100) NOT NULL,
  `ROUTING_STATUS` varchar(100) NOT NULL,
  `spec_origin_id` varchar(20) DEFAULT NULL,
  `spec_destination_id` varchar(20) DEFAULT NULL,
  `SPEC_ARRIVAL_DEADLINE` date DEFAULT NULL,
  `origin_id` varchar(20) DEFAULT NULL,
  `BOOKING_AMOUNT` int(11) NOT NULL,
  `handling_event_id` int(11) DEFAULT NULL,
  `next_expected_location_id` varchar(20) DEFAULT NULL,
  `next_expected_handling_event_type` varchar(20) DEFAULT NULL,
  `next_expected_voyage_id` varchar(20) DEFAULT NULL,
  `last_known_location_id` varchar(20) DEFAULT NULL,
  `current_voyage_number` varchar(100) DEFAULT NULL,
  `last_handling_event_id` int(11) DEFAULT NULL,
  `last_handling_event_type` varchar(20) DEFAULT NULL,
  `last_handling_event_location` varchar(20) DEFAULT NULL,
  `last_handling_event_voyage` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2923 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


##Leg Table DDL
	CREATE TABLE `LEG` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOAD_TIME` timestamp NULL DEFAULT NULL,
  `UNLOAD_TIME` timestamp NULL DEFAULT NULL,
  `load_location_id` varchar(20) DEFAULT NULL,
  `unload_location_id` varchar(20) DEFAULT NULL,
  `voyage_number` varchar(100) DEFAULT NULL,
  `CARGO_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3095 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

##Location Table DDL
CREATE TABLE `location` (
`ID` int(11) DEFAULT NULL,
`NAME` varchar(50) DEFAULT NULL,
`UNLOCODE` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

##Voyage Table DDL
CREATE TABLE `VOYAGE` (
`Id` int(11) NOT NULL AUTO_INCREMENT,
`voyage_number` varchar(20) NOT NULL,
PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

##Carrier Movement Table DDL -
CREATE TABLE `carrier_movement` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `arrival_location_id` varchar(100) DEFAULT NULL,
  `departure_location_id` varchar(100) DEFAULT NULL,
  `voyage_id` int(11) DEFAULT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1358 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

### Data to ensure Routing works fine ->
insert VOYAGE (Id,voyage_number) values(3,'0100S');
insert VOYAGE (Id,voyage_number) values(4,'0101S');
insert VOYAGE (Id,voyage_number) values(5,'0102S');
INSERT INTO `cargotracker`.`VOYAGE` (`Id`, `voyage_number`) VALUES ('6', '0103S');
INSERT INTO `cargotracker`.`VOYAGE` (`Id`, `voyage_number`) VALUES ('7', '0104S');
INSERT INTO `cargotracker`.`VOYAGE` (`Id`, `voyage_number`) VALUES ('8', '0105S');

insert into carrier_movement (Id,arrival_location_id,departure_location_id,voyage_id,arrival_date,departure_date) 		values (1355,'CNHGH','CNHKG',3,'2019-08-28','2019-08-25');
insert into carrier_movement (Id,arrival_location_id,departure_location_id,voyage_id,arrival_date,departure_date) 		values (1356,'JNTKO','CNHGH',4,'2019-09-10','2019-09-01');
insert into carrier_movement (Id,arrival_location_id,departure_location_id,voyage_id,arrival_date,departure_date) 		values (1357,'USNYC','JNTKO',5,'2019-09-25','2019-09-15');  

INSERT INTO `cargotracker`.`carrier_movement` (`Id`, `arrival_location_id`, `departure_location_id`, `voyage_id`, `arrival_date`, `departure_date`) VALUES ('1358', 'USNYC', 'JNTKO', '6', '2020-01-15', '2020-01-18');
INSERT INTO `cargotracker`.`carrier_movement` (`Id`, `arrival_location_id`, `departure_location_id`, `voyage_id`, `arrival_date`, `departure_date`) VALUES ('1359', 'JNTKO', 'CNHGH', '7', '2020-01-19', '2020-01-22');
INSERT INTO `cargotracker`.`carrier_movement` (`Id`, `arrival_location_id`, `departure_location_id`, `voyage_id`, `arrival_date`, `departure_date`) VALUES ('1360', 'CNHGH', 'CNHKG', '8', '2020-01-23', '2020-01-25');

##Tracking_activity DDL
 CREATE TABLE `tracking_activity` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking_number` varchar(20) NOT NULL,
  `booking_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

##Tracking_handling_events DDL
  CREATE TABLE `tracking_handling_events` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `tracking_id` int(11) DEFAULT NULL,
  `event_type` varchar(225) DEFAULT NULL,
  `event_time` timestamp NULL DEFAULT NULL,
  `location_id` varchar(100) DEFAULT NULL,
  `voyage_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

##Handling_activity DDL 
 CREATE TABLE handling_activity ( 
  id int(11) NOT NULL AUTO_INCREMENT, 
  event_completion_time timestamp NULL DEFAULT NULL, 
  event_type varchar(225) DEFAULT NULL, 
  booking_id varchar(20) DEFAULT NULL, 
  voyage_number varchar(100) DEFAULT NULL, 
  location varchar(100) DEFAULT NULL, 
  PRIMARY KEY (id) ) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;