-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.5.19-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- petgoods 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `petgoods` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `petgoods`;

-- 테이블 petgoods.address 구조 내보내기
CREATE TABLE IF NOT EXISTS `address` (
  `address_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `address_last_date` datetime NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`address_no`) USING BTREE,
  KEY `FK_address_customer` (`id`),
  CONSTRAINT `FK_address_customer` FOREIGN KEY (`id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.address:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;

-- 테이블 petgoods.answer 구조 내보내기
CREATE TABLE IF NOT EXISTS `answer` (
  `a_no` int(11) NOT NULL AUTO_INCREMENT,
  `q_no` int(11) NOT NULL,
  `id` varchar(50) NOT NULL,
  `a_content` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`a_no`),
  KEY `FK_answer_question` (`q_no`),
  KEY `FK_answer_employees` (`id`),
  CONSTRAINT `FK_answer_employees` FOREIGN KEY (`id`) REFERENCES `employees` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_answer_question` FOREIGN KEY (`q_no`) REFERENCES `question` (`q_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.answer:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;

-- 테이블 petgoods.cart 구조 내보내기
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_no` int(11) NOT NULL AUTO_INCREMENT,
  `product_no` int(11) NOT NULL,
  `id` varchar(50) NOT NULL,
  `cart_cnt` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`cart_no`) USING BTREE,
  KEY `FK_cart_product` (`product_no`),
  KEY `FK_cart_customer` (`id`),
  CONSTRAINT `FK_cart_customer` FOREIGN KEY (`id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cart_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.cart:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

-- 테이블 petgoods.category 구조 내보내기
CREATE TABLE IF NOT EXISTS `category` (
  `category_no` int(11) NOT NULL AUTO_INCREMENT,
  `category_main_name` varchar(50) NOT NULL,
  `category_sub_name` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`category_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.category:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- 테이블 petgoods.customer 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer` (
  `cstm_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `cstm_name` varchar(50) NOT NULL,
  `cstm_add` text NOT NULL,
  `cstm_email` varchar(50) NOT NULL,
  `cstm_birth` date NOT NULL,
  `cstm_gender` enum('M','F') NOT NULL,
  `cstm_rank` enum('BRONZE','SILVER','GOLD') NOT NULL,
  `cstm_point` int(11) NOT NULL,
  `cstm_last_login` datetime NOT NULL,
  `cstm_agree` enum('Y','N') NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`cstm_no`) USING BTREE,
  KEY `FK_customer_id_list` (`id`),
  CONSTRAINT `FK_customer_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.customer:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;

-- 테이블 petgoods.discount 구조 내보내기
CREATE TABLE IF NOT EXISTS `discount` (
  `discount_no` int(11) NOT NULL AUTO_INCREMENT,
  `product_no` int(11) NOT NULL,
  `discount_start` datetime NOT NULL,
  `discount_end` datetime NOT NULL,
  `discount_rate` double NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`discount_no`) USING BTREE,
  KEY `FK_discount_product` (`product_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.discount:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` (`discount_no`, `product_no`, `discount_start`, `discount_end`, `discount_rate`, `createdate`, `updatedate`) VALUES
	(1, 1, '2022-06-05 00:00:00', '2022-06-08 00:00:00', 0.1, '2023-06-02 10:30:26', '2023-06-02 10:30:26'),
	(3, 1, '2023-06-01 00:00:00', '2023-06-08 00:00:00', 0.7, '2023-06-02 10:36:16', '2023-06-02 10:36:16');
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;

-- 테이블 petgoods.employees 구조 내보내기
CREATE TABLE IF NOT EXISTS `employees` (
  `emp_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `emp_name` varchar(50) NOT NULL,
  `emp_level` enum('1','2') NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`emp_no`),
  KEY `FK_employees_id_list` (`id`),
  CONSTRAINT `FK_employees_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.employees:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;

-- 테이블 petgoods.id_list 구조 내보내기
CREATE TABLE IF NOT EXISTS `id_list` (
  `id_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `last_pw` varchar(50) NOT NULL,
  `active` enum('Y','N') NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`id_no`) USING BTREE,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.id_list:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `id_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `id_list` ENABLE KEYS */;

-- 테이블 petgoods.orders 구조 내보내기
CREATE TABLE IF NOT EXISTS `orders` (
  `order_no` int(11) NOT NULL AUTO_INCREMENT,
  `product_no` int(11) NOT NULL,
  `id` varchar(50) NOT NULL,
  `order_status` enum('주문취소','결제완료','배송완료','구매확정') NOT NULL,
  `order_cnt` int(11) NOT NULL,
  `order_price` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`order_no`) USING BTREE,
  KEY `FK_orders_product` (`product_no`),
  KEY `FK_orders_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.orders:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`order_no`, `product_no`, `id`, `order_status`, `order_cnt`, `order_price`, `createdate`, `updatedate`) VALUES
	(1, 1, 'test', '주문취소', 1, 1000, '2023-06-01 17:42:38', '2023-06-01 17:42:40');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- 테이블 petgoods.point_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `point_history` (
  `point_no` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL,
  `point_pm` enum('+','-') NOT NULL,
  `point` int(11) NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`point_no`) USING BTREE,
  KEY `FK_point_history_orders` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.point_history:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `point_history` DISABLE KEYS */;
INSERT INTO `point_history` (`point_no`, `order_no`, `point_pm`, `point`, `createdate`) VALUES
	(1, 1, '+', 100, '2023-06-01 17:29:28'),
	(2, 1, '+', 100, '2023-06-01 17:29:28'),
	(3, 1, '-', 50, '2023-06-01 17:29:28');
/*!40000 ALTER TABLE `point_history` ENABLE KEYS */;

-- 테이블 petgoods.product 구조 내보내기
CREATE TABLE IF NOT EXISTS `product` (
  `product_no` int(11) NOT NULL AUTO_INCREMENT,
  `category_no` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_stock` int(11) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_status` enum('판매중','품절') NOT NULL,
  `product_info` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`product_no`) USING BTREE,
  KEY `FK_product_category` (`category_no`),
  CONSTRAINT `FK_product_category` FOREIGN KEY (`category_no`) REFERENCES `category` (`category_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.product:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- 테이블 petgoods.product_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `product_img` (
  `product_img_no` int(11) NOT NULL AUTO_INCREMENT,
  `product_no` int(11) NOT NULL,
  `product_ori_filename` varchar(50) NOT NULL,
  `product_save_filename` varchar(50) NOT NULL,
  `product_filetype` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`product_img_no`) USING BTREE,
  KEY `FK_product_img_product` (`product_no`),
  CONSTRAINT `FK_product_img_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.product_img:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `product_img` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_img` ENABLE KEYS */;

-- 테이블 petgoods.pw_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `pw_history` (
  `pw_no` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(50) NOT NULL,
  `pw` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  PRIMARY KEY (`pw_no`),
  KEY `FK_pw_history_id_list` (`id`),
  CONSTRAINT `FK_pw_history_id_list` FOREIGN KEY (`id`) REFERENCES `id_list` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.pw_history:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `pw_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `pw_history` ENABLE KEYS */;

-- 테이블 petgoods.question 구조 내보내기
CREATE TABLE IF NOT EXISTS `question` (
  `q_no` int(11) NOT NULL AUTO_INCREMENT,
  `product_no` int(11) NOT NULL,
  `id` varchar(50) NOT NULL,
  `q_category` enum('상품','교환/환불','배송','기타') NOT NULL,
  `q_title` varchar(50) NOT NULL,
  `q_content` text NOT NULL,
  ` q_status` enum('답변대기','답변완료') NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`q_no`),
  KEY `FK_question_product` (`product_no`),
  KEY `FK_question_customer` (`id`),
  CONSTRAINT `FK_question_customer` FOREIGN KEY (`id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_question_product` FOREIGN KEY (`product_no`) REFERENCES `product` (`product_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.question:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
/*!40000 ALTER TABLE `question` ENABLE KEYS */;

-- 테이블 petgoods.review 구조 내보내기
CREATE TABLE IF NOT EXISTS `review` (
  `review_no` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` int(11) NOT NULL,
  `review_title` varchar(50) NOT NULL,
  `review_content` text NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`review_no`) USING BTREE,
  KEY `FK_review_orders` (`order_no`),
  CONSTRAINT `FK_review_orders` FOREIGN KEY (`order_no`) REFERENCES `orders` (`order_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.review:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;

-- 테이블 petgoods.review_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `review_img` (
  `review_img_no` int(11) NOT NULL AUTO_INCREMENT,
  `review_no` int(11) NOT NULL,
  `review_ori_filename` varchar(50) NOT NULL,
  `review_save_filename` varchar(50) NOT NULL,
  `review_filetype` varchar(50) NOT NULL,
  `createdate` datetime NOT NULL,
  `updatedate` datetime NOT NULL,
  PRIMARY KEY (`review_img_no`) USING BTREE,
  KEY `FK_review_img_review` (`review_no`),
  CONSTRAINT `FK_review_img_review` FOREIGN KEY (`review_no`) REFERENCES `review` (`review_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 petgoods.review_img:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `review_img` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_img` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
