-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 24, 2023 at 07:08 PM
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
-- Database: `dbmslab2`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `cust_name` varchar(40) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL,
  `salesman_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `cust_name`, `city`, `grade`, `salesman_id`) VALUES
(902, 'punya', 'belagavi', 8, 103),
(903, 'anu', 'kodagu', 6, 102),
(904, 'jeevi', 'udupi', 8, 104),
(905, 'harshi', 'goa', 6, 101),
(906, 'janu', 'hdkote', 8, 102),
(907, 'ammu', 'bangalore', 6, 103);

-- --------------------------------------------------------

--
-- Stand-in structure for view `high_order`
-- (See below for the actual view)
--
CREATE TABLE `high_order` (
`salesman_id` int(11)
,`customer_id` int(11)
,`purchase_amt` int(11)
,`ord_date` date
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `ord_no` int(11) NOT NULL,
  `purchase_amt` int(11) NOT NULL,
  `ord_date` date NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `salesman_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`ord_no`, `purchase_amt`, `ord_date`, `customer_id`, `salesman_id`) VALUES
(203, 5000, '2021-12-03', 903, 103),
(205, 7000, '2021-12-03', 905, 104),
(206, 3000, '2021-08-18', 906, 102);

-- --------------------------------------------------------

--
-- Table structure for table `salesman`
--

CREATE TABLE `salesman` (
  `salesman_id` int(11) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `commission` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salesman`
--

INSERT INTO `salesman` (`salesman_id`, `name`, `city`, `commission`) VALUES
(101, 'madhu', 'mysore', 1500),
(102, 'manju', 'maddur', 1000),
(103, 'sanju', 'bangalore', 3000),
(104, 'theju', 'kolar', 2000);

-- --------------------------------------------------------

--
-- Structure for view `high_order`
--
DROP TABLE IF EXISTS `high_order`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `high_order`  AS SELECT `x`.`salesman_id` AS `salesman_id`, `x`.`customer_id` AS `customer_id`, `x`.`purchase_amt` AS `purchase_amt`, `x`.`ord_date` AS `ord_date` FROM `orders` AS `x` WHERE `x`.`purchase_amt` = (select max(`y`.`purchase_amt`) from `orders` `y` where `x`.`ord_date` = `y`.`ord_date`) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `salesman_id` (`salesman_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ord_no`),
  ADD KEY `salesman_id` (`salesman_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `salesman`
--
ALTER TABLE `salesman`
  ADD PRIMARY KEY (`salesman_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`salesman_id`) REFERENCES `salesman` (`salesman_id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`salesman_id`) REFERENCES `salesman` (`salesman_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
