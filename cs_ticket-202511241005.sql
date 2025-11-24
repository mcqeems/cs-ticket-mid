-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: cs_ticket
-- ------------------------------------------------------
-- Server version	12.0.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Technical Support','2025-11-23 15:06:20',NULL),(2,'Billing & Finance','2025-11-23 15:06:20',NULL),(3,'Customer Service','2025-11-23 15:06:20',NULL),(4,'Sales & Inquiry','2025-11-23 15:06:20',NULL);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_topic`
--

DROP TABLE IF EXISTS `help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_topic`
--

LOCK TABLES `help_topic` WRITE;
/*!40000 ALTER TABLE `help_topic` DISABLE KEYS */;
INSERT INTO `help_topic` VALUES (1,'Masalah Login / Akun','2025-11-23 15:06:20',NULL),(2,'Gagal Pembayaran','2025-11-23 15:06:20',NULL),(3,'Laporan Bug Aplikasi','2025-11-23 15:06:20',NULL),(4,'Pertanyaan Umum','2025-11-23 15:06:20',NULL),(5,'Permintaan Fitur Baru','2025-11-23 15:06:20',NULL);
/*!40000 ALTER TABLE `help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_logs`
--

DROP TABLE IF EXISTS `history_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `history_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_client_id` int(11) DEFAULT NULL,
  `user_agent_id` int(11) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_agent_id` (`user_agent_id`),
  KEY `user_client_id` (`user_client_id`),
  CONSTRAINT `history_logs_ibfk_1` FOREIGN KEY (`user_agent_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `history_logs_ibfk_2` FOREIGN KEY (`user_client_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_logs`
--

LOCK TABLES `history_logs` WRITE;
/*!40000 ALTER TABLE `history_logs` DISABLE KEYS */;
INSERT INTO `history_logs` VALUES (1,5,NULL,'Create Ticket',NULL,'open','2025-11-23 15:06:20'),(2,6,NULL,'Create Ticket',NULL,'open','2025-11-23 15:06:20'),(3,7,NULL,'Create Ticket',NULL,'open','2025-11-23 15:06:20'),(4,5,NULL,'Create Ticket',NULL,'open','2025-11-23 15:06:20'),(5,6,NULL,'Create Ticket',NULL,'open','2025-11-23 15:06:20'),(6,6,NULL,'Create Ticket',NULL,'open','2025-11-23 15:08:01'),(7,5,NULL,'Create Ticket',NULL,'open','2025-11-23 15:08:32'),(8,5,2,'Status changed from open to process',NULL,'process','2025-11-23 15:23:15'),(9,5,NULL,'Status changed from open to close',NULL,'close','2025-11-23 15:23:32'),(10,5,NULL,'Create Ticket',NULL,'open','2025-11-23 15:28:26'),(11,5,2,'Status changed from open to process',NULL,'process','2025-11-23 15:32:25'),(12,NULL,5,'Replied to Ticket #8',NULL,'process','2025-11-23 15:33:59'),(13,NULL,2,'Replied to Ticket #8',NULL,'process','2025-11-23 15:34:45'),(14,NULL,2,'Replied to Ticket #8',NULL,'process','2025-11-23 15:34:51'),(15,5,2,'Status changed from process to close',NULL,'close','2025-11-23 15:34:58'),(16,NULL,2,'Replied to Ticket #8',NULL,'process','2025-11-24 02:03:32'),(17,5,3,'Status changed from open to process',NULL,'process','2025-11-24 02:03:41'),(18,6,4,'Status changed from process to close',NULL,'close','2025-11-24 02:03:52'),(19,5,2,'Status changed from process to close',NULL,'close','2025-11-24 02:04:57'),(20,5,3,'Status changed from process to close',NULL,'close','2025-11-24 02:05:20'),(21,6,NULL,'Create Ticket',NULL,'open','2025-11-24 02:05:49');
/*!40000 ALTER TABLE `history_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledgebases`
--

DROP TABLE IF EXISTS `knowledgebases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledgebases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` enum('support','maintenance','faq') NOT NULL DEFAULT 'support',
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `knowledgebases_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledgebases`
--

LOCK TABLES `knowledgebases` WRITE;
/*!40000 ALTER TABLE `knowledgebases` DISABLE KEYS */;
INSERT INTO `knowledgebases` VALUES (1,'faq','Cara Reset Password','Jika Anda lupa password, klik tombol \"Lupa Password\" di halaman login...',1,'2025-11-23 15:06:20',NULL),(2,'support','Mengatasi Error 500','Coba refresh halaman atau bersihkan cache browser Anda...',2,'2025-11-23 15:06:20',NULL),(3,'maintenance','Jadwal Maintenance Mingguan','Sistem akan melakukan maintenance rutin setiap hari Minggu pukul 02:00 WIB.',1,'2025-11-23 15:06:20',NULL),(4,'faq','Metode Pembayaran yang Tersedia','Kami menerima transfer bank, kartu kredit, dan e-wallet.',3,'2025-11-23 15:06:20',NULL);
/*!40000 ALTER TABLE `knowledgebases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrator','Super user dengan akses penuh sistem','2025-11-23 15:06:20',NULL),(2,'Support Agent','Staff yang menangani tiket masuk','2025-11-23 15:06:20',NULL),(3,'Client','User/Pelanggan yang membuat tiket','2025-11-23 15:06:20',NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_details`
--

DROP TABLE IF EXISTS `ticket_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL,
  `details` text NOT NULL,
  `status` enum('open','close','process') NOT NULL DEFAULT 'open',
  `department_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `topic_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `agent_id` (`agent_id`),
  KEY `topic_id` (`topic_id`),
  KEY `department_id` (`department_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `ticket_details_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `ticket_details_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `help_topic` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ticket_details_ibfk_3` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ticket_details_ibfk_4` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_details`
--

LOCK TABLES `ticket_details` WRITE;
/*!40000 ALTER TABLE `ticket_details` DISABLE KEYS */;
INSERT INTO `ticket_details` VALUES (1,'Tidak bisa login aplikasi mobile','Setiap kali login muncul error \"Network Timeout\" padahal internet lancar.','close',1,5,2,1,'2025-11-23 15:06:20','2025-11-24 02:04:57'),(2,'Laporan Bug pada halaman checkout','Tombol bayar tidak bisa diklik saat menggunakan browser Firefox.','process',1,6,2,3,'2025-11-22 15:06:20','2025-11-23 15:06:20'),(3,'Pembayaran terdebet dua kali','Saya melakukan transaksi kemarin dan saldo terpotong 2x. Mohon refund.','close',2,7,3,2,'2025-11-20 15:06:20','2025-11-22 15:06:20'),(4,'Tanya harga paket enterprise','Berapa biaya langganan untuk 50 user?','close',4,5,NULL,4,'2025-11-23 15:06:20','2025-11-23 15:23:32'),(5,'Akun terkunci','Saya salah memasukkan password 5 kali.','close',3,6,4,1,'2025-11-23 10:06:20','2025-11-24 02:03:52'),(7,'Tanya harga paket enterprise','Berapa biaya langganan untuk 50 user?','close',4,5,3,4,'2025-11-23 15:06:20','2025-11-24 02:05:20'),(8,'Internet lemot','gak kuat download game black myth wukong\n\n[2025-11-23 22:33:59] Ahmad Customer Replied:\njawab dong abangku\n\n[2025-11-23 22:34:45] Budi (Tech Agent) Replied:\niya sabar\n\n[2025-11-23 22:34:51] Budi (Tech Agent) Replied:\n\n\n[2025-11-24 09:03:32] Budi (Tech Agent) Replied:\nwooooi','close',1,5,2,4,'2025-11-23 15:28:26','2025-11-24 02:03:32'),(9,'Nggak bisa bayar DU','banyak banget chat ama gw sini','open',2,6,NULL,2,'2025-11-24 02:05:49',NULL);
/*!40000 ALTER TABLE `ticket_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_log_new_ticket
AFTER INSERT ON ticket_details
FOR EACH ROW
BEGIN
    INSERT INTO history_logs (user_client_id, action, status, created_at)
    VALUES (NEW.client_id, 'Create Ticket', 'open', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_ticket_updated_timestamp
BEFORE UPDATE ON ticket_details
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_log_ticket_status_change
AFTER UPDATE ON ticket_details
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO history_logs (user_client_id, user_agent_id, action, status, created_at)
        VALUES (
            NEW.client_id, 
            NEW.agent_id, 
            CONCAT('Status changed from ', OLD.status, ' to ', NEW.status), 
            NEW.status, 
            NOW()
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Super Admin','admin@csticket.com','hashed_pass_admin','081234567890',1,'2025-11-23 15:06:20',NULL),(2,'Budi (Tech Agent)','budi@csticket.com','hashed_pass_budi','081234567891',2,'2025-11-23 15:06:20',NULL),(3,'Siti (Billing Agent)','siti@csticket.com','hashed_pass_siti','081234567892',2,'2025-11-23 15:06:20',NULL),(4,'Rian (CS Agent)','rian@csticket.com','hashed_pass_rian','081234567893',2,'2025-11-23 15:06:20',NULL),(5,'Ahmad Customer','ahmad@gmail.com','hashed_pass_ahmad','089876543210',3,'2025-11-23 15:06:20',NULL),(6,'Dewi Customer','dewi@gmail.com','hashed_pass_dewi','089876543211',3,'2025-11-23 15:06:20',NULL),(7,'Joko Customer','joko@gmail.com','hashed_pass_joko','089876543212',3,'2025-11-23 15:06:20',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_agent_performance`
--

DROP TABLE IF EXISTS `v_agent_performance`;
/*!50001 DROP VIEW IF EXISTS `v_agent_performance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_agent_performance` AS SELECT 
 1 AS `agent_id`,
 1 AS `agent_name`,
 1 AS `tickets_processing`,
 1 AS `tickets_closed`,
 1 AS `total_assigned`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_history_logs_readable`
--

DROP TABLE IF EXISTS `v_history_logs_readable`;
/*!50001 DROP VIEW IF EXISTS `v_history_logs_readable`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_history_logs_readable` AS SELECT 
 1 AS `id`,
 1 AS `action`,
 1 AS `status`,
 1 AS `ip_address`,
 1 AS `created_at`,
 1 AS `client_name`,
 1 AS `agent_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_ticket_complete_info`
--

DROP TABLE IF EXISTS `v_ticket_complete_info`;
/*!50001 DROP VIEW IF EXISTS `v_ticket_complete_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_ticket_complete_info` AS SELECT 
 1 AS `ticket_id`,
 1 AS `subject`,
 1 AS `status`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `client_name`,
 1 AS `client_email`,
 1 AS `agent_name`,
 1 AS `department_name`,
 1 AS `topic_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'cs_ticket'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_assign_agent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_assign_agent`(
    IN p_ticket_id INT,
    IN p_agent_id INT
)
BEGIN
    DECLARE v_current_status VARCHAR(50);
    
    -- Cek status tiket saat ini
    SELECT status INTO v_current_status FROM ticket_details WHERE id = p_ticket_id;
    
    IF v_current_status = 'close' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Cannot assign agent to a closed ticket.';
    ELSE
        UPDATE ticket_details
        SET agent_id = p_agent_id,
            status = 'process'
        WHERE id = p_ticket_id;
        
        SELECT CONCAT('Ticket #', p_ticket_id, ' assigned to Agent #', p_agent_id) AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_close_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_close_ticket`(
    IN p_ticket_id INT,
    IN p_closer_id INT -- ID user yang melakukan closing (bisa agent atau client)
)
BEGIN
    UPDATE ticket_details
    SET status = 'close'
    WHERE id = p_ticket_id;
    
    -- Opsional: Tambah log manual jika trigger tidak cukup detail
    -- INSERT INTO history_logs ...
    
    SELECT CONCAT('Ticket #', p_ticket_id, ' has been closed.') AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_create_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_ticket`(
    IN p_client_id INT,
    IN p_subject VARCHAR(255),
    IN p_details TEXT,
    IN p_department_id INT,
    IN p_topic_id INT
)
BEGIN
    INSERT INTO ticket_details (subject, details, status, department_id, client_id, topic_id, created_at)
    VALUES (p_subject, p_details, 'open', p_department_id, p_client_id, p_topic_id, NOW());
    
    -- Mengembalikan ID tiket yang baru dibuat
    SELECT LAST_INSERT_ID() AS new_ticket_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_dashboard_stats` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_dashboard_stats`()
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM ticket_details) AS total_tickets,
        (SELECT COUNT(*) FROM ticket_details WHERE status = 'open') AS open_tickets,
        (SELECT COUNT(*) FROM ticket_details WHERE status = 'process') AS active_tickets,
        (SELECT COUNT(*) FROM ticket_details WHERE status = 'close') AS closed_tickets,
        (SELECT COUNT(*) FROM users WHERE role_id = (SELECT id FROM roles WHERE name LIKE '%Agent%' LIMIT 1)) AS total_agents;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reply_ticket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reply_ticket`(
    IN p_ticket_id INT,
    IN p_user_id INT,
    IN p_message TEXT
)
BEGIN
    DECLARE v_user_name VARCHAR(100);
    
    -- Ambil nama user yang membalas
    SELECT name INTO v_user_name FROM users WHERE id = p_user_id;
    
    -- Update tiket: Tambahkan pesan ke detail & update timestamp
    UPDATE ticket_details 
    SET details = CONCAT(details, '\n\n[', NOW(), '] ', v_user_name, ' Replied:\n', p_message),
        status = IF(status = 'open', 'process', status), -- Otomatis jadi process jika dibalas
        updated_at = NOW()
    WHERE id = p_ticket_id;
    
    -- Log aktivitas
    INSERT INTO history_logs (user_agent_id, action, status, created_at)
    VALUES (p_user_id, CONCAT('Replied to Ticket #', p_ticket_id), 'process', NOW());
    
    SELECT 'Reply berhasil ditambahkan.' AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_agent_performance`
--

/*!50001 DROP VIEW IF EXISTS `v_agent_performance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_agent_performance` AS select `u`.`id` AS `agent_id`,`u`.`name` AS `agent_name`,count(case when `td`.`status` = 'process' then 1 end) AS `tickets_processing`,count(case when `td`.`status` = 'close' then 1 end) AS `tickets_closed`,count(`td`.`id`) AS `total_assigned` from ((`users` `u` join `roles` `r` on(`u`.`role_id` = `r`.`id`)) left join `ticket_details` `td` on(`u`.`id` = `td`.`agent_id`)) where `r`.`name` like '%Agent%' or `r`.`name` like '%Admin%' group by `u`.`id`,`u`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_history_logs_readable`
--

/*!50001 DROP VIEW IF EXISTS `v_history_logs_readable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_history_logs_readable` AS select `h`.`id` AS `id`,`h`.`action` AS `action`,`h`.`status` AS `status`,`h`.`ip_address` AS `ip_address`,`h`.`created_at` AS `created_at`,`u_client`.`name` AS `client_name`,`u_agent`.`name` AS `agent_name` from ((`history_logs` `h` left join `users` `u_client` on(`h`.`user_client_id` = `u_client`.`id`)) left join `users` `u_agent` on(`h`.`user_agent_id` = `u_agent`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_ticket_complete_info`
--

/*!50001 DROP VIEW IF EXISTS `v_ticket_complete_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_uca1400_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_ticket_complete_info` AS select `td`.`id` AS `ticket_id`,`td`.`subject` AS `subject`,`td`.`status` AS `status`,`td`.`created_at` AS `created_at`,`td`.`updated_at` AS `updated_at`,`uc`.`name` AS `client_name`,`uc`.`email` AS `client_email`,`ua`.`name` AS `agent_name`,`dept`.`name` AS `department_name`,`ht`.`topic_name` AS `topic_name` from ((((`ticket_details` `td` left join `users` `uc` on(`td`.`client_id` = `uc`.`id`)) left join `users` `ua` on(`td`.`agent_id` = `ua`.`id`)) left join `departments` `dept` on(`td`.`department_id` = `dept`.`id`)) left join `help_topic` `ht` on(`td`.`topic_id` = `ht`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-24 10:05:42
