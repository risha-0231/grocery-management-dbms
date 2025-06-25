-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: grocerystore
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Anita','9876543210','anita@abc.com'),(2,'Ravi','9123456780','ravi.k@abc.com'),(3,'Meena','9988776600','meena.v@gmail.com'),(4,'Aditya K','9855543210','adityakat@abc.com'),(5,'Vedanth','9124433780','vedm@abc.com'),(6,'Nikhita','9567776600','niks@gmail.com'),(7,'Priya','9875643221',''),(8,'Ishwar','9778342671A',''),(9,'Neha','6754698764',''),(10,'priya','76876839',''),(11,'Sourabh','9988765432',''),(12,'Riya','9887577382',''),(13,'Riya','9887577382',''),(14,'Riya','9887577382',''),(15,'Riya','9887577382',''),(16,'Riya','9887577382',''),(17,'Riya','9887577382',''),(18,'Riya','9887577382',''),(19,'Riya','9887577382',''),(20,'Riya','9887577382',''),(21,'Riya','9887577382',''),(22,'Riya','9887577382',''),(23,'Riya','9887577382',''),(24,'Riya','9887577382',''),(25,'Riya','9887577382',''),(26,'Riya','9887577382',''),(27,'Riya','9887577382',''),(28,'Riya','9887577382',''),(29,'Riya','9887577382',''),(30,'Riya','9887577382',''),(31,'Riya','9887577382',''),(32,'Riya','9887577382',''),(33,'Riya','9887577382',''),(34,'Riya','9887577382',''),(35,'Riya','9887577382',''),(36,'Riya','9887577382',''),(37,'Riya','9887577382',''),(38,'Riya','9887577382','');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `role` enum('Administrator','Cashier','Inventory Manager') NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Admin User','Administrator','admin','admin123'),(2,'Cashier One','Cashier','cashier1','cash123'),(3,'Inventory Manager','Inventory Manager','inventory1','inv123');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_prod_id_idx` (`product_id`),
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `fk_prod_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (1,1,2,100.00),(1,2,1,30.00),(1,5,3,75.00),(2,2,1,30.00),(2,3,2,120.00),(10,1,2,50.00),(10,3,1,60.00),(10,5,2,25.00),(11,2,25,30.00),(11,7,100,5.00),(12,1,1,50.00),(12,9,1,60.00),(13,2,5,30.00),(13,7,7,5.00),(14,1,2,50.00),(14,5,2,25.00),(14,8,4,60.00),(15,7,5,5.00),(16,7,5,5.00),(17,7,5,5.00),(18,7,5,5.00),(19,7,5,5.00),(20,7,5,5.00),(21,7,5,5.00),(22,7,5,5.00),(23,7,5,5.00),(24,7,5,5.00),(25,7,5,5.00),(26,7,5,5.00),(27,7,5,5.00),(28,7,5,5.00),(29,7,5,5.00),(30,7,5,5.00),(31,7,5,5.00),(32,7,5,5.00),(33,7,5,5.00),(34,7,5,5.00),(35,7,5,5.00),(36,7,5,5.00),(37,7,5,5.00),(38,7,5,5.00),(39,7,5,5.00),(40,7,5,5.00),(41,7,5,5.00);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `order_date` datetime NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_cust_id_idx` (`customer_id`),
  KEY `fk_employee_id_idx` (`employee_id`),
  CONSTRAINT `fk_cust_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,2,'2025-05-14 20:50:45',205.00),(2,2,2,'2025-05-14 20:50:45',150.00),(3,1,2,'2025-05-14 20:50:50',205.00),(4,2,2,'2025-05-14 20:50:50',150.00),(5,1,2,'2025-05-14 20:55:07',205.00),(10,7,2,'2025-05-14 21:02:03',210.00),(11,8,2,'2025-05-14 22:47:32',1250.00),(12,9,2,'2025-05-27 12:37:52',110.00),(13,10,2,'2025-05-27 12:47:17',185.00),(14,11,2,'2025-05-27 13:09:57',390.00),(15,12,2,'2025-06-09 21:35:42',300.00),(16,13,2,'2025-06-09 21:35:45',300.00),(17,14,2,'2025-06-09 21:35:46',300.00),(18,15,2,'2025-06-09 21:35:46',300.00),(19,16,2,'2025-06-09 21:35:47',300.00),(20,17,2,'2025-06-09 21:35:47',300.00),(21,18,2,'2025-06-09 21:35:50',300.00),(22,19,2,'2025-06-09 21:35:50',300.00),(23,20,2,'2025-06-09 21:35:50',300.00),(24,21,2,'2025-06-09 21:35:50',300.00),(25,22,2,'2025-06-09 21:35:50',300.00),(26,23,2,'2025-06-09 21:35:50',300.00),(27,24,2,'2025-06-09 21:35:51',300.00),(28,25,2,'2025-06-09 21:35:51',300.00),(29,26,2,'2025-06-09 21:35:51',300.00),(30,27,2,'2025-06-09 21:35:51',300.00),(31,28,2,'2025-06-09 21:35:51',300.00),(32,29,2,'2025-06-09 21:35:52',300.00),(33,30,2,'2025-06-09 21:35:52',300.00),(34,31,2,'2025-06-09 21:35:52',300.00),(35,32,2,'2025-06-09 21:35:52',300.00),(36,33,2,'2025-06-09 21:35:52',300.00),(37,34,2,'2025-06-09 21:35:53',300.00),(38,35,2,'2025-06-09 21:35:54',300.00),(39,36,2,'2025-06-09 21:35:54',300.00),(40,37,2,'2025-06-09 21:35:54',300.00),(41,38,2,'2025-06-09 21:35:54',300.00);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int DEFAULT NULL,
  `supplier` int DEFAULT NULL,
  `unit_id` int NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `fk_supplier_id_idx` (`supplier`),
  KEY `fk_unit_id_idx` (`unit_id`),
  CONSTRAINT `fk_supplier_id` FOREIGN KEY (`supplier`) REFERENCES `suppliers` (`supplier_id`),
  CONSTRAINT `fk_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `units` (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Milk','Dairy',50.00,195,2,3),(2,'Bread','Bakery',30.00,120,1,1),(3,'Rice','Grains',60.00,499,3,2),(4,'Apple','Fruits',120.00,100,3,2),(5,'Soap','Personal Care',25.00,296,1,1),(6,'Carrot','Vegetables',25.00,200,2,3),(7,'Candy','Bakery',5.00,-92,1,1),(8,'Wheat','Grains',60.00,496,3,2),(9,'Banana','Fruits',60.00,99,3,2),(10,'Toothpaste','Personal Care',27.00,300,1,1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'FreshFarms Ltd.','9876543210','contact@freshfarms.com'),(2,'DailyDairy Co.','9123456789','sales@dailydairy.com'),(3,'VeggieMart','9988776655','support@veggiemart.com'),(4,'ABC Ltd.','97786543227','contact@abc.com'),(5,'XYZ Co.','98888456789','sales@xyz.com'),(6,'PQR','9985636655','support@pqr.com');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units` (
  `unit_id` int NOT NULL AUTO_INCREMENT,
  `unit_name` enum('unit','kg','litre') NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,'unit'),(2,'kg'),(3,'litre');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-25 17:48:32
