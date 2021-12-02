-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 02, 2021 at 06:59 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `diplomski`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `measurements`
--

DROP TABLE IF EXISTS `measurements`;
CREATE TABLE IF NOT EXISTS `measurements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `measurements`
--

INSERT INTO `measurements` (`id`, `name`, `unit`, `url`) VALUES
(1, 'Unutrašnja temperatura vazduha', '°C', 'inner-temp.png'),
(2, 'Temperatura zemljišta', '°C', 'soil-temp.png'),
(3, 'Vanjska temperatura vazduha', '°C', 'out-temp.png'),
(4, 'Vlažnost vazduha', '%', 'air-humidity.png'),
(5, 'Vlažnost zemljišta', '%', 'soil-humidity.png'),
(6, 'Brzina vjetra', 'km/h', 'wind-speed.png'),
(7, 'Intezitet osvjetljenja', 'lux', 'light-intesity.png'),
(8, 'Kiselost zemljišta', 'pH', 'soil-acidity.png'),
(9, 'Temperatura vode', '°C', 'water-temp.png'),
(10, 'Pritisak vode', 'Pa', 'water-pressure.png');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('asd@asd', '$2y$10$qX9ZODDxL8gCuPS1pBoYl.MYeLX8ZfeOsA6QNxCVOUNA02ahzslti', '2021-10-24 17:31:06'),
('ljerkatoptop@gmail.com', '$2y$10$vuO39LkS0RfFfTN1OdTjfOZ/54B6BadcHbn.9n7exFaNuZGjM8XCG', '2021-11-25 18:21:37'),
('piltidugno@yevme.com', '$2y$10$NfhVk.RANg2fB3hEmKUNg.Qqsyv0hgojPPx453CEOARyA1xo5Hhce', '2021-10-24 18:36:27'),
('daspozofye@yevme.com', '$2y$10$X5fTAJ0UmDyQM3zw.A1nfeS6hYsmYyBLpbidWJMZW2KMFYNb2DGcK', '2021-10-24 19:25:53');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` tinyint(4) NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `email_verified_at`, `password`, `role`, `url`, `remember_token`, `created_at`, `updated_at`) VALUES
(3, 'Stefan', 'Stefanović', 'asd@asd', '2021-10-23 21:15:42', '$2y$10$btY7orFk5hlUk4Kesjq/S.ozvzxeOqIQMJg9ukCqhnkwLt2SqF46.', 2, 'milan.jpg', 'WN923595tQtvSto40hEe6k03AwQ1sTDKCKwOAFLw3VSh0PTa2jh6obxi7Vwx', '2021-10-22 15:13:31', '2021-10-23 15:13:31'),
(2, 'Marko', 'Marković', 'user@user', NULL, '$2y$10$3cGLd9kvZr1kER6Lfj985ejNjOn3RSimBYeKDaooQitfUpOF0cHZG', 2, 'marko.jpg', '23BgkWcIHaGXZayWm1934zwsLI2vzSFpLb5F11N9l357AcnE1qHeuXTTjNkT', '2021-10-23 21:43:08', '2021-10-25 15:53:41'),
(1, 'Milan', 'Milanović', 'admin@admin', NULL, '$2y$10$3cGLd9kvZr1kER6Lfj985ejNjOn3RSimBYeKDaooQitfUpOF0cHZG', 1, 'stefan.jpg', 'ofiXevOK0L2eMELnemi2aQPlrScoA1gVL1e1vAtxpg4dUe6e81ttGIVgaKiq', '2021-10-24 17:14:32', '2021-11-23 00:53:26'),
(4, 'Darko', 'Darković', 'asdasd@asd', NULL, '$2y$10$mQfdcbJ5QP.a5JMliGGUFOIepr6RXK.I4Hot8nQGjyvxuI1UXxbg6', 2, 'darko.jpg', NULL, '2021-11-22 02:54:13', '2021-11-22 02:54:13');

-- --------------------------------------------------------

--
-- Table structure for table `user_measurements`
--

DROP TABLE IF EXISTS `user_measurements`;
CREATE TABLE IF NOT EXISTS `user_measurements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `measurements_id` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `measurements_id` (`measurements_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_measurements`
--

INSERT INTO `user_measurements` (`id`, `user_id`, `measurements_id`, `fieldId`) VALUES
(167, 2, 7, 5),
(166, 2, 2, 3),
(165, 3, 2, 3),
(164, 3, 4, 2),
(143, 1, 7, 5),
(142, 1, 5, 4),
(141, 1, 2, 3),
(140, 1, 4, 2),
(139, 1, 1, 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
