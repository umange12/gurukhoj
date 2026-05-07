-- ============================================================
--  YatraGo v3 — Full DSA Travel Reservation
-- ============================================================
CREATE DATABASE IF NOT EXISTS yatragodb;
USE yatragodb;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS booking_queue;
DROP TABLE IF EXISTS search_history;
DROP TABLE IF EXISTS seats;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS buses;
DROP TABLE IF EXISTS trains;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS route_graph;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE users (
  id VARCHAR(36) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  phone VARCHAR(20) DEFAULT '',
  age INT DEFAULT 25,
  gender ENUM('male','female','other') DEFAULT 'other',
  disability TINYINT(1) DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE flights (
  id VARCHAR(15) PRIMARY KEY,
  airline VARCHAR(100) NOT NULL,
  airline_code VARCHAR(5) NOT NULL,
  `from` VARCHAR(100) NOT NULL,
  `to` VARCHAR(100) NOT NULL,
  stops JSON DEFAULT NULL,
  date DATE NOT NULL,
  departure VARCHAR(10) NOT NULL,
  arrival VARCHAR(10) NOT NULL,
  duration VARCHAR(20) NOT NULL,
  price_economy INT DEFAULT NULL,
  price_business INT DEFAULT NULL,
  price_first INT DEFAULT NULL,
  seats_economy INT DEFAULT 0,
  seats_business INT DEFAULT 0,
  seats_first INT DEFAULT 0,
  is_direct TINYINT(1) DEFAULT 1
);

CREATE TABLE trains (
  id VARCHAR(15) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  number VARCHAR(20) NOT NULL,
  `from` VARCHAR(100) NOT NULL,
  `to` VARCHAR(100) NOT NULL,
  stops JSON DEFAULT NULL,
  date DATE NOT NULL,
  departure VARCHAR(10) NOT NULL,
  arrival VARCHAR(20) NOT NULL,
  duration VARCHAR(20) NOT NULL,
  price_sleeper INT DEFAULT NULL,
  price_3ac INT DEFAULT NULL,
  price_2ac INT DEFAULT NULL,
  price_1ac INT DEFAULT NULL,
  price_cc INT DEFAULT NULL,
  price_ec INT DEFAULT NULL,
  seats_sleeper INT DEFAULT 0,
  seats_3ac INT DEFAULT 0,
  seats_2ac INT DEFAULT 0,
  seats_1ac INT DEFAULT 0,
  seats_cc INT DEFAULT 0,
  seats_ec INT DEFAULT 0
);

CREATE TABLE buses (
  id VARCHAR(15) PRIMARY KEY,
  operator VARCHAR(100) NOT NULL,
  `from` VARCHAR(100) NOT NULL,
  `to` VARCHAR(100) NOT NULL,
  stops JSON DEFAULT NULL,
  date DATE NOT NULL,
  departure VARCHAR(10) NOT NULL,
  arrival VARCHAR(20) NOT NULL,
  duration VARCHAR(20) NOT NULL,
  bus_type VARCHAR(50) NOT NULL,
  price INT NOT NULL,
  seats INT NOT NULL
);

CREATE TABLE bookings (
  id VARCHAR(20) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  type ENUM('flight','train','bus') NOT NULL,
  item_id VARCHAR(15) NOT NULL,
  item_data JSON NOT NULL,
  passengers JSON NOT NULL,
  travel_class VARCHAR(30) DEFAULT 'Economy',
  total_amount INT NOT NULL,
  contact_email VARCHAR(100) NOT NULL,
  contact_phone VARCHAR(20) NOT NULL,
  seat_number VARCHAR(10) DEFAULT NULL,
  seat_category VARCHAR(20) DEFAULT 'general',
  priority_label VARCHAR(60) DEFAULT 'General',
  status ENUM('Confirmed','Cancelled') DEFAULT 'Confirmed',
  booked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE seats (
  id INT AUTO_INCREMENT PRIMARY KEY,
  transport_id VARCHAR(15) NOT NULL,
  transport_type ENUM('flight','train','bus') NOT NULL,
  travel_class VARCHAR(30) NOT NULL DEFAULT 'Economy',
  seat_number VARCHAR(10) NOT NULL,
  seat_category ENUM('disability','senior','female','general') NOT NULL,
  is_reserved TINYINT(1) DEFAULT 0,
  booking_id VARCHAR(20) DEFAULT NULL,
  UNIQUE KEY uniq_seat (transport_id, transport_type, travel_class, seat_number)
);

CREATE TABLE route_graph (
  id INT AUTO_INCREMENT PRIMARY KEY,
  city_from VARCHAR(100) NOT NULL,
  city_to VARCHAR(100) NOT NULL,
  distance_km INT NOT NULL,
  base_price INT NOT NULL,
  transport_type ENUM('flight','train','bus') NOT NULL,
  duration_mins INT NOT NULL,
  stops_count INT DEFAULT 0
);

CREATE TABLE search_history (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  search_from VARCHAR(100),
  search_to VARCHAR(100),
  search_type ENUM('flights','trains','buses') NOT NULL,
  travel_class VARCHAR(30) DEFAULT NULL,
  searched_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE booking_queue (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  transport_id VARCHAR(15) NOT NULL,
  transport_type ENUM('flight','train','bus') NOT NULL,
  passenger_data JSON NOT NULL,
  priority_score INT DEFAULT 4,
  queue_status ENUM('waiting','processed','expired') DEFAULT 'waiting',
  queued_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- FLIGHTS DATA
INSERT INTO flights VALUES
('fl001','IndiGo','6E','Delhi','Mumbai',NULL,'2025-06-10','06:00','08:20','2h 20m',3499,8999,NULL,120,20,0,1),
('fl002','Air India','AI','Delhi','Mumbai',NULL,'2025-06-10','09:30','11:55','2h 25m',4299,11999,21999,100,24,8,1),
('fl003','SpiceJet','SJ','Delhi','Mumbai',NULL,'2025-06-10','13:00','15:25','2h 25m',3199,NULL,NULL,140,0,0,1),
('fl004','Vistara','UK','Delhi','Mumbai',NULL,'2025-06-10','17:00','19:20','2h 20m',5499,13999,24999,110,28,8,1),
('fl005','GoFirst','G8','Delhi','Mumbai',NULL,'2025-06-10','20:30','22:55','2h 25m',2999,NULL,NULL,130,0,0,1),
('fl006','AirAsia','I5','Delhi','Mumbai','["Jaipur"]','2025-06-10','07:00','10:30','3h 30m',2499,NULL,NULL,160,0,0,0),
('fl007','IndiGo','6E','Delhi','Goa',NULL,'2025-06-10','06:30','09:00','2h 30m',5299,NULL,NULL,100,0,0,1),
('fl008','Air India','AI','Delhi','Goa',NULL,'2025-06-10','11:00','13:35','2h 35m',6499,15999,NULL,80,20,0,1),
('fl009','SpiceJet','SJ','Delhi','Goa',NULL,'2025-06-10','16:00','18:40','2h 40m',4899,NULL,NULL,120,0,0,1),
('fl010','Vistara','UK','Delhi','Goa',NULL,'2025-06-10','19:30','22:05','2h 35m',7299,17999,NULL,90,24,0,1),
('fl011','IndiGo','6E','Delhi','Goa','["Mumbai"]','2025-06-10','08:00','12:30','4h 30m',3999,NULL,NULL,150,0,0,0),
('fl012','IndiGo','6E','Mumbai','Bangalore',NULL,'2025-06-10','07:00','08:45','1h 45m',3299,NULL,NULL,130,0,0,1),
('fl013','Vistara','UK','Mumbai','Bangalore',NULL,'2025-06-10','10:00','11:50','1h 50m',5999,13499,22999,80,24,8,1),
('fl014','Air India','AI','Mumbai','Bangalore',NULL,'2025-06-10','14:00','15:55','1h 55m',4499,10999,NULL,100,20,0,1),
('fl015','SpiceJet','SJ','Mumbai','Bangalore',NULL,'2025-06-10','18:00','19:50','1h 50m',3499,NULL,NULL,120,0,0,1),
('fl016','GoFirst','G8','Mumbai','Bangalore',NULL,'2025-06-10','21:00','22:55','1h 55m',2899,NULL,NULL,140,0,0,1),
('fl017','Air India','AI','Delhi','Chennai',NULL,'2025-06-10','07:00','09:55','2h 55m',5299,12999,NULL,90,20,0,1),
('fl018','IndiGo','6E','Delhi','Chennai',NULL,'2025-06-10','10:30','13:25','2h 55m',4199,NULL,NULL,130,0,0,1),
('fl019','SpiceJet','SJ','Delhi','Chennai',NULL,'2025-06-10','14:00','16:55','2h 55m',3799,NULL,NULL,120,0,0,1),
('fl020','Vistara','UK','Delhi','Chennai',NULL,'2025-06-10','18:00','21:00','3h 00m',6299,15999,NULL,80,24,0,1),
('fl021','IndiGo','6E','Delhi','Chennai','["Hyderabad"]','2025-06-10','08:00','12:30','4h 30m',3499,NULL,NULL,160,0,0,0),
('fl022','IndiGo','6E','Mumbai','Delhi',NULL,'2025-06-10','05:30','07:50','2h 20m',3299,8499,NULL,120,20,0,1),
('fl023','Air India','AI','Mumbai','Delhi',NULL,'2025-06-10','09:00','11:20','2h 20m',4599,11499,20999,90,24,8,1),
('fl024','Vistara','UK','Mumbai','Delhi',NULL,'2025-06-10','13:30','15:50','2h 20m',5299,13499,23999,100,28,8,1),
('fl025','SpiceJet','SJ','Mumbai','Delhi',NULL,'2025-06-10','17:00','19:20','2h 20m',3099,NULL,NULL,140,0,0,1),
('fl026','GoFirst','G8','Mumbai','Delhi',NULL,'2025-06-10','21:00','23:20','2h 20m',2799,NULL,NULL,130,0,0,1),
('fl027','Air India','AI','Bangalore','Kolkata',NULL,'2025-06-10','07:30','10:30','3h 00m',5999,14999,NULL,80,20,0,1),
('fl028','IndiGo','6E','Bangalore','Kolkata',NULL,'2025-06-10','11:00','14:05','3h 05m',4799,NULL,NULL,120,0,0,1),
('fl029','SpiceJet','SJ','Bangalore','Kolkata',NULL,'2025-06-10','15:00','18:10','3h 10m',4299,NULL,NULL,110,0,0,1),
('fl030','Vistara','UK','Bangalore','Kolkata',NULL,'2025-06-10','19:00','22:05','3h 05m',6799,16999,NULL,70,20,0,1),
('fl031','IndiGo','6E','Bangalore','Kolkata','["Hyderabad"]','2025-06-10','09:00','13:30','4h 30m',3799,NULL,NULL,150,0,0,0),
('fl032','Air India','AI','Chennai','Kolkata',NULL,'2025-06-10','08:00','10:45','2h 45m',5499,13999,NULL,80,20,0,1),
('fl033','IndiGo','6E','Chennai','Kolkata',NULL,'2025-06-10','12:00','14:50','2h 50m',4299,NULL,NULL,120,0,0,1),
('fl034','SpiceJet','SJ','Chennai','Kolkata',NULL,'2025-06-10','16:00','18:55','2h 55m',3899,NULL,NULL,110,0,0,1),
('fl035','Vistara','UK','Chennai','Kolkata',NULL,'2025-06-10','20:00','22:50','2h 50m',6299,15499,NULL,70,20,0,1),
('fl036','IndiGo','6E','Hyderabad','Delhi',NULL,'2025-06-10','06:00','08:20','2h 20m',3999,NULL,NULL,130,0,0,1),
('fl037','Air India','AI','Hyderabad','Delhi',NULL,'2025-06-10','10:00','12:25','2h 25m',5299,12999,NULL,80,20,0,1),
('fl038','SpiceJet','SJ','Hyderabad','Delhi',NULL,'2025-06-10','14:30','16:55','2h 25m',3699,NULL,NULL,120,0,0,1),
('fl039','Vistara','UK','Hyderabad','Delhi',NULL,'2025-06-10','18:00','20:20','2h 20m',5999,14999,NULL,70,20,0,1),
('fl040','GoFirst','G8','Hyderabad','Delhi',NULL,'2025-06-10','21:00','23:25','2h 25m',3199,NULL,NULL,130,0,0,1),
('fl041','IndiGo','6E','Pune','Delhi',NULL,'2025-06-10','07:00','09:20','2h 20m',3799,NULL,NULL,120,0,0,1),
('fl042','Air India','AI','Pune','Delhi',NULL,'2025-06-10','11:00','13:25','2h 25m',4999,12499,NULL,80,20,0,1),
('fl043','SpiceJet','SJ','Pune','Delhi',NULL,'2025-06-10','15:00','17:20','2h 20m',3299,NULL,NULL,130,0,0,1),
('fl044','Vistara','UK','Pune','Delhi',NULL,'2025-06-10','19:00','21:20','2h 20m',5799,14499,NULL,70,20,0,1),
('fl045','GoFirst','G8','Pune','Delhi',NULL,'2025-06-10','06:00','08:25','2h 25m',2799,NULL,NULL,140,0,0,1),
('fl046','Air India','AI','Kochi','Delhi',NULL,'2025-06-10','06:30','09:20','2h 50m',5499,13999,NULL,80,20,0,1),
('fl047','IndiGo','6E','Kochi','Delhi',NULL,'2025-06-10','10:30','13:20','2h 50m',4399,NULL,NULL,130,0,0,1),
('fl048','SpiceJet','SJ','Kochi','Delhi',NULL,'2025-06-10','14:00','16:50','2h 50m',3899,NULL,NULL,120,0,0,1),
('fl049','Vistara','UK','Kochi','Delhi',NULL,'2025-06-10','18:30','21:20','2h 50m',6299,15999,NULL,70,20,0,1),
('fl050','GoFirst','G8','Kochi','Delhi',NULL,'2025-06-10','22:00','00:50','2h 50m',3199,NULL,NULL,120,0,0,1);

-- TRAINS DATA
INSERT INTO trains VALUES
('tr001','Rajdhani Express','12951','Delhi','Mumbai','["Kota","Vadodara","Surat"]','2025-06-10','16:55','08:15','15h 20m',NULL,1850,2600,4200,NULL,NULL,0,200,120,40,0,0),
('tr002','August Kranti','12953','Delhi','Mumbai','["Vadodara","Surat"]','2025-06-10','17:40','10:26','16h 46m',NULL,1950,2750,4400,NULL,NULL,0,180,100,30,0,0),
('tr003','Mumbai Rajdhani','12955','Delhi','Mumbai','["Jaipur","Ahmedabad","Vadodara"]','2025-06-10','19:55','12:25','16h 30m',NULL,2050,2850,4600,NULL,NULL,0,160,90,24,0,0),
('tr004','Duronto Express','12267','Delhi','Mumbai','[]','2025-06-10','22:30','14:45','16h 15m',NULL,1700,2450,NULL,NULL,NULL,0,250,150,0,0,0),
('tr005','Paschim Express','12925','Delhi','Mumbai','["Ahmedabad","Surat","Vadodara"]','2025-06-10','11:25','06:40','19h 15m',650,1250,1900,NULL,NULL,NULL,200,180,80,0,0,0),
('tr006','Golden Temple Mail','12903','Delhi','Mumbai','["Vadodara","Surat","Ahmedabad"]','2025-06-10','09:40','08:55','23h 15m',550,1100,1700,NULL,NULL,NULL,220,160,60,0,0,0),
('tr007','Mumbai Superfast','12245','Delhi','Mumbai','["Agra","Kota","Vadodara"]','2025-06-10','06:30','00:30','18h 00m',700,1350,2000,NULL,NULL,NULL,190,150,70,0,0,0),
('tr008','Avantika Express','18233','Delhi','Mumbai','["Agra","Kota","Ratlam","Vadodara"]','2025-06-10','14:40','11:50','21h 10m',600,1200,1800,NULL,NULL,NULL,200,140,50,0,0,0),
('tr009','Gujarat Express','19032','Delhi','Mumbai','["Jaipur","Ahmedabad","Vadodara","Surat"]','2025-06-10','07:20','07:35','24h 15m',500,1000,1550,NULL,NULL,NULL,220,180,80,0,0,0),
('tr010','Kutch Express','22953','Delhi','Mumbai','["Ahmedabad","Vadodara"]','2025-06-10','23:55','17:40','17h 45m',620,1280,1950,NULL,NULL,NULL,200,160,60,0,0,0),
('tr011','Shatabdi Express','12001','Delhi','Agra','[]','2025-06-10','06:00','08:10','2h 10m',NULL,NULL,NULL,NULL,750,1100,0,0,0,0,150,60),
('tr012','Gatimaan Express','12049','Delhi','Agra','[]','2025-06-10','08:10','09:50','1h 40m',NULL,NULL,NULL,NULL,NULL,995,0,0,0,0,0,100),
('tr013','Taj Express','12279','Delhi','Agra','[]','2025-06-10','07:15','09:55','2h 40m',NULL,NULL,NULL,NULL,680,NULL,0,0,0,0,120,0),
('tr014','Intercity Express','12627','Delhi','Agra','["Mathura"]','2025-06-10','15:30','18:05','2h 35m',350,NULL,NULL,NULL,NULL,NULL,100,0,0,0,0,0),
('tr015','Agra Express','14311','Delhi','Agra','["Mathura"]','2025-06-10','18:00','21:15','3h 15m',280,650,NULL,NULL,NULL,NULL,120,60,0,0,0,0),
('tr016','Vande Bharat','22439','Delhi','Varanasi','["Prayagraj"]','2025-06-10','06:00','14:00','8h 00m',NULL,NULL,NULL,NULL,1200,1600,0,0,0,0,80,40),
('tr017','Kashi Vishwanath','13307','Delhi','Varanasi','["Aligarh","Kanpur","Prayagraj"]','2025-06-10','14:10','06:40','16h 30m',650,1300,1950,NULL,NULL,NULL,180,140,50,0,0,0),
('tr018','Poorva Express','12303','Delhi','Varanasi','["Kanpur","Prayagraj"]','2025-06-10','16:00','07:25','15h 25m',600,1200,1800,NULL,NULL,NULL,200,160,60,0,0,0),
('tr019','Mahananda Express','15609','Delhi','Varanasi','["Aligarh","Kanpur","Prayagraj"]','2025-06-10','11:55','05:55','18h 00m',500,1000,1550,NULL,NULL,NULL,220,180,70,0,0,0),
('tr020','Bundelkhand Express','11108','Delhi','Varanasi','["Kanpur","Prayagraj"]','2025-06-10','09:00','02:50','17h 50m',480,950,1450,NULL,NULL,NULL,220,180,70,0,0,0),
('tr021','Double Decker','12985','Delhi','Jaipur','["Gurgaon","Rewari"]','2025-06-10','06:05','10:35','4h 30m',NULL,NULL,NULL,NULL,650,NULL,0,0,0,0,120,0),
('tr022','Ajmer Shatabdi','12015','Delhi','Jaipur','["Gurgaon"]','2025-06-10','06:05','09:15','3h 10m',NULL,NULL,NULL,NULL,700,1050,0,0,0,0,100,40),
('tr023','Jaipur SF','12413','Delhi','Jaipur','["Gurgaon","Rewari","Alwar"]','2025-06-10','18:00','23:30','5h 30m',380,750,1150,NULL,NULL,NULL,150,120,50,0,0,0),
('tr024','Intercity','12016','Delhi','Jaipur','["Mathura","Alwar"]','2025-06-10','15:00','20:40','5h 40m',350,700,NULL,NULL,NULL,NULL,180,140,0,0,0,0),
('tr025','Pink City Express','12017','Delhi','Jaipur','["Rewari"]','2025-06-10','21:45','02:25','4h 40m',320,680,1050,NULL,NULL,NULL,160,130,50,0,0,0),
('tr026','Tejas Express','22119','Mumbai','Goa','["Ratnagiri","Kankavli"]','2025-06-10','05:00','14:00','9h 00m',NULL,NULL,NULL,NULL,1500,2200,0,0,0,0,100,40),
('tr027','Konkan Kanya','10111','Mumbai','Goa','["Ratnagiri","Kudal","Sawantwadi"]','2025-06-10','23:05','10:55','11h 50m',650,1350,1950,NULL,NULL,NULL,180,120,40,0,0,0),
('tr028','Mandovi Express','10103','Mumbai','Goa','["Roha","Ratnagiri","Sawantwadi"]','2025-06-10','07:10','20:20','13h 10m',600,1250,1850,NULL,NULL,NULL,200,140,50,0,0,0),
('tr029','Jan Shatabdi','12051','Mumbai','Goa','["Khed","Ratnagiri","Kudal"]','2025-06-10','05:20','14:00','8h 40m',NULL,NULL,NULL,NULL,1100,NULL,0,0,0,0,120,0),
('tr030','Netravati Express','16345','Mumbai','Goa','["Ratnagiri","Kudal","Sawantwadi"]','2025-06-10','11:50','23:00','11h 10m',580,1150,1750,NULL,NULL,NULL,200,160,60,0,0,0),
('tr031','Shatabdi Express','12007','Chennai','Bangalore','[]','2025-06-10','06:00','10:55','4h 55m',NULL,NULL,NULL,NULL,880,1300,0,0,0,0,100,40),
('tr032','Brindavan Express','12639','Chennai','Bangalore','["Vellore","Jolarpettai","Krishnagiri"]','2025-06-10','07:40','12:35','4h 55m',NULL,NULL,NULL,NULL,550,NULL,0,0,0,0,160,0),
('tr033','Intercity SF','12677','Chennai','Bangalore','["Ambur","Krishnagiri","Hosur"]','2025-06-10','08:35','14:10','5h 35m',380,780,NULL,NULL,NULL,NULL,180,140,0,0,0,0),
('tr034','Lalbagh Express','12608','Chennai','Bangalore','["Vellore","Krishnagiri","Hosur"]','2025-06-10','16:50','22:10','5h 20m',350,720,1100,NULL,NULL,NULL,180,140,50,0,0,0),
('tr035','Island Express','16341','Chennai','Bangalore','["Vellore","Jolarpettai","Krishnagiri"]','2025-06-10','19:15','00:30','5h 15m',320,680,1050,NULL,NULL,NULL,200,160,60,0,0,0),
('tr036','Rajdhani Express','12301','Delhi','Kolkata','["Kanpur","Prayagraj","Dhanbad"]','2025-06-10','16:55','09:55','17h 00m',NULL,2100,2900,4800,NULL,NULL,0,180,100,30,0,0),
('tr037','Poorva Express','12303','Delhi','Kolkata','["Kanpur","Prayagraj","Gaya","Dhanbad"]','2025-06-10','08:00','06:30','22h 30m',750,1500,2200,NULL,NULL,NULL,180,140,50,0,0,0),
('tr038','Durgiana Express','12317','Delhi','Kolkata','["Kanpur","Prayagraj","Gaya"]','2025-06-10','21:35','22:20','24h 45m',680,1350,2000,NULL,NULL,NULL,200,160,60,0,0,0),
('tr039','Howrah Mail','12311','Delhi','Kolkata','["Aligarh","Kanpur","Prayagraj","Gaya"]','2025-06-10','19:05','23:30','28h 25m',620,1250,1900,NULL,NULL,NULL,220,180,70,0,0,0),
('tr040','Bombay Howrah Mail','12809','Delhi','Kolkata','["Kanpur","Prayagraj","Gaya","Dhanbad"]','2025-06-10','15:00','18:15','27h 15m',600,1200,1800,NULL,NULL,NULL,220,180,70,0,0,0);

-- BUSES DATA
INSERT INTO buses VALUES
('bu001','RedBus Volvo','Delhi','Jaipur','["Gurgaon","Manesar","Behror"]','2025-06-10','06:00','11:30','5h 30m','Volvo AC',899,36),
('bu002','RSRTC Deluxe','Delhi','Jaipur','["Gurgaon","Rewari","Shahjahanpur"]','2025-06-10','07:00','12:45','5h 45m','AC Seater',549,45),
('bu003','Neeta Travels','Delhi','Jaipur','["Behror","Shahjahanpur"]','2025-06-10','08:00','13:00','5h 00m','AC Sleeper',799,32),
('bu004','RSRTC Express','Delhi','Jaipur','["Rewari","Alwar"]','2025-06-10','09:00','14:30','5h 30m','Non-AC Seater',299,55),
('bu005','Orange Travels','Delhi','Jaipur','["Gurgaon","Manesar","Behror"]','2025-06-10','10:30','16:00','5h 30m','Luxury Sleeper',1199,24),
('bu006','SRS Travels','Delhi','Jaipur','["Gurgaon","Rewari"]','2025-06-10','12:00','17:30','5h 30m','AC Seater',599,44),
('bu007','RSRTC Night','Delhi','Jaipur','["Gurgaon","Rewari","Shahjahanpur"]','2025-06-10','14:00','19:30','5h 30m','Non-AC Sleeper',399,40),
('bu008','Hans Travels','Delhi','Jaipur','["Behror"]','2025-06-10','16:00','21:00','5h 00m','Volvo AC',849,36),
('bu009','Paradise Travels','Delhi','Jaipur','["Gurgaon","Manesar","Behror","Shahjahanpur"]','2025-06-10','18:00','23:30','5h 30m','AC Sleeper',749,32),
('bu010','GreenLine','Delhi','Jaipur','["Rewari","Alwar"]','2025-06-10','20:00','01:30','5h 30m','Non-AC Seater',279,55),
('bu011','RSRTC Rajdhani','Delhi','Jaipur','["Behror"]','2025-06-10','22:00','03:00','5h 00m','Volvo AC',999,32),
('bu012','Raj Travels','Delhi','Jaipur','["Gurgaon","Rewari","Behror"]','2025-06-10','23:00','04:30','5h 30m','AC Sleeper',699,36),
('bu013','KGN Travels','Delhi','Jaipur','["Rewari","Behror","Shahjahanpur"]','2025-06-10','00:30','06:00','5h 30m','Non-AC Sleeper',349,44),
('bu014','SRS Travels Volvo','Mumbai','Pune','["Khopoli","Khalapur"]','2025-06-10','06:30','09:30','3h 00m','Volvo AC',699,40),
('bu015','Orange Travels','Mumbai','Pune','["Khopoli"]','2025-06-10','07:30','10:30','3h 00m','AC Seater',499,45),
('bu016','Neeta Travels','Mumbai','Pune','["Khopoli","Khalapur"]','2025-06-10','08:00','11:00','3h 00m','Luxury Sleeper',899,24),
('bu017','MSRTC Shivneri','Mumbai','Pune','[]','2025-06-10','08:30','11:15','2h 45m','Volvo AC',599,45),
('bu018','MSRTC Express','Mumbai','Pune','["Khalapur"]','2025-06-10','09:00','12:30','3h 30m','Non-AC Seater',199,60),
('bu019','GreenLine Pune','Mumbai','Pune','["Khopoli","Khalapur"]','2025-06-10','11:00','14:00','3h 00m','AC Sleeper',549,32),
('bu020','Konduskar Travels','Mumbai','Pune','["Khopoli"]','2025-06-10','14:00','17:00','3h 00m','Volvo AC',649,40),
('bu021','Paulo Travels','Mumbai','Pune','["Khopoli","Khalapur"]','2025-06-10','17:00','20:00','3h 00m','AC Seater',449,44),
('bu022','MSRTC Night','Mumbai','Pune','[]','2025-06-10','20:00','23:00','3h 00m','Non-AC Sleeper',299,40),
('bu023','VRL Travels','Mumbai','Pune','["Khopoli"]','2025-06-10','22:00','01:00','3h 00m','AC Sleeper',499,32),
('bu024','VRL Luxury','Bangalore','Goa','["Hubli","Dharwad","Belgaum"]','2025-06-10','20:00','06:00','10h 00m','Luxury Sleeper',1599,28),
('bu025','KSRTC Airavat','Bangalore','Goa','["Dharwad","Belgaum"]','2025-06-10','20:30','06:30','10h 00m','Volvo AC',1299,45),
('bu026','Paulo Travels','Bangalore','Goa','["Hubli","Belgaum"]','2025-06-10','19:00','05:00','10h 00m','AC Sleeper',1099,32),
('bu027','Parveen Travels','Bangalore','Goa','["Hubli","Dharwad","Belgaum","Londa"]','2025-06-10','18:00','05:00','11h 00m','AC Sleeper',999,36),
('bu028','SRS Gold','Bangalore','Goa','["Hubli","Belgaum"]','2025-06-10','21:00','07:00','10h 00m','Non-AC Sleeper',799,40),
('bu029','Orange Travels','Bangalore','Goa','["Dharwad","Belgaum"]','2025-06-10','21:30','07:30','10h 00m','AC Seater',849,44),
('bu030','KPN Travels','Bangalore','Goa','["Hubli","Dharwad","Belgaum"]','2025-06-10','22:00','08:00','10h 00m','Volvo AC',1199,36),
('bu031','KSRTC Express','Bangalore','Goa','["Dharwad","Belgaum"]','2025-06-10','22:30','08:30','10h 00m','Non-AC Seater',649,55),
('bu032','Chintamani','Bangalore','Goa','["Hubli","Dharwad","Belgaum","Londa"]','2025-06-10','17:00','04:00','11h 00m','Non-AC Sleeper',749,40),
('bu033','Raj National','Bangalore','Goa','["Dharwad","Belgaum"]','2025-06-10','23:00','09:00','10h 00m','AC Sleeper',949,32),
('bu034','IntrCity Smart','Bangalore','Goa','["Hubli","Belgaum"]','2025-06-10','19:30','05:30','10h 00m','Volvo AC',1399,36),
('bu035','KSRTC Airavat','Chennai','Bangalore','["Krishnagiri","Hosur"]','2025-06-10','22:00','06:00','8h 00m','Volvo AC',899,45),
('bu036','Orange Travels','Chennai','Bangalore','["Krishnagiri","Hosur"]','2025-06-10','21:00','05:30','8h 30m','AC Sleeper',799,32),
('bu037','SRS Travels','Chennai','Bangalore','["Krishnagiri"]','2025-06-10','20:00','04:00','8h 00m','Luxury Sleeper',1199,24),
('bu038','TNSTC Deluxe','Chennai','Bangalore','["Krishnagiri","Hosur","Electronic City"]','2025-06-10','23:00','07:30','8h 30m','Non-AC Seater',399,60),
('bu039','Paulo Travels','Chennai','Bangalore','["Krishnagiri","Hosur"]','2025-06-10','22:30','06:30','8h 00m','AC Seater',699,44),
('bu040','KPN Travels','Chennai','Bangalore','["Krishnagiri","Hosur"]','2025-06-10','21:30','05:30','8h 00m','Volvo AC',849,36),
('bu041','Raj National','Chennai','Bangalore','["Vellore","Krishnagiri","Hosur"]','2025-06-10','20:30','05:30','9h 00m','Non-AC Sleeper',549,40),
('bu042','IntrCity Smart','Chennai','Bangalore','["Krishnagiri"]','2025-06-10','23:30','07:30','8h 00m','Luxury Sleeper',1099,28),
('bu043','Chintamani','Chennai','Bangalore','["Vellore","Krishnagiri","Hosur"]','2025-06-10','19:00','04:00','9h 00m','AC Sleeper',749,32),
('bu044','Parveen Travels','Chennai','Bangalore','["Krishnagiri","Hosur","Electronic City"]','2025-06-10','22:00','06:30','8h 30m','AC Seater',649,44),
('bu045','Greenways','Chennai','Bangalore','["Vellore","Krishnagiri","Hosur"]','2025-06-10','20:00','05:00','9h 00m','Non-AC Seater',349,55);

-- ROUTE GRAPH
INSERT INTO route_graph (city_from,city_to,distance_km,base_price,transport_type,duration_mins,stops_count) VALUES
('Delhi','Mumbai',1400,3499,'flight',140,0),('Delhi','Goa',1900,5299,'flight',155,0),
('Delhi','Bangalore',2100,5499,'flight',165,0),('Delhi','Chennai',2200,4199,'flight',175,0),
('Delhi','Kolkata',1500,3999,'flight',165,0),('Delhi','Hyderabad',1500,3999,'flight',150,0),
('Mumbai','Goa',600,2999,'flight',75,0),('Mumbai','Bangalore',1000,3299,'flight',110,0),
('Mumbai','Chennai',1350,3799,'flight',125,0),('Bangalore','Kolkata',1900,4799,'flight',185,0),
('Bangalore','Chennai',350,2499,'flight',60,0),('Chennai','Kolkata',1700,4299,'flight',170,0),
('Hyderabad','Mumbai',800,3299,'flight',95,0),('Hyderabad','Bangalore',600,2799,'flight',80,0),
('Delhi','Mumbai',1400,1850,'train',920,3),('Delhi','Agra',200,750,'train',130,0),
('Delhi','Jaipur',280,600,'train',190,2),('Delhi','Varanasi',800,1200,'train',480,2),
('Delhi','Kolkata',1500,2100,'train',1020,3),('Mumbai','Goa',600,1500,'train',540,3),
('Mumbai','Pune',150,350,'train',180,1),('Chennai','Bangalore',350,550,'train',295,3),
('Delhi','Jaipur',280,599,'bus',330,3),('Mumbai','Pune',150,499,'bus',180,2),
('Bangalore','Goa',570,1099,'bus',600,3),('Chennai','Bangalore',350,799,'bus',480,2);

INSERT INTO route_graph (city_from,city_to,distance_km,base_price,transport_type,duration_mins,stops_count)
SELECT city_to,city_from,distance_km,base_price,transport_type,duration_mins,stops_count FROM route_graph;

-- SEATS
INSERT INTO seats (transport_id,transport_type,travel_class,seat_number,seat_category) VALUES
('fl001','flight','Economy','1A','disability'),('fl001','flight','Economy','1B','disability'),
('fl001','flight','Economy','2A','senior'),('fl001','flight','Economy','2B','senior'),('fl001','flight','Economy','2C','senior'),
('fl001','flight','Economy','3A','female'),('fl001','flight','Economy','3B','female'),('fl001','flight','Economy','3C','female'),
('fl001','flight','Economy','4A','general'),('fl001','flight','Economy','4B','general'),('fl001','flight','Economy','4C','general'),
('fl001','flight','Business','1A','disability'),('fl001','flight','Business','2A','senior'),
('fl001','flight','Business','3A','female'),('fl001','flight','Business','4A','general'),
('tr001','train','3AC','1A','disability'),('tr001','train','3AC','1B','disability'),
('tr001','train','3AC','2A','senior'),('tr001','train','3AC','2B','senior'),
('tr001','train','3AC','3A','female'),('tr001','train','3AC','3B','female'),
('tr001','train','3AC','4A','general'),('tr001','train','3AC','4B','general'),
('bu001','bus','Volvo AC','L1','disability'),('bu001','bus','Volvo AC','L2','female'),
('bu001','bus','Volvo AC','U1','senior'),('bu001','bus','Volvo AC','U2','general');
