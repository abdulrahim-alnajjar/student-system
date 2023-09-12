-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 12, 2023 at 02:52 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `students_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `about_app`
--

CREATE TABLE `about_app` (
  `p_title` varchar(255) NOT NULL,
  `body` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `about_app`
--

INSERT INTO `about_app` (`p_title`, `body`) VALUES
('ما هو ', 'هو تطبيق ويب لإدارة قواعد بيانات الطلاب بطريقة بسيطة وسهلة، عن طريق تنظيم البيانات في جداول تمكن من الاحتفاظ بهذة البيانات مرتبة بعدة طرق مختلفة، وتمكن من البحث داخلها بكافة البيانات التي تم حفظها مسبقا'),
('ما يميز ', 'سهولة الاستخدام، إمكانية البحث المتعدد، إضافة طلاب والتعديل عليهم لاحقا أو حذفهم');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT '-',
  `state` varchar(255) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `fullname`, `phone`, `email`, `state`, `date`) VALUES
(153, 'عبدالرحيم محمد النجار', '011********', 'a@m.info', 'قيد المراجعة', '2023-09-12'),
(154, 'علي محمد سليم', '012********', 'a@m.com', 'تم القبول', '2023-09-12'),
(155, 'بافلي زاهر أشرف', '010********', 'ba@z.ic', 'قيد المراجعة', '2023-09-12'),
(157, 'سارة حسن مــحمود', '015********', 's@h.com', 'قيد المراجعة', '2023-09-12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `truststate` varchar(255) NOT NULL DEFAULT 'helper'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `email`, `truststate`) VALUES
(1, 'alnajjar', '7b52009b64fd0a2a49e6d8a939753077792b0554', 'عبدالرحيم محمد ناجي', 'abdo@gmail.com', 'owner');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `about_app`
--
ALTER TABLE `about_app`
  ADD PRIMARY KEY (`p_title`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fullname` (`fullname`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
