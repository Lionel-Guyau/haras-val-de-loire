/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ hvl /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE hvl;

DROP TABLE IF EXISTS admin;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `last_connexion` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS contact;
CREATE TABLE `contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `message` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS course;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `default_price` int NOT NULL,
  `capacity` int NOT NULL,
  `start_at` datetime NOT NULL,
  `end_at` datetime DEFAULT NULL,
  `price` int DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `duration` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Price_id_Course_Type` (`default_price`),
  CONSTRAINT `fk_Price_id_Course_Type` FOREIGN KEY (`default_price`) REFERENCES `price` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS course_equipment;
CREATE TABLE `course_equipment` (
  `course_id` int NOT NULL,
  `equipment_id` int NOT NULL,
  KEY `fk_Course_Equipment_stage_id` (`course_id`),
  KEY `fk_Course_Equipment_equipment_id` (`equipment_id`),
  CONSTRAINT `fk_Course_Equipment_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `fk_Course_Equipment_stage_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS course_news;
CREATE TABLE `course_news` (
  `course_id` int NOT NULL,
  `news_id` int NOT NULL,
  KEY `fk_Course_News_Course_id` (`course_id`),
  KEY `fk_Course_News_News_id` (`news_id`),
  CONSTRAINT `fk_Course_News_Course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_Course_News_News_id` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS customer;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS customer_course;
CREATE TABLE `customer_course` (
  `customer_id` int NOT NULL,
  `course_id` int NOT NULL,
  `register` tinyint(1) NOT NULL,
  KEY `fk_Clients_Course_client_id` (`customer_id`),
  KEY `fk_Clients_Course_stage_id` (`course_id`),
  CONSTRAINT `fk_Clients_Course_client_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_Clients_Course_stage_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS customer_lesson;
CREATE TABLE `customer_lesson` (
  `customer_id` int NOT NULL,
  `lesson_id` int NOT NULL,
  `register` tinyint(1) NOT NULL,
  KEY `fk_Clients_Lesson_client_id` (`customer_id`),
  KEY `fk_Clients_Lesson_cours_id` (`lesson_id`),
  CONSTRAINT `fk_Clients_Lesson_client_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_Clients_Lesson_stage_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS equipment;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `desciption` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `season` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS lesson;
CREATE TABLE `lesson` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `default_price` int NOT NULL,
  `capacity` int NOT NULL,
  `start_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_at` datetime DEFAULT NULL,
  `price` int DEFAULT NULL,
  `is_active` tinyint NOT NULL,
  `duration` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Price_id_Lesson_Type` (`default_price`),
  CONSTRAINT `fk_Price_id_Lesson_Type` FOREIGN KEY (`default_price`) REFERENCES `price` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS lesson_equipment;
CREATE TABLE `lesson_equipment` (
  `lesson_id` int NOT NULL,
  `equipment_id` int NOT NULL,
  KEY `fk_Lesson_Equipment_cours_id` (`lesson_id`),
  KEY `fk_Lesson_Equipment_equipment_id` (`equipment_id`),
  CONSTRAINT `fk_Lesson_Equipment_cours_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`),
  CONSTRAINT `fk_Lesson_Equipment_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS lesson_news;
CREATE TABLE `lesson_news` (
  `lesson_id` int NOT NULL,
  `news_id` int NOT NULL,
  KEY `fk_Lesson_News_Lesson_id` (`lesson_id`),
  KEY `fk_Lesson_News_News_id` (`news_id`),
  CONSTRAINT `fk_Lesson_News_Lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`),
  CONSTRAINT `fk_Lesson_News_News_id` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS news;
CREATE TABLE `news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `news_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS planning;
CREATE TABLE `planning` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_at` datetime NOT NULL,
  `end_at` datetime NOT NULL,
  `course_id` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Planning_Course_id` (`course_id`),
  KEY `fk_Planning_Lesson_id` (`lesson_id`),
  CONSTRAINT `fk_Planning_Course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_Planning_Lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS price;
CREATE TABLE `price` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` varchar(11) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

DROP TABLE IF EXISTS shop;
CREATE TABLE `shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `quantity` int NOT NULL,
  `size` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;




INSERT INTO admin(id,firstname,lastname,email,password,last_connexion) VALUES(1,'admin_1','admin_1','admin-1@mail.com','admin1','2021-04-20 01:00:00'),(2,'admin_2','admin_2','admin-2@mail.com','admin2','2021-05-13 02:00:00');

INSERT INTO contact(id,firstname,lastname,email,subject,message) VALUES(1,'Michel','Céleubrézil','michou@mail.com','don','cadeau de 5 euros');

INSERT INTO course(id,name,default_price,capacity,start_at,end_at,price,is_active,duration) VALUES(1,'stage_1',1,30,'2021-05-13 01:00:01',NULL,NULL,1,'01:00:00'),(2,'stage_2',2,30,'2021-05-13 02:00:01',NULL,NULL,0,'01:00:00'),(3,'stage_3',3,30,'2021-05-13 03:00:01',NULL,NULL,1,'01:00:00'),(4,'stage_4',3,1,'2021-05-13 04:00:01',NULL,NULL,1,'01:00:00'),(5,'stage_5',3,30,'2021-04-20 05:00:01',NULL,NULL,1,'01:00:00'),(6,'stage_6',3,30,'2021-04-20 06:00:01',NULL,NULL,0,'01:00:00'),(7,'stage_7',3,30000000,'2021-05-13 07:00:01',NULL,NULL,1,'01:00:00'),(8,'stage_8',3,30,'2021-05-13 08:00:01',NULL,1000,1,'01:00:00'),(9,'stage_9',3,30,'2021-05-13 09:00:01','2021-05-14 00:00:00',NULL,1,'01:00:00'),(10,'stage_10',3,30,'2021-05-13 10:00:01','2021-04-20 00:00:00',NULL,1,'01:00:00');

INSERT INTO course_equipment(course_id,equipment_id) VALUES(2,2),(3,3),(4,4),(4,5),(5,5);

INSERT INTO course_news(course_id,news_id) VALUES(2,2),(3,3),(4,4),(4,5),(5,5);

INSERT INTO customer(id,firstname,lastname,email) VALUES(1,'Lionel','Guyau','lguyau@gmail.com'),(2,'Stéphanie','Mariani','stephanie.mariani31@gmail.com'),(3,'Quentin','Burty','quentin.burty@gmail.com'),(4,'Pierre-Jean','Touraille','pierrejean.touraille.jobs@gmail.com');

INSERT INTO customer_course(customer_id,course_id,register) VALUES(1,1,1),(1,2,1),(1,3,1),(1,4,1),(2,1,1),(2,2,1),(2,3,1),(2,4,0),(3,1,1),(3,2,1),(3,3,0),(3,4,0),(4,1,1),(4,2,0),(4,3,0),(4,4,0);

INSERT INTO customer_lesson(customer_id,lesson_id,register) VALUES(1,1,1),(1,2,1),(1,3,1),(1,4,1),(2,1,1),(2,2,1),(2,3,1),(2,4,0),(3,1,1),(3,2,1),(3,3,0),(3,4,0),(4,1,1),(4,2,0),(4,3,0),(4,4,0);

INSERT INTO equipment(id,desciption,season) VALUES(1,'Un pantalon long\r\nDes chaussettes hautes mises par dessus le pantalon\r\nDes chaussures fermées ou bottes de pluie\r\nLe casque aux normes en vigueur est prêté par le Haras du Val de Loire',NULL),(2,'Un pantalon d\'équitation\r\nDes boots et chaps ou bottes d\'équitation\r\nUn casque/bombe aux normes européennes\r\nUn gilet de protection à partir du galop 5',NULL),(3,'N\'hésitez pas à habiller vos petits bouts en tenue de ski (pantalon et chaussures).\r\nN\'oubliez pas les gants, c\'est un sport d\'extérieur !!','hiver'),(4,'Un pique-nique pour le midi, à réchauffer ou non, il y a 4 micro-ondes\r\nDes couverts et assiette si besoin.\r\nUn goûter pour le 4 heures\r\nUne paire de crocs ou tong pour le midi\r\nDes mouchoirs en papier','été'),(5,'Un pique-nique pour le midi, à réchauffer ou non, il y a 4 micro-ondes\r\nDes couverts et assiette si besoin.\r\nUn goûter pour le 4 heures\r\nDes gants\r\nDes mouchoirs en papier','hiver');

INSERT INTO lesson(id,name,default_price,capacity,start_at,end_at,price,is_active,duration) VALUES(1,'cours_1',1,30,'2021-05-13 01:00:00',NULL,NULL,1,'01:00:00'),(2,'cours_2',2,30,'2021-05-13 02:00:00',NULL,NULL,0,'01:00:00'),(3,'cours_3',3,30,'2021-05-13 03:00:00',NULL,NULL,1,'01:00:00'),(4,'cours_4',3,1,'2021-05-13 04:00:00',NULL,NULL,1,'01:00:00'),(5,'cours_5',3,30,'2021-04-20 05:00:00',NULL,NULL,1,'01:00:00'),(6,'cours_6',3,30,'2021-04-20 06:00:00',NULL,NULL,0,'01:00:00'),(7,'cours_7',3,30000000,'2021-05-13 07:00:00',NULL,NULL,1,'01:00:00'),(8,'cours_8',3,30,'2021-05-13 08:00:00',NULL,1000,1,'01:00:00'),(9,'cours_9',3,30,'2021-05-13 09:00:00','2021-05-14 00:00:00',NULL,1,'01:00:00'),(10,'cours_10',3,30,'2021-05-13 10:00:00','2021-04-20 10:00:00',NULL,1,'01:00:00');

INSERT INTO lesson_equipment(lesson_id,equipment_id) VALUES(2,2),(3,3),(4,4),(4,5),(5,5);

INSERT INTO lesson_news(lesson_id,news_id) VALUES(2,2),(3,3),(4,4),(4,5),(5,4);

INSERT INTO news(id,description,news_date) VALUES(1,'information_1','2021-05-13'),(2,'information_2','2021-05-14'),(3,'information_3','2021-04-20'),(4,'information_4','2021-05-15'),(5,'information_5','2021-05-16');

INSERT INTO planning(id,start_at,end_at,course_id,lesson_id) VALUES(1,'2021-04-24 00:00:00','2021-04-24 00:00:00',1,NULL),(2,'2021-04-27 00:00:00','2021-04-27 00:00:00',NULL,1),(3,'2021-04-26 00:00:00','2021-04-26 00:00:00',NULL,2);

INSERT INTO price(id,price) VALUES(1,'1'),(2,'4'),(3,'9'),(4,'16'),(5,'25');
INSERT INTO shop(id,name,description,quantity,size,color) VALUES(1,'Doudoune sans manches','Pratique, chaude et ultra légère.\r\nMatière résistante, souple et facile d\'entretien.\r\nCompressible dans son sac de rangement.',10,'M','blouge'),(2,'La veste Teddy','L\'indémodable Teddy inspiré des universités américaines.\r\nConfort optimal.',5,'L','vert'),(3,'Le softshell','Coupe-vent respirant et imperméable, idéal pour la mi-saison.',2,'S','jaune');







/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;