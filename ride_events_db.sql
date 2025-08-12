-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2025 at 05:52 PM
-- Server version: 11.7.2-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ride_events_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('1f8246b2b71ad8837d0a7ce2587e2a7dce2dc0a5', '2025-08-12 05:23:36.911560', 1),
('430f2d56246dc80321c0f274872fde64af6a1493', '2025-08-12 05:23:50.020457', 4);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add ride', 7, 'add_ride'),
(26, 'Can change ride', 7, 'change_ride'),
(27, 'Can delete ride', 7, 'delete_ride'),
(28, 'Can view ride', 7, 'view_ride'),
(29, 'Can add ride event', 8, 'add_rideevent'),
(30, 'Can change ride event', 8, 'change_rideevent'),
(31, 'Can delete ride event', 8, 'delete_rideevent'),
(32, 'Can view ride event', 8, 'view_rideevent'),
(33, 'Can add Token', 9, 'add_token'),
(34, 'Can change Token', 9, 'change_token'),
(35, 'Can delete Token', 9, 'delete_token'),
(36, 'Can view Token', 9, 'view_token'),
(37, 'Can add Token', 10, 'add_tokenproxy'),
(38, 'Can change Token', 10, 'change_tokenproxy'),
(39, 'Can delete Token', 10, 'delete_tokenproxy'),
(40, 'Can view Token', 10, 'view_tokenproxy');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(9, 'authtoken', 'token'),
(10, 'authtoken', 'tokenproxy'),
(4, 'contenttypes', 'contenttype'),
(7, 'rides', 'ride'),
(8, 'rides', 'rideevent'),
(6, 'rides', 'user'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-08-11 15:45:55.512706'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-08-11 15:45:55.564245'),
(3, 'auth', '0001_initial', '2025-08-11 15:45:55.747469'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-08-11 15:45:55.847814'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-08-11 15:45:55.860170'),
(6, 'auth', '0004_alter_user_username_opts', '2025-08-11 15:45:55.870395'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-08-11 15:45:55.880274'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-08-11 15:45:55.885613'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-08-11 15:45:55.894761'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-08-11 15:45:55.906767'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-08-11 15:45:55.915367'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-08-11 15:45:55.936688'),
(13, 'auth', '0011_update_proxy_permissions', '2025-08-11 15:45:55.948633'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-08-11 15:45:55.960466'),
(15, 'rides', '0001_initial', '2025-08-11 15:45:56.281468'),
(16, 'admin', '0001_initial', '2025-08-11 15:45:56.402856'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-08-11 15:45:56.420527'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-08-11 15:45:56.444072'),
(19, 'sessions', '0001_initial', '2025-08-11 15:45:56.497871'),
(20, 'rides', '0002_alter_user_options_alter_user_role_ride_rideevent_and_more', '2025-08-11 15:50:26.869573'),
(21, 'authtoken', '0001_initial', '2025-08-12 05:23:26.507995'),
(22, 'authtoken', '0002_auto_20160226_1747', '2025-08-12 05:23:26.591865'),
(23, 'authtoken', '0003_tokenproxy', '2025-08-12 05:23:26.595814'),
(24, 'authtoken', '0004_alter_tokenproxy_options', '2025-08-12 05:23:26.604195');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride`
--

CREATE TABLE `ride` (
  `id_ride` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `pickup_latitude` double NOT NULL,
  `pickup_longitude` double NOT NULL,
  `dropoff_latitude` double NOT NULL,
  `dropoff_longitude` double NOT NULL,
  `pickup_time` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `id_driver` int(11) DEFAULT NULL,
  `id_rider` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ride`
--

INSERT INTO `ride` (`id_ride`, `status`, `pickup_latitude`, `pickup_longitude`, `dropoff_latitude`, `dropoff_longitude`, `pickup_time`, `created_at`, `updated_at`, `id_driver`, `id_rider`) VALUES
(2, 'completed', 14.581, 121.0045, 14.6091, 121.0223, '2025-08-11 14:30:00.000000', '2025-08-12 13:08:19.000000', '2025-08-12 06:40:43.464431', 3, 2),
(3, 'cancelled', 14.57, 121.05, 14.6, 121.08, '2025-08-10 08:15:00.000000', '2025-08-12 13:08:19.000000', '2025-08-12 13:08:19.000000', NULL, 2),
(4, 'pickup', 1, 1, 1, 1, '2025-08-12 14:44:00.000000', '2025-08-12 06:44:38.544313', '2025-08-12 06:44:38.544326', 3, 2),
(5, 'completed', 1, 1, 1, 1, '2025-08-16 15:44:00.000000', '2025-08-12 07:44:36.348137', '2025-08-12 07:44:36.348151', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `ride_event`
--

CREATE TABLE `ride_event` (
  `id_ride_event` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `id_ride` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ride_event`
--

INSERT INTO `ride_event` (`id_ride_event`, `description`, `created_at`, `id_ride`) VALUES
(4, 'Ride created', '2025-08-11 14:20:00.000000', 2),
(5, 'Driver assigned', '2025-08-11 14:25:00.000000', 2),
(6, 'Status changed to pickup', '2025-08-11 14:35:00.000000', 2),
(8, 'Ride completed', '2025-08-11 15:10:00.000000', 2),
(10, 'Ride cancelled by rider', '2025-08-10 08:10:00.000000', 3),
(12, 'Status changed to pickup', '2024-01-07 14:00:00.000000', 3),
(13, 'Status changed to dropoff', '2024-01-07 14:45:00.000000', 3),
(14, 'Status changed to pickup', '2024-02-10 10:15:00.000000', 4),
(15, 'Status changed to dropoff', '2024-02-10 12:00:00.000000', 4),
(16, 'Status changed to pickup', '2024-02-18 08:45:00.000000', 5),
(17, 'Status changed to dropoff', '2024-02-18 10:30:00.000000', 5),
(20, 'Status changed to pickup', '2024-01-05 08:00:00.000000', 2),
(21, 'Status changed to dropoff', '2024-01-05 09:30:00.000000', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `id_user` int(11) NOT NULL,
  `role` varchar(50) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`password`, `last_login`, `is_superuser`, `username`, `is_staff`, `is_active`, `date_joined`, `id_user`, `role`, `first_name`, `last_name`, `email`, `phone_number`) VALUES
('pbkdf2_sha256$870000$QXcg2kBJQTl6n1aMmnZ4Ko$YWynwGUf/Hst8mqIkXAciHvi8bVK8ZL/G67UQRzv/zY=', NULL, 1, 'testUsername', 1, 1, '2025-08-12 04:53:09.215644', 1, 'rider', 'admin', 'Ramos', 'testUsername@email.com', '09672962339'),
('pbkdf2_sha256$870000$QXcg2kBJQTl6n1aMmnZ4Ko$YWynwGUf/Hst8mqIkXAciHvi8bVK8ZL/G67UQRzv/zY=', NULL, 0, 'rider1', 0, 1, '2025-08-12 13:08:19.000000', 2, 'rider', 'Bob', 'Rider', 'bob.rider@example.com', '09182345678'),
('pbkdf2_sha256$870000$QXcg2kBJQTl6n1aMmnZ4Ko$YWynwGUf/Hst8mqIkXAciHvi8bVK8ZL/G67UQRzv/zY=', NULL, 0, 'driver1aa', 0, 1, '2025-08-12 13:08:19.000000', 3, 'driver', 'Charlie', 'Driver', 'charlie.driver@example.com', '09193456789'),
('pbkdf2_sha256$870000$n3S7zkdCDq81oWuUmsqUqY$NbiGQEqyGGcF9y6S8ZcvYXhjS7G6BcOYwVQjor/k0A4=', NULL, 1, 'admin1', 1, 1, '2025-08-12 05:23:02.999257', 4, 'admin', '', '', 'admin1@email.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_user_permissions`
--

CREATE TABLE `user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_user_id_user` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `ride`
--
ALTER TABLE `ride`
  ADD PRIMARY KEY (`id_ride`),
  ADD KEY `ride_status_4ce3bb_idx` (`status`),
  ADD KEY `ride_pickup__112ef2_idx` (`pickup_time`),
  ADD KEY `ride_id_ride_92a52a_idx` (`id_rider`,`status`),
  ADD KEY `ride_id_driv_9d49a9_idx` (`id_driver`,`status`),
  ADD KEY `ride_pickup__22d4cb_idx` (`pickup_latitude`,`pickup_longitude`);

--
-- Indexes for table `ride_event`
--
ALTER TABLE `ride_event`
  ADD PRIMARY KEY (`id_ride_event`),
  ADD KEY `ride_event_id_ride_ca7133_idx` (`id_ride`,`created_at`),
  ADD KEY `ride_event_created_fda889_idx` (`created_at`),
  ADD KEY `ride_event_descrip_3849aa_idx` (`description`),
  ADD KEY `ride_event_today_idx` (`id_ride`,`created_at`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `user_role_3744fd_idx` (`role`),
  ADD KEY `user_email_7bbb4c_idx` (`email`);

--
-- Indexes for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_groups_user_id_group_id_40beef00_uniq` (`user_id`,`group_id`),
  ADD KEY `user_groups_group_id_b76f8aba_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `user_user_permissions`
--
ALTER TABLE `user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_user_permissions_user_id_permission_id_7dc6e2e0_uniq` (`user_id`,`permission_id`),
  ADD KEY `user_user_permission_permission_id_9deb68a3_fk_auth_perm` (`permission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `ride`
--
ALTER TABLE `ride`
  MODIFY `id_ride` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ride_event`
--
ALTER TABLE `ride_event`
  MODIFY `id_ride_event` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_groups`
--
ALTER TABLE `user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_user_permissions`
--
ALTER TABLE `user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `ride`
--
ALTER TABLE `ride`
  ADD CONSTRAINT `ride_id_driver_4fe99485_fk_user_id_user` FOREIGN KEY (`id_driver`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `ride_id_rider_e5dca6bf_fk_user_id_user` FOREIGN KEY (`id_rider`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `ride_event`
--
ALTER TABLE `ride_event`
  ADD CONSTRAINT `ride_event_id_ride_93d5fca7_fk_ride_id_ride` FOREIGN KEY (`id_ride`) REFERENCES `ride` (`id_ride`);

--
-- Constraints for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD CONSTRAINT `user_groups_group_id_b76f8aba_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `user_groups_user_id_abaea130_fk_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `user_user_permissions`
--
ALTER TABLE `user_user_permissions`
  ADD CONSTRAINT `user_user_permission_permission_id_9deb68a3_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `user_user_permissions_user_id_ed4a47ea_fk_user_id_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
