-- phpMyAdmin SQL Dump
-- version 4.9.7deb1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : jeu. 06 mai 2021 à 08:44
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
-- Structure de la table `activity`
--

CREATE TABLE `activity` (
  `id` int(11) NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `activity`
--

INSERT INTO `activity` (`id`, `type`, `capacity`, `price`, `name`, `description`) VALUES
(1, 'cours', 30, 120, 'baby poney', 'À poney, c\'est l\'enfant qui joue le coup de la séparation avec son parent, c\'est lui qui le lâche. L\'activité poney aide à grandir.'),
(2, 'cours', 30, 32, 'eveil-poney', 'Les enfants prendront un premier contact avec les poneys en les brossant et en participant à leur préparation. Ils effectueront des jeux à poney et participeront aussi à des promenades à l\'extérieur.'),
(3, 'cours', 30, 100, '6+', 'Pendant la première année d\'équitation, l’objectif est d’arriver à se déplacer au pas et au trot et de découvrir les premières sensations du galop et du saut d\'obstacle.'),
(4, 'cours', 110, 15, 'adulte', 'Découvrez, recommencez ou perfectionnez-vous, il n’y pas d’âge pour profiter du cheval. Nous nous adaptons à vos besoins et vous proposons des prestations différenciées.'),
(5, 'cours', 5, 12, 'privilege', 'A partir du Galop 3 : Vous avez la possibilité de monter votre équidé préféré. Cette formule vous permet de progresser avecvotre monture tout au long de l\'année et de pouvoir le sortir en concours.'),
(6, 'stage', 45, 45, 'stage d\'été', 'Il s\'agit de s\'immerger dans le monde des équidés en participant à la vie du Haras.'),
(7, 'formation', 2, 80, 'animateur d\'équitation', 'L’Animateur Equitation est un titre professionnel permettant de travailler en tant que salarié dans un centre équestre pour enseigner l\'équitation du galop 1 au galop 4.');

-- --------------------------------------------------------

--
-- Structure de la table `activity_equipment`
--

CREATE TABLE `activity_equipment` (
  `activity_id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `activity_equipment`
--

INSERT INTO `activity_equipment` (`activity_id`, `equipment_id`) VALUES
(1, 3),
(1, 2),
(2, 5),
(2, 4),
(3, 3),
(4, 2),
(5, 5),
(5, 4),
(5, 3),
(6, 2),
(7, 5),
(7, 4);

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `firstname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `last_connexion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`id`, `firstname`, `lastname`, `email`, `password`, `last_connexion`) VALUES
(1, 'admin', 'admin', 'admin@hvl.com', '$2y$10$l1xaL4wBimytTdh/C8GuquIw8K1tkmTrmx5S.D0W9vrByX7GSe7b.', '2021-04-20 01:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `firstname` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `number` int(11) NOT NULL,
  `subject` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `contact`
--

INSERT INTO `contact` (`id`, `firstname`, `lastname`, `email`, `number`, `subject`, `message`) VALUES
(1, 'Michel', 'Céleubrézil', 'm@c.fr', 0, 'don', 'cadeau de 1 euros'),
(2, 'Lionel', 'Guyau', 'lguyau@gmail.com', 0, 'fdfsd', 'fsdfsdf');

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
(1, 'Lionel', 'Guyau', 'l@g.fr'),
(2, 'Stéphanie', 'Mariani', 's@m.fr'),
(3, 'Quentin', 'Burty', 'q@b.fr'),
(4, 'Pierre-Jean', 'Touraille', 'pj@t.fr'),
(5, 'Lionel', 'Guyau', 'lguyau@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `customer_planning`
--

CREATE TABLE `customer_planning` (
  `customer_id` int(11) NOT NULL,
  `planning_id` int(11) NOT NULL,
  `register` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `customer_planning`
--

INSERT INTO `customer_planning` (`customer_id`, `planning_id`, `register`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1),
(1, 4, 1),
(1, 5, 1),
(1, 6, 1),
(1, 7, 1),
(1, 8, 1),
(2, 6, 0),
(5, 1, 1),
(5, 4, 1),
(5, 8, 1);

-- --------------------------------------------------------

--
-- Structure de la table `equipment`
--

CREATE TABLE `equipment` (
  `id` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `equipment`
--

INSERT INTO `equipment` (`id`, `description`) VALUES
(1, 'Un pantalon long'),
(2, 'Un short de fils-à-papa'),
(3, 'Le petit polo rose pale de fils-à-papa'),
(4, 'Un sandwich à la fraise'),
(5, 'Un bob jaune');

-- --------------------------------------------------------

--
-- Structure de la table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_520_ci NOT NULL,
  `news_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `news`
--

INSERT INTO `news` (`id`, `description`, `news_date`) VALUES
(1, 'Pas de boogie-woogie avant les prières ce soir', '2021-04-22 00:00:00'),
(2, 'COVID : Pas de cours après 19h', '2021-04-30 09:49:43'),
(3, 'Les cours sont maintenus pendant le confinement', '2021-04-27 00:00:00'),
(4, 'Pensez à prendre ses équipements personnels pour des raisons d\'hygiène', '2021-04-26 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `planning`
--

CREATE TABLE `planning` (
  `id` int(11) NOT NULL,
  `description` varchar(100) COLLATE utf8_unicode_520_ci NOT NULL,
  `activity_id` int(11) NOT NULL,
  `start_at` datetime NOT NULL,
  `end_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Déchargement des données de la table `planning`
--

INSERT INTO `planning` (`id`, `description`, `activity_id`, `start_at`, `end_at`) VALUES
(1, 'Premier cours', 1, '2021-04-20 01:00:00', '2021-04-20 02:00:00'),
(2, 'Cours n°1', 1, '2021-04-20 02:00:00', '2021-04-21 02:00:00'),
(3, 'cours n3', 2, '2021-04-20 03:00:00', '2021-04-22 04:00:00'),
(4, 'cours n4', 3, '2021-05-20 04:00:00', '2021-05-20 05:00:00'),
(5, 'cours n5', 4, '2021-04-21 05:00:00', '2021-04-21 06:00:00'),
(6, 'cours n6', 5, '2021-05-21 06:00:00', '0000-00-00 00:00:00'),
(7, 'cours n7', 6, '2021-05-22 07:00:00', '2021-05-25 08:00:00'),
(8, 'cours n8', 7, '2021-05-13 08:00:00', '2021-05-27 09:00:00');

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
(1, 'Doudoune sans manches', 'Pratique, chaude et ultra confortable', 10, 'M', 'blouge'),
(2, 'La vete Teddy', 'L\'indémodable', 5, 'L', 'vert kaki'),
(3, 'Le softshell', 'Coupe-vent respirant', 2, 'S', 'jaune fluo');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `activity`
--
ALTER TABLE `activity`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `activity_equipment`
--
ALTER TABLE `activity_equipment`
  ADD KEY `fk_Course_Equipment_Activity_id` (`activity_id`),
  ADD KEY `fk_Course_Equipment_Equipment_id` (`equipment_id`);

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `customer_planning`
--
ALTER TABLE `customer_planning`
  ADD KEY `fk_Customer_planning_Customer_id` (`customer_id`),
  ADD KEY `fk_Customer_planning_Planning_id` (`planning_id`);

--
-- Index pour la table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `fk_Planning_Activity_id` (`activity_id`);

--
-- Index pour la table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `activity`
--
ALTER TABLE `activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `planning`
--
ALTER TABLE `planning`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `shop`
--
ALTER TABLE `shop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `activity_equipment`
--
ALTER TABLE `activity_equipment`
  ADD CONSTRAINT `fk_Course_Equipment_Activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_Course_Equipment_Equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `customer_planning`
--
ALTER TABLE `customer_planning`
  ADD CONSTRAINT `fk_Customer_planning_Customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_Customer_planning_Planning_id` FOREIGN KEY (`planning_id`) REFERENCES `planning` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `planning`
--
ALTER TABLE `planning`
  ADD CONSTRAINT `Delete_Planning_Activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
