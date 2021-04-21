-- phpMyAdmin SQL Dump
-- version 4.9.7deb1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mer. 21 avr. 2021 à 21:13
-- Version du serveur :  10.3.25-MariaDB-0ubuntu1
-- Version de PHP : 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hvl`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `password` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `last_connexion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `default_price` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `start_at` datetime NOT NULL,
  `end_at` date DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL,
  `duration` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `course`
--

INSERT INTO `course` (`id`, `name`, `default_price`, `capacity`, `start_at`, `end_at`, `price`, `is_active`, `duration`) VALUES
(1, 'Stage', 5, 10, '2021-04-24 00:00:00', NULL, NULL, 1, '09:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `course_equipment`
--

CREATE TABLE `course_equipment` (
  `course_id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `course_equipment`
--

INSERT INTO `course_equipment` (`course_id`, `equipment_id`) VALUES
(1, 1),
(1, 2),
(1, 5);

-- --------------------------------------------------------

--
-- Structure de la table `course_news`
--

CREATE TABLE `course_news` (
  `course_id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `course_news`
--

INSERT INTO `course_news` (`course_id`, `news_id`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `customer`
--

INSERT INTO `customer` (`id`, `firstname`, `lastname`, `email`) VALUES
(1, 'Lionel', 'Guyau', 'lguyau@gmail.com'),
(2, 'Stéphanie', 'Mariani', 'stephanie.mariani31@gmail.com'),
(3, 'Quentin', 'Burty', 'quentin.burty@gmail.com'),
(4, 'Pierre-Jean', 'Touraille', 'pierrejean.touraille.jobs@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `customer_course`
--

CREATE TABLE `customer_course` (
  `customer_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `register` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `customer_course`
--

INSERT INTO `customer_course` (`customer_id`, `course_id`, `register`) VALUES
(1, 1, 1),
(3, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `customer_lesson`
--

CREATE TABLE `customer_lesson` (
  `customer_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `register` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `customer_lesson`
--

INSERT INTO `customer_lesson` (`customer_id`, `lesson_id`, `register`) VALUES
(4, 2, 1),
(2, 5, 1),
(1, 2, 1),
(2, 2, 0),
(3, 2, 1),
(2, 6, 1);

-- --------------------------------------------------------

--
-- Structure de la table `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11) NOT NULL,
  `desciption` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `season` varchar(20) COLLATE utf8_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `equipment`
--

INSERT INTO `equipment` (`id`, `desciption`, `season`) VALUES
(1, 'Un pantalon long\r\nDes chaussettes hautes mises par dessus le pantalon\r\nDes chaussures fermées ou bottes de pluie\r\nLe casque aux normes en vigueur est prêté par le Haras du Val de Loire', NULL),
(2, 'Un pantalon d\'équitation\r\nDes boots et chaps ou bottes d\'équitation\r\nUn casque/bombe aux normes européennes\r\nUn gilet de protection à partir du galop 5', NULL),
(3, 'N\'hésitez pas à habiller vos petits bouts en tenue de ski (pantalon et chaussures).\r\nN\'oubliez pas les gants, c\'est un sport d\'extérieur !!', 'hiver'),
(4, 'Un pique-nique pour le midi, à réchauffer ou non, il y a 4 micro-ondes\r\nDes couverts et assiette si besoin.\r\nUn goûter pour le 4 heures\r\nUne paire de crocs ou tong pour le midi\r\nDes mouchoirs en papier', 'été'),
(5, 'Un pique-nique pour le midi, à réchauffer ou non, il y a 4 micro-ondes\r\nDes couverts et assiette si besoin.\r\nUn goûter pour le 4 heures\r\nDes gants\r\nDes mouchoirs en papier', 'hiver');

-- --------------------------------------------------------

--
-- Structure de la table `lesson`
--

CREATE TABLE `lesson` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `default_price` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `start_at` datetime NOT NULL DEFAULT current_timestamp(),
  `end_at` date DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL,
  `duration` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `lesson`
--

INSERT INTO `lesson` (`id`, `name`, `default_price`, `capacity`, `start_at`, `end_at`, `price`, `is_active`, `duration`) VALUES
(1, 'Eveil Poney', 2, 5, '2021-04-17 00:00:00', NULL, 249, 0, '03:00:00'),
(2, 'Baby Poney', 1, 2, '2021-04-21 15:00:00', NULL, 20, 1, '01:00:00'),
(3, 'Poney', 3, 2, '2021-04-27 00:00:00', NULL, 20, 1, '04:00:00'),
(4, 'Cours+6ans', 3, 10, '2021-04-24 00:00:00', NULL, NULL, 0, '01:30:00'),
(5, 'Cheval Privilege', 4, 8, '2021-04-29 00:00:00', NULL, NULL, 1, '02:00:00'),
(6, 'Baby Poney 2', 1, 5, '2021-04-21 16:00:00', NULL, NULL, 1, '03:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `lesson_equipment`
--

CREATE TABLE `lesson_equipment` (
  `lesson_id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `lesson_equipment`
--

INSERT INTO `lesson_equipment` (`lesson_id`, `equipment_id`) VALUES
(1, 1),
(2, 1),
(4, 2),
(5, 1);

-- --------------------------------------------------------

--
-- Structure de la table `lesson_news`
--

CREATE TABLE `lesson_news` (
  `lesson_id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `news_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `news`
--

INSERT INTO `news` (`id`, `description`, `news_date`) VALUES
(1, 'Information 1', '2021-04-21'),
(2, 'Information 2', '2021-04-29'),
(3, 'Information 3', '2021-04-27');

-- --------------------------------------------------------

--
-- Structure de la table `planning`
--

CREATE TABLE `planning` (
  `id` int(11) NOT NULL,
  `start_at` date NOT NULL,
  `end_at` date NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `lesson_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `planning`
--

INSERT INTO `planning` (`id`, `start_at`, `end_at`, `course_id`, `lesson_id`) VALUES
(1, '2021-04-24', '2021-04-24', 1, NULL),
(2, '2021-04-27', '2021-04-27', NULL, 1),
(3, '2021-04-26', '2021-04-26', NULL, 2);

-- --------------------------------------------------------

--
-- Structure de la table `price`
--

CREATE TABLE `price` (
  `id` int(11) NOT NULL,
  `price` varchar(11) COLLATE utf8_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `price`
--

INSERT INTO `price` (`id`, `price`) VALUES
(1, '20'),
(2, '25'),
(3, '249'),
(4, '149'),
(5, '80');

-- --------------------------------------------------------

--
-- Structure de la table `shop`
--

CREATE TABLE `shop` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `size` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `color` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `shop`
--

INSERT INTO `shop` (`id`, `name`, `description`, `quantity`, `size`, `color`) VALUES
(1, 'Doudoune sans manches', 'Pratique, chaude et ultra légère.\r\nMatière résistante, souple et facile d\'entretien.\r\nCompressible dans son sac de rangement.', 10, 'M', 'blouge'),
(2, 'La veste Teddy', 'L\'indémodable Teddy inspiré des universités américaines.\r\nConfort optimal.', 5, 'L', 'vert'),
(3, 'Le softshell', 'Coupe-vent respirant et imperméable, idéal pour la mi-saison.', 2, 'S', 'jaune');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Price_id_Course_Type` (`default_price`);

--
-- Index pour la table `course_equipment`
--
ALTER TABLE `course_equipment`
  ADD KEY `fk_Stage_Equipment_stage_id` (`course_id`),
  ADD KEY `fk_Stage_Equipment_equipment_id` (`equipment_id`);

--
-- Index pour la table `course_news`
--
ALTER TABLE `course_news`
  ADD KEY `fk_Course_News_Course_id` (`course_id`),
  ADD KEY `fk_Course_News_News_id` (`news_id`);

--
-- Index pour la table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `customer_course`
--
ALTER TABLE `customer_course`
  ADD KEY `fk_Clients_Stage_client_id` (`customer_id`),
  ADD KEY `fk_Clients_Stage_stage_id` (`course_id`);

--
-- Index pour la table `customer_lesson`
--
ALTER TABLE `customer_lesson`
  ADD KEY `fk_Clients_Cours_client_id` (`customer_id`),
  ADD KEY `fk_Clients_Cours_cours_id` (`lesson_id`);

--
-- Index pour la table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `lesson`
--
ALTER TABLE `lesson`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Price_id_Lesson_Type` (`default_price`);

--
-- Index pour la table `lesson_equipment`
--
ALTER TABLE `lesson_equipment`
  ADD KEY `fk_Cours_Equipment_cours_id` (`lesson_id`),
  ADD KEY `fk_Cours_Equipment_equipment_id` (`equipment_id`);

--
-- Index pour la table `lesson_news`
--
ALTER TABLE `lesson_news`
  ADD KEY `fk_Lesson_News_Lesson_id` (`lesson_id`),
  ADD KEY `fk_Lesson_News_News_id` (`news_id`);

--
-- Index pour la table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `planning`
--
ALTER TABLE `planning`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Planning_Course_id` (`course_id`),
  ADD KEY `fk_Planning_Lesson_id` (`lesson_id`);

--
-- Index pour la table `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `planning`
--
ALTER TABLE `planning`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `price`
--
ALTER TABLE `price`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `shop`
--
ALTER TABLE `shop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `fk_Price_id_Course_Type` FOREIGN KEY (`default_price`) REFERENCES `price` (`id`);

--
-- Contraintes pour la table `course_equipment`
--
ALTER TABLE `course_equipment`
  ADD CONSTRAINT `fk_Stage_Equipment_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  ADD CONSTRAINT `fk_Stage_Equipment_stage_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Contraintes pour la table `course_news`
--
ALTER TABLE `course_news`
  ADD CONSTRAINT `fk_Course_News_Course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  ADD CONSTRAINT `fk_Course_News_News_id` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`);

--
-- Contraintes pour la table `customer_course`
--
ALTER TABLE `customer_course`
  ADD CONSTRAINT `fk_Clients_Stage_client_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `fk_Clients_Stage_stage_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Contraintes pour la table `customer_lesson`
--
ALTER TABLE `customer_lesson`
  ADD CONSTRAINT `fk_Clients_Cours_client_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `fk_Clients_Cours_cours_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`);

--
-- Contraintes pour la table `lesson`
--
ALTER TABLE `lesson`
  ADD CONSTRAINT `fk_Price_id_Lesson_Type` FOREIGN KEY (`default_price`) REFERENCES `price` (`id`);

--
-- Contraintes pour la table `lesson_equipment`
--
ALTER TABLE `lesson_equipment`
  ADD CONSTRAINT `fk_Cours_Equipment_cours_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`),
  ADD CONSTRAINT `fk_Cours_Equipment_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`);

--
-- Contraintes pour la table `lesson_news`
--
ALTER TABLE `lesson_news`
  ADD CONSTRAINT `fk_Lesson_News_Lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`),
  ADD CONSTRAINT `fk_Lesson_News_News_id` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`);

--
-- Contraintes pour la table `planning`
--
ALTER TABLE `planning`
  ADD CONSTRAINT `fk_Planning_Course_id` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  ADD CONSTRAINT `fk_Planning_Lesson_id` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;