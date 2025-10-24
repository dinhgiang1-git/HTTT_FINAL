-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost
-- Thời gian đã tạo: Th10 24, 2025 lúc 07:07 AM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `Laptop_BuyOnline`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `brands`
--

INSERT INTO `brands` (`id`, `name`, `image`) VALUES
(1, 'Dell', 'dell.png'),
(2, 'HP', 'hp.png'),
(3, 'Asus', 'asus.png'),
(4, 'Apple', 'apple.png'),
(5, 'Lenovo', 'lenovo.png'),
(6, 'Acer', 'acer.png'),
(7, 'MSI', 'msi.png'),
(8, 'Razer', 'razer.png'),
(9, 'Microsoft Surface', 'surface.png'),
(10, 'Samsung', 'samsung.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Laptop Gaming'),
(2, 'Laptop Văn Phòng'),
(3, 'Laptop Học Tập'),
(4, 'Laptop Đồ Họa - Kỹ Thuật'),
(5, 'MacBook'),
(6, 'Laptop 2-in-1 (Convertible)'),
(7, 'Ultrabook'),
(8, 'Laptop Doanh Nhân');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `image` text NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `news_details`
--

CREATE TABLE `news_details` (
  `id` int(11) NOT NULL,
  `new_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `content` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 3,
  `note` text DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `status`, `note`, `total`, `created_at`, `updated_at`) VALUES
(8, 6, 0, 'Chờ xác nhận.', 52000000, '2025-10-07 00:50:11', '2025-10-07 01:22:38'),
(9, 6, 0, 'Chờ xác nhận.', 79000000, '2025-10-07 01:23:27', '2025-10-24 05:12:02'),
(10, 6, 0, 'Chờ xác nhận.', 55000000, '2025-10-07 16:34:47', '2025-10-14 02:12:36'),
(11, 6, 0, 'Chờ xác nhận.', 147000000, '2025-10-15 15:02:27', '2025-10-15 15:29:30'),
(12, 6, 3, NULL, 65000000, '2025-10-15 15:30:37', NULL),
(13, 6, 0, 'Chờ xác nhận.', 23500000, '2025-10-24 10:10:00', '2025-10-24 10:12:00'),
(14, 7, 3, NULL, 52000000, '2025-10-24 10:15:00', NULL),
(15, 8, 0, 'Chờ xác nhận.', 65000000, '2025-10-24 10:20:00', '2025-10-24 10:22:00'),
(16, 9, 3, NULL, 17000000, '2025-10-24 10:25:00', NULL),
(17, 10, 0, 'Chờ xác nhận.', 38000000, '2025-10-24 10:30:00', '2025-10-24 10:32:00'),
(18, 12, 3, NULL, 22000000, '2025-10-24 10:35:00', NULL),
(19, 13, 0, 'Chờ xác nhận.', 54000000, '2025-10-24 10:40:00', '2025-10-24 10:42:00'),
(20, 15, 3, NULL, 29500000, '2025-10-24 10:45:00', NULL),
(21, 16, 0, 'Chờ xác nhận.', 42000000, '2025-10-24 10:50:00', '2025-10-24 10:52:00'),
(22, 17, 3, NULL, 19000000, '2025-10-24 10:55:00', NULL),
(23, 18, 0, 'Chờ xác nhận.', 32000000, '2025-10-24 11:00:00', '2025-10-24 11:02:00'),
(24, 19, 3, NULL, 60000000, '2025-10-24 11:05:00', NULL),
(25, 20, 0, 'Chờ xác nhận.', 28000000, '2025-10-24 11:10:00', '2025-10-24 11:12:00'),
(26, 21, 3, NULL, 20500000, '2025-10-24 11:15:00', NULL),
(27, 22, 0, 'Chờ xác nhận.', 25000000, '2025-10-24 11:20:00', '2025-10-24 11:22:00'),
(28, 23, 3, NULL, 36000000, '2025-10-24 11:25:00', NULL),
(29, 24, 0, 'Chờ xác nhận.', 22000000, '2025-10-24 11:30:00', '2025-10-24 11:32:00'),
(30, 25, 3, NULL, 47000000, '2025-10-24 11:35:00', NULL),
(31, 26, 0, 'Chờ xác nhận.', 19500000, '2025-10-24 11:40:00', '2025-10-24 11:42:00'),
(32, 27, 3, NULL, 30000000, '2025-10-24 11:45:00', NULL),
(33, 28, 0, 'Chờ xác nhận.', 42000000, '2025-10-24 11:50:00', '2025-10-24 11:52:00'),
(34, 29, 3, NULL, 28000000, '2025-10-24 11:55:00', NULL),
(35, 30, 0, 'Chờ xác nhận.', 65000000, '2025-10-24 12:00:00', '2025-10-24 12:02:00'),
(36, 31, 3, NULL, 23500000, '2025-10-24 12:05:00', NULL),
(37, 32, 0, 'Chờ xác nhận.', 52000000, '2025-10-24 12:10:00', '2025-10-24 12:12:00'),
(38, 33, 3, NULL, 19000000, '2025-10-24 12:15:00', NULL),
(39, 34, 0, 'Chờ xác nhận.', 38000000, '2025-10-24 12:20:00', '2025-10-24 12:22:00'),
(40, 35, 3, NULL, 29500000, '2025-10-24 12:25:00', NULL),
(41, 36, 0, 'Chờ xác nhận.', 32000000, '2025-10-24 12:30:00', '2025-10-24 12:32:00'),
(42, 37, 3, NULL, 60000000, '2025-10-24 12:35:00', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders_details`
--

CREATE TABLE `orders_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `price` int(11) NOT NULL,
  `oldprice` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders_details`
--

INSERT INTO `orders_details` (`id`, `order_id`, `variant_id`, `product_id`, `price`, `oldprice`, `quantity`, `created_at`) VALUES
(5, 2, 1, 1, 10000000, 15000000, 3, '2025-09-25 16:08:02'),
(16, 2, 3, 1, 12000000, 17000000, 11, '2025-09-30 18:16:22'),
(17, 2, 4, 5, 12000000, 17000000, 6, '2025-10-01 02:27:24'),
(21, 8, 3, 2, 52000000, 58000000, 1, '2025-10-07 01:18:10'),
(22, 9, 12, 7, 23500000, 25500000, 2, '2025-10-07 01:23:27'),
(23, 9, 14, 9, 32000000, 35000000, 1, '2025-10-07 01:23:35'),
(26, 10, 54, 45, 17000000, 19000000, 1, '2025-10-09 13:12:30'),
(27, 10, 67, 58, 38000000, 41000000, 1, '2025-10-09 13:20:10'),
(28, 11, 54, 45, 17000000, 19000000, 1, '2025-10-15 15:02:27'),
(29, 11, 5, 3, 65000000, 70000000, 2, '2025-10-15 15:02:41'),
(31, 12, 33, 25, 65000000, 70000000, 1, '2025-10-15 15:30:37'),
(32, 13, 1, 1, 22000000, 25000000, 1, '2025-10-24 10:10:00'),
(33, 13, 9, 6, 19000000, 21000000, 1, '2025-10-24 10:10:00'),
(34, 14, 3, 2, 52000000, 58000000, 1, '2025-10-24 10:15:00'),
(35, 15, 5, 3, 65000000, 70000000, 1, '2025-10-24 10:20:00'),
(36, 16, 54, 45, 17000000, 19000000, 1, '2025-10-24 10:25:00'),
(37, 17, 67, 58, 38000000, 41000000, 1, '2025-10-24 10:30:00'),
(38, 18, 11, 7, 22000000, 24000000, 1, '2025-10-24 10:35:00'),
(39, 19, 4, 2, 54000000, 59000000, 1, '2025-10-24 10:40:00'),
(40, 20, 7, 4, 29500000, 32000000, 1, '2025-10-24 10:45:00'),
(41, 21, 16, 11, 42000000, 45000000, 1, '2025-10-24 10:50:00'),
(42, 22, 23, 17, 19000000, 22000000, 1, '2025-10-24 10:55:00'),
(43, 23, 14, 9, 32000000, 35000000, 1, '2025-10-24 11:00:00'),
(44, 24, 21, 15, 60000000, 65000000, 1, '2025-10-24 11:05:00'),
(45, 25, 6, 4, 28000000, 31000000, 1, '2025-10-24 11:10:00'),
(46, 26, 10, 6, 20500000, 23000000, 1, '2025-10-24 11:15:00'),
(47, 27, 13, 8, 25000000, 28000000, 1, '2025-10-24 11:20:00'),
(48, 28, 8, 5, 36000000, 39000000, 1, '2025-10-24 11:25:00'),
(49, 29, 11, 7, 22000000, 24000000, 1, '2025-10-24 11:30:00'),
(50, 30, 82, 94, 47000000, 50000000, 1, '2025-10-24 11:35:00'),
(51, 31, 43, 35, 13500000, 15500000, 1, '2025-10-24 11:40:00'),
(52, 31, 58, 49, 19500000, 21500000, 1, '2025-10-24 11:40:00'),
(53, 32, 3, 2, 52000000, 58000000, 1, '2025-10-24 12:10:00'),
(54, 33, 23, 17, 19000000, 22000000, 1, '2025-10-24 12:15:00'),
(55, 34, 67, 58, 38000000, 41000000, 1, '2025-10-24 12:20:00'),
(56, 35, 7, 4, 29500000, 32000000, 1, '2025-10-24 12:25:00'),
(57, 36, 14, 9, 32000000, 35000000, 1, '2025-10-24 12:30:00'),
(58, 37, 21, 15, 60000000, 65000000, 1, '2025-10-24 12:35:00'),
(59, 13, 34, 30, 16000000, 18000000, 1, '2025-10-24 10:10:00'),
(60, 14, 36, 31, 15500000, 17500000, 2, '2025-10-24 10:15:00'),
(61, 15, 39, 33, 28000000, 31000000, 1, '2025-10-24 10:20:00'),
(62, 16, 43, 35, 13500000, 15500000, 1, '2025-10-24 10:25:00'),
(63, 17, 46, 38, 26000000, 29000000, 1, '2025-10-24 10:30:00'),
(64, 18, 48, 39, 24000000, 26500000, 1, '2025-10-24 10:35:00'),
(65, 19, 50, 41, 23000000, 25500000, 1, '2025-10-24 10:40:00'),
(66, 20, 52, 43, 22000000, 24000000, 1, '2025-10-24 10:45:00'),
(67, 21, 54, 45, 17000000, 19000000, 1, '2025-10-24 10:50:00'),
(68, 22, 57, 48, 18000000, 20000000, 1, '2025-10-24 10:55:00'),
(69, 23, 62, 53, 36000000, 38000000, 1, '2025-10-24 11:00:00'),
(70, 24, 65, 56, 27000000, 29500000, 1, '2025-10-24 11:05:00'),
(71, 25, 68, 59, 30000000, 32500000, 1, '2025-10-24 11:10:00'),
(72, 26, 34, 30, 16000000, 18000000, 1, '2025-10-24 11:15:00'),
(73, 27, 36, 31, 15500000, 17500000, 1, '2025-10-24 11:20:00'),
(74, 28, 39, 33, 28000000, 31000000, 1, '2025-10-24 11:25:00'),
(75, 29, 43, 35, 13500000, 15500000, 2, '2025-10-24 11:30:00'),
(76, 30, 50, 41, 23000000, 25500000, 2, '2025-10-24 11:35:00'),
(77, 31, 52, 43, 22000000, 24000000, 1, '2025-10-24 11:40:00'),
(78, 32, 54, 45, 17000000, 19000000, 2, '2025-10-24 12:10:00'),
(79, 33, 57, 48, 18000000, 20000000, 1, '2025-10-24 12:15:00'),
(80, 34, 62, 53, 36000000, 38000000, 1, '2025-10-24 12:20:00'),
(81, 35, 65, 56, 27000000, 29500000, 1, '2025-10-24 12:25:00'),
(82, 36, 68, 59, 30000000, 32500000, 1, '2025-10-24 12:30:00'),
(83, 37, 79, 91, 39000000, 42000000, 1, '2025-10-24 12:35:00'),
(84, 13, 84, 95, 24000000, 26000000, 1, '2025-10-24 10:10:00'),
(85, 14, 87, 97, 29000000, 31000000, 1, '2025-10-24 10:15:00'),
(86, 15, 89, 99, 28000000, 30000000, 1, '2025-10-24 10:20:00'),
(87, 16, 91, 101, 24000000, 26000000, 1, '2025-10-24 10:25:00'),
(88, 17, 94, 104, 42000000, 45000000, 1, '2025-10-24 10:30:00'),
(89, 18, 96, 106, 55000000, 58000000, 1, '2025-10-24 10:35:00'),
(90, 19, 97, 107, 78000000, 82000000, 1, '2025-10-24 10:40:00'),
(91, 20, 34, 30, 16000000, 18000000, 1, '2025-10-24 10:45:00'),
(92, 21, 36, 31, 15500000, 17500000, 1, '2025-10-24 10:50:00'),
(93, 22, 39, 33, 28000000, 31000000, 1, '2025-10-24 10:55:00'),
(94, 23, 43, 35, 13500000, 15500000, 1, '2025-10-24 11:00:00'),
(95, 24, 46, 38, 26000000, 29000000, 1, '2025-10-24 11:05:00'),
(96, 25, 48, 39, 24000000, 26500000, 1, '2025-10-24 11:10:00'),
(97, 26, 50, 41, 23000000, 25500000, 1, '2025-10-24 11:15:00'),
(98, 27, 52, 43, 22000000, 24000000, 1, '2025-10-24 11:20:00'),
(99, 28, 54, 45, 17000000, 19000000, 1, '2025-10-24 11:25:00'),
(100, 29, 57, 48, 18000000, 20000000, 2, '2025-10-24 11:30:00'),
(101, 30, 62, 53, 36000000, 38000000, 1, '2025-10-24 11:35:00'),
(102, 31, 65, 56, 27000000, 29500000, 1, '2025-10-24 11:40:00'),
(103, 32, 68, 59, 30000000, 32500000, 1, '2025-10-24 12:10:00'),
(104, 33, 79, 91, 39000000, 42000000, 1, '2025-10-24 12:15:00'),
(105, 34, 84, 95, 24000000, 26000000, 1, '2025-10-24 12:20:00'),
(106, 35, 87, 97, 29000000, 31000000, 1, '2025-10-24 12:25:00'),
(107, 36, 89, 99, 28000000, 30000000, 1, '2025-10-24 12:30:00'),
(108, 37, 91, 101, 24000000, 26000000, 1, '2025-10-24 12:35:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` text NOT NULL,
  `description` text NOT NULL,
  `buyturn` int(11) NOT NULL DEFAULT 0,
  `quantity` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `is_spotlight` int(11) NOT NULL DEFAULT 0,
  `is_delete` int(11) NOT NULL DEFAULT 0,
  `deleted_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `description`, `buyturn`, `quantity`, `brand_id`, `category_id`, `is_spotlight`, `is_delete`, `deleted_at`, `updated_at`, `created_at`) VALUES
(1, 'Dell G15 Gaming', 'https://images.unsplash.com/photo-1684127987312-43455fd95925?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Laptop gaming tầm trung', 2, 10, 1, 1, 1, 0, NULL, NULL, '2025-10-06 23:49:22'),
(2, 'Dell Alienware M15', 'https://images.unsplash.com/photo-1593640495371-1f7ddf3dedf6?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Laptop gaming cao cấp', 3, 8, 1, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:27'),
(3, 'Dell Alienware X16', 'https://images.unsplash.com/photo-1641623410264-948701015656?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Máy gaming cao cấp RTX 4080', 1, 5, 1, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:29'),
(4, 'HP Omen 16', 'https://bizweb.dktcdn.net/100/512/769/products/hp-omen-16-2023-3.webp?v=1717310030653https://laptop15.vn/wp-content/uploads/2023/11/HP-Omen-16-wf0130TX-1.png', 'Laptop gaming hiệu năng cao', 0, 12, 2, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:31'),
(5, 'HP Omen Transcend', 'https://kinglap.vn/wp-content/uploads/2024/03/Omen-1.jpg', 'Gaming mỏng nhẹ', 5, 7, 2, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:33'),
(6, 'HP Victus 15', 'https://laptopxachtayshop.com/uploads/2024/09/HP-Gaming-VICTUS-15-FA0033DX-2.jpg', 'Laptop gaming phổ thông', 7, 20, 2, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:34'),
(7, 'Asus TUF Gaming A15', 'https://bizweb.dktcdn.net/100/487/158/files/1-jpeg-1549c4c7-3428-46f0-b3b0-b7f2bebd765b.jpg?v=1689161824835', 'Laptop gaming bền bỉ', 3, 15, 3, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:35'),
(8, 'Asus TUF Dash F15', 'https://i.ytimg.com/vi/vpOAa1umhaA/maxresdefault.jpg', 'Laptop gaming RTX 4050', 2, 18, 3, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:36'),
(9, 'Asus ROG Strix G15', 'https://techcare.vn/image/asus-rog-strix-g15-g513qe-wh96-5-9l6opq1.jpg', 'Laptop gaming hiệu năng cao', 4, 9, 3, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:38'),
(10, 'Asus ROG Zephyrus G14', 'https://mac24h.vn/images/companies/1/Asus/ASUS%20ROG%20Zephyrus%20G15/G14/G14%202024/170728681833.jpg?1711081856623', 'Gaming mỏng nhẹ cao cấp', 2, 6, 3, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:40'),
(11, 'Asus ROG Flow X16', 'https://dlcdnwebimgs.asus.com/files/media/C2118EAC-69AE-4260-AC1D-D574E9575F17/v1/img/modes/multitasking.jpg', 'Gaming 2-in-1 cao cấp', 1, 4, 3, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:41'),
(12, 'MSI Katana 15', 'https://cdn.tgdd.vn/Products/Images/44/310447/Slider/vi-vn-msi-katana-15-b13vfk-i7-676vn-slider-2.jpg', 'Laptop gaming phổ thông', 3, 14, 4, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:42'),
(13, 'MSI Cyborg 15', 'https://laptopxachtayshop.com/uploads/2024/07/Laptop-MSI-Cyborg-Gaming-15-2.jpg', 'Laptop gaming mới 2024', 0, 13, 4, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:46'),
(14, 'MSI Sword 15', 'https://storage-asset.msi.com/global/picture/image/feature/nb/2022_RPL/sword_15_a13/msi-sword15-13th-nv-laptop.jpg', 'Gaming hiệu năng ổn định', 0, 11, 4, 1, 0, 0, NULL, NULL, '2025-10-06 23:49:47'),
(15, 'MSI Raider GE78', 'https://storage-asset.msi.com/global/picture/image/feature/nb/GE/Raider-GE78-HX-13V/photo-4.png', 'Flagship gaming cao cấp', 0, 5, 4, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:27'),
(16, 'MSI Stealth 14', 'https://storage-asset.msi.com/global/picture/image/feature/nb/2022_RPL/stealth_14_A13/msi-stealth14-360-degree-bg-mobile.jpg', 'Gaming mỏng nhẹ cao cấp', 0, 8, 4, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:30'),
(17, 'Acer Nitro 5', 'https://no1computer.vn/upload_images/images/2022/03/01/acer-nitro-5-2022-news-1(1).jpg', 'Laptop gaming phổ biến', 0, 25, 5, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:31'),
(18, 'Acer Nitro V15', 'https://cdn-media.sforum.vn/storage/app/media/chidung/danh-gia-acer-nitro-v/danh-gia-acer-nitro-v15-COVER.jpg', 'Gaming giá tốt', 0, 18, 5, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:32'),
(19, 'Acer Predator Helios 16', 'https://anphat.com.vn/media/product/47594_laptop_acer_predator_helios_16_ph16_72_95zm_nh_qnzsv_008__intel_core_i9_14900hx.jpg', 'Gaming cao cấp', 0, 6, 5, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:33'),
(20, 'Acer Predator Triton 17X', 'https://d28jzcg6y4v9j1.cloudfront.net/media/social/articles/2023/4/24/acer-predator-triton-17-x-duoc-trang-bi-man-hinh-an-tuong-e1682059288193-thinkpro.jpg', 'Siêu laptop gaming', 0, 3, 5, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:34'),
(21, 'Lenovo LOQ 15', 'https://sm.pcmag.com/pcmag_au/cover/l/lenovo-loq/lenovo-loq-15_hgdu.jpg', 'Laptop gaming tầm trung', 0, 22, 6, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:35'),
(22, 'Lenovo Legion 5', 'https://laptop15.vn/wp-content/uploads/2023/08/Lenovo-Legion-Pro-5-Y9000P-2.png', 'Gaming hiệu năng cao', 0, 17, 6, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:37'),
(23, 'Lenovo Legion Pro 7', 'https://nhatminhlaptop.com/Upload/Editor/2024/12/20/lenovolegionpro72-cb39.jpg', 'Gaming cao cấp RTX 4080', 0, 4, 6, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:37'),
(24, 'Razer Blade 14', 'https://images.unsplash.com/photo-1605134513573-384dcf99a44c?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'Laptop gaming cao cấp', 0, 5, 7, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:38'),
(25, 'Razer Blade 15', 'https://d28jzcg6y4v9j1.cloudfront.net/media/social/articles/2022/3/26/razer-blade-15%203.jpeg', 'Gaming cao cấp mỏng nhẹ', 0, 4, 7, 1, 1, 0, NULL, NULL, '2025-10-07 15:36:39'),
(26, 'Razer Blade 16', 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/02/razer-blade-15-2023.jpeg', 'Gaming đầu bảng', 0, 3, 7, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:40'),
(27, 'Razer Blade 18', 'https://platform.theverge.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/22336712/cfaulkner_210228_4451_0005.jpg?quality=90&strip=all&crop=16.658536585366,0,66.682926829268,100', 'Gaming màn hình lớn', 0, 2, 7, 1, 0, 0, NULL, NULL, '2025-10-07 15:36:42'),
(28, 'Gigabyte Aorus 15', 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/03/AORUS-15-va-AORUS-17-1.jpg', 'Laptop gaming hiệu năng tốt', 2, 14, 7, 1, 0, 0, NULL, NULL, '2025-10-24 09:56:42'),
(29, 'Gigabyte Aorus 17H', 'https://i.ytimg.com/vi/dW7SdFKwfHc/maxresdefault.jpg', 'Gaming mạnh mẽ', 2, 6, 7, 1, 0, 0, NULL, NULL, '2025-10-24 09:56:45'),
(30, 'Dell Inspiron 14', 'https://laptopkimanh.vn/upload/image/product/laptop-dell-inspiron-14-5445.jpg', 'Laptop văn phòng gọn nhẹ, pin lâu', 0, 20, 1, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(31, 'HP Pavilion 14', 'https://i0.wp.com/transustore.com/wp-content/uploads/2023/11/img_3899-1-scaled.jpg?fit=2560%2C1920&ssl=1', 'Laptop văn phòng bền bỉ, hiệu năng ổn định', 0, 15, 2, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(32, 'Asus Vivobook 15', 'https://anphat.com.vn/media/product/44640_a1505va_l1201w_1.png', 'Laptop văn phòng hiện đại, giá tốt', 1, 25, 3, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(33, 'Apple MacBook Air M2', 'https://www.duchuymobile.com/images/detailed/54/tinh-nang-air-2.jpg', 'MacBook Air M2 mỏng nhẹ, hiệu năng cao', 0, 10, 4, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(34, 'Lenovo ThinkBook 14', 'https://laptopkimanh.vn/upload/image/product/z6347681993429_cd37e188e658c0e18d688c912286c22e.jpg', 'Laptop văn phòng bền, phù hợp doanh nghiệp', 0, 18, 5, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(35, 'Acer Aspire 5', 'https://cdn.tgdd.vn/Products/Images/44/323587/Slider/vi-vn-acer-aspire-5-a515-58m-56yx-i5-nxkq8sv005-slider-1.jpg', 'Laptop văn phòng hiệu năng ổn', 0, 12, 6, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(36, 'MSI Modern 14', 'https://laptoptld.com/wp-content/uploads/2022/06/Laptop-MSI-Modern-14-B11MO-004VN-corei5-2.jpeg', 'Laptop văn phòng mỏng nhẹ, đẹp', 0, 14, 7, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(37, 'Razer Book 13', 'https://laptoptld.com/wp-content/uploads/2023/04/z4294042797484_6cd4d893fe573c02ff1146023199e56d.jpg', 'Laptop văn phòng cao cấp, siêu mỏng', 0, 8, 8, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(38, 'Microsoft Surface Laptop 5', 'https://surfacecity.vn/wp-content/uploads/surface-laptop-5-2022.jpg', 'Surface Laptop 5 mượt mà, pin tốt', 0, 10, 9, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(39, 'Samsung Galaxy Book3', 'https://cdn2.fptshop.com.vn/unsafe/2023_2_2_638109037439988616_galaxy-book3-series-b.jpg', 'Laptop văn phòng thanh lịch, màn đẹp', 0, 9, 10, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(40, 'Dell Vostro 3400', 'https://nhatminhlaptop.com/Upload/Editor/2022/3/8/dellvostro34004-acdd.jpg', 'Laptop văn phòng hiệu quả, pin khỏe', 0, 10, 1, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(41, 'HP Envy 13', 'https://phongvu.vn/cong-nghe/wp-content/uploads/sites/2/2020/09/HP-Envy-13-2020-phong-vu-5-1.jpg', 'Laptop văn phòng cao cấp, mỏng nhẹ', 0, 15, 2, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(42, 'Asus ZenBook 14', 'https://baohanhtrondoi.com/wp-content/uploads/2024/10/Asus-Zenbook-14-OLED-Q415M-U5512-4.jpg', 'Laptop văn phòng sang trọng', 0, 10, 3, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(43, 'Apple MacBook Air M1', 'https://cellphones.com.vn/sforum/wp-content/uploads/2020/11/gPvyaz76tASn87RCGuSdDc.jpg', 'MacBook Air M1 siêu tiết kiệm năng lượng', 0, 8, 4, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(44, 'Lenovo IdeaPad 3', 'https://bizweb.dktcdn.net/thumb/1024x1024/100/446/400/products/laptop-lenovo-ideapad-3-15iil05-1-gia-loc.jpg?v=1673925657627', 'Laptop văn phòng cơ bản', 0, 20, 5, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(45, 'Acer Swift 3', 'https://platform.theverge.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/21786687/mchin_181113_4146_0009.0.jpg?quality=90&strip=all&crop=0,0,100,100', 'Laptop văn phòng nhẹ, pin lâu', 0, 10, 6, 2, 1, 0, NULL, NULL, '2025-10-07 15:33:32'),
(46, 'MSI Summit E13', 'https://reviewed-com-res.cloudinary.com/image/fetch/s--vzrKEl6l--/b_white,c_limit,cs_srgb,f_auto,fl_progressive.strip_profile,g_center,h_668,q_auto,w_1187/https://reviewed-production.s3.amazonaws.com/1626297722386/msisummithero.jpeg', 'Laptop văn phòng hiệu suất cao', 0, 5, 7, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(47, 'Razer Blade Stealth 13', 'https://platform.theverge.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/20104450/mchin_181015_4105_0011.0.jpg?quality=90&strip=all&crop=0,0,100,100', 'Laptop văn phòng sang trọng', 0, 7, 8, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(48, 'Microsoft Surface Go 3', 'https://surfacecity.vn/wp-content/uploads/surface-go-3-surfacecity-1s.jpg', 'Laptop văn phòng nhỏ gọn', 0, 12, 9, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(49, 'Samsung Galaxy Book2', 'https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/laptop/Samsung/Samsung-Galaxy-Book-2-5.jpg', 'Laptop văn phòng pin lâu', 0, 10, 10, 2, 1, 0, NULL, NULL, '2025-10-07 15:33:32'),
(50, 'Dell Latitude 3420', 'https://bizweb.dktcdn.net/thumb/1024x1024/100/446/400/products/laptop-dell-latitude-3420-gia-loc-1.jpg?v=1697687946317', 'Laptop văn phòng doanh nghiệp', 0, 10, 1, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(51, 'HP ProBook 450', 'https://minhvu.vn/upload/hp-probook/hp-probook-450-g5/hp-probook-450-g5-jp.jpg', 'Laptop văn phòng mạnh mẽ', 0, 8, 2, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(52, 'Asus ExpertBook B1', 'https://www.vzstore.vn/wp-content/uploads/2024/11/ASUS-ExpertBook-B1-B1402CVA-7.jpg', 'Laptop văn phòng bền bỉ', 0, 10, 3, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(53, 'Apple MacBook Pro 13', 'https://www.apple.com/v/macbook-pro-13/p/images/overview/hero_endframe__bsza6x4fldiq_large_2x.jpg', 'Laptop văn phòng hiệu năng cao', 0, 6, 4, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(54, 'Lenovo ThinkPad X1 Carbon', 'https://minhvu.vn/upload/lenovo-thinkpad-x1-carbon-yoga/thinkpad-x1-carbon-gen-6/lenovo-thinkpad-x1-carbon-gen-6-cud.jpg', 'Laptop văn phòng cao cấp', 0, 4, 5, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(55, 'Acer TravelMate P2', 'https://us.v-cdn.net/6036147/uploads/T0H47CN5HJWR/r-34-2-1-1200x675.jpg', 'Laptop văn phòng ổn định', 0, 10, 6, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(56, 'MSI Prestige 14', 'https://nguyencongpc.vn/media/product/21768-9fb26015f22a3e74673b.jpg', 'Laptop văn phòng cho designer', 0, 5, 7, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(57, 'Razer Book 14', 'https://assets2.razerzone.com/images/pnx.assets/3df7902fb78730b5b8ca5a23dcfbfc7a/razer-blade-14-2023-ogimage-1200x630.png', 'Laptop văn phòng nhẹ, tinh tế', 0, 6, 8, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(58, 'Microsoft Surface Laptop Studio', 'https://surfaceviet.vn/wp-content/uploads/2023/09/Surface-Laptop-Studio-2-chinh-hang.png', 'Laptop văn phòng 2 trong 1', 0, 5, 9, 2, 1, 0, NULL, NULL, '2025-10-07 15:33:32'),
(59, 'Samsung Galaxy Book Flex', 'https://laptopnsc.vn/upload/product/ss-np950qcg-3-.jpg', 'Laptop văn phòng màn cảm ứng', 0, 7, 10, 2, 0, 0, NULL, NULL, '2025-10-07 15:33:32'),
(90, 'Dell Precision 5570', 'https://product.hstatic.net/1000089469/product/dell-precision-5570-lsb___6__f969f667b7924615abeae61d137b5c92_master.jpg', 'Laptop đồ họa mạnh mẽ, dành cho kỹ sư chuyên nghiệp', 0, 10, 1, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(91, 'Dell XPS 15 Creator', 'https://cdn.mos.cms.futurecdn.net/zUeAevTo8KAEhbtrjafb5R.jpg', 'Laptop đồ họa mỏng nhẹ, màn chuẩn màu', 0, 8, 1, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(92, 'HP ZBook Firefly 15 G10', 'https://static0.pocketnowimages.com/wordpress/wp-content/uploads/2023/07/hp-zbook-fireflyg10_img_20230731_112458_1.jpg', 'Laptop đồ họa di động cho kỹ sư, thiết kế bền bỉ', 0, 10, 2, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(93, 'HP Envy 16 Creator', 'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2022/11/Review-HP-Envy-16-2.jpg', 'Laptop đồ họa cao cấp, phù hợp designer', 0, 8, 2, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(94, 'Asus ProArt Studiobook 16', 'https://i.rtings.com/assets/products/Zea7WSC2/asus-proart-studiobook-pro-16-oled-2021/design-medium.jpg?format=auto', 'Laptop đồ họa chuyên nghiệp, chuẩn màu Pantone', 0, 6, 3, 4, 1, 0, NULL, NULL, '2025-10-07 15:59:29'),
(95, 'Asus Vivobook Pro 15 OLED', 'https://i.ytimg.com/vi/5gmf2Y5Q3JI/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBkDk6GiCazTk9yYA0bp9Gd6FYSZQ', 'Laptop đồ họa tầm trung, màn OLED 120Hz', 0, 12, 3, 4, 1, 0, NULL, NULL, '2025-10-07 15:59:29'),
(96, 'MSI Creator Z17', 'https://cdn2.fptshop.com.vn/unsafe/1920x0/filters:format(webp):quality(75)/msi_creator_z17hx_review_2f43757ea9.jpg', 'Laptop đồ họa cao cấp, hiệu năng mạnh', 0, 5, 4, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(97, 'MSI Prestige 15', 'https://owlgaming.vn/wp-content/uploads/2019/09/MSI-Prestige-15-A10SC-1-1.jpg', 'Laptop đồ họa mỏng nhẹ, pin lâu', 0, 7, 4, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(98, 'Acer ConceptD 7', 'https://cdn2.fptshop.com.vn/unsafe/Uploads/images/tin-tuc/108475/Originals/acer-conceptd-7-ezel-pro-hands-on-12.jpg', 'Laptop đồ họa chuyên nghiệp, GPU mạnh mẽ', 0, 4, 5, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(99, 'Acer Swift X 14', 'https://cohotech.vn/wp-content/uploads/2024/01/Acer-Swift-X-14-01.jpg', 'Laptop đồ họa nhẹ, GPU RTX 4050', 0, 8, 5, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(100, 'Lenovo ThinkPad P16', 'https://www.laptopvip.vn/images/ab__webp/detailed/30/ThinkPad-P16-Gen-1-CT5-05-www.laptopvip.vn-1672052075.webp', 'Laptop kỹ thuật chuyên nghiệp, siêu bền', 0, 6, 6, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(101, 'Lenovo IdeaPad Creator 5', 'https://laptopworld.vn/media/lib/16-05-2024/screenshot_1715828679.png', 'Laptop đồ họa tầm trung, GPU GTX 1650', 0, 10, 6, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(102, 'Razer Blade 15 Studio', 'https://st.quantrimang.com/photos/image/2020/05/30/razer-blade-15-studio-edition1.jpg', 'Laptop đồ họa siêu mỏng, màn 4K 100% DCI-P3', 0, 5, 7, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(103, 'Razer Blade 17 Studio', 'https://macstores.vn/wp-content/uploads/2022/07/razer-blade-17-studio-edition-3.jpg', 'Laptop đồ họa hiệu năng cao, màn lớn', 0, 3, 7, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(104, 'Gigabyte Aero 15 OLED', 'https://i.ytimg.com/vi/39pd_PtnS0w/maxresdefault.jpg', 'Laptop đồ họa OLED chuẩn màu, hiệu năng cao', 0, 7, 8, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(105, 'Gigabyte Aero 16', 'https://photo2.tinhte.vn/data/attachment-files/2022/02/5855561_cover_trentay_Gigabyte_Aero16_tinhte11.jpg', 'Laptop đồ họa cao cấp, màn 16 inch chuẩn Delta-E <2', 0, 4, 8, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(106, 'Apple MacBook Pro 14 M3', 'https://mac24h.vn/images/detailed/95/Macbook_Pro_14_inch_M3_PRO.jpg', 'MacBook đồ họa chuyên nghiệp cho designer và video editor', 0, 6, 9, 4, 1, 0, NULL, NULL, '2025-10-07 15:59:29'),
(107, 'Apple MacBook Pro 16 M3 Max', 'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2023/11/danh-gia-macbook-pro-16-inch-m3-max-1.jpg', 'Laptop đồ họa mạnh nhất, tối ưu cho kỹ thuật & dựng phim', 0, 4, 9, 4, 0, 0, NULL, NULL, '2025-10-07 15:59:29'),
(108, 'toitest', 'khong co', '2222', 0, 20, 3, 3, 0, 1, '2025-10-24 08:44:50', NULL, '2025-10-24 08:32:54'),
(109, 'Tôi test lại', 'không có', 'ưdfnjdsfsdfdfs', 0, 0, 1, 1, 0, 1, '2025-10-24 08:44:46', NULL, '2025-10-24 08:36:45'),
(110, 'toi test them', 'https://laptopworld.vn/media/product/250_23889_30048_laptop_dell_15_dc15250_cph99.jpg', 'khong co', 0, 0, 3, 3, 0, 0, NULL, NULL, '2025-10-24 08:45:36');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products_variants`
--

CREATE TABLE `products_variants` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `oldprice` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `ram` varchar(255) DEFAULT NULL,
  `storage` varchar(155) DEFAULT NULL,
  `cpu` varchar(255) DEFAULT NULL,
  `vga` varchar(255) DEFAULT NULL,
  `monitor` varchar(255) DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `is_delete` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products_variants`
--

INSERT INTO `products_variants` (`id`, `product_id`, `price`, `oldprice`, `quantity`, `color`, `ram`, `storage`, `cpu`, `vga`, `monitor`, `updated_at`, `created_at`, `deleted_at`, `is_delete`) VALUES
(1, 1, 22000000, 25000000, 5, 'Black', '16GB', '512GB', 'i5-12500H', 'RTX 3050 4GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(2, 1, 23500000, 26000000, 3, 'Gray', '16GB', '1TB', 'i7-12700H', 'RTX 3060 6GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(3, 2, 52000000, 58000000, 4, 'Silver', '32GB', '1TB', 'i9-12900HK', 'RTX 4070 8GB', '15.6\" QHD', NULL, '2025-10-07', NULL, 0),
(4, 2, 54000000, 59000000, 2, 'White', '32GB', '2TB', 'i9-13900HX', 'RTX 4080 12GB', '16\" QHD+', NULL, '2025-10-07', NULL, 0),
(5, 3, 65000000, 70000000, 3, 'Gray', '32GB', '1TB', 'i9-13900HX', 'RTX 4080 12GB', '16\" QHD', NULL, '2025-10-07', NULL, 0),
(6, 4, 28000000, 31000000, 6, 'Black', '16GB', '1TB', 'i7-13700H', 'RTX 4060 8GB', '16\" FHD', NULL, '2025-10-07', NULL, 0),
(7, 4, 29500000, 32000000, 5, 'White', '32GB', '1TB', 'i9-13900H', 'RTX 4070 8GB', '16\" QHD', NULL, '2025-10-07', NULL, 0),
(8, 5, 36000000, 39000000, 4, 'Silver', '16GB', '1TB', 'i7-13700H', 'RTX 4070 8GB', '16\" QHD', NULL, '2025-10-07', NULL, 0),
(9, 6, 19000000, 21000000, 8, 'Black', '8GB', '512GB', 'i5-12500H', 'RTX 3050 4GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(10, 6, 20500000, 23000000, 6, 'Gray', '16GB', '1TB', 'i7-12700H', 'RTX 4060 8GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(11, 7, 22000000, 24000000, 6, 'Gray', '16GB', '512GB', 'Ryzen 7 7735HS', 'RTX 4050 6GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(12, 7, 23500000, 25500000, 5, 'Black', '32GB', '1TB', 'Ryzen 9 7940HS', 'RTX 4060 8GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(13, 8, 25000000, 28000000, 4, 'Black', '16GB', '1TB', 'i7-13700H', 'RTX 4060 8GB', '15.6\" QHD', NULL, '2025-10-07', NULL, 0),
(14, 9, 32000000, 35000000, 3, 'Gray', '32GB', '1TB', 'Ryzen 9 7945HX', 'RTX 4070 8GB', '15.6\" QHD', NULL, '2025-10-07', NULL, 0),
(15, 10, 42000000, 45000000, 4, 'White', '32GB', '1TB', 'Ryzen 9 7940HS', 'RTX 4060 8GB', '14\" QHD+', NULL, '2025-10-07', NULL, 0),
(16, 11, 55000000, 60000000, 2, 'Gray', '32GB', '2TB', 'Ryzen 9 7945HX', 'RTX 4070 8GB', '16\" Touch QHD+', NULL, '2025-10-07', NULL, 0),
(17, 12, 21000000, 23000000, 8, 'Black', '16GB', '512GB', 'i5-12500H', 'RTX 4050 6GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(18, 12, 22500000, 24500000, 6, 'White', '32GB', '1TB', 'i7-13700H', 'RTX 4060 8GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(19, 13, 24000000, 27000000, 6, 'Gray', '16GB', '1TB', 'i7-13620H', 'RTX 4060 8GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(20, 14, 25000000, 28000000, 5, 'White', '16GB', '1TB', 'i7-13620H', 'RTX 4060 8GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(21, 15, 60000000, 65000000, 2, 'Black', '64GB', '2TB', 'i9-13980HX', 'RTX 4080 12GB', '17\" QHD+', NULL, '2025-10-07', NULL, 0),
(22, 16, 38000000, 42000000, 3, 'Gray', '32GB', '1TB', 'i7-13700H', 'RTX 4070 8GB', '14\" QHD+', NULL, '2025-10-07', NULL, 0),
(23, 17, 19000000, 22000000, 10, 'Black', '16GB', '512GB', 'i5-12450H', 'RTX 3050 4GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(24, 17, 20500000, 23500000, 7, 'Red', '16GB', '1TB', 'i7-12700H', 'RTX 3060 6GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(25, 18, 20000000, 23000000, 8, 'Black', '16GB', '512GB', 'i5-13420H', 'RTX 4050 6GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(26, 19, 45000000, 49000000, 5, 'Gray', '32GB', '1TB', 'i9-13900HX', 'RTX 4070 8GB', '16\" QHD+', NULL, '2025-10-07', NULL, 0),
(27, 20, 70000000, 75000000, 2, 'Silver', '64GB', '2TB', 'i9-13980HX', 'RTX 4090 16GB', '17\" MiniLED', NULL, '2025-10-07', NULL, 0),
(28, 21, 20000000, 22000000, 9, 'Black', '16GB', '512GB', 'i5-13420H', 'RTX 3050 4GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(29, 21, 21500000, 23500000, 6, 'Gray', '16GB', '1TB', 'i7-13700H', 'RTX 4060 8GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(30, 22, 28000000, 32000000, 5, 'Gray', '16GB', '1TB', 'Ryzen 7 7840HS', 'RTX 4060 8GB', '16\" QHD+', NULL, '2025-10-07', NULL, 0),
(31, 23, 50000000, 54000000, 3, 'Black', '32GB', '2TB', 'Ryzen 9 7945HX', 'RTX 4080 12GB', '16\" QHD+', NULL, '2025-10-07', NULL, 0),
(32, 24, 60000000, 65000000, 3, 'Black', '32GB', '1TB', 'Ryzen 9 7940HS', 'RTX 4070 8GB', '14\" QHD+', NULL, '2025-10-07', NULL, 0),
(33, 25, 65000000, 70000000, 2, 'Gray', '32GB', '2TB', 'i9-13900HX', 'RTX 4080 12GB', '15.6\" QHD+', NULL, '2025-10-07', NULL, 0),
(34, 30, 16000000, 18000000, 10, 'Silver', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(35, 30, 18500000, 20500000, 6, 'Gray', '16GB', '1TB', 'i7-1355U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(36, 31, 15500000, 17500000, 8, 'Silver', '8GB', '512GB', 'i5-1235U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(37, 31, 17500000, 19500000, 5, 'Gold', '16GB', '1TB', 'i7-1355U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(38, 32, 14000000, 16000000, 12, 'Gray', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(39, 33, 28000000, 31000000, 8, 'Silver', '8GB', '256GB', 'Apple M2', 'Integrated GPU', '13.6\" Retina', NULL, '2025-10-07', NULL, 0),
(40, 33, 32000000, 34000000, 6, 'Midnight', '16GB', '512GB', 'Apple M2', 'Integrated GPU', '13.6\" Retina', NULL, '2025-10-07', NULL, 0),
(41, 34, 17500000, 19500000, 10, 'Gray', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(42, 34, 19500000, 21500000, 6, 'Silver', '16GB', '1TB', 'i7-1355U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(43, 35, 13500000, 15500000, 10, 'Black', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(44, 36, 15000000, 17000000, 8, 'Gray', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(45, 37, 30000000, 33000000, 5, 'Silver', '16GB', '1TB', 'i7-1360P', 'Intel Iris Xe', '13.4\" FHD+', NULL, '2025-10-07', NULL, 0),
(46, 38, 26000000, 29000000, 6, 'Platinum', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '13.5\" PixelSense', NULL, '2025-10-07', NULL, 0),
(47, 38, 29500000, 32000000, 5, 'Black', '16GB', '512GB', 'i7-1355U', 'Intel Iris Xe', '13.5\" PixelSense', NULL, '2025-10-07', NULL, 0),
(48, 39, 24000000, 26500000, 7, 'Silver', '16GB', '512GB', 'i7-1355U', 'Intel Iris Xe', '15.6\" AMOLED', NULL, '2025-10-07', NULL, 0),
(49, 40, 14500000, 16500000, 10, 'Black', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(50, 41, 23000000, 25500000, 8, 'Silver', '16GB', '512GB', 'i7-1355U', 'Intel Iris Xe', '13.3\" OLED', NULL, '2025-10-07', NULL, 0),
(51, 42, 22000000, 24500000, 7, 'Blue', '16GB', '512GB', 'i7-1355U', 'Intel Iris Xe', '14\" OLED', NULL, '2025-10-07', NULL, 0),
(52, 43, 22000000, 24000000, 6, 'Silver', '8GB', '256GB', 'Apple M1', 'Integrated GPU', '13.3\" Retina', NULL, '2025-10-07', NULL, 0),
(53, 44, 12000000, 13500000, 10, 'Gray', '8GB', '512GB', 'i5-1135G7', 'Intel Iris Xe', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(54, 45, 17000000, 19000000, 8, 'Silver', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(55, 46, 32000000, 34000000, 4, 'Black', '16GB', '1TB', 'i7-13700H', 'Intel Iris Xe', '13.3\" Touch', NULL, '2025-10-07', NULL, 0),
(56, 47, 28000000, 30000000, 5, 'Black', '16GB', '1TB', 'i7-1355U', 'Intel Iris Xe', '13.3\" FHD', NULL, '2025-10-07', NULL, 0),
(57, 48, 18000000, 20000000, 9, 'Silver', '8GB', '256GB', 'Intel i5-1235U', 'Intel UHD', '10.5\" Touch', NULL, '2025-10-07', NULL, 0),
(58, 49, 19500000, 21500000, 8, 'Silver', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(59, 50, 19000000, 21000000, 7, 'Gray', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(60, 51, 21000000, 23000000, 6, 'Silver', '16GB', '512GB', 'i7-1355U', 'Intel Iris Xe', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(61, 52, 18500000, 20500000, 9, 'Black', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(62, 53, 36000000, 38000000, 4, 'Silver', '16GB', '1TB', 'Apple M2', 'Integrated GPU', '13.3\" Retina', NULL, '2025-10-07', NULL, 0),
(63, 54, 42000000, 45000000, 3, 'Black', '16GB', '1TB', 'i7-1370P', 'Intel Iris Xe', '14\" OLED', NULL, '2025-10-07', NULL, 0),
(64, 55, 17000000, 19000000, 8, 'Gray', '8GB', '512GB', 'i5-1335U', 'Intel Iris Xe', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(65, 56, 27000000, 29500000, 5, 'White', '16GB', '1TB', 'i7-13700H', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(66, 57, 32000000, 34000000, 4, 'Silver', '16GB', '1TB', 'i7-1360P', 'Intel Iris Xe', '14\" FHD', NULL, '2025-10-07', NULL, 0),
(67, 58, 38000000, 41000000, 3, 'Platinum', '16GB', '512GB', 'i7-13800H', 'Intel Iris Xe', '14.4\" Touch', NULL, '2025-10-07', NULL, 0),
(68, 59, 30000000, 32500000, 5, 'Blue', '16GB', '512GB', 'i7-1360P', 'Intel Iris Xe', '15.6\" AMOLED Touch', NULL, '2025-10-07', NULL, 0),
(69, 26, 70000000, 76000000, 4, 'Black', '16GB', '1TB SSD', 'Intel Core i9-13900HX', 'RTX 4080 12GB', '16\" QHD+ 240Hz', NULL, '2025-10-07', NULL, 0),
(70, 26, 74000000, 78000000, 3, 'Mercury', '32GB', '2TB SSD', 'Intel Core i9-13950HX', 'RTX 4090 16GB', '16\" QHD+ 240Hz', NULL, '2025-10-07', NULL, 0),
(71, 27, 75000000, 80000000, 3, 'Black', '32GB', '1TB SSD', 'Intel Core i9-13950HX', 'RTX 4080 12GB', '18\" QHD+ 240Hz', NULL, '2025-10-07', NULL, 0),
(72, 27, 82000000, 87000000, 2, 'Mercury', '64GB', '2TB SSD', 'Intel Core i9-13980HX', 'RTX 4090 16GB', '18\" QHD+ 240Hz', NULL, '2025-10-07', NULL, 0),
(73, 28, 26000000, 29000000, 12, 'Black', '16GB', '512GB SSD', 'Intel Core i7-13700H', 'RTX 4060 8GB', '15.6\" FHD 144Hz', NULL, '2025-10-07', NULL, 0),
(74, 28, 29500000, 32000000, 8, 'Gray', '16GB', '1TB SSD', 'Intel Core i7-13700HX', 'RTX 4070 8GB', '15.6\" QHD 165Hz', NULL, '2025-10-07', NULL, 0),
(75, 29, 42000000, 45000000, 5, 'Black', '32GB', '1TB SSD', 'Intel Core i9-13900HX', 'RTX 4070 8GB', '17.3\" QHD 165Hz', NULL, '2025-10-07', NULL, 0),
(76, 29, 46000000, 49000000, 3, 'Silver', '32GB', '2TB SSD', 'Intel Core i9-13950HX', 'RTX 4080 12GB', '17.3\" QHD 240Hz', NULL, '2025-10-07', NULL, 0),
(77, 90, 42000000, 45000000, 5, 'Gray', '32GB', '1TB SSD', 'Intel Core i7-13700H', 'RTX A1000 6GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(78, 90, 48000000, 52000000, 3, 'Silver', '64GB', '2TB SSD', 'Intel Core i9-13900H', 'RTX A2000 8GB', '15.6\" 4K', NULL, '2025-10-07', NULL, 0),
(79, 91, 39000000, 42000000, 6, 'Silver', '32GB', '1TB SSD', 'Intel Core i7-13700H', 'RTX 4060 8GB', '15.6\" OLED 3.5K', NULL, '2025-10-07', NULL, 0),
(80, 92, 37000000, 40000000, 5, 'Gray', '16GB', '1TB SSD', 'Intel Core i7-1360P', 'RTX A500 4GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(81, 93, 34000000, 36500000, 6, 'Silver', '16GB', '1TB SSD', 'Intel Core i7-13700H', 'RTX 4060 8GB', '16\" QHD+', NULL, '2025-10-07', NULL, 0),
(82, 94, 47000000, 50000000, 4, 'Black', '32GB', '1TB SSD', 'AMD Ryzen 9 7940HS', 'RTX 4070 8GB', '16\" OLED 120Hz', NULL, '2025-10-07', NULL, 0),
(83, 94, 52000000, 55000000, 2, 'Gray', '64GB', '2TB SSD', 'Intel Core i9-13980HX', 'RTX 4080 12GB', '16\" OLED 120Hz', NULL, '2025-10-07', NULL, 0),
(84, 95, 24000000, 26000000, 10, 'Gray', '16GB', '512GB SSD', 'Ryzen 7 7735HS', 'RTX 4050 6GB', '15.6\" OLED 120Hz', NULL, '2025-10-07', NULL, 0),
(85, 95, 27000000, 29000000, 5, 'Silver', '32GB', '1TB SSD', 'Ryzen 9 7940HS', 'RTX 4060 8GB', '15.6\" OLED 120Hz', NULL, '2025-10-07', NULL, 0),
(86, 96, 56000000, 59000000, 3, 'Gray', '32GB', '1TB SSD', 'Intel Core i9-13900HX', 'RTX 4070 8GB', '17\" QHD+', NULL, '2025-10-07', NULL, 0),
(87, 97, 29000000, 31000000, 6, 'Silver', '16GB', '512GB SSD', 'Intel Core i7-13700H', 'RTX 3050 4GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(88, 98, 52000000, 56000000, 4, 'White', '32GB', '1TB SSD', 'Intel Core i9-13900H', 'RTX 4070 8GB', '15.6\" 4K UHD', NULL, '2025-10-07', NULL, 0),
(89, 99, 28000000, 30000000, 6, 'Silver', '16GB', '512GB SSD', 'Intel Core i7-13700H', 'RTX 4050 6GB', '14\" OLED', NULL, '2025-10-07', NULL, 0),
(90, 100, 58000000, 62000000, 3, 'Black', '64GB', '2TB SSD', 'Intel Core i9-13900HX', 'RTX 4080 12GB', '16\" WQXGA', NULL, '2025-10-07', NULL, 0),
(91, 101, 24000000, 26000000, 8, 'Gray', '16GB', '512GB SSD', 'Ryzen 7 5800H', 'GTX 1650 4GB', '15.6\" FHD', NULL, '2025-10-07', NULL, 0),
(92, 102, 65000000, 69000000, 4, 'Black', '32GB', '1TB SSD', 'Intel Core i9-13900H', 'RTX 4070 8GB', '15.6\" 4K OLED', NULL, '2025-10-07', NULL, 0),
(93, 103, 73000000, 78000000, 3, 'Black', '32GB', '1TB SSD', 'Intel Core i9-13980HX', 'RTX 4080 12GB', '17.3\" QHD', NULL, '2025-10-07', NULL, 0),
(94, 104, 42000000, 45000000, 5, 'Silver', '32GB', '1TB SSD', 'Intel Core i7-13700H', 'RTX 4060 8GB', '15.6\" OLED 4K', NULL, '2025-10-07', NULL, 0),
(95, 105, 48000000, 51000000, 4, 'Gray', '32GB', '1TB SSD', 'Intel Core i9-13900H', 'RTX 4070 8GB', '16\" OLED', NULL, '2025-10-07', NULL, 0),
(96, 106, 55000000, 58000000, 6, 'Silver', '18GB', '512GB SSD', 'Apple M3 Pro', 'Integrated', '14\" Liquid Retina XDR', NULL, '2025-10-07', NULL, 0),
(97, 107, 78000000, 82000000, 4, 'Space Black', '36GB', '1TB SSD', 'Apple M3 Max', 'Integrated', '16\" Liquid Retina XDR', NULL, '2025-10-07', NULL, 0),
(103, 110, 1000000, 3000000, 2, 'gray', '2gb', '64gb', 'i7', '3070TI', '13inch', '2025-10-24', '2025-10-24', NULL, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `ho` varchar(255) DEFAULT NULL,
  `ten` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `diachi` text DEFAULT NULL,
  `congty` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL DEFAULT '1',
  `role` int(1) NOT NULL,
  `avata` text DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `is_delete` int(11) NOT NULL DEFAULT 0,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `ho`, `ten`, `email`, `diachi`, `congty`, `password`, `role`, `avata`, `phone`, `is_delete`, `deleted_at`, `created_at`, `updated_at`) VALUES
(2, 'Thinh', 'Chu', 'user1@gmail.com', NULL, NULL, '123456', 0, 'user1.png', '0987654321', 1, NULL, '2025-09-07 12:39:54', '2025-09-07 12:39:54'),
(3, NULL, NULL, 'user2@gmail.com', NULL, NULL, '123456', 0, 'user2.png', '0978123456', 1, NULL, '2025-09-07 12:39:54', '2025-09-10 03:26:17'),
(6, 'Dinh', 'Giang', 'toitest@gmail.com', '138 Tân Triều, Thanh Trì, HN', 'Không', '$2b$10$P9FvSZMvfy8/fjYZ/jYI.eI88Ik19ztVT1na.KFxkgdAE4aVxUUaW', 0, NULL, '1038472649', 0, NULL, '2025-09-20 16:34:58', '2025-10-14 02:23:01'),
(7, NULL, NULL, 'toitest1@gmail.com', NULL, NULL, '$2b$10$dqFGAA2bKrZ1f0mHUFJZ2OjLzWN/Nnd7QW0LveTIJmLWjUq/zrDnm', 0, NULL, NULL, 0, NULL, '2025-09-21 22:17:20', NULL),
(8, 'Lưu', 'Khải', 'admin@gmail.com', '124 Tân Triều', NULL, '$2b$10$ZtQ09FgDoneukoX3mwx9pO1ukMijxXkFTurBvkDi/qVlFJRrAY0Sa', 1, NULL, '01736592857', 0, NULL, '2025-10-20 02:08:30', NULL),
(9, NULL, NULL, 'fff@gmail.com', NULL, NULL, '$2b$10$aiHv4/sQ15mKQh/ypX7X7upymQ46IvDWxNX8aG/94SckeFrL9bQua', 0, NULL, NULL, 0, NULL, '2025-10-24 03:05:07', NULL),
(10, NULL, NULL, 'e@gmail.com', NULL, NULL, '$2b$10$ZrDVIElEWukfTlZo1ZA.M.Dp0kvfIfOqwbcVkSKkYpgOiIaap5XhK', 0, NULL, NULL, 0, NULL, '2025-10-24 03:10:09', NULL),
(11, NULL, NULL, 'e1@gmail.com', NULL, NULL, '$2b$10$Wjpdpyw7.5fOC93LELTIO.skqOKcpUzG9JGsYYknPYDXW/lASNYuq', 1, NULL, NULL, 0, '2025-10-24 03:18:37', '2025-10-24 03:12:34', NULL),
(12, NULL, NULL, 'G@gmail.com', NULL, NULL, '$2b$10$8KqDafXXC4UQY7Iq74DkvONo9Vhv99/1Bf1gOL6I1vdImjiMxjPMK', 0, NULL, NULL, 0, NULL, '2025-10-24 03:13:19', NULL),
(13, 'Vương', 'Vang', 'g1@gmail.com', 'Hương Cảng', '', '$2b$10$12fkwUN/kV600joAxDeoMuPcb1e4fltp9RWgeGZjYQ5vz959v.Xm.', 1, NULL, '0284958273', 0, '2025-10-24 03:21:20', '2025-10-24 03:18:10', NULL),
(14, '1', '2', 'Customer1', '', '', '$2b$10$SbGknWY5o5oigQwvrSCBZ.V1.tAoPSOm/f9Jq0pc2PkpO4AmHyY1q', 0, NULL, '03769029384', 1, '2025-10-24 03:59:18', '2025-10-24 03:58:53', NULL),
(15, 'Nguyen', 'Van A', 'user_1@gmail.com', '123 Tran Hung Dao, HN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345001', 0, NULL, '2025-10-24 09:59:00', NULL),
(16, 'Tran', 'Thi B', 'user_2@gmail.com', '456 Le Loi, HCM', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345002', 0, NULL, '2025-10-24 09:59:00', NULL),
(17, 'Le', 'Van C', 'user_3@gmail.com', '789 Nguyen Trai, DN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345003', 0, NULL, '2025-10-24 09:59:00', NULL),
(18, 'Pham', 'Thi D', 'user_4@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(19, 'Hoang', 'Van E', 'user_5@gmail.com', '321 Hai Ba Trung, HN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345005', 0, NULL, '2025-10-24 09:59:00', NULL),
(20, 'Vu', 'Thi F', 'user_6@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(21, 'Dang', 'Van G', 'user_7@gmail.com', '654 Ly Thuong Kiet, HCM', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345007', 0, NULL, '2025-10-24 09:59:00', NULL),
(22, 'Bui', 'Thi H', 'user_8@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(23, 'Nguyen', 'Van I', 'user_9@gmail.com', '987 Ton Duc Thang, DN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345009', 0, NULL, '2025-10-24 09:59:00', NULL),
(24, 'Tran', 'Thi J', 'user_10@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(25, 'Le', 'Van K', 'user_11@gmail.com', '147 Pham Van Dong, HN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345011', 0, NULL, '2025-10-24 09:59:00', NULL),
(26, 'Pham', 'Thi L', 'user_12@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(27, 'Hoang', 'Van M', 'user_13@gmail.com', '258 Nguyen Hue, HCM', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345013', 0, NULL, '2025-10-24 09:59:00', NULL),
(28, 'Vu', 'Thi N', 'user_14@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(29, 'Dang', 'Van O', 'user_15@gmail.com', '369 Tran Phu, DN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345015', 0, NULL, '2025-10-24 09:59:00', NULL),
(30, 'Bui', 'Thi P', 'user_16@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(31, 'Nguyen', 'Van Q', 'user_17@gmail.com', '741 Le Duan, HN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345017', 0, NULL, '2025-10-24 09:59:00', NULL),
(32, 'Tran', 'Thi R', 'user_18@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(33, 'Le', 'Van S', 'user_19@gmail.com', '852 Hoang Dieu, HCM', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345019', 0, NULL, '2025-10-24 09:59:00', NULL),
(34, 'Pham', 'Thi T', 'user_20@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(35, 'Hoang', 'Van U', 'user_21@gmail.com', '963 Nguyen Van Cu, DN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345021', 0, NULL, '2025-10-24 09:59:00', NULL),
(36, 'Vu', 'Thi V', 'user_22@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(37, 'Dang', 'Van W', 'user_23@gmail.com', '159 Ly Thai To, HN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345023', 0, NULL, '2025-10-24 09:59:00', NULL),
(38, 'Bui', 'Thi X', 'user_24@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(39, 'Nguyen', 'Van Y', 'user_25@gmail.com', '357 Tran Dai Nghia, HCM', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345025', 0, NULL, '2025-10-24 09:59:00', NULL),
(40, 'Tran', 'Thi Z', 'user_26@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(41, 'Le', 'Van AA', 'user_27@gmail.com', '468 Nguyen Thi Minh Khai, DN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345027', 0, NULL, '2025-10-24 09:59:00', NULL),
(42, 'Pham', 'Thi AB', 'user_28@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL),
(43, 'Hoang', 'Van AC', 'user_29@gmail.com', '579 Le Van Sy, HN', NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, '0912345029', 0, NULL, '2025-10-24 09:59:00', NULL),
(44, 'Vu', 'Thi AD', 'user_30@gmail.com', NULL, NULL, '$2b$10$RandomHashedPassword1234567890abcdefg', 0, NULL, NULL, 0, NULL, '2025-10-24 09:59:00', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `news_details`
--
ALTER TABLE `news_details`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders_details`
--
ALTER TABLE `orders_details`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `products_variants`
--
ALTER TABLE `products_variants`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `news_details`
--
ALTER TABLE `news_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT cho bảng `orders_details`
--
ALTER TABLE `orders_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT cho bảng `products_variants`
--
ALTER TABLE `products_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
