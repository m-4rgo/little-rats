-- MySQL dump 10.13  Distrib 9.0.1, for macos15.0 (arm64)
--
-- Host: localhost    Database: little_rats
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `contests`
--

DROP TABLE IF EXISTS `contests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contests` (
  `contestID` int NOT NULL AUTO_INCREMENT,
  `contest_name` varchar(100) DEFAULT NULL,
  `parent_event` int DEFAULT NULL,
  `contest_description` varchar(100) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`contestID`),
  KEY `contests_events_FK` (`parent_event`),
  CONSTRAINT `contests_events_FK` FOREIGN KEY (`parent_event`) REFERENCES `events` (`eventID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contests`
--

LOCK TABLES `contests` WRITE;
/*!40000 ALTER TABLE `contests` DISABLE KEYS */;
INSERT INTO `contests` VALUES (1,'Love Letters',1,NULL,NULL,NULL),(2,'Dress to Impress',1,NULL,NULL,NULL),(3,'Grand National',1,NULL,NULL,NULL),(4,'Dressage \"Test\"',1,NULL,NULL,NULL),(5,'Circus Tricks',1,NULL,NULL,NULL),(6,'Jousting Tournament',1,NULL,NULL,NULL),(7,'Scavenger Hunt Gymkhana',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `contests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `eventID` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`eventID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'Rat Circus 2025'),(2,'Rat Circus 2026');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `item_id` int NOT NULL,
  `user_id` int NOT NULL,
  `quantity` varchar(100) DEFAULT NULL,
  `inventoryID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`inventoryID`),
  UNIQUE KEY `unique_inventory` (`user_id`,`item_id`),
  KEY `inventory_items_FK` (`item_id`),
  CONSTRAINT `inventory_items_FK` FOREIGN KEY (`item_id`) REFERENCES `items` (`itemID`),
  CONSTRAINT `inventory_users_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,'1',1),(2,1,'1',2),(10,1,'1',3),(12,1,'1',4),(21,1,'1',5),(3,2,'1',6),(14,2,'1',7),(21,2,'1',8),(1,3,'1',9),(4,3,'1',10),(17,3,'1',11),(18,3,'1',12),(5,4,'1',13),(9,4,'1',14),(12,4,'1',15),(13,4,'2',16),(15,4,'1',17),(16,4,'1',18),(26,4,'1',19),(27,4,'1',20),(50,4,'1',22),(7,5,'1',23),(20,5,'1',24),(21,5,'1',25),(22,5,'1',26),(24,5,'1',27),(25,5,'1',28),(25,6,'1',29),(10,7,'1',30),(13,7,'1',31),(16,7,'1',32),(20,7,'1',33),(24,7,'1',34),(20,8,'1',35),(12,9,'1',36),(15,9,'1',37),(19,9,'1',38),(9,10,'1',39),(12,10,'1',40),(17,10,'1',41),(22,10,'1',42),(24,10,'1',43),(25,10,'1',44),(31,10,'1',45),(14,12,'1',46),(19,12,'1',47),(20,12,'1',48),(24,12,'1',49),(1,13,'1',50),(21,13,'1',51),(6,14,'1',52),(11,14,'1',53),(14,14,'1',54),(25,14,'1',55),(8,17,'1',56),(13,17,'2',57),(14,17,'1',58),(16,17,'1',59),(24,17,'1',60),(28,17,'1',61),(29,17,'1',62),(1,22,'1',63),(11,22,'1',64),(12,22,'1',65),(17,22,'1',66),(20,22,'1',67),(22,22,'1',68),(24,22,'1',69),(25,22,'1',70),(30,22,'1',71),(18,24,'1',72),(24,28,'1',73),(25,28,'1',74),(12,24,'1',75),(24,24,'1',76),(50,24,'1',78),(14,3,'1',79),(15,3,'1',80),(24,3,'1',81),(51,22,'1',82),(52,22,'1',83),(53,3,'1',84),(47,22,'1',85),(32,24,'1',86),(32,4,'1',87),(33,22,'2',88),(33,3,'1',89),(49,1,'1',98),(49,3,'1',99),(49,22,'1',100),(49,4,'1',101),(49,7,'1',102),(49,9,'1',103),(49,5,'1',105),(49,13,'1',106),(49,17,'1',107),(49,28,'1',108),(49,10,'1',110),(49,6,'1',111),(49,12,'1',112),(49,14,'1',113),(49,24,'1',114),(49,8,'1',115),(49,2,'1',116),(55,29,'1',117),(56,10,'1',118),(57,10,'1',120),(58,9,'1',121),(59,24,'1',122),(60,17,'1',123),(61,17,'1',124),(62,17,'1',125),(63,28,'1',126),(64,7,'1',127),(65,7,'1',128),(66,7,'1',129),(67,5,'1',130),(68,4,'1',131),(69,4,'1',132),(73,4,'1',136),(76,4,'1',137),(77,4,'1',138),(78,29,'1',139),(79,29,'1',140),(80,29,'1',141),(81,29,'1',142);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `itemID` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(100) DEFAULT NULL,
  `item_description` varchar(100) DEFAULT NULL,
  `image_path` varchar(100) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `item_scale` int DEFAULT NULL,
  `item_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Red Raffle Ticket 2025','A free raffle ticket, awarded for entering the raffle 2025','items/red_raffle_2025.png','2025-02-06 00:00:00',20,'item'),(2,'Custom Racing Hood','A custom racing hood for Butter Dragon','items/hood_butterdragon_2025.png','2025-02-06 00:00:00',NULL,'item'),(3,'Custom Racing Hood','A custom racing hood for Parkiet','items/hood_parkiet_2025.png','2025-02-06 00:00:00',NULL,'item'),(4,'Custom Racing Hood','A custom racing hood for kijauni','items/hood_kijauni_2025.png','2025-02-06 00:00:00',NULL,'item'),(5,'Custom Racing Hood','A custom racing hood for Boomer1414','items/hood_boomer1414_2025.png','2025-02-06 00:00:00',NULL,'item'),(6,'Custom Racing Hood','A custom racing hood for Shadowhunter,','items/hood_koel_2025.png','2025-02-06 00:00:00',NULL,'item'),(7,'Custom Racing Hood','A custom racing hood for dragongoddest','items/hood_dragongoddest_2025.png','2025-02-06 00:00:00',NULL,'item'),(8,'Custom Racing Hood','A custom racing hood for S h e b s t e r','items/hood_shebster_2025.png','2025-02-06 00:00:00',NULL,'item'),(9,'1st Place Heart Rosette 2025','A rosette for winning the valentine\'s event in 2025','items/1_heart_2025.png','2025-02-06 00:00:00',NULL,'item'),(10,'2nd Place Heart Rosette 2025','A rosette for placing in the valentine\'s event in 2025','items/2_heart_2025.png','2025-02-06 00:00:00',NULL,'item'),(11,'3rd Place Heart Rosette 2025','A rosette for placing in the valentine\'s event in 2025','items/3_heart_2025.png','2025-02-06 00:00:00',NULL,'item'),(12,'1st Place Rosette 2025','A rosette for placing in the little rats circus 2025','items/1_2025.png','2025-02-06 00:00:00',NULL,'item'),(13,'2nd Place Rosette 2025','A rosette for placing in the little rats circus 2025','items/2_2025.png','2025-02-06 00:00:00',NULL,'item'),(14,'3rd Place Rosette 2025','A rosette for placing in the little rats circus 2025','items/3_2025.png','2025-02-06 00:00:00',NULL,'item'),(15,'4th Place Rosette 2025','A rosette for placing in the little rats circus 2025','items/4_2025.png','2025-02-06 00:00:00',NULL,'item'),(16,'5th Place Rosette 2025','A rosette for placing in the little rats circus 2025','items/5_2025.png','2025-02-06 00:00:00',NULL,'item'),(17,'6th Place Rosette 2025','A rosette for placing in the little rats circus 2025','items/6_2025.png','2025-02-06 00:00:00',NULL,'item'),(18,'7th Place Rosette 2025','A rosette for placing in the little rats circus 2025','items/7_2025.png','2025-02-06 00:00:00',NULL,'item'),(19,'8th Place Rosette 2025','A rosette for placing in the little rats circus 2025','items/8_2025.png','2025-02-06 00:00:00',NULL,'item'),(20,'Valentines Seal 2025','A seal for participating in the valentine\'s event 2025','items/valentines_2025.png','2025-02-06 00:00:00',NULL,'item'),(21,'Grand National Seal 2025','A seal for participating in the little rats circus 2025','items/grand_national_2025.png','2025-02-06 00:00:00',NULL,'item'),(22,'Dressage \"Test\" Seal 2025','A seal for participating in the little rats circus 2025','items/test_2025.png','2025-02-06 00:00:00',NULL,'item'),(23,'Circus Tricks Seal 2025','A seal for participating in the little rats circus 2025','items/circus_2025.png','2025-02-06 00:00:00',NULL,'item'),(24,'Jousting Tournament Seal 2025','A seal for participating in the little rats circus 2025','items/joust_2025.png','2025-02-06 00:00:00',NULL,'item'),(25,'Scavenger Hunt Seal 2025','A seal for participating in the little rats circus 2025','items/scavenger_2025.png','2025-02-06 00:00:00',NULL,'item'),(26,'Grand Champion Rosette 2025','The prize for winning the Little Rats Circus 2025!','items/champion_rosette_2025.png','2025-02-06 00:00:00',NULL,'item'),(27,'Grand Champion Trophy 2025','The prize for winning the Little Rats Circus 2025!','items/champion_trophy_2025.png','2025-02-06 00:00:00',NULL,'item'),(28,'Reserve Champion Rosette 2025','The prize for placing second in the Little Rats Circus 2025!','items/reserve_rosette_2025.png','2025-02-06 00:00:00',NULL,'item'),(29,'Reserve Champion Trophy 2025','The prize for placing second in the Little Rats Circus 2025!','items/reserve_trophy_2025.png','2025-02-06 00:00:00',NULL,'item'),(30,'Best in Show Statue 2025','A gold best in show statue, awarded for great performance in the Little Rats Circus 2025','items/bis_2025.png','2025-02-06 00:00:00',NULL,'item'),(31,'Honourable Mention Statue 2025','A bronze honourable mention statue, awarded for good performance in the Little Rats Circus 2025','items/hm_2025.png','2025-02-06 00:00:00',NULL,'item'),(32,'Team Plaque 2025','A team trophy, awarded to the team that won the scavenger hunt in the Little Rats Circus 2025','items/team_plaque_2025.png','2025-02-06 00:00:00',NULL,'item'),(33,'Photo Frame 2025','A photo frame, awarded as a raffle prize in the 2025 Rat Cicus Raffle','items/photo_frame_2025.png','2025-02-06 00:00:00',NULL,'item'),(45,'Green Raffle Ticket 2025','1 coin raffle ticket','items/green_raffle_2025.png','2025-02-06 00:00:00',NULL,'item'),(46,'Blue Raffle Ticket 2025','5 coins raffle ticket','items/blue_raffle_2025.png','2025-02-06 00:00:00',NULL,'item'),(47,'Yellow Raffle Ticket 2025','20 coins raffle ticket','items/yellow_raffle_2025.png','2025-02-06 00:00:00',NULL,'item'),(48,'Purple Raffle Ticket 2025','mystery prize raffle ticket','items/purple_raffle_2025.png','2025-02-06 00:00:00',NULL,'item'),(49,'Circus Hills Wallpaper 2025','A backdrop awarded to all participants of the Little Rats Circus 2025','items/circus_hills_2025.png','2025-02-06 00:00:00',NULL,'wallpaper'),(50,'Scavenger Hunt Medal 2025','A medal awarded as a mystery prize in the 2025 Rat Circus Scavenger Hunt','items/custom_scavenger_medal_2025.png','2025-02-06 00:00:00',NULL,'item'),(51,'Custom Raffle Prize 2025','For Nalena (Backdrop 1)',NULL,'2025-02-06 00:00:00',NULL,'item'),(52,'Custom Raffle Prize 2025','For Nalena (Backdrop 2)',NULL,'2025-02-06 00:00:00',NULL,'item'),(53,'Custom Raffle Prize 2025','For Lloma (custom prize)',NULL,'2025-02-06 00:00:00',NULL,'item'),(55,'Copper Coin','A copper coin','items/copper_coin.png','2026-02-06 00:00:00',20,'item'),(56,'Custom Caparison 2025','A custom caparison for Toffi','items/custom_caparison_toffi.png','2025-02-06 00:00:00',NULL,'item'),(57,'Custom Caparison 2025','A custom caparison for Toffi','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(58,'Custom Caparison 2025','A custom caparison for Tilluels-Paradise','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(59,'Custom Caparison 2025','A custom caparison for Silkwurm','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(60,'Custom Caparison 2025','A custom caparison for S h e b s t e r','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(61,'Custom Caparison 2025','A custom caparison for S h e b s t e r','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(62,'Custom Caparison 2025','A custom caparison for S h e b s t e r','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(63,'Custom Caparison 2025','A custom caparison for Jensen Ackles','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(64,'Custom Caparison 2025','A custom caparison for Hobbit Geek','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(65,'Custom Caparison 2025','A custom caparison for Hobbit Geek','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(66,'Custom Caparison 2025','A custom caparison for Hobbit Geek','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(67,'Custom Caparison 2025','A custom caparison for dragongoddest','items/custom_caparison_dragongoddest.png','2025-02-06 00:00:00',NULL,'item'),(68,'Custom Caparison 2025','A custom caparison for Boomer1414','items/custom_caparison_boomer.png','2025-02-06 00:00:00',NULL,'item'),(69,'Custom Caparison 2025','A custom caparison for Boomer1414','items/joust_mystery_prize.png','2025-02-06 00:00:00',NULL,'item'),(70,'1st Place Heart Rosette 2026','A rosette for winning the valentine\'s event in 2026','items/1_heart_rosette_2026.png','2026-02-06 00:00:00',50,'item'),(71,'2nd Place Heart Rosette 2026','A rosette for placing in the valentine\'s event in 2026','items/2_heart_rosette_2026.png','2026-02-06 00:00:00',50,'item'),(72,'3rd Place Heart Rosette 2026','A rosette for placing in the valentine\'s event in 2026','items/3_heart_rosette_2026.png','2026-02-06 00:00:00',50,'item'),(73,'Gold Chamfron','A golden medieval headpiece','items/gold_chamfron.png','2025-02-06 00:00:00',NULL,'item'),(74,'Gold and Red Medieval Saddle','A medieval Saddle','items/gold_red_medieval_saddle.png','2025-02-06 00:00:00',NULL,'item'),(75,'Rat Circus Wallpaper 2026','A backdrop awarded to all participants of the Little Rats Circus 2026','items/circus_hills_2026.png','2026-02-06 00:00:00',NULL,NULL),(76,'Custom Medieval Bridle','Custom tack for Boomer1414','items/custom_medieval_bridle.png','2025-02-06 00:00:00',NULL,NULL),(77,'Custom Medieval Saddle','Custom tack for Boomer1414','items/custom_medieval_saddle.png','2025-02-06 00:00:00',NULL,NULL),(78,'Gold Rat Race Trophy 2026','Trophy for placing 1st in the Rat Race 2026','items/rat_race_1.png','2026-02-06 00:00:00',50,NULL),(79,'Silver Rat Race Trophy 2026','Trophy for placing 2nd in the Rat Race 2026','items/rat_race_2.png','2026-02-06 00:00:00',50,NULL),(80,'Bronze Rat Race Trophy 2026','Trophy for placing 3rd in the Rat Race 2026','items/rat_race_3.png','2026-02-06 00:00:00',50,NULL),(81,'Wood Rat Race Trophy 2026','Trophy for placing last in the Rat Race 2026','items/rat_race_wood.png','2026-02-06 00:00:00',50,NULL);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outfits`
--

DROP TABLE IF EXISTS `outfits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outfits` (
  `outfitID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`outfitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outfits`
--

LOCK TABLES `outfits` WRITE;
/*!40000 ALTER TABLE `outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `outfits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passports`
--

DROP TABLE IF EXISTS `passports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passports` (
  `passportID` int NOT NULL AUTO_INCREMENT,
  `passport_type` varchar(100) DEFAULT NULL,
  `passport_description` varchar(100) DEFAULT NULL,
  `image_path` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`passportID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passports`
--

LOCK TABLES `passports` WRITE;
/*!40000 ALTER TABLE `passports` DISABLE KEYS */;
INSERT INTO `passports` VALUES (1,'white','unregistered or awaiting papers',NULL),(2,'green','A rat released by the Rats Adoption Team',NULL),(3,'yellow','A make-your-own rat',NULL),(4,'blue',NULL,NULL),(5,'red',NULL,NULL),(6,'purple',NULL,NULL);
/*!40000 ALTER TABLE `passports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rats`
--

DROP TABLE IF EXISTS `rats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rats` (
  `ratID` int NOT NULL AUTO_INCREMENT,
  `rat_link` varchar(100) DEFAULT NULL,
  `rat_name` varchar(100) DEFAULT NULL,
  `image_path` varchar(100) DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `artist_id` int DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ratID`),
  KEY `rats_users_FK` (`owner_id`),
  KEY `rats_users_FK_1` (`artist_id`),
  CONSTRAINT `rats_users_FK` FOREIGN KEY (`owner_id`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rats_users_FK_1` FOREIGN KEY (`artist_id`) REFERENCES `users` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rats`
--

LOCK TABLES `rats` WRITE;
/*!40000 ALTER TABLE `rats` DISABLE KEYS */;
INSERT INTO `rats` VALUES (1,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025054','stumpy','rats/gen_2_rat.png',29,29,NULL),(2,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025270',NULL,'rats/rat_2.png',5,29,NULL),(3,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025271','centurion','rats/rat_3.png',7,7,NULL),(4,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025272','nibbles','rats/rat_4.png',22,29,NULL),(5,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025274','bailey','rats/rat_5.png',11,29,NULL),(6,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025281','pickles','rats/rat_6.png',6,29,NULL),(7,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025284',NULL,'rats/rat_7.png',14,29,NULL),(8,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025313','lil\' rockstar','rats/rat_8.png',13,29,NULL),(9,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025330','denim','rats/rat_9.png',12,12,NULL),(10,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025349','gideon','rats/rat_10.png',1,1,NULL),(11,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025607','ashelle','rats/rat_11.png',16,29,NULL),(12,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025608','roosevelt','rats/rat_12.png',15,29,NULL),(13,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025609','blythe','rats/rat_13.png',20,29,NULL),(14,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025832','Cassiopeia','rats/rat_14.png',9,9,NULL),(15,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5025855','micky','rats/rat_15.png',10,10,NULL),(16,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=125&t=5025874','slinky','rats/rat_16.png',17,17,NULL),(17,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5026141','iggy','rats/rat_17.png',18,10,NULL),(18,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5026562','Darlin’ Kakao','rats/rat_18.png',26,17,NULL),(19,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5026567','squeaky','rats/rat_19.png',27,17,NULL),(20,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5026894','rakiki','rats/rat_20.png',2,17,NULL),(21,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027189','eros','rats/rat_21.png',22,17,NULL),(22,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027192',NULL,'rats/rat_22.png',21,29,NULL),(23,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027198','sweetums','rats/rat_23.png',29,29,NULL),(24,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027487','mimi','rats/rat_24.png',22,17,NULL),(25,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027496','Fussle','rats/rat_25.png',10,17,NULL),(26,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027505','aiko','rats/rat_26.png',7,29,NULL),(27,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027506',NULL,'rats/rat_27.png',4,29,NULL),(28,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027518',NULL,'rats/rat_28.png',14,17,NULL),(29,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5027590',NULL,'rats/rat_29.png',1,17,NULL),(30,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5028280',NULL,'rats/rat_30.png',1,29,NULL),(31,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5028823','olin','rats/rat_31.png',4,4,NULL),(32,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5029395','Lil Ratscal','rats/rat_32.png',3,23,NULL),(33,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5032220','maude','rats/rat_33.png',24,4,NULL),(34,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5032254','domino','rats/rat_34.png',40,4,NULL),(35,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5032553',NULL,'rats/rat_35.png',25,29,NULL),(36,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5033160','styx','rats/rat_36.png',9,4,NULL),(37,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5033194','gespy','rats/rat_37.png',28,28,NULL),(38,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5033574','gideon','rats/rat_38.png',39,17,NULL),(39,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5033584','vegas','rats/rat_39.png',22,17,NULL),(40,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5035419','FLÖHE','rats/rat_40.png',26,4,NULL),(41,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5039783','myrtice','rats/rat_41.png',38,4,NULL),(42,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5041550','brie','rats/rat_42.png',37,4,NULL),(43,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5042252','pooky','rats/rat_43.png',36,4,NULL),(44,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5042543','theodore','rats/rat_44.png',35,4,NULL),(45,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=125&t=5056384','pumpkin','rats/rat_45.png',33,33,NULL),(46,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5072750','speckles','rats/rat_46.png',30,4,NULL),(47,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5072937','ophelia','rats/rat_47.png',34,4,NULL),(48,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5095280','dorian','rats/rat_48.png',19,4,NULL),(49,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5095281','forrest','rats/rat_49.png',34,4,NULL),(50,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5095282','star','rats/rat_50.png',33,4,NULL),(51,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5095283','Vixen','rats/rat_51.png',32,4,NULL),(52,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5106412','elm','rats/rat_52.png',4,4,NULL),(53,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5109068',NULL,'rats/rat_53.png',NULL,4,NULL),(54,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5109069',NULL,'rats/rat_54.png',NULL,4,NULL),(55,'https://www.chickensmoothie.com/Forum/viewtopic.php?f=124&t=5109156',NULL,'rats/rat_55.png',NULL,29,NULL);
/*!40000 ALTER TABLE `rats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `results`
--

DROP TABLE IF EXISTS `results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `results` (
  `resultID` int NOT NULL AUTO_INCREMENT,
  `prize_id` int DEFAULT NULL,
  `user_entrant` int DEFAULT NULL,
  `rat_entrant` int DEFAULT NULL,
  `contest_id` int DEFAULT NULL,
  PRIMARY KEY (`resultID`),
  KEY `results_contests_FK` (`contest_id`),
  CONSTRAINT `results_contests_FK` FOREIGN KEY (`contest_id`) REFERENCES `contests` (`contestID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `results`
--

LOCK TABLES `results` WRITE;
/*!40000 ALTER TABLE `results` DISABLE KEYS */;
/*!40000 ALTER TABLE `results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `chickensmoothie_id` int DEFAULT NULL COMMENT 'the user ID of this person''s chickensmoothie account',
  `discord_user` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `unique_user_name` (`user_name`),
  UNIQUE KEY `users_csid` (`chickensmoothie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Butter Dragon',214917,'prince_buer'),(2,'Parkiet',1089820,NULL),(3,'kijauni',107596,'lloma.'),(4,'Boomer1414',441710,NULL),(5,'dragongoddest',179084,NULL),(6,'funnyfarm96',41378,NULL),(7,'hobbit geek',375149,NULL),(8,'kaju',1082006,NULL),(9,'Tilluels-Paradise',1108908,NULL),(10,'Toffi~',190793,NULL),(11,'violenca',265048,NULL),(12,'wifflebee',62573,NULL),(13,'wildly-unaware',216635,NULL),(14,'Shadowhunter,',540499,NULL),(15,'Oddly Shaded',56186,NULL),(16,'Mavi',561197,NULL),(17,'S h e b s t e r',181038,NULL),(18,'Kenjaku',151344,NULL),(19,'Nanorat',41722,NULL),(20,'- Alice -',784303,NULL),(21,'Columbina',938992,NULL),(22,'Nalena',972450,'nalenaashe'),(23,'Embergleam',127087,NULL),(24,'seraphs',486449,NULL),(25,'sprig',554506,NULL),(26,'YourLostTeddyBear',1067829,NULL),(27,'CrazyB',901304,NULL),(28,'Jensen Ackles',519951,NULL),(29,'p-ond',77818,'po_n_d'),(30,'l1lithu',1037131,NULL),(31,'test account 1',NULL,NULL),(32,'gypsum_moon',318316,NULL),(33,'nellas',150882,'birdie5412'),(34,'ricocheted',1132888,NULL),(35,'ipphie',305675,NULL),(36,'*JACKAL*',214862,NULL),(37,'nikalodeon',1125291,NULL),(38,'sonatine',808392,NULL),(39,'folmes',318315,NULL),(40,'veramora',512343,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'little_rats'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-05 11:29:39
