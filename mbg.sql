-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for mbg_tugas
CREATE DATABASE IF NOT EXISTS `mbg_tugas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mbg_tugas`;

-- Dumping structure for table mbg_tugas.bahanmakanan
CREATE TABLE IF NOT EXISTS `bahanmakanan` (
  `id_bahan` int NOT NULL AUTO_INCREMENT,
  `nama_bahan` varchar(100) NOT NULL,
  `kategori` varchar(30) NOT NULL,
  `satuan` enum('gram','kg','liter') NOT NULL,
  `harga_per_satuan` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_bahan`),
  UNIQUE KEY `nama_bahan` (`nama_bahan`),
  CONSTRAINT `bahanmakanan_chk_1` CHECK ((`harga_per_satuan` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mbg_tugas.bahanmakanan: ~0 rows (approximately)

-- Dumping structure for table mbg_tugas.kandungangizi
CREATE TABLE IF NOT EXISTS `kandungangizi` (
  `id_gizi` int NOT NULL AUTO_INCREMENT,
  `bahan_id` int NOT NULL,
  `energi` decimal(10,2) NOT NULL,
  `protein` decimal(10,2) NOT NULL,
  `lemak` decimal(10,2) NOT NULL,
  `karbohidrat` decimal(10,2) NOT NULL,
  `vitamin_mineral` text,
  PRIMARY KEY (`id_gizi`),
  UNIQUE KEY `bahan_id` (`bahan_id`),
  CONSTRAINT `kandungangizi_ibfk_1` FOREIGN KEY (`bahan_id`) REFERENCES `bahanmakanan` (`id_bahan`),
  CONSTRAINT `kandungangizi_chk_1` CHECK (((`energi` >= 0) and (`protein` >= 0) and (`lemak` >= 0) and (`karbohidrat` >= 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mbg_tugas.kandungangizi: ~0 rows (approximately)

-- Dumping structure for table mbg_tugas.menu
CREATE TABLE IF NOT EXISTS `menu` (
  `id_menu` int NOT NULL AUTO_INCREMENT,
  `nama_menu` varchar(100) NOT NULL,
  `kategori` enum('sarapan','makan siang','snack') NOT NULL,
  `tingkat_kesukaan` decimal(3,2) DEFAULT NULL,
  `total_kalori` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_menu`),
  CONSTRAINT `menu_chk_1` CHECK ((`tingkat_kesukaan` between 1 and 5)),
  CONSTRAINT `menu_chk_2` CHECK ((`total_kalori` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mbg_tugas.menu: ~0 rows (approximately)

-- Dumping structure for table mbg_tugas.resep
CREATE TABLE IF NOT EXISTS `resep` (
  `id_resep` int NOT NULL AUTO_INCREMENT,
  `menu_id` int NOT NULL,
  `bahan_id` int NOT NULL,
  `jumlah_bahan` decimal(10,3) NOT NULL,
  PRIMARY KEY (`id_resep`),
  UNIQUE KEY `menu_id` (`menu_id`,`bahan_id`),
  KEY `bahan_id` (`bahan_id`),
  CONSTRAINT `resep_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id_menu`),
  CONSTRAINT `resep_ibfk_2` FOREIGN KEY (`bahan_id`) REFERENCES `bahanmakanan` (`id_bahan`),
  CONSTRAINT `resep_chk_1` CHECK ((`jumlah_bahan` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table mbg_tugas.resep: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
