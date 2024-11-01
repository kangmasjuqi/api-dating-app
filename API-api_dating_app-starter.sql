-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: localhost    Database: api_dating_app
-- ------------------------------------------------------
-- Server version	5.7.30

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
-- Table structure for table `premium_packages`
--

DROP TABLE IF EXISTS `premium_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `premium_packages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `benefits` json NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `premium_packages`
--

LOCK TABLES `premium_packages` WRITE;
/*!40000 ALTER TABLE `premium_packages` DISABLE KEYS */;
INSERT INTO `premium_packages` VALUES (1,'No Daily Swipe Quota','Unlimited daily swipes without restrictions',29.99,'{\"unlimited_swipes\": true, \"no_daily_swipe_quota\": true}','2024-11-01 14:05:47','2024-11-01 14:05:47'),(2,'Verified Profile','Get verified profile label',19.99,'{\"verified_label\": true, \"profile_credibility\": true}','2024-11-01 14:05:47','2024-11-01 14:05:47');
/*!40000 ALTER TABLE `premium_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_premium_packages`
--

DROP TABLE IF EXISTS `user_premium_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_premium_packages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `package_id` int(11) NOT NULL,
  `purchased_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `user_premium_packages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_premium_packages_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `premium_packages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_premium_packages`
--

LOCK TABLES `user_premium_packages` WRITE;
/*!40000 ALTER TABLE `user_premium_packages` DISABLE KEYS */;
INSERT INTO `user_premium_packages` VALUES (1,27,1,'2024-11-01 22:56:22','2024-12-01 22:56:22');
/*!40000 ALTER TABLE `user_premium_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_swipes`
--

DROP TABLE IF EXISTS `user_swipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_swipes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `target_user_id` int(11) NOT NULL,
  `action` enum('like','pass') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_swipe` (`user_id`,`target_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_swipes`
--

LOCK TABLES `user_swipes` WRITE;
/*!40000 ALTER TABLE `user_swipes` DISABLE KEYS */;
INSERT INTO `user_swipes` VALUES (1,27,16,'like','2024-11-01 10:11:44'),(2,27,4,'pass','2024-11-01 10:12:04'),(3,27,1,'like','2024-11-01 22:58:30'),(4,27,2,'like','2024-11-01 22:58:43');
/*!40000 ALTER TABLE `user_swipes` ENABLE KEYS */;
UNLOCK TABLES;

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
  `password` varchar(255) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `label` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `verified_status` enum('not_verified','verified') DEFAULT 'not_verified',
  `premium_package_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `premium_package_id` (`premium_package_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`premium_package_id`) REFERENCES `premium_packages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Chris Cox','sweeneybarry@hotmail.com','#s6Nvo4h3C','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(2,'Meghan Washington','jbrown@downs-silva.com','9i&0XZ4uFq','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(3,'Katherine Mason','xlivingston@martinez.com','zSn!R0gn%9','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(4,'Donna Carr','calvin14@hotmail.com','p_)5VKp$I4','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(5,'Brian Huff','stephanieho@rose.com','#z2Coc#oak','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(6,'Dr. Emily White','dianahall@drake.org','!0Du$fgBCJ','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(7,'Eric Mack','hayneschristina@yahoo.com','&_4M8sB&2f','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(8,'Mario Rodgers','tammy06@yahoo.com','+P7jiDtnKs','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(9,'Paula Campbell','parkermaureen@brooks.com','^CK!m7Mwi1','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(10,'Belinda Orozco','conradshelby@marks-dixon.net',')KkJ+RBm@1','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(11,'Sierra Morris','nelsonchristopher@gmail.com','+)4NY*(n6r','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(12,'James Merritt','stephenjohnson@yahoo.com','*y79)EQJQ+','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(13,'Lisa Harris','mistyalexander@hotmail.com','FTOz@ecm@6','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(14,'Alexander West','chavezmaria@price.com','^83YFGPhH^','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(15,'Laura Williams','grahamdonna@mcfarland.com','Vk7BQjm5c^','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(16,'Dr. Janet Wallace MD','paul04@yahoo.com','$6LM_v&u01','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(17,'Jonathan Hernandez','wandaparker@sims.biz','j1E@!OAh8#','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(18,'Robert Rivera','vpowers@mills-schmidt.net','I$H8_Xyk4v','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(19,'Randy Lopez','webbjill@fisher.com','HN&3O9Fp_*','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(20,'Roberta Lewis','breannaperez@williams.org','8Bw4g@Hq^P','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(21,'Miguel Moran','wpeterson@rosario.info','Thi45DswD(','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(22,'Tonya Castillo','jmcdonald@hotmail.com','b00RRp1f&Z','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(23,'Tyler Martinez','prestonmelissa@yahoo.com','11iKs5dR&U','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(24,'Christopher Nguyen','caldwelljennifer@ortiz.info','z4GrLpDg&e','Male',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(25,'Melanie Ayers','hansonrachael@johnson.com','Jj3VEzSpK@','Female',NULL,'2024-10-31 07:42:49','2024-10-31 07:42:49','not_verified',NULL),(27,'M Rahmat','mrah@example.com','$2b$10$uBQk1JJvIKbelOdGjsyw7ejfAXwui.bJ.xYUxGys/1MJSu7KMJDku','Male',NULL,'2024-11-01 10:04:45','2024-11-01 10:04:45','not_verified',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'api_dating_app'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-02  6:11:35
