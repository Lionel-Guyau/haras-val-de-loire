/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ hvl_test /*!40100 DEFAULT CHARACTER SET utf8 */;
USE hvl_test;

DROP TABLE IF EXISTS activity;
CREATE TABLE `activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci DEFAULT NULL,
  `type` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `capacity` int NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS activity_equipment;
CREATE TABLE `activity_equipment` (
  `activity_id` int NOT NULL,
  `equipment_id` int NOT NULL,
  KEY `fk_Course_Equipment_Activity_id` (`activity_id`),
  KEY `fk_Course_Equipment_Equipment_id` (`equipment_id`),
  CONSTRAINT `fk_Course_Equipment_Activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`),
  CONSTRAINT `fk_Course_Equipment_Equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS admin;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `last_connexion` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS contact;
CREATE TABLE `contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `subject` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS customer;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS customer_planning;
CREATE TABLE `customer_planning` (
  `customer_id` int NOT NULL,
  `planning_id` int NOT NULL,
  `register` tinyint(1) NOT NULL,
  KEY `fk_Customer_planning_Customer_id` (`customer_id`),
  KEY `fk_Customer_planning_Planning_id` (`planning_id`),
  CONSTRAINT `fk_Customer_planning_Customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_Customer_planning_Planning_id` FOREIGN KEY (`planning_id`) REFERENCES `planning` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS equipment;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `desciption` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS news;
CREATE TABLE `news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `news_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS planning;
CREATE TABLE `planning` (
  `id` int NOT NULL AUTO_INCREMENT,
  `activity_id` int NOT NULL,
  `start_at` datetime NOT NULL,
  `end_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Planning_Activity_id` (`activity_id`),
  CONSTRAINT `fk_Planning_Activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS shop;
CREATE TABLE `shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `quantity` int NOT NULL,
  `size` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `color` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;




INSERT INTO activity(id,name,type,capacity,price) VALUES(1,'','baby-poney',30,120),(2,'','eveil-poney',30,32),(3,'','6+',30,1000000),(4,'','adulte',5000000,1),(5,'','privilege',1,12),(6,'ete','stage',45,45),(7,'animateur d\'équitation','formation',2,79846);

INSERT INTO activity_equipment(activity_id,equipment_id) VALUES(1,1),(2,2),(3,3),(3,4),(4,4);

INSERT INTO admin(id,firstname,lastname,email,password,last_connexion) VALUES(1,'admin1','admin1','a1@a1.fr','admin1','2021-04-20 01:00:00'),(2,'admin2','admin2','a2@a2.fr','admin2','2021-04-13 02:00:00');

INSERT INTO contact(id,firstname,lastname,email,subject,message) VALUES(1,'Michel','Céleubrézil','m@c.fr','don','cadeau de 1 euros');

INSERT INTO customer(id,firstname,lastname,email) VALUES(1,'Lionel','Guyau','l@g.fr'),(2,'Stéphanie','Mariani','s@m.fr'),(3,'Quentin','Burty','q@b.fr'),(4,'Pierre-Jean','Touraille','pj@t.fr');

INSERT INTO customer_planning(customer_id,planning_id,register) VALUES(1,5,1),(2,5,1),(3,5,1),(4,5,1),(1,8,1),(1,9,1),(1,10,1),(1,11,1),(1,12,1),(2,10,0);

INSERT INTO equipment(id,desciption) VALUES(1,'Un pantalon long'),(2,'Un short de fils-à-papa'),(3,'Le petit polo rose pale de fils-à-papa'),(4,'Un sandwich à la fraise');

INSERT INTO news(id,description,news_date) VALUES(1,'Pas de boogie-woogie avant les prières ce soir','2021-04-22 00:00:00'),(2,'COVID : Pas de cours après 19h','2021-04-28 00:00:00'),(3,'Les cours sont maintenus pendant le confinement','2021-04-27 00:00:00'),(4,'Pensez à prendre ses équipements personnels pour des raisons d\'hygiène','2021-04-26 00:00:00');

INSERT INTO planning(id,activity_id,start_at,end_at) VALUES(5,1,'2021-04-20 01:00:00','2021-04-20 02:00:00'),(6,1,'2021-04-20 02:00:00','2021-04-21 02:00:00'),(7,2,'2021-04-20 03:00:00','2021-04-22 04:00:00'),(8,3,'2021-05-20 04:00:00','2021-05-20 05:00:00'),(9,4,'2021-04-21 05:00:00','2021-04-21 06:00:00'),(10,5,'2021-05-21 06:00:00','2021-04522 07:00:00'),(11,6,'2021-05-22 07:00:00','2021-05-25 08:00:00'),(12,7,'2021-05-13 08:00:00','2021-05-27 09:00:00');

INSERT INTO shop(id,name,description,quantity,size,color) VALUES(1,'Doudoune sans manches','Pratique, chaude et ultra confortable',10,'M','blouge'),(2,'La vete Teddy','L\'indémodable',5,'L','vert kaki'),(3,'Le softshell','Coupe-vent respirant',2,'S','jaune fluo');







/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;