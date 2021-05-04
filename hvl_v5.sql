/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ hvl /*!40100 DEFAULT CHARACTER SET utf8 */;
USE hvl;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES(1,'baby-poney',30,120),(2,'eveil-poney',30,32),(3,'6+',30,100),(4,'adulte',110,15),(5,'privilege',5,12),(6,'stage',45,45),(7,'formation',2,80);
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'Un pantalon long'),(2,'Un short de fils-à-papa'),(3,'Le petit polo rose pale de fils-à-papa'),(4,'Un sandwich à la fraise'),(5,'Un bob');
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_equipment`
--

DROP TABLE IF EXISTS `activity_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_equipment` (
  `activity_id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL,
  KEY `fk_Course_Equipment_Activity_id` (`activity_id`),
  KEY `fk_Course_Equipment_Equipment_id` (`equipment_id`),
  CONSTRAINT `fk_Course_Equipment_Activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Course_Equipment_Equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_equipment`
--

LOCK TABLES `activity_equipment` WRITE;
/*!40000 ALTER TABLE `activity_equipment` DISABLE KEYS */;
INSERT INTO `activity_equipment` VALUES (1,3),(1,2),(2,5),(2,4),(3,3),(4,2),(5,5),(5,4),(5,3),(6,2),(7,5),(7,4);
/*!40000 ALTER TABLE `activity_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `last_connexion` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin','admin@hvl.com','$2y$10$l1xaL4wBimytTdh/C8GuquIw8K1tkmTrmx5S.D0W9vrByX7GSe7b.','2021-04-20 01:00:00');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `subject` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,'Michel','Céleubrézil','m@c.fr','don','cadeau de 1 euros'),(2,'Lionel','Guyau','lguyau@gmail.com','fdfsd','fsdfsdf');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Lionel','Guyau','l@g.fr'),(2,'Stéphanie','Mariani','s@m.fr'),(3,'Quentin','Burty','q@b.fr'),(4,'Pierre-Jean','Touraille','pj@t.fr'),(5,'Lionel','Guyau','lguyau@gmail.com');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `planning`
--

DROP TABLE IF EXISTS `planning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planning` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `activity_id` int(11) NOT NULL,
  `start_at` datetime NOT NULL,
  `end_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Planning_Activity_id` (`activity_id`),
  CONSTRAINT `Delete_Planning_Activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `planning`
--

LOCK TABLES `planning` WRITE;
/*!40000 ALTER TABLE `planning` DISABLE KEYS */;
INSERT INTO planning(id,activity_id,description,start_at,end_at) VALUES(1,1,'Premier cours','2021-04-20 01:00:00','2021-04-20 02:00:00'),(2,1,'Cours n°1','2021-04-20 02:00:00','2021-04-21 02:00:00'),(3,2,'cours n3','2021-04-20 03:00:00','2021-04-22 04:00:00'),(4,3,'cours n4','2021-05-20 04:00:00','2021-05-20 05:00:00'),(5,4,'cours n5','2021-04-21 05:00:00','2021-04-21 06:00:00'),(6,5,'cours n6','2021-05-21 06:00:00','2021-04522 07:00:00'),(7,6,'cours n7','2021-05-22 07:00:00','2021-05-25 08:00:00'),(8,7,'cours n8','2021-05-13 08:00:00','2021-05-27 09:00:00');
/*!40000 ALTER TABLE `planning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_planning`
--

DROP TABLE IF EXISTS `customer_planning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_planning` (
  `customer_id` int(11) NOT NULL,
  `planning_id` int(11) NOT NULL,
  `register` tinyint(1) NOT NULL,
  KEY `fk_Customer_planning_Customer_id` (`customer_id`),
  KEY `fk_Customer_planning_Planning_id` (`planning_id`),
  CONSTRAINT `fk_Customer_planning_Customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Customer_planning_Planning_id` FOREIGN KEY (`planning_id`) REFERENCES `planning` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_planning`
--

LOCK TABLES `customer_planning` WRITE;
/*!40000 ALTER TABLE `customer_planning` DISABLE KEYS */;
INSERT INTO `customer_planning` VALUES (1,1,1),(2,1,1),(3,1,1),(4,1,1),(1,4,1),(1,5,1),(1,6,1),(1,7,1),(1,8,1),(2,6,0),(5,1,1);
/*!40000 ALTER TABLE `customer_planning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `news_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,'Pas de boogie-woogie avant les prières ce soir','2021-04-22 00:00:00'),(2,'COVID : Pas de cours après 19h','2021-04-30 09:49:43'),(3,'Les cours sont maintenus pendant le confinement','2021-04-27 00:00:00'),(4,'Pensez à prendre ses équipements personnels pour des raisons d\'hygiène','2021-04-26 00:00:00');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop`
--

DROP TABLE IF EXISTS `shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `size` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `color` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop`
--

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` VALUES (1,'Doudoune sans manches','Pratique, chaude et ultra confortable',10,'M','blouge'),(2,'La vete Teddy','L\'indémodable',5,'L','vert kaki'),(3,'Le softshell','Coupe-vent respirant',2,'S','jaune fluo');
/*!40000 ALTER TABLE `shop` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-30 11:44:04