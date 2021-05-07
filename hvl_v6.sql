/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE="+00:00" */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;
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
  `name` varchar(50) COLLATE utf8_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_equipment`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` (`id`, `type`, `capacity`, `price`, `name`, `description`) VALUES
(1, "cours", 10, 40, "baby-poney", "À poney, c'est l'enfant qui joue le coup de la séparation avec son parent, c'est lui qui le lâche."),
(2, "cours", 10, 25, "eveil-poney", "Les enfants prendront un premier contact avec les poneys en les brossant."),
(3, "cours", 15, 25, "6+", "Pendant la première année d'équitation, l’objectif est d’arriver à se déplacer au pas et au trot."),
(4, "cours", 8, 30, "adulte", "Découvrez, recommencez ou perfectionnez-vous, il n’y pas d’âge pour profiter du cheval."),
(5, "cours", 5, 18, "privilege", "A partir du Galop 3 : Vous avez la possibilité de monter votre équidé préféré."),
(6, "stage", 12, 249, "", "Il s'agit de s'immerger dans le monde des équidés en participant à la vie du Haras."),
(7, "formation", 2, 7500, "", "L’Animateur Equitation est un titre professionnel permettant de travailler en tant que salarié.");
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
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
INSERT INTO `admin` (`id`, `firstname`, `lastname`, `email`, `password`, `last_connexion`) VALUES
(1, "admin", "admin", "admin@hvl.com", "$2y$10$l1xaL4wBimytTdh/C8GuquIw8K1tkmTrmx5S.D0W9vrByX7GSe7b.", "2021-04-20 01:00:00");
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
  `number` int(11) NOT NULL,
  `subject` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


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
INSERT INTO `customer` (`id`, `firstname`, `lastname`, `email`) VALUES
(1, "Lionel", "Guyau", "l@g.fr"),
(2, "Stéphanie", "Mariani", "s@m.fr"),
(3, "Quentin", "Burty", "q@b.fr"),
(4, "Pierre-Jean", "Touraille", "pj@t.fr"),
(5, "Lionel", "Guyau", "lguyau@gmail.com");
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
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
INSERT INTO `equipment` (`id`, `description`) VALUES
(1, "Pantalon d'équitation"),
(2, "Chaussettes hautes"),
(3, "Chaussures fermées"),
(4, "Bottes d'équitation"),
(5, "Casque/Bombe"),
(6, "Gilet de protection"),
(7, "Gants"),
(8, "Pantalon long"),
(9, "Pique-nique & goûter");
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
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
INSERT INTO `news` (`id`, `description`, `news_date`) VALUES
(1, "Ouvert pendant le confinement", "2021-05-06 09:57:01"),
(2, "Les garderies du soir sont suspendues le temps du couvre-feu", "2021-05-06 09:57:03"),
(3, "Cours, stages, baby-poney maintenus", "2021-05-06 09:57:38");
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
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
INSERT INTO `planning` (`id`, `description`, `activity_id`, `start_at`, `end_at`) VALUES
(1, "Galop 3/4 Ados", 3, "2021-05-04 18:00:00", "2021-05-04 19:30:00"),
(2, "Galop 2/4 Adulte", 4, "2021-05-04 19:00:00", "2021-05-04 21:00:00"),
(3, "Poney Argent/Or", 1, "2021-05-05 09:00:00", "2021-05-05 10:15:00"),
(4, "Eveil Poney", 2, "2021-05-05 10:30:00", "2021-05-05 11:00:00"),
(5, "Poney Débutant/Bronze", 1, "2021-05-05 11:00:00", "2021-05-05 12:15:00"),
(6, "Galot Bronze/Argent", 3, "2021-05-05 13:30:00", "2021-05-05 14:45:00"),
(7, "Galot 2/3 Ados", 3, "2021-05-05 14:45:00", "2021-05-05 16:00:00"),
(8, "Eveil poney", 2, "2021-05-05 16:15:00", "2021-05-05 16:45:00"),
(9, "Poney Argent/Or", 1, "2021-05-05 17:00:00", "2021-05-05 18:15:00"),
(10, "Galot 1/2 Ados", 3, "2021-05-05 18:00:00", "2021-05-05 19:30:00"),
(11, "Galot 6/7 Adulte", 4, "2021-05-05 18:00:00", "2021-05-05 21:00:00"),
(12, "Galot Débutant/1", 1, "2021-05-05 13:30:00", "2021-05-05 14:15:00"),
(13, "Poney Débutant/Bronze/Argent", 1, "2021-05-05 14:45:00", "2021-05-05 16:00:00"),
(14, "Galot 6/7 Competition Ados", 3, "2021-05-05 16:00:00", "2021-05-05 18:00:00"),
(15, "Galot 3/4 Ados", 3, "2021-05-06 18:00:00", "2021-05-06 19:30:00"),
(16, "Débutant Ados/adulte", 4, "2021-05-06 19:00:00", "2021-05-06 21:00:00"),
(17, "Galot 2/3 Ados", 3, "2021-05-07 18:00:00", "2021-05-07 19:30:00"),
(18, "Galot 4/5 Ados", 3, "2021-05-07 19:00:00", "2021-05-07 21:00:00"),
(19, "Poney Argent/Or", 1, "2021-05-08 09:00:00", "2021-05-08 10:15:00"),
(20, "Eveil Poney", 2, "2021-05-08 10:30:00", "2021-05-08 11:00:00"),
(21, "Poney Bronze/Argent", 1, "2021-05-08 11:00:00", "2021-05-08 12:15:00"),
(22, "Galot Bronze/Argent", 3, "2021-05-08 13:30:00", "2021-05-08 14:45:00"),
(23, "Poney Débutant/Bronze", 1, "2021-05-08 14:45:00", "2021-05-08 16:00:00"),
(24, "Eveil Poney", 2, "2021-05-08 16:15:00", "2021-05-08 16:45:00"),
(25, "Débutant", 1, "2021-05-08 09:00:00", "2021-05-08 10:15:00"),
(26, "Galot 5/7 Compétition Ados/Adultes", 4, "2021-05-08 10:30:00", "2021-05-08 12:15:00"),
(27, "Galot 5/7 Compétition Ados/Adultes", 4, "2021-05-08 12:15:00", "2021-05-08 14:00:00"),
(28, "Cheval privilege", 5, "2021-05-08 14:00:00", "2021-05-08 17:00:00"),
(29, "stage de préparation", 6, "2021-05-08 09:00:00", "2021-05-08 17:00:00"),
(30, "animateur équestre", 7, "2021-05-04 09:00:00", "2021-05-08 17:00:00");
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
INSERT INTO `customer_planning` (`customer_id`, `planning_id`, `register`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(1, 6, 1),
(2, 7, 1),
(3, 8, 1),
(4, 9, 1),
(5, 10, 1),
(1, 11, 1),
(2, 12, 1),
(3, 13, 1),
(4, 14, 1),
(5, 15, 1),
(1, 16, 1),
(2, 17, 1),
(3, 18, 1),
(4, 19, 1),
(5, 20, 1),
(1, 21, 1),
(2, 22, 1),
(3, 23, 1),
(4, 24, 1),
(5, 25, 1),
(1, 26, 1),
(2, 27, 1),
(3, 28, 1),
(4, 29, 1),
(5, 30, 1);
/*!40000 ALTER TABLE `customer_planning` ENABLE KEYS */;
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
INSERT INTO `activity_equipment` (`activity_id`, `equipment_id`) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 4),
(2, 5),
(3, 1),
(3, 3),
(3, 4),
(3, 5),
(4, 1),
(4, 4),
(4, 5),
(4, 6),
(5, 1),
(5, 4),
(5, 5),
(5, 6),
(6, 1),
(6, 4),
(6, 5),
(6, 9),
(7, 1),
(7, 4),
(7, 5),
(7, 6),
(7, 7);
/*!40000 ALTER TABLE `activity_equipment` ENABLE KEYS */;
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
  `description` text COLLATE utf8_unicode_520_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `size` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Dumping data for table `shop`
--

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` (`id`, `name`, `description`, `quantity`, `size`, `price`) VALUES
(1, "Doudoune sans manches", "Pratique, chaude et ultra légère", 10, "XS-S-M-L-XL", 60),
(2, "La vete Teddy", "L'indémodable", 5, "12-14", 40),
(3, "Le softshell", "Coupe-vent respirant", 2, "XS-S-M-L-XL", 45),
(4, "Le polo", "Idéal pour l'été", 2, "XS-S-M-L-XL", 20),
(5, "Le softshell à capuche", "Coupe-vent respirant", 2, "XS-S-M-L-XL", 45),
(6, "Le sweat à capuche", "Le préféré des ados", 2, "XS-S-M-L-XL", 35);
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
