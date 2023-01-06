-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2023 at 10:51 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_stock`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_import_stock`
--

CREATE TABLE `tbl_import_stock` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(5) NOT NULL,
  `import_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbl_import_stock`
--

INSERT INTO `tbl_import_stock` (`id`, `product_id`, `qty`, `import_date`) VALUES
(1, 1, 5, '2023-01-01 11:16:40'),
(2, 4, 10, '2023-01-03 11:16:57'),
(3, 2, 50, '2023-01-01 14:44:54'),
(4, 6, 20, '2023-01-01 14:49:07'),
(5, 7, 30, '2023-01-01 14:49:16'),
(6, 4, 20, '2023-01-06 15:55:08');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_outstock`
--

CREATE TABLE `tbl_outstock` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(5) NOT NULL,
  `outdate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbl_outstock`
--

INSERT INTO `tbl_outstock` (`id`, `product_id`, `qty`, `outdate`) VALUES
(1, 1, 2, '2023-01-02 11:43:02'),
(2, 2, 10, '2023-01-03 14:45:20'),
(3, 6, 2, '2023-01-04 14:49:39'),
(4, 7, 6, '2023-01-05 14:49:56'),
(5, 4, 3, '2023-01-06 15:53:02'),
(6, 7, 5, '2023-01-06 15:53:47'),
(7, 4, 10, '2023-01-06 15:55:53');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product`
--

CREATE TABLE `tbl_product` (
  `id` int(11) NOT NULL,
  `barcode` varchar(15) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `tbl_product`
--

INSERT INTO `tbl_product` (`id`, `barcode`, `name`) VALUES
(1, '1001', 'nodeJs'),
(2, '1002', 'NextJs'),
(4, '1003', 'JAVA'),
(6, '1004', 'Python'),
(7, '1005', 'PHP');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_import_stock`
--
ALTER TABLE `tbl_import_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_outstock`
--
ALTER TABLE `tbl_outstock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_import_stock`
--
ALTER TABLE `tbl_import_stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_outstock`
--
ALTER TABLE `tbl_outstock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_product`
--
ALTER TABLE `tbl_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
