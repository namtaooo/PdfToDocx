-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 24, 2025 at 06:23 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pdf2word_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `conversion_job`
--

CREATE TABLE `conversion_job` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `output_file_name` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `error_message` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `finished_at` timestamp NULL DEFAULT NULL,
  `real_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `conversion_job`
--

INSERT INTO `conversion_job` (`id`, `user_id`, `original_file_name`, `output_file_name`, `file_size`, `status`, `error_message`, `created_at`, `finished_at`, `real_name`) VALUES
(1, 6, 'b5a46c20a8f84b919ab400b2fba3ff27.pdf', 'BẢN THIẾT KẾ MÔ HÌNH MVC.docx', 139480, 'DONE', NULL, '2025-11-24 16:13:26', '2025-11-24 16:13:33', 'BẢN THIẾT KẾ MÔ HÌNH MVC.pdf'),
(2, 6, 'c45cd9abbb54426f86292c5ab4443bf4.pdf', NULL, 8, 'FAILED', 'Error: End-of-File, expected line at offset 8', '2025-11-24 16:21:34', '2025-11-24 16:21:37', 'Bản bánh mỳ.pdf'),
(3, 6, 'bb2dc8a013144057bc0cd1f93de586f4.pdf', 'Oke con dê.docx', 16067, 'DONE', NULL, '2025-11-24 16:27:36', '2025-11-24 16:27:43', 'Oke con dê.pdf'),
(4, 6, '3a708e6ad20446f18477180900d6b741.pdf', 'Oke con dê.docx', 16067, 'DONE', NULL, '2025-11-24 16:42:55', '2025-11-24 16:42:56', 'Oke con dê.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password_hash`, `created_at`) VALUES
(1, 'namtaoo', '1234', '2025-11-23 13:44:40'),
(2, 'testuser_1763912341112', 'hash123', '2025-11-23 15:39:01'),
(3, 'testuser_1763914115741', 'hash123', '2025-11-23 16:08:36'),
(4, 'testuser_1763914184028', 'hash123', '2025-11-23 16:09:44'),
(5, 'user_1763914484853', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '2025-11-23 16:14:45'),
(6, 'namcaca', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '2025-11-24 13:18:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `conversion_job`
--
ALTER TABLE `conversion_job`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_job_user` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `conversion_job`
--
ALTER TABLE `conversion_job`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `conversion_job`
--
ALTER TABLE `conversion_job`
  ADD CONSTRAINT `fk_job_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
