-- MySQL dump 10.13  Distrib 5.7.35, for FreeBSD13.0 (amd64)
--
-- Host: localhost    Database: mllog
-- ------------------------------------------------------
-- Server version	5.7.35-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED='810e863d-4d88-11ea-b0b2-000c29288c01:1-12953';

--
-- Table structure for table `algorithm`
--

DROP TABLE IF EXISTS `algorithm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `algorithm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `parameters` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_representation`
--

DROP TABLE IF EXISTS `class_representation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_representation` (
  `dataset_id` int(11) NOT NULL,
  `class` varchar(100) DEFAULT NULL,
  `samples_count` int(11) DEFAULT NULL,
  UNIQUE KEY `dataset_id` (`dataset_id`,`class`),
  CONSTRAINT `class_representation_ibfk_1` FOREIGN KEY (`dataset_id`) REFERENCES `dataset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `context`
--

DROP TABLE IF EXISTS `context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `context` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project` varchar(100) DEFAULT NULL,
  `task_details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataset`
--

DROP TABLE IF EXISTS `dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `size_MB` int(11) DEFAULT NULL,
  `sample_count` int(11) DEFAULT NULL,
  `feature_count` int(11) DEFAULT NULL,
  `classified` binary(1) DEFAULT NULL,
  `source` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataset_experiment`
--

DROP TABLE IF EXISTS `dataset_experiment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_experiment` (
  `dataset_id` int(11) DEFAULT NULL,
  `experiment_id` int(11) DEFAULT NULL,
  KEY `dataset_id` (`dataset_id`),
  KEY `experiment_id` (`experiment_id`),
  CONSTRAINT `dataset_experiment_ibfk_1` FOREIGN KEY (`dataset_id`) REFERENCES `dataset` (`id`),
  CONSTRAINT `dataset_experiment_ibfk_2` FOREIGN KEY (`experiment_id`) REFERENCES `experiment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `experiment`
--

DROP TABLE IF EXISTS `experiment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `experiment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  `preprocessing_id` int(11) DEFAULT NULL,
  `learning_process_id` int(11) DEFAULT NULL,
  `system_setup` json DEFAULT NULL,
  `context_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `learning_process_id` (`learning_process_id`),
  KEY `preprocessing_id` (`preprocessing_id`),
  KEY `context_id` (`context_id`),
  CONSTRAINT `experiment_ibfk_1` FOREIGN KEY (`learning_process_id`) REFERENCES `multistep_process` (`id`),
  CONSTRAINT `experiment_ibfk_2` FOREIGN KEY (`preprocessing_id`) REFERENCES `multistep_process` (`id`),
  CONSTRAINT `experiment_ibfk_3` FOREIGN KEY (`context_id`) REFERENCES `context` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dataset_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `feature_order` int(11) DEFAULT NULL,
  `feature_type` set('nemerical','categorical') DEFAULT NULL,
  `nullvals_count` int(11) DEFAULT NULL,
  `distribution_plot` blob,
  `density_plot` blob,
  PRIMARY KEY (`id`),
  KEY `dataset_id` (`dataset_id`),
  CONSTRAINT `feature_ibfk_1` FOREIGN KEY (`dataset_id`) REFERENCES `dataset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feature_correlation`
--

DROP TABLE IF EXISTS `feature_correlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature_correlation` (
  `featureA` int(11) DEFAULT NULL,
  `featureB` int(11) DEFAULT NULL,
  `measure` varchar(100) DEFAULT NULL,
  `value` float DEFAULT NULL,
  KEY `featureA` (`featureA`),
  KEY `featureB` (`featureB`),
  CONSTRAINT `feature_correlation_ibfk_1` FOREIGN KEY (`featureA`) REFERENCES `feature` (`id`),
  CONSTRAINT `feature_correlation_ibfk_2` FOREIGN KEY (`featureB`) REFERENCES `feature` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `multistep_process`
--

DROP TABLE IF EXISTS `multistep_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multistep_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `process_step`
--

DROP TABLE IF EXISTS `process_step`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `process_step` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `process_id` int(11) DEFAULT NULL,
  `algorithm_id` int(11) DEFAULT NULL,
  `step_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `process_id` (`process_id`),
  KEY `algorithm_id` (`algorithm_id`),
  CONSTRAINT `process_step_ibfk_1` FOREIGN KEY (`process_id`) REFERENCES `multistep_process` (`id`),
  CONSTRAINT `process_step_ibfk_2` FOREIGN KEY (`algorithm_id`) REFERENCES `algorithm` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `result`
--

DROP TABLE IF EXISTS `result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `experiment_id` int(11) DEFAULT NULL,
  `accuracy` float DEFAULT NULL,
  `f1` float DEFAULT NULL,
  `mean_absolute_error` float DEFAULT NULL,
  `mean_squared_error` float DEFAULT NULL,
  `additional_metrics` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `experiment_id` (`experiment_id`),
  CONSTRAINT `result_ibfk_1` FOREIGN KEY (`experiment_id`) REFERENCES `experiment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-11 14:18:27
