-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: jira_comal
-- ------------------------------------------------------
-- Server version	8.0.27-cluster

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
-- Table structure for table `#Tableau_46_sid_00000114_3_Connect_CheckCreateTempTableCap`
--

DROP TABLE IF EXISTS `#Tableau_46_sid_00000114_3_Connect_CheckCreateTempTableCap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `#Tableau_46_sid_00000114_3_Connect_CheckCreateTempTableCap` (
  `COL` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `Build_CardData`
--

DROP TABLE IF EXISTS `Build_CardData`;
/*!50001 DROP VIEW IF EXISTS `Build_CardData`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Build_CardData` AS SELECT 
 1 AS `kpi_sprint_id`,
 1 AS `TrackerChange`,
 1 AS `kpi_name`,
 1 AS `kpi_dashboard`,
 1 AS `kpi_title1`,
 1 AS `kpi_value1`,
 1 AS `kpi_title2`,
 1 AS `kpi_value2`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Build_ChangeView`
--

DROP TABLE IF EXISTS `Build_ChangeView`;
/*!50001 DROP VIEW IF EXISTS `Build_ChangeView`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Build_ChangeView` AS SELECT 
 1 AS `project_id`,
 1 AS `issue_id`,
 1 AS `issue_key`,
 1 AS `summary`,
 1 AS `sprint_id`,
 1 AS `TrackChange`,
 1 AS `status`,
 1 AS `assigned_to`,
 1 AS `change_type`,
 1 AS `change_item_from_string`,
 1 AS `change_item_to_string`,
 1 AS `change_created`,
 1 AS `change_author`,
 1 AS `DateDiff`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Build_StoryTrack`
--

DROP TABLE IF EXISTS `Build_StoryTrack`;
/*!50001 DROP VIEW IF EXISTS `Build_StoryTrack`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Build_StoryTrack` AS SELECT 
 1 AS `project_id`,
 1 AS `sprint_id`,
 1 AS `sprint_name`,
 1 AS `issue_summary`,
 1 AS `epic_name`,
 1 AS `epic_name_text`,
 1 AS `issue_key`,
 1 AS `status_name`,
 1 AS `user_name`,
 1 AS `estimated_hours`,
 1 AS `remaining_hours`,
 1 AS `due_date`,
 1 AS `priority_name`,
 1 AS `missedduedate`,
 1 AS `trackchange`,
 1 AS `nextupdate`,
 1 AS `sprint_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Build_SummaryChangeView`
--

DROP TABLE IF EXISTS `Build_SummaryChangeView`;
/*!50001 DROP VIEW IF EXISTS `Build_SummaryChangeView`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Build_SummaryChangeView` AS SELECT 
 1 AS `project_id`,
 1 AS `sprint_name`,
 1 AS `trackchange`,
 1 AS `change_type`,
 1 AS `original_value`,
 1 AS `new_value`,
 1 AS `change_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Build_SummaryStoryView`
--

DROP TABLE IF EXISTS `Build_SummaryStoryView`;
/*!50001 DROP VIEW IF EXISTS `Build_SummaryStoryView`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Build_SummaryStoryView` AS SELECT 
 1 AS `sprint_id`,
 1 AS `sprint_name`,
 1 AS `TrackerChange`,
 1 AS `total_time`,
 1 AS `time_spent`,
 1 AS `ideal_burndown`,
 1 AS `remaining_effort`,
 1 AS `remaining_tasks`,
 1 AS `uat_tasks`,
 1 AS `completed_tasks`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Build_changelog_summary`
--

DROP TABLE IF EXISTS `Build_changelog_summary`;
/*!50001 DROP VIEW IF EXISTS `Build_changelog_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Build_changelog_summary` AS SELECT 
 1 AS `sprint_id`,
 1 AS `sprint_name`,
 1 AS `date`,
 1 AS `track_change`,
 1 AS `sprint_days`,
 1 AS `issue_id`,
 1 AS `change_type`,
 1 AS `change_from`,
 1 AS `change_to`,
 1 AS `Datediff`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Build_kpi`
--

DROP TABLE IF EXISTS `Build_kpi`;
/*!50001 DROP VIEW IF EXISTS `Build_kpi`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Build_kpi` AS SELECT 
 1 AS `sprint_id`,
 1 AS `track_change`,
 1 AS `change_type`,
 1 AS `kpi_value`,
 1 AS `kpi_delta`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Due_date_master`
--

DROP TABLE IF EXISTS `Due_date_master`;
/*!50001 DROP VIEW IF EXISTS `Due_date_master`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Due_date_master` AS SELECT 
 1 AS `issue_id`,
 1 AS `issue_key`,
 1 AS `issue_type_id`,
 1 AS `project_id`,
 1 AS `sprint_id`,
 1 AS `status_id`,
 1 AS `status_category`,
 1 AS `epic_name`,
 1 AS `story_point`,
 1 AS `assignee_account_id`,
 1 AS `creator_account_id`,
 1 AS `reporter_account_id`,
 1 AS `fix_version`,
 1 AS `time_estimate`,
 1 AS `time_original_estimate`,
 1 AS `aggregate_time_estimate`,
 1 AS `aggregate_time_original_estimate`,
 1 AS `time_spent`,
 1 AS `work_ratio`,
 1 AS `created_v2`,
 1 AS `created`,
 1 AS `updated`,
 1 AS `status_category_change_date`,
 1 AS `start_date`,
 1 AS `change_start_date`,
 1 AS `change_completion_date`,
 1 AS `priority_name`,
 1 AS `epic_name_text`,
 1 AS `sprint_due_date`,
 1 AS `project_name`,
 1 AS `assignee`,
 1 AS `sprint_name`,
 1 AS `assigned_hours`,
 1 AS `status`,
 1 AS `priority`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Project_Summary_View`
--

DROP TABLE IF EXISTS `Project_Summary_View`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Project_Summary_View` (
  `project_id` int DEFAULT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `groomed_perc_today` decimal(46,4) NOT NULL DEFAULT '0.0000',
  `groomed_perc_yesterday` decimal(46,4) NOT NULL DEFAULT '0.0000',
  `total_stories_today` decimal(42,0) DEFAULT NULL,
  `total_stories_yesterday` decimal(42,0) DEFAULT NULL,
  `new_issues_today` decimal(42,0) NOT NULL DEFAULT '0',
  `new_issues_yesterday` decimal(42,0) NOT NULL DEFAULT '0',
  `issues_with_activity_today` bigint NOT NULL DEFAULT '0',
  `issues_with_activity_yesterday` bigint NOT NULL DEFAULT '0',
  `total_activities_today` decimal(42,0) NOT NULL DEFAULT '0',
  `total_activities_yesterday` decimal(42,0) NOT NULL DEFAULT '0',
  `original_estimate` double DEFAULT NULL,
  `new_estimate` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `Requirement_CardData`
--

DROP TABLE IF EXISTS `Requirement_CardData`;
/*!50001 DROP VIEW IF EXISTS `Requirement_CardData`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_CardData` AS SELECT 
 1 AS `kpi_project_id`,
 1 AS `TrackerChange`,
 1 AS `fix_version`,
 1 AS `kpi_name`,
 1 AS `kpi_dashboard`,
 1 AS `kpi_title1`,
 1 AS `kpi_value1`,
 1 AS `kpi_title2`,
 1 AS `kpi_value2`,
 1 AS `kpi_group`,
 1 AS `kpi_order`,
 1 AS `kpi_click`,
 1 AS `kpi_icon`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Requirement_CardData_fixversion`
--

DROP TABLE IF EXISTS `Requirement_CardData_fixversion`;
/*!50001 DROP VIEW IF EXISTS `Requirement_CardData_fixversion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_CardData_fixversion` AS SELECT 
 1 AS `kpi_project_id`,
 1 AS `TrackerChange`,
 1 AS `fix_version`,
 1 AS `kpi_name`,
 1 AS `kpi_dashboard`,
 1 AS `kpi_title1`,
 1 AS `kpi_value1`,
 1 AS `kpi_title2`,
 1 AS `kpi_value2`,
 1 AS `kpi_group`,
 1 AS `kpi_order`,
 1 AS `kpi_click`,
 1 AS `kpi_icon`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Requirement_EpicSummary`
--

DROP TABLE IF EXISTS `Requirement_EpicSummary`;
/*!50001 DROP VIEW IF EXISTS `Requirement_EpicSummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_EpicSummary` AS SELECT 
 1 AS `project_id`,
 1 AS `Epic_name`,
 1 AS `Epic_name_text`,
 1 AS `TrackChange`,
 1 AS `Groomed_Stories`,
 1 AS `Total_User_Stories`,
 1 AS `Original_hours`,
 1 AS `New_Estimate`,
 1 AS `Estimate_hours`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Requirement_EpicSummary_fixversion`
--

DROP TABLE IF EXISTS `Requirement_EpicSummary_fixversion`;
/*!50001 DROP VIEW IF EXISTS `Requirement_EpicSummary_fixversion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_EpicSummary_fixversion` AS SELECT 
 1 AS `project_id`,
 1 AS `epic_name`,
 1 AS `Epic_name_text`,
 1 AS `TrackChange`,
 1 AS `fix_version`,
 1 AS `Groomed_Stories`,
 1 AS `Total_User_Stories`,
 1 AS `Original_hours`,
 1 AS `New_Estimate`,
 1 AS `Estimate_hours`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Requirement_EpicSummarytest`
--

DROP TABLE IF EXISTS `Requirement_EpicSummarytest`;
/*!50001 DROP VIEW IF EXISTS `Requirement_EpicSummarytest`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_EpicSummarytest` AS SELECT 
 1 AS `project_id`,
 1 AS `Epic_name`,
 1 AS `TrackChange`,
 1 AS `Groomed_Stories`,
 1 AS `Total_User_Stories`,
 1 AS `Original_hours`,
 1 AS `New_Estimate`,
 1 AS `Estimate_hours`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Requirement_EstimateSummary`
--

DROP TABLE IF EXISTS `Requirement_EstimateSummary`;
/*!50001 DROP VIEW IF EXISTS `Requirement_EstimateSummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_EstimateSummary` AS SELECT 
 1 AS `project_id`,
 1 AS `TrackChange`,
 1 AS `To_do_stories`,
 1 AS `Requirement_complete`,
 1 AS `Remaining_User_Stories`,
 1 AS `Original_hours`,
 1 AS `Estimated_minutes`,
 1 AS `total_user_stories`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Requirement_EstimateSummary_fixversion`
--

DROP TABLE IF EXISTS `Requirement_EstimateSummary_fixversion`;
/*!50001 DROP VIEW IF EXISTS `Requirement_EstimateSummary_fixversion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_EstimateSummary_fixversion` AS SELECT 
 1 AS `project_id`,
 1 AS `TrackChange`,
 1 AS `fix_version`,
 1 AS `To_do_stories`,
 1 AS `Requirement_complete`,
 1 AS `Remaining_User_Stories`,
 1 AS `Original_hours`,
 1 AS `Estimated_minutes`,
 1 AS `total_user_stories`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Requirement_MainTableView`
--

DROP TABLE IF EXISTS `Requirement_MainTableView`;
/*!50001 DROP VIEW IF EXISTS `Requirement_MainTableView`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_MainTableView` AS SELECT 
 1 AS `project_id`,
 1 AS `issue_key`,
 1 AS `issue_type_id`,
 1 AS `issue_type_name`,
 1 AS `fix_version`,
 1 AS `summary`,
 1 AS `epic_name`,
 1 AS `status`,
 1 AS `to_do_filter`,
 1 AS `blocked_filter`,
 1 AS `new_stories_filter`,
 1 AS `original_hours`,
 1 AS `new_hours`,
 1 AS `change_hours`,
 1 AS `user_name`,
 1 AS `priority_name`,
 1 AS `trackchange`,
 1 AS `New_Filter`,
 1 AS `lastupdate`,
 1 AS `nextupdate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `Requirement_MainTableView_fixversion`
--

DROP TABLE IF EXISTS `Requirement_MainTableView_fixversion`;
/*!50001 DROP VIEW IF EXISTS `Requirement_MainTableView_fixversion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Requirement_MainTableView_fixversion` AS SELECT 
 1 AS `project_id`,
 1 AS `issue_key`,
 1 AS `issue_type_id`,
 1 AS `issue_type_name`,
 1 AS `fix_version`,
 1 AS `summary`,
 1 AS `epic_name`,
 1 AS `epic_name_text`,
 1 AS `status`,
 1 AS `to_do_filter`,
 1 AS `blocked_filter`,
 1 AS `new_stories_filter`,
 1 AS `original_hours`,
 1 AS `new_hours`,
 1 AS `change_hours`,
 1 AS `user_name`,
 1 AS `priority_name`,
 1 AS `trackchange`,
 1 AS `New_Filter`,
 1 AS `lastupdate`,
 1 AS `nextupdate`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `avg_close_time_priority`
--

DROP TABLE IF EXISTS `avg_close_time_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avg_close_time_priority` (
  `priority_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `avg_close_time` decimal(14,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `build_kpi`
--

DROP TABLE IF EXISTS `build_kpi`;
/*!50001 DROP VIEW IF EXISTS `build_kpi`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `build_kpi` AS SELECT 
 1 AS `sprint_id`,
 1 AS `track_change`,
 1 AS `change_type`,
 1 AS `kpi_value`,
 1 AS `kpi_delta`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `calendar_table`
--

DROP TABLE IF EXISTS `calendar_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar_table` (
  `dt` date NOT NULL,
  `y` smallint DEFAULT NULL,
  `q` tinyint DEFAULT NULL,
  `m` tinyint DEFAULT NULL,
  `d` tinyint DEFAULT NULL,
  `dw` tinyint DEFAULT NULL,
  `monthName` varchar(9) DEFAULT NULL,
  `dayName` varchar(9) DEFAULT NULL,
  `w` tinyint DEFAULT NULL,
  `isWeekday` binary(1) DEFAULT NULL,
  `isHoliday` binary(1) DEFAULT NULL,
  `holidayDescr` varchar(32) DEFAULT NULL,
  `isPayday` binary(1) DEFAULT NULL,
  PRIMARY KEY (`dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `card_data_intermediate`
--

DROP TABLE IF EXISTS `card_data_intermediate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card_data_intermediate` (
  `issue_id` int,
  `issue_key` varchar(20) DEFAULT NULL,
  `sprint_id` int NOT NULL,
  `TrackChange` varchar(25) DEFAULT NULL,
  `status` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `assigned_to` varchar(50) DEFAULT NULL,
  `new_scope_flag` varchar(1) NOT NULL DEFAULT '',
  `scope_removed_flag` varchar(1) NOT NULL DEFAULT '',
  `estimate_changed_flag` varchar(1) NOT NULL DEFAULT '',
  `assignee_change_flag` varchar(1) NOT NULL DEFAULT '',
  `ready_for_testing_flag` varchar(1) NOT NULL DEFAULT '',
  `duedate_change_flag` varchar(1) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `change_log`
--

DROP TABLE IF EXISTS `change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `change_log` (
  `change_id` int NOT NULL,
  `issue_id` int DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `initial_status` varchar(20) DEFAULT NULL,
  `status_rank1` bigint unsigned NOT NULL DEFAULT '0',
  `end_date` datetime DEFAULT NULL,
  `final_status` varchar(20) DEFAULT NULL,
  `status_rank2` bigint unsigned NOT NULL DEFAULT '0',
  `Day_diff` double DEFAULT NULL,
  `Open` double DEFAULT NULL,
  `Requirements` double DEFAULT NULL,
  `To Do` double DEFAULT NULL,
  `In Progress` double DEFAULT NULL,
  `Deployed` double DEFAULT NULL,
  `UAT` double DEFAULT NULL,
  `SIT Testing` double DEFAULT NULL,
  `Dev Complete` double DEFAULT NULL,
  `Cancelled` double DEFAULT NULL,
  `Ready for Release` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `change_view_intermediate`
--

DROP TABLE IF EXISTS `change_view_intermediate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `change_view_intermediate` (
  `issue_id` int,
  `issue_key` varchar(20) DEFAULT NULL,
  `summary` varchar(500) DEFAULT NULL,
  `sprint_id` int NOT NULL,
  `project_id` int DEFAULT NULL,
  `TrackChange` varchar(25) DEFAULT NULL,
  `date` date NOT NULL,
  `status` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `assigned_to` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `changelog_test`
--

DROP TABLE IF EXISTS `changelog_test`;
/*!50001 DROP VIEW IF EXISTS `changelog_test`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `changelog_test` AS SELECT 
 1 AS `change_id`,
 1 AS `issue_id`,
 1 AS `start_date`,
 1 AS `initial_status`,
 1 AS `status_rank1`,
 1 AS `end_date`,
 1 AS `final_status`,
 1 AS `status_rank2`,
 1 AS `Day_diff`,
 1 AS `Open`,
 1 AS `Requirements`,
 1 AS `To Do`,
 1 AS `In Progress`,
 1 AS `Deployed`,
 1 AS `UAT`,
 1 AS `SIT Testing`,
 1 AS `Dev Complete`,
 1 AS `Cancelled`,
 1 AS `Ready for Release`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `daily_status_intermediate`
--

DROP TABLE IF EXISTS `daily_status_intermediate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_status_intermediate` (
  `sprint_id` int NOT NULL,
  `sprint_name` varchar(50) DEFAULT NULL,
  `sprint_start_date` date DEFAULT NULL,
  `sprint_end_date` date DEFAULT NULL,
  `date` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0',
  `sprint_days` decimal(23,0) DEFAULT NULL,
  `issue_id` int,
  `status_end_day` varchar(20) DEFAULT NULL,
  `log_date` date DEFAULT NULL,
  `f_rank` bigint unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `db_refresh_table`
--

DROP TABLE IF EXISTS `db_refresh_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `db_refresh_table` (
  `serial_no` int NOT NULL AUTO_INCREMENT,
  `refresh_type` varchar(50) NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `schdule_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `schdule_date` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `complete_date` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `complete_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `refresh_projects` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`serial_no`)
) ENGINE=InnoDB AUTO_INCREMENT=787578 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `df_w_dup`
--

DROP TABLE IF EXISTS `df_w_dup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_w_dup` (
  `issue_id` int NOT NULL,
  `issue_key` varchar(20) DEFAULT NULL,
  `issuetype` varchar(50) DEFAULT NULL,
  `assignee_account_id` varchar(100) DEFAULT NULL,
  `assignee` varchar(50) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `change_created` datetime DEFAULT NULL,
  `originalTimeEstimate` int DEFAULT NULL,
  `priorityName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `project_key` varchar(50) DEFAULT NULL,
  `projectName` text,
  `sprintName` varchar(50) DEFAULT NULL,
  `statusName` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Complete` int NOT NULL DEFAULT '0',
  `# Incomplete stories` int NOT NULL DEFAULT '0',
  `P1+P2 defects` int NOT NULL DEFAULT '0',
  `P3+P4 defects` int NOT NULL DEFAULT '0',
  `statusName_v2` varchar(11) NOT NULL DEFAULT '',
  `statusName_v3` varchar(9) NOT NULL DEFAULT '',
  `created_date` datetime DEFAULT NULL,
  `diff_create_update` double DEFAULT NULL,
  `today` date NOT NULL,
  `avg_close_time` decimal(14,4) DEFAULT NULL,
  `Hrs required` double NOT NULL DEFAULT '0',
  `Hrs Available` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `due_date_summary`
--

DROP TABLE IF EXISTS `due_date_summary`;
/*!50001 DROP VIEW IF EXISTS `due_date_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `due_date_summary` AS SELECT 
 1 AS `sprint_id`,
 1 AS `sprint_name`,
 1 AS `sprint_start_date`,
 1 AS `issue_id`,
 1 AS `trackchange`,
 1 AS `epic_name`,
 1 AS `time_estimate`,
 1 AS `created_v2`,
 1 AS `priority_name`,
 1 AS `sprint_due_date`,
 1 AS `missed_due_date`,
 1 AS `assignee`,
 1 AS `project_id`,
 1 AS `project_name`,
 1 AS `status_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `due_date_summary_test`
--

DROP TABLE IF EXISTS `due_date_summary_test`;
/*!50001 DROP VIEW IF EXISTS `due_date_summary_test`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `due_date_summary_test` AS SELECT 
 1 AS `sprint_id`,
 1 AS `sprint_name`,
 1 AS `date`,
 1 AS `trackchange`,
 1 AS `issue_id`,
 1 AS `kpi_title1`,
 1 AS `status_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `epic_base_table`
--

DROP TABLE IF EXISTS `epic_base_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epic_base_table` (
  `project_id` int DEFAULT NULL,
  `epic_name` varchar(22) DEFAULT NULL,
  `epic_start_date` date DEFAULT NULL,
  `epic_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `epic_fix_version_base`
--

DROP TABLE IF EXISTS `epic_fix_version_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epic_fix_version_base` (
  `project_id` int DEFAULT NULL,
  `epic_name` varchar(22) DEFAULT NULL,
  `epic_start_date` date DEFAULT NULL,
  `epic_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0',
  `fix_version` int DEFAULT NULL,
  KEY `join_condition` (`epic_name`,`dt`,`fix_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `epic_hours_estimate`
--

DROP TABLE IF EXISTS `epic_hours_estimate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epic_hours_estimate` (
  `epic_key` varchar(100) DEFAULT NULL,
  `estimate_hours` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `epic_issue_daily_status_intermediate`
--

DROP TABLE IF EXISTS `epic_issue_daily_status_intermediate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `epic_issue_daily_status_intermediate` (
  `project_id` int DEFAULT NULL,
  `epic_name` varchar(22) DEFAULT NULL,
  `epic_start_date` date DEFAULT NULL,
  `epic_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0',
  `issue_id` int,
  `fix_version` int DEFAULT NULL,
  `status_end_day` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estimate_base_table`
--

DROP TABLE IF EXISTS `estimate_base_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estimate_base_table` (
  `project_id` int DEFAULT NULL,
  `epic_start_date` date DEFAULT NULL,
  `epic_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estimate_issue_daily_status_intermediate`
--

DROP TABLE IF EXISTS `estimate_issue_daily_status_intermediate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estimate_issue_daily_status_intermediate` (
  `project_id` int DEFAULT NULL,
  `epic_start_date` date DEFAULT NULL,
  `epic_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0',
  `issue_id` int DEFAULT NULL,
  `status_end_day` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fix_version_day_intermediate`
--

DROP TABLE IF EXISTS `fix_version_day_intermediate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fix_version_day_intermediate` (
  `kpi_project_id` int DEFAULT NULL,
  `TrackerChange` varchar(25) DEFAULT NULL,
  `fix_version` int DEFAULT NULL,
  KEY `join_condition` (`kpi_project_id`,`TrackerChange`,`fix_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `get_resource_sheet_table`
--

DROP TABLE IF EXISTS `get_resource_sheet_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `get_resource_sheet_table` (
  `project_id` int NOT NULL,
  `resource_sheet_name` varchar(50) DEFAULT NULL,
  `update_date` varchar(50) DEFAULT NULL,
  `update_time` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issue_sprint_data`
--

DROP TABLE IF EXISTS `issue_sprint_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_sprint_data` (
  `issue_id` int NOT NULL,
  `original_sprint_id` int DEFAULT NULL,
  `dt` date,
  `issue_start_date` date DEFAULT NULL,
  `issue_end_date` date NOT NULL,
  `current_sprint_id` varchar(21) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `live_date`
--

DROP TABLE IF EXISTS `live_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `live_date` (
  `dt` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login_log`
--

DROP TABLE IF EXISTS `login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_log` (
  `user_id` varchar(25) DEFAULT NULL,
  `login_date` varchar(25) DEFAULT NULL,
  `serial_no` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`serial_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1703 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_board`
--

DROP TABLE IF EXISTS `master_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_board` (
  `board_id` int NOT NULL,
  `board_name` varchar(50) DEFAULT NULL,
  `board_type` varchar(50) DEFAULT NULL,
  `board_project_id` int DEFAULT NULL,
  PRIMARY KEY (`board_id`),
  KEY `board_id_IDX` (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_change_log`
--

DROP TABLE IF EXISTS `master_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_change_log` (
  `change_id` int NOT NULL,
  `issue_id` int DEFAULT NULL,
  `change_author_account_id` varchar(100) DEFAULT NULL,
  `change_created` datetime DEFAULT NULL,
  `change_item_key` int NOT NULL,
  `change_item_field` varchar(20) DEFAULT NULL,
  `change_item_field_type` varchar(20) DEFAULT NULL,
  `change_item_field_id` varchar(20) DEFAULT NULL,
  `change_item_from` varchar(20) DEFAULT NULL,
  `change_item_from_string` varchar(20) DEFAULT NULL,
  `change_item_to` varchar(20) DEFAULT NULL,
  `change_item_to_string` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`change_id`,`change_item_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `master_change_log_v2`
--

DROP TABLE IF EXISTS `master_change_log_v2`;
/*!50001 DROP VIEW IF EXISTS `master_change_log_v2`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `master_change_log_v2` AS SELECT 
 1 AS `change_id`,
 1 AS `issue_id`,
 1 AS `change_author_account_id`,
 1 AS `change_createdv1`,
 1 AS `change_item_key`,
 1 AS `change_item_field`,
 1 AS `change_item_field_type`,
 1 AS `change_item_field_id`,
 1 AS `change_item_from`,
 1 AS `change_item_from_string`,
 1 AS `change_item_to`,
 1 AS `change_item_to_string`,
 1 AS `change_created`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `master_fix_version`
--

DROP TABLE IF EXISTS `master_fix_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_fix_version` (
  `fix_version_id` int NOT NULL,
  `fix_version_description` varchar(50) DEFAULT NULL,
  `fix_version_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fix_version_archived` varchar(20) DEFAULT NULL,
  `fix_version_released` varchar(20) DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  PRIMARY KEY (`fix_version_id`),
  KEY `fix_version_id_IDX` (`fix_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_issue`
--

DROP TABLE IF EXISTS `master_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_issue` (
  `issue_id` int NOT NULL,
  `issue_key` varchar(20) DEFAULT NULL,
  `issue_type_id` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `sprint_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `status_category` int DEFAULT NULL,
  `epic_name` varchar(20) DEFAULT NULL,
  `story_point` float DEFAULT NULL,
  `assignee_account_id` varchar(100) DEFAULT NULL,
  `creator_account_id` varchar(100) DEFAULT NULL,
  `reporter_account_id` varchar(100) DEFAULT NULL,
  `summary` varchar(500) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `fix_version` int DEFAULT NULL,
  `time_estimate` int DEFAULT NULL,
  `time_original_estimate` int DEFAULT NULL,
  `aggregate_time_estimate` int DEFAULT NULL,
  `aggregate_time_original_estimate` int DEFAULT NULL,
  `time_spent` int DEFAULT NULL,
  `aggregate_time_spent` datetime DEFAULT NULL,
  `work_ratio` float DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `status_category_change_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `change_start_date` datetime DEFAULT NULL,
  `change_completion_date` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `priority_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `epic_name_text` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `issue_id_IDX` (`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_issue_errors`
--

DROP TABLE IF EXISTS `master_issue_errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_issue_errors` (
  `issue_id` int NOT NULL,
  `issue_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `issue_type_id` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `sprint_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `status_category` int DEFAULT NULL,
  `epic_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `story_point` float DEFAULT NULL,
  `assignee_account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `creator_account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `reporter_account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fix_version` int DEFAULT NULL,
  `time_estimate` int DEFAULT NULL,
  `time_original_estimate` int DEFAULT NULL,
  `aggregate_time_estimate` int DEFAULT NULL,
  `aggregate_time_original_estimate` int DEFAULT NULL,
  `time_spent` int DEFAULT NULL,
  `aggregate_time_spent` datetime DEFAULT NULL,
  `work_ratio` float DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `status_category_change_date` varchar(250) DEFAULT NULL,
  `start_date` varchar(250) DEFAULT NULL,
  `change_start_date` varchar(250) DEFAULT NULL,
  `change_completion_date` varchar(250) DEFAULT NULL,
  `due_date` varchar(250) DEFAULT NULL,
  `priority_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `epic_name_text` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `issue_id_IDX` (`issue_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_issue_test`
--

DROP TABLE IF EXISTS `master_issue_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_issue_test` (
  `issue_id` int NOT NULL,
  `issue_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `issue_type_id` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `sprint_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `status_category` int DEFAULT NULL,
  `epic_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `story_point` float DEFAULT NULL,
  `assignee_account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `creator_account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `reporter_account_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fix_version` int DEFAULT NULL,
  `time_estimate` int DEFAULT NULL,
  `time_original_estimate` int DEFAULT NULL,
  `aggregate_time_estimate` int DEFAULT NULL,
  `aggregate_time_original_estimate` int DEFAULT NULL,
  `time_spent` int DEFAULT NULL,
  `aggregate_time_spent` datetime DEFAULT NULL,
  `work_ratio` float DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `status_category_change_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `change_start_date` datetime DEFAULT NULL,
  `change_completion_date` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `priority_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `epic_name_text` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `issue_id_IDX` (`issue_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_issue_type`
--

DROP TABLE IF EXISTS `master_issue_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_issue_type` (
  `issue_type_id` int NOT NULL,
  `issue_type_desc` varchar(100) DEFAULT NULL,
  `issue_type_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`issue_type_id`),
  KEY `issue_type_id_IDX` (`issue_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_project`
--

DROP TABLE IF EXISTS `master_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_project` (
  `project_id` int NOT NULL,
  `project_key` varchar(50) DEFAULT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `project_type_key` varchar(50) DEFAULT NULL,
  `project_to_pick` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `project_id_IDX` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_resource`
--

DROP TABLE IF EXISTS `master_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_resource` (
  `account_id` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `org` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `sprint_name` varchar(100) DEFAULT NULL,
  `avail_hours` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_sprint`
--

DROP TABLE IF EXISTS `master_sprint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_sprint` (
  `sprint_id` int NOT NULL,
  `sprint_state` varchar(20) DEFAULT NULL,
  `sprint_name` varchar(50) DEFAULT NULL,
  `sprint_start_date` datetime DEFAULT NULL,
  `sprint_end_date` datetime DEFAULT NULL,
  `sprint_complete_date` datetime DEFAULT NULL,
  `board_id` int DEFAULT NULL,
  PRIMARY KEY (`sprint_id`),
  KEY `sprint_id_IDX` (`sprint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_status`
--

DROP TABLE IF EXISTS `master_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_status` (
  `status_id` int NOT NULL,
  `status_name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status_untranslated_name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`status_id`),
  KEY `status_id_IDX` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_status_category`
--

DROP TABLE IF EXISTS `master_status_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_status_category` (
  `status_category_id` int NOT NULL,
  `status_category_key` varchar(20) DEFAULT NULL,
  `status_category_color_name` varchar(20) DEFAULT NULL,
  `status_category_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`status_category_id`),
  KEY `status_category_id_IDX` (`status_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_test`
--

DROP TABLE IF EXISTS `master_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_test` (
  `test_id` int NOT NULL,
  `parent_issue_id` int NOT NULL,
  `unique_test_id` int NOT NULL AUTO_INCREMENT,
  `status_in_parent` varchar(100) DEFAULT NULL,
  `test_key` varchar(20) DEFAULT NULL,
  `assignee_account_id` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT (curdate()),
  `updated` datetime DEFAULT (curdate()),
  `status_category_id` int DEFAULT NULL,
  `test_status` varchar(100) DEFAULT NULL,
  `priority_name` varchar(100) DEFAULT NULL,
  `reporter_account_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`unique_test_id`),
  KEY `project_id_IDX` (`unique_test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23433 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `master_user_account`
--

DROP TABLE IF EXISTS `master_user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_user_account` (
  `account_id` varchar(100) NOT NULL,
  `account_type` varchar(20) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `active` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  KEY `account_id_IDX` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `planners_data`
--

DROP TABLE IF EXISTS `planners_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planners_data` (
  `ï»¿Project` text,
  `Resource` text,
  `Project Allocation %` double DEFAULT NULL,
  `Sprint` text,
  `Development Hours` int DEFAULT NULL,
  `Admin/Other/Buffer` int DEFAULT NULL,
  `PTO` text,
  `Total` int DEFAULT NULL,
  `MyUnknownColumn` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proj_base_table`
--

DROP TABLE IF EXISTS `proj_base_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proj_base_table` (
  `project_id` int DEFAULT NULL,
  `project_start_date` date DEFAULT NULL,
  `project_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_daily_time_estimate`
--

DROP TABLE IF EXISTS `project_daily_time_estimate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_daily_time_estimate` (
  `project_id` int DEFAULT NULL,
  `project_start_date` date DEFAULT NULL,
  `project_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0',
  `issue_id` int,
  `fix_version` int DEFAULT NULL,
  `change_date_status` varchar(20) DEFAULT NULL,
  `change_item_from_string` varchar(20) DEFAULT NULL,
  `change_item_to_string` varchar(20) DEFAULT NULL,
  `original_estimate` varchar(20) DEFAULT NULL,
  `new_estimate` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_epic_daily_time_estimate`
--

DROP TABLE IF EXISTS `project_epic_daily_time_estimate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_epic_daily_time_estimate` (
  `project_id` int DEFAULT NULL,
  `epic_name` varchar(22) DEFAULT NULL,
  `epic_start_date` date DEFAULT NULL,
  `epic_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0',
  `issue_id` int,
  `fix_version` int DEFAULT NULL,
  `change_date_status` varchar(20) DEFAULT NULL,
  `change_item_from_string` varchar(20) DEFAULT NULL,
  `change_item_to_string` varchar(20) DEFAULT NULL,
  `original_estimate` varchar(20) DEFAULT NULL,
  `new_estimate` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_issue_daily_status_intermediate`
--

DROP TABLE IF EXISTS `project_issue_daily_status_intermediate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_issue_daily_status_intermediate` (
  `project_id` int DEFAULT NULL,
  `project_start_date` date DEFAULT NULL,
  `project_end_date` date DEFAULT NULL,
  `dt` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0',
  `issue_id` int,
  `fix_version` int DEFAULT NULL,
  `change_item_to` varchar(20) DEFAULT NULL,
  `change_item_from` varchar(20) DEFAULT NULL,
  `status_end_day` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `resource_summary_chart_data`
--

DROP TABLE IF EXISTS `resource_summary_chart_data`;
/*!50001 DROP VIEW IF EXISTS `resource_summary_chart_data`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `resource_summary_chart_data` AS SELECT 
 1 AS `assignee_account_id`,
 1 AS `sprint_id`,
 1 AS `sprint_name`,
 1 AS `avail_hours`,
 1 AS `assigned_hours`,
 1 AS `perc_change`,
 1 AS `over_flag`,
 1 AS `color_code`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `resource_summary_detail`
--

DROP TABLE IF EXISTS `resource_summary_detail`;
/*!50001 DROP VIEW IF EXISTS `resource_summary_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `resource_summary_detail` AS SELECT 
 1 AS `assignee_account_id`,
 1 AS `sprint_name`,
 1 AS `sprint_id`,
 1 AS `available_hours`,
 1 AS `assigned_hours`,
 1 AS `issue_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `summary_story_view`
--

DROP TABLE IF EXISTS `summary_story_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `summary_story_view` (
  `project_id` int DEFAULT NULL,
  `sprint_id` int NOT NULL,
  `sprint_name` varchar(50) DEFAULT NULL,
  `TrackerChange` varchar(25) DEFAULT NULL,
  `ideal_burndown` decimal(63,8) NOT NULL DEFAULT '0.00000000',
  `remaining_effort` decimal(37,4) DEFAULT NULL,
  `remaining_tasks` bigint NOT NULL DEFAULT '0',
  `uat_tasks` bigint NOT NULL DEFAULT '0',
  `completed_tasks` bigint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `summary_story_view_base_table`
--

DROP TABLE IF EXISTS `summary_story_view_base_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `summary_story_view_base_table` (
  `sprint_id` int NOT NULL,
  `sprint_name` varchar(50) DEFAULT NULL,
  `sprint_start_date` date DEFAULT NULL,
  `sprint_end_date` date DEFAULT NULL,
  `date` date NOT NULL,
  `day_count` bigint unsigned NOT NULL DEFAULT '0',
  `sprint_days` decimal(23,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp`
--

DROP TABLE IF EXISTS `temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp` (
  `change_id` int NOT NULL,
  `issue_id` int DEFAULT NULL,
  `change_author_account_id` varchar(100) DEFAULT NULL,
  `change_created` datetime DEFAULT NULL,
  `change_item_key` int NOT NULL,
  `change_item_field` varchar(20) DEFAULT NULL,
  `change_item_field_type` varchar(20) DEFAULT NULL,
  `change_item_field_id` varchar(20) DEFAULT NULL,
  `change_item_from` varchar(20) DEFAULT NULL,
  `change_item_from_string` varchar(20) DEFAULT NULL,
  `change_item_to` varchar(20) DEFAULT NULL,
  `change_item_to_string` varchar(20) DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `sprint_id` int DEFAULT NULL,
  `time_estimate` int DEFAULT NULL,
  `time_original_estimate` int DEFAULT NULL,
  `aggregate_time_estimate` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `priority_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `epic_name_text` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `test`
--

DROP TABLE IF EXISTS `test`;
/*!50001 DROP VIEW IF EXISTS `test`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `test` AS SELECT 
 1 AS `project_id`,
 1 AS `TrackChange`,
 1 AS `To_do_stories`,
 1 AS `Requirement_complete`,
 1 AS `Remaining_User_Stories`,
 1 AS `Original_hours`,
 1 AS `Estimated_minutes`,
 1 AS `total_user_stories`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `time_estimate_change_log`
--

DROP TABLE IF EXISTS `time_estimate_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_estimate_change_log` (
  `issue_id` int DEFAULT NULL,
  `change_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `change_item_from_string` varchar(20) DEFAULT NULL,
  `change_item_to_string` varchar(20) DEFAULT NULL,
  KEY `join_index` (`issue_id`,`start_date`,`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_account` (
  `user_id` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `yest_date`
--

DROP TABLE IF EXISTS `yest_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yest_date` (
  `dt` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `Build_CardData`
--

/*!50001 DROP VIEW IF EXISTS `Build_CardData`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Build_CardData` AS select `s1`.`sprint_id` AS `kpi_sprint_id`,`s1`.`TrackerChange` AS `TrackerChange`,'Sprint Status' AS `kpi_name`,'Build Dashboard' AS `kpi_dashboard`,'Status' AS `kpi_title1`,(case when ((`s1`.`remaining_effort` / `s1`.`ideal_burndown`) <= 0.9) then '1' when (((`s1`.`remaining_effort` / `s1`.`ideal_burndown`) > 0.9) and ((`s1`.`remaining_effort` / `s1`.`ideal_burndown`) <= 1.1)) then '2' when ((`s1`.`remaining_effort` / `s1`.`ideal_burndown`) > 1.1) then '3' end) AS `kpi_value1`,'Change' AS `kpi_title2`,(coalesce((`s1`.`remaining_effort` / `s1`.`ideal_burndown`),0) - coalesce((`s2`.`remaining_effort` / `s2`.`ideal_burndown`),0)) AS `kpi_value2` from (`Build_SummaryStoryView` `s1` left join `Build_SummaryStoryView` `s2` on(((`s1`.`sprint_id` = `s2`.`sprint_id`) and ((ltrim(replace(`s1`.`TrackerChange`,'Day ','')) - 1) = ltrim(replace(`s2`.`TrackerChange`,'Day ','')))))) union select `summary_story_view_base_table`.`sprint_id` AS `kpi_sprint_id`,concat('Day ',`summary_story_view_base_table`.`day_count`) AS `TrackerChange`,'Sprint Days' AS `kpi_name`,'Build Dashboard' AS `kpi_dashboard`,'Remain' AS `kpi_title1`,(`summary_story_view_base_table`.`sprint_days` - `summary_story_view_base_table`.`day_count`) AS `kpi_value1`,'Complete' AS `kpi_title2`,(`summary_story_view_base_table`.`day_count` - 1) AS `kpi_title2` from `summary_story_view_base_table` union select `YY`.`sprint_id` AS `kpi_sprint_id`,concat('Day ',`YY`.`day_count`) AS `TrackerChange`,'Due Date Summary' AS `kpi_name`,'Build Dashboard' AS `kpi_dashboard`,'Issue Due Tomorrow' AS `kpi_title1`,coalesce(`YY`.`due_tomo`,0) AS `kpi_value1`,'' AS `kpi_title2`,'' AS `kpi_value` from (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`sprint_name` AS `sprint_name`,`ssvbt`.`sprint_start_date` AS `sprint_start_date`,`ssvbt`.`sprint_end_date` AS `sprint_end_date`,`ssvbt`.`date` AS `date`,`ssvbt`.`day_count` AS `day_count`,`ssvbt`.`sprint_days` AS `sprint_days`,`XX`.`due_tomo` AS `due_tomo` from (`summary_story_view_base_table` `ssvbt` left join (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`date` AS `change_date`,count(distinct `isd`.`issue_id`) AS `due_tomo` from (((`summary_story_view_base_table` `ssvbt` left join `issue_sprint_data` `isd` on(((`ssvbt`.`sprint_id` = `isd`.`current_sprint_id`) and (`ssvbt`.`date` = `isd`.`dt`)))) left join `master_issue` `mi` on((`isd`.`issue_id` = `mi`.`issue_id`))) left join `daily_status_intermediate` `dsi` on(((`isd`.`issue_id` = `dsi`.`issue_id`) and (`ssvbt`.`date` = `dsi`.`date`)))) where (((to_days((case when (weekday(`ssvbt`.`sprint_end_date`) = 5) then (`ssvbt`.`sprint_end_date` + interval -(1) day) when (weekday(`ssvbt`.`sprint_end_date`) = 6) then (`ssvbt`.`sprint_end_date` + interval -(2) day) else `ssvbt`.`sprint_end_date` end)) - to_days(`ssvbt`.`date`)) = 1) and (`dsi`.`status_end_day` not in (10205,10403,11710))) group by `ssvbt`.`sprint_id`,`ssvbt`.`date`) `XX` on(((`ssvbt`.`sprint_id` = `XX`.`sprint_id`) and (`ssvbt`.`date` = `XX`.`change_date`))))) `YY` union select `YY`.`sprint_id` AS `kpi_sprint_id`,concat('Day ',`YY`.`day_count`) AS `TrackerChange`,'Due Date Summary' AS `kpi_name`,'Build Dashboard' AS `kpi_dashboard`,'Issue Due Today' AS `kpi_title1`,coalesce(`YY`.`due_today`,0) AS `kpi_value1`,'' AS `kpi_title2`,'' AS `kpi_value` from (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`sprint_name` AS `sprint_name`,`ssvbt`.`sprint_start_date` AS `sprint_start_date`,`ssvbt`.`sprint_end_date` AS `sprint_end_date`,`ssvbt`.`date` AS `date`,`ssvbt`.`day_count` AS `day_count`,`ssvbt`.`sprint_days` AS `sprint_days`,`XX`.`due_today` AS `due_today` from (`summary_story_view_base_table` `ssvbt` left join (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`date` AS `change_date`,count(distinct `isd`.`issue_id`) AS `due_today` from (((`summary_story_view_base_table` `ssvbt` left join `issue_sprint_data` `isd` on(((`ssvbt`.`sprint_id` = `isd`.`current_sprint_id`) and (`ssvbt`.`date` = `isd`.`dt`)))) left join `master_issue` `mi` on((`isd`.`issue_id` = `mi`.`issue_id`))) left join `daily_status_intermediate` `dsi` on(((`isd`.`issue_id` = `dsi`.`issue_id`) and (`ssvbt`.`date` = `dsi`.`date`)))) where (((to_days((case when (weekday(`ssvbt`.`sprint_end_date`) = 5) then (`ssvbt`.`sprint_end_date` + interval -(1) day) when (weekday(`ssvbt`.`sprint_end_date`) = 6) then (`ssvbt`.`sprint_end_date` + interval -(2) day) else `ssvbt`.`sprint_end_date` end)) - to_days(`ssvbt`.`date`)) = 0) and (`dsi`.`status_end_day` not in (10205,10403,11710))) group by `ssvbt`.`sprint_id`,`ssvbt`.`date`) `XX` on(((`ssvbt`.`sprint_id` = `XX`.`sprint_id`) and (`ssvbt`.`date` = `XX`.`change_date`))))) `YY` union select `YY`.`sprint_id` AS `kpi_sprint_id`,concat('Day ',`YY`.`day_count`) AS `TrackerChange`,'Due Date Summary' AS `kpi_name`,'Build Dashboard' AS `kpi_dashboard`,'Issue Past Due' AS `kpi_title1`,coalesce(`YY`.`past_due`,0) AS `kpi_value1`,'' AS `kpi_title2`,'' AS `kpi_value` from (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`sprint_name` AS `sprint_name`,`ssvbt`.`sprint_start_date` AS `sprint_start_date`,`ssvbt`.`sprint_end_date` AS `sprint_end_date`,`ssvbt`.`date` AS `date`,`ssvbt`.`day_count` AS `day_count`,`ssvbt`.`sprint_days` AS `sprint_days`,`XX`.`past_due` AS `past_due` from (`summary_story_view_base_table` `ssvbt` left join (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`date` AS `change_date`,count(distinct `isd`.`issue_id`) AS `past_due` from (((`summary_story_view_base_table` `ssvbt` left join `issue_sprint_data` `isd` on(((`ssvbt`.`sprint_id` = `isd`.`current_sprint_id`) and (`ssvbt`.`date` = `isd`.`dt`)))) left join `master_issue` `mi` on((`isd`.`issue_id` = `mi`.`issue_id`))) left join `daily_status_intermediate` `dsi` on(((`isd`.`issue_id` = `dsi`.`issue_id`) and (`ssvbt`.`date` = `dsi`.`date`)))) where (((to_days((case when (weekday(`ssvbt`.`sprint_end_date`) = 5) then (`ssvbt`.`sprint_end_date` + interval -(1) day) when (weekday(`ssvbt`.`sprint_end_date`) = 6) then (`ssvbt`.`sprint_end_date` + interval -(2) day) else `ssvbt`.`sprint_end_date` end)) - to_days(`ssvbt`.`date`)) < 0) and (`dsi`.`status_end_day` not in (10205,10403,11710))) group by `ssvbt`.`sprint_id`,`ssvbt`.`date`) `XX` on(((`ssvbt`.`sprint_id` = `XX`.`sprint_id`) and (`ssvbt`.`date` = `XX`.`change_date`))))) `YY` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Build_ChangeView`
--

/*!50001 DROP VIEW IF EXISTS `Build_ChangeView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Build_ChangeView` AS select `interim`.`project_id` AS `project_id`,`interim`.`issue_id` AS `issue_id`,`interim`.`issue_key` AS `issue_key`,`interim`.`summary` AS `summary`,`interim`.`sprint_id` AS `sprint_id`,`interim`.`TrackChange` AS `TrackChange`,`interim`.`status` AS `status`,`interim`.`assigned_to` AS `assigned_to`,`interim`.`change_type` AS `change_type`,`interim`.`change_item_from_string` AS `change_item_from_string`,`interim`.`change_item_to_string` AS `change_item_to_string`,`interim`.`change_created` AS `change_created`,`mua`.`display_name` AS `change_author`,`interim`.`Datediff` AS `DateDiff` from ((select `X`.`project_id` AS `project_id`,`X`.`issue_id` AS `issue_id`,`X`.`issue_key` AS `issue_key`,`X`.`summary` AS `summary`,`X`.`sprint_id` AS `sprint_id`,`X`.`TrackChange` AS `TrackChange`,`X`.`status` AS `status`,`X`.`assigned_to` AS `assigned_to`,'New Scope' AS `change_type`,`X`.`change_item_from_string` AS `change_item_from_string`,`X`.`change_item_to_string` AS `change_item_to_string`,`X`.`date` AS `change_created`,`X`.`change_author_account_id` AS `change_author_account_id`,(to_days(curdate()) - to_days(`X`.`date`)) AS `Datediff` from (select `cvi`.`issue_id` AS `issue_id`,`cvi`.`issue_key` AS `issue_key`,`cvi`.`summary` AS `summary`,`cvi`.`sprint_id` AS `sprint_id`,`cvi`.`project_id` AS `project_id`,`cvi`.`TrackChange` AS `TrackChange`,`cvi`.`date` AS `date`,`cvi`.`status` AS `status`,`cvi`.`assigned_to` AS `assigned_to`,(case when ((`new_scope`.`change_item_field` = 'sprint') and (`new_scope`.`sprint_id_change` = `cvi`.`sprint_id`)) then 1 when (`new_scope`.`change_item_field` = 'status') then 1 else 0 end) AS `filter_flag`,`new_scope`.`change_item_field` AS `change_item_field`,`new_scope`.`change_item_from_string` AS `change_item_from_string`,`new_scope`.`change_item_to_string` AS `change_item_to_string`,`new_scope`.`change_author_account_id` AS `change_author_account_id` from (`change_view_intermediate` `cvi` join (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `log_date`,`master_change_log_v2`.`change_item_field` AS `change_item_field`,(case when ((`master_change_log_v2`.`change_item_field` = 'sprint') and (((length(`master_change_log_v2`.`change_item_to`) - length(replace(`master_change_log_v2`.`change_item_to`,',',''))) + 1) = 1)) then `master_change_log_v2`.`change_item_to` when ((`master_change_log_v2`.`change_item_field` = 'sprint') and (((length(`master_change_log_v2`.`change_item_to`) - length(replace(`master_change_log_v2`.`change_item_to`,',',''))) + 1) > 1)) then cast(substring_index(`master_change_log_v2`.`change_item_to`,',',-(1)) as unsigned) end) AS `sprint_id_change`,`master_change_log_v2`.`change_item_from` AS `change_item_from`,`master_change_log_v2`.`change_item_to` AS `change_item_to`,`master_change_log_v2`.`change_item_from_string` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to_string` AS `change_item_to_string`,`master_change_log_v2`.`change_author_account_id` AS `change_author_account_id` from `master_change_log_v2` where ((`master_change_log_v2`.`change_item_field` = 'sprint') or ((`master_change_log_v2`.`change_item_field_id` = 'status') and (`master_change_log_v2`.`change_item_from` in (1,10011)) and (`master_change_log_v2`.`change_item_to` not in (10011,10013))))) `new_scope` on(((`new_scope`.`issue_id` = `cvi`.`issue_id`) and (`new_scope`.`log_date` = `cvi`.`date`))))) `X` where (`X`.`filter_flag` = 1) union select `X`.`project_id` AS `project_id`,`X`.`issue_id` AS `issue_id`,`X`.`issue_key` AS `issue_key`,`X`.`summary` AS `summary`,`X`.`sprint_id` AS `sprint_id`,`X`.`TrackChange` AS `TrackChange`,`X`.`status` AS `status`,`X`.`assigned_to` AS `assigned_to`,'Scope Removed' AS `change_type`,`X`.`change_item_from_string` AS `change_item_from_string`,`X`.`change_item_to_string` AS `change_item_to_string`,`X`.`date` AS `change_created`,`X`.`change_author_account_id` AS `change_author_account_id`,(to_days(curdate()) - to_days(`X`.`date`)) AS `Datediff` from (select `cvi`.`issue_id` AS `issue_id`,`cvi`.`issue_key` AS `issue_key`,`cvi`.`summary` AS `summary`,`cvi`.`sprint_id` AS `sprint_id`,`cvi`.`project_id` AS `project_id`,`cvi`.`TrackChange` AS `TrackChange`,`cvi`.`date` AS `date`,`cvi`.`status` AS `status`,`cvi`.`assigned_to` AS `assigned_to`,`scope_removed`.`change_item_from_string` AS `change_item_from_string`,`scope_removed`.`change_item_to_string` AS `change_item_to_string`,`scope_removed`.`change_author_account_id` AS `change_author_account_id`,(case when (`cvi`.`sprint_id` <> `scope_removed`.`sprint_id_change`) then 1 else 0 end) AS `filter_flag` from (`change_view_intermediate` `cvi` join (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `log_date`,(case when ((`master_change_log_v2`.`change_item_field` = 'sprint') and (((length(`master_change_log_v2`.`change_item_to`) - length(replace(`master_change_log_v2`.`change_item_to`,',',''))) + 1) = 1)) then `master_change_log_v2`.`change_item_to` when ((`master_change_log_v2`.`change_item_field` = 'sprint') and (((length(`master_change_log_v2`.`change_item_to`) - length(replace(`master_change_log_v2`.`change_item_to`,',',''))) + 1) > 1)) then cast(substring_index(`master_change_log_v2`.`change_item_to`,',',-(1)) as unsigned) end) AS `sprint_id_change`,`master_change_log_v2`.`change_item_from_string` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to_string` AS `change_item_to_string`,`master_change_log_v2`.`change_author_account_id` AS `change_author_account_id` from `master_change_log_v2` where (`master_change_log_v2`.`change_item_field` = 'sprint')) `scope_removed` on(((`cvi`.`issue_id` = `scope_removed`.`issue_id`) and (`cvi`.`date` = `scope_removed`.`log_date`))))) `X` where (`X`.`filter_flag` = 1) union select `cvi`.`project_id` AS `project_id`,`cvi`.`issue_id` AS `issue_id`,`cvi`.`issue_key` AS `issue_key`,`cvi`.`summary` AS `summary`,`cvi`.`sprint_id` AS `sprint_id`,`cvi`.`TrackChange` AS `TrackChange`,`cvi`.`status` AS `status`,`cvi`.`assigned_to` AS `assigned_to`,'Estimate Changed' AS `change_type`,`time_change`.`change_item_from_string` AS `change_item_from_string`,`time_change`.`change_item_to_string` AS `change_item_to_string`,`cvi`.`date` AS `change_created`,`time_change`.`change_author_account_id` AS `change_author_account_id`,(to_days(curdate()) - to_days(`cvi`.`date`)) AS `Datediff` from (`change_view_intermediate` `cvi` join (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `log_date`,`master_change_log_v2`.`change_item_from` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to` AS `change_item_to_string`,`master_change_log_v2`.`change_author_account_id` AS `change_author_account_id` from `master_change_log_v2` where (`master_change_log_v2`.`change_item_field` = 'timeoriginalestimate')) `time_change` on(((`cvi`.`issue_id` = `time_change`.`issue_id`) and (`cvi`.`date` = `time_change`.`log_date`)))) union select `cvi`.`project_id` AS `project_id`,`cvi`.`issue_id` AS `issue_id`,`cvi`.`issue_key` AS `issue_key`,`cvi`.`summary` AS `summary`,`cvi`.`sprint_id` AS `sprint_id`,`cvi`.`TrackChange` AS `TrackChange`,`cvi`.`status` AS `status`,`cvi`.`assigned_to` AS `assigned_to`,'Assignee Change' AS `change_type`,`time_change`.`change_item_from_string` AS `change_item_from_string`,`time_change`.`change_item_to_string` AS `change_item_to_string`,`cvi`.`date` AS `change_created`,`time_change`.`change_author_account_id` AS `change_author_account_id`,(to_days(curdate()) - to_days(`cvi`.`date`)) AS `Datediff` from (`change_view_intermediate` `cvi` join (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `log_date`,`master_change_log_v2`.`change_item_from_string` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to_string` AS `change_item_to_string`,`master_change_log_v2`.`change_author_account_id` AS `change_author_account_id` from `master_change_log_v2` where (`master_change_log_v2`.`change_item_field` = 'assignee')) `time_change` on(((`cvi`.`issue_id` = `time_change`.`issue_id`) and (`cvi`.`date` = `time_change`.`log_date`)))) union select `cvi`.`project_id` AS `project_id`,`cvi`.`issue_key` AS `issue_key`,`cvi`.`summary` AS `summary`,`cvi`.`issue_id` AS `issue_id`,`cvi`.`sprint_id` AS `sprint_id`,`cvi`.`TrackChange` AS `TrackChange`,`cvi`.`status` AS `status`,`cvi`.`assigned_to` AS `assigned_to`,'Ready for Testing' AS `change_type`,`uat`.`change_item_from_string` AS `change_item_from_string`,`uat`.`change_item_to_string` AS `change_item_to_string`,`cvi`.`date` AS `change_created`,`uat`.`change_author_account_id` AS `change_author_account_id`,(to_days(curdate()) - to_days(`cvi`.`date`)) AS `Datediff` from (`change_view_intermediate` `cvi` join (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `log_date`,`master_change_log_v2`.`change_item_from_string` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to_string` AS `change_item_to_string`,`master_change_log_v2`.`change_author_account_id` AS `change_author_account_id` from `master_change_log_v2` where ((`master_change_log_v2`.`change_item_field` = 'status') and (`master_change_log_v2`.`change_item_to` = 11710))) `uat` on(((`cvi`.`issue_id` = `uat`.`issue_id`) and (`cvi`.`date` = `uat`.`log_date`)))) union select `cvi`.`project_id` AS `project_id`,`cvi`.`issue_id` AS `issue_id`,`cvi`.`issue_key` AS `issue_key`,`cvi`.`summary` AS `summary`,`cvi`.`sprint_id` AS `sprint_id`,`cvi`.`TrackChange` AS `TrackChange`,`cvi`.`status` AS `status`,`cvi`.`assigned_to` AS `assigned_to`,'Due Date Change' AS `change_type`,`ddc`.`change_item_from_string` AS `change_item_from_string`,`ddc`.`change_item_to_string` AS `change_item_to_string`,`cvi`.`date` AS `change_created`,`ddc`.`change_author_account_id` AS `change_author_account_id`,(to_days(curdate()) - to_days(`cvi`.`date`)) AS `Datediff` from (`change_view_intermediate` `cvi` join (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `log_date`,cast(`master_change_log_v2`.`change_item_from_string` as date) AS `change_item_from_string`,cast(`master_change_log_v2`.`change_item_to_string` as date) AS `change_item_to_string`,`master_change_log_v2`.`change_author_account_id` AS `change_author_account_id` from `master_change_log_v2` where (`master_change_log_v2`.`change_item_field` = 'duedate')) `ddc` on(((`cvi`.`issue_id` = `ddc`.`issue_id`) and (`cvi`.`date` = `ddc`.`log_date`))))) `interim` left join `master_user_account` `mua` on((`interim`.`change_author_account_id` = `mua`.`account_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Build_StoryTrack`
--

/*!50001 DROP VIEW IF EXISTS `Build_StoryTrack`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Build_StoryTrack` AS select `i`.`project_id` AS `project_id`,`i`.`sprint_id` AS `sprint_id`,`sp`.`sprint_name` AS `sprint_name`,`i`.`summary` AS `issue_summary`,`i`.`epic_name` AS `epic_name`,(case when (coalesce(`epic_name`.`epic_name_text`,`i`.`epic_name_text`) = '') then `i`.`issue_key` else coalesce(`epic_name`.`epic_name_text`,`i`.`epic_name_text`) end) AS `epic_name_text`,`i`.`issue_key` AS `issue_key`,`st`.`status_name` AS `status_name`,`ac`.`display_name` AS `user_name`,`i`.`time_estimate` AS `estimated_hours`,(`i`.`time_estimate` - `i`.`time_spent`) AS `remaining_hours`,`i`.`due_date` AS `due_date`,`i`.`priority_name` AS `priority_name`,(to_days(now()) - to_days(`i`.`due_date`)) AS `missedduedate`,(to_days(now()) - to_days(`sp`.`sprint_start_date`)) AS `trackchange`,'Need to add table' AS `nextupdate`,`sp`.`sprint_state` AS `sprint_status` from (((((select `mi`.`issue_id` AS `issue_id`,`mi`.`issue_key` AS `issue_key`,`mi`.`issue_type_id` AS `issue_type_id`,`mi`.`project_id` AS `project_id`,`inter`.`sprint_id` AS `sprint_id`,`mi`.`status_id` AS `status_id`,`mi`.`status_category` AS `status_category`,`mi`.`epic_name` AS `epic_name`,`mi`.`story_point` AS `story_point`,`mi`.`assignee_account_id` AS `assignee_account_id`,`mi`.`creator_account_id` AS `creator_account_id`,`mi`.`reporter_account_id` AS `reporter_account_id`,`mi`.`summary` AS `summary`,`mi`.`description` AS `description`,`mi`.`fix_version` AS `fix_version`,`mi`.`time_estimate` AS `time_estimate`,`mi`.`time_original_estimate` AS `time_original_estimate`,`mi`.`aggregate_time_estimate` AS `aggregate_time_estimate`,`mi`.`aggregate_time_original_estimate` AS `aggregate_time_original_estimate`,`mi`.`time_spent` AS `time_spent`,`mi`.`aggregate_time_spent` AS `aggregate_time_spent`,`mi`.`work_ratio` AS `work_ratio`,`mi`.`created` AS `created`,`mi`.`updated` AS `updated`,`mi`.`status_category_change_date` AS `status_category_change_date`,`mi`.`start_date` AS `start_date`,`mi`.`change_start_date` AS `change_start_date`,`mi`.`change_completion_date` AS `change_completion_date`,`mi`.`due_date` AS `due_date`,`mi`.`epic_name_text` AS `epic_name_text`,`mi`.`priority_name` AS `priority_name` from (`master_issue` `mi` left join (select distinct `daily_status_intermediate`.`issue_id` AS `issue_id`,`daily_status_intermediate`.`sprint_id` AS `sprint_id` from `daily_status_intermediate`) `inter` on((`mi`.`issue_id` = `inter`.`issue_id`)))) `i` left join `master_sprint` `sp` on((`i`.`sprint_id` = `sp`.`sprint_id`))) left join `master_status` `st` on((`i`.`status_id` = `st`.`status_id`))) left join `master_user_account` `ac` on((`i`.`assignee_account_id` = `ac`.`account_id`))) left join (select distinct `master_issue`.`issue_key` AS `issue_key`,`master_issue`.`epic_name_text` AS `epic_name_text` from `master_issue` where (`master_issue`.`epic_name_text` <> '')) `epic_name` on((`i`.`epic_name` = `epic_name`.`issue_key`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Build_SummaryChangeView`
--

/*!50001 DROP VIEW IF EXISTS `Build_SummaryChangeView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Build_SummaryChangeView` AS select 1 AS `project_id`,1 AS `sprint_name`,1 AS `trackchange`,1 AS `change_type`,1 AS `original_value`,1 AS `new_value`,1 AS `change_value` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Build_SummaryStoryView`
--

/*!50001 DROP VIEW IF EXISTS `Build_SummaryStoryView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Build_SummaryStoryView` AS select `agg`.`sprint_id` AS `sprint_id`,`agg`.`sprint_name` AS `sprint_name`,concat('Day ',`agg`.`day_count`) AS `TrackerChange`,`agg`.`total_time` AS `total_time`,`agg`.`time_spent` AS `time_spent`,coalesce((`agg`.`total_time` - ((`agg`.`total_time` / `agg`.`sprint_days`) * (`agg`.`day_count` - 1))),0) AS `ideal_burndown`,(`agg`.`total_time` - `agg`.`time_spent`) AS `remaining_effort`,`agg`.`remaining_tasks` AS `remaining_tasks`,`agg`.`uat_tasks` AS `uat_tasks`,`agg`.`completed_tasks` AS `completed_tasks` from (select `dsl`.`sprint_id` AS `sprint_id`,`dsl`.`sprint_name` AS `sprint_name`,`dsl`.`date` AS `date`,`dsl`.`day_count` AS `day_count`,`dsl`.`sprint_days` AS `sprint_days`,count(distinct `dsl`.`issue_id`) AS `total_tasks`,count(distinct (case when (`dsl`.`status_end_day` in (10205,10403)) then `dsl`.`issue_id` end)) AS `completed_tasks`,count(distinct (case when (`dsl`.`status_end_day` = 11710) then `dsl`.`issue_id` end)) AS `uat_tasks`,count(distinct (case when (`dsl`.`status_end_day` not in (10205,10403,11710)) then `dsl`.`issue_id` end)) AS `remaining_tasks`,coalesce(sum((case when (`dsl`.`status_end_day` in (10205,10403)) then `mi`.`time_estimate` end)),0) AS `time_spent`,coalesce(sum(`mi`.`time_estimate`),0) AS `total_time` from (`daily_status_intermediate` `dsl` join `master_issue` `mi` on((`dsl`.`issue_id` = `mi`.`issue_id`))) group by `dsl`.`sprint_id`,`dsl`.`sprint_name`,`dsl`.`date`,`dsl`.`day_count`,`dsl`.`sprint_days`) `agg` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Build_changelog_summary`
--

/*!50001 DROP VIEW IF EXISTS `Build_changelog_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Build_changelog_summary` AS select `ssb`.`sprint_id` AS `sprint_id`,`ssb`.`sprint_name` AS `sprint_name`,`ssb`.`date` AS `date`,concat('Day ',`ssb`.`day_count`) AS `track_change`,`ssb`.`sprint_days` AS `sprint_days`,`ssa`.`issue_id_sr` AS `issue_id`,`ssa`.`change_type` AS `change_type`,`ssa`.`change_from` AS `change_from`,`ssa`.`change_to` AS `change_to`,(to_days(curdate()) - to_days(`ssb`.`date`)) AS `Datediff` from ((select `summary_story_view_base_table`.`sprint_id` AS `sprint_id`,`summary_story_view_base_table`.`sprint_name` AS `sprint_name`,`summary_story_view_base_table`.`sprint_start_date` AS `sprint_start_date`,`summary_story_view_base_table`.`sprint_end_date` AS `sprint_end_date`,`summary_story_view_base_table`.`date` AS `date`,`summary_story_view_base_table`.`day_count` AS `day_count`,`summary_story_view_base_table`.`sprint_days` AS `sprint_days` from `summary_story_view_base_table` where `summary_story_view_base_table`.`sprint_id` in (select distinct `ms`.`sprint_id` from (`master_sprint` `ms` join `master_issue` `mi` on((`ms`.`sprint_id` = `mi`.`sprint_id`))) where (cast(`ms`.`sprint_start_date` as date) <> 0))) `ssb` left join (select `t1`.`issue_id` AS `issue_id_sr`,`t1`.`log_date` AS `log_date`,`t1`.`sprint_id1` AS `sprint_id1`,(case when (`t1`.`sprint_id1` is not null) then 'Scope Removed' end) AS `change_type`,`t1`.`change_to` AS `change_to`,`t1`.`change_from` AS `change_from` from (select `X`.`issue_id` AS `issue_id`,`X`.`log_date` AS `log_date`,`X`.`change_to` AS `change_to`,`X`.`change_from` AS `change_from`,(case when ((`X`.`change_item_field` = 'sprint') and (length(`X`.`change_item_from`) = length(replace(`X`.`change_item_from`,',','')))) then `X`.`change_item_from` when ((`X`.`change_item_field` = 'sprint') and (length(`X`.`change_item_from`) <> length(replace(`X`.`change_item_from`,',','')))) then cast(substring_index(`X`.`change_item_from`,',',-(1)) as unsigned) end) AS `sprint_id1` from (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `log_date`,row_number() OVER (PARTITION BY `master_change_log_v2`.`issue_id`,cast(`master_change_log_v2`.`change_created` as date) ORDER BY `master_change_log_v2`.`change_created` desc )  AS `row_num`,`master_change_log_v2`.`change_item_field` AS `change_item_field`,`master_change_log_v2`.`change_item_to` AS `change_item_to`,`master_change_log_v2`.`change_item_from` AS `change_item_from`,(case when ((`master_change_log_v2`.`change_item_field` = 'sprint') and (length(`master_change_log_v2`.`change_item_from_string`) = length(replace(`master_change_log_v2`.`change_item_from_string`,',','')))) then `master_change_log_v2`.`change_item_from_string` when ((`master_change_log_v2`.`change_item_field` = 'sprint') and (length(`master_change_log_v2`.`change_item_from_string`) <> length(replace(`master_change_log_v2`.`change_item_from_string`,',','')))) then substring_index(`master_change_log_v2`.`change_item_from_string`,',',-(1)) end) AS `change_from`,(case when ((`master_change_log_v2`.`change_item_field` = 'sprint') and (length(`master_change_log_v2`.`change_item_to_string`) = length(replace(`master_change_log_v2`.`change_item_to_string`,',','')))) then `master_change_log_v2`.`change_item_to_string` when ((`master_change_log_v2`.`change_item_field` = 'sprint') and (length(`master_change_log_v2`.`change_item_to_string`) <> length(replace(`master_change_log_v2`.`change_item_to_string`,',','')))) then substring_index(`master_change_log_v2`.`change_item_to_string`,',',-(1)) end) AS `change_to` from `master_change_log_v2` where ((`master_change_log_v2`.`change_item_field` = 'sprint') and (`master_change_log_v2`.`change_item_from` is not null))) `X` where (`X`.`row_num` = 1)) `t1`) `ssa` on(((`ssa`.`log_date` = `ssb`.`date`) and (`ssa`.`sprint_id1` = `ssb`.`sprint_id`)))) where (`ssa`.`change_type` is not null) union all select `ssb`.`sprint_id` AS `sprint_id`,`ssb`.`sprint_name` AS `sprint_name`,`ssb`.`date` AS `date`,concat('Day ',`ssb`.`day_count`) AS `track_change`,`ssb`.`sprint_days` AS `sprint_days`,`ssc`.`issue_id_ns` AS `issue_id`,`ssc`.`change_type` AS `change_type`,`ssc`.`change_from` AS `change_from`,`ssc`.`change_to` AS `change_to`,(to_days(curdate()) - to_days(`ssb`.`date`)) AS `Datediff` from ((select `summary_story_view_base_table`.`sprint_id` AS `sprint_id`,`summary_story_view_base_table`.`sprint_name` AS `sprint_name`,`summary_story_view_base_table`.`sprint_start_date` AS `sprint_start_date`,`summary_story_view_base_table`.`sprint_end_date` AS `sprint_end_date`,`summary_story_view_base_table`.`date` AS `date`,`summary_story_view_base_table`.`day_count` AS `day_count`,`summary_story_view_base_table`.`sprint_days` AS `sprint_days` from `summary_story_view_base_table` where `summary_story_view_base_table`.`sprint_id` in (select distinct `ms`.`sprint_id` from (`master_sprint` `ms` join `master_issue` `mi` on((`ms`.`sprint_id` = `mi`.`sprint_id`))) where (cast(`ms`.`sprint_start_date` as date) <> 0))) `ssb` left join (select `t2`.`issue_id` AS `issue_id_ns`,`t2`.`log_date` AS `log_date`,`t2`.`sprint_id2` AS `sprint_id2`,(case when (`t2`.`sprint_id2` is not null) then 'New Scope' else 'n' end) AS `change_type`,`t2`.`change_to` AS `change_to`,`t2`.`change_from` AS `change_from` from (select `X`.`issue_id` AS `issue_id`,`X`.`log_date` AS `log_date`,`X`.`change_to` AS `change_to`,`X`.`change_from` AS `change_from`,(case when (`X`.`status_end_day` <> 1) then (case when ((`X`.`change_item_field` = 'sprint') and (length(`X`.`change_item_to`) = length(replace(`X`.`change_item_to`,',','')))) then `X`.`change_item_to` when ((`X`.`change_item_field` = 'sprint') and (length(`X`.`change_item_to`) <> length(replace(`X`.`change_item_to`,',','')))) then cast(substring_index(`X`.`change_item_to`,',',-(1)) as unsigned) when (`X`.`change_item_field` = 'status') then `X`.`sprint_id_dsl` else `X`.`change_item_to` end) end) AS `sprint_id2` from (select `mcl2`.`issue_id` AS `issue_id`,cast(`mcl2`.`change_created` as date) AS `log_date`,`mcl2`.`sprint_id_dsl` AS `sprint_id_dsl`,row_number() OVER (PARTITION BY `mcl2`.`issue_id`,cast(`mcl2`.`change_created` as date) ORDER BY `mcl2`.`change_created` desc )  AS `row_num`,`mcl2`.`change_item_field` AS `change_item_field`,`mcl2`.`change_item_to` AS `change_item_to`,`mcl2`.`change_item_from` AS `change_item_from`,`mcl2`.`status_end_day` AS `status_end_day`,(case when ((`mcl2`.`change_item_field` = 'sprint') and (length(`mcl2`.`change_item_from_string`) = length(replace(`mcl2`.`change_item_from_string`,',','')))) then `mcl2`.`change_item_from_string` when ((`mcl2`.`change_item_field` = 'sprint') and (length(`mcl2`.`change_item_from_string`) <> length(replace(`mcl2`.`change_item_from_string`,',','')))) then substring_index(`mcl2`.`change_item_from_string`,',',-(1)) else `mcl2`.`change_item_from_string` end) AS `change_from`,(case when ((`mcl2`.`change_item_field` = 'sprint') and (length(`mcl2`.`change_item_to_string`) = length(replace(`mcl2`.`change_item_to_string`,',','')))) then `mcl2`.`change_item_to_string` when ((`mcl2`.`change_item_field` = 'sprint') and (length(`mcl2`.`change_item_to_string`) <> length(replace(`mcl2`.`change_item_to_string`,',','')))) then substring_index(`mcl2`.`change_item_to_string`,',',-(1)) else `mcl2`.`change_item_to_string` end) AS `change_to` from (select `mcl`.`change_id` AS `change_id`,`mcl`.`issue_id` AS `issue_id`,`mcl`.`change_author_account_id` AS `change_author_account_id`,`mcl`.`change_createdv1` AS `change_createdv1`,`mcl`.`change_item_key` AS `change_item_key`,`mcl`.`change_item_field` AS `change_item_field`,`mcl`.`change_item_field_type` AS `change_item_field_type`,`mcl`.`change_item_field_id` AS `change_item_field_id`,`mcl`.`change_item_from` AS `change_item_from`,`mcl`.`change_item_from_string` AS `change_item_from_string`,`mcl`.`change_item_to` AS `change_item_to`,`mcl`.`change_item_to_string` AS `change_item_to_string`,`mcl`.`change_created` AS `change_created`,`dsl`.`status_end_day` AS `status_end_day`,`dsl`.`sprint_id` AS `sprint_id_dsl` from (`master_change_log_v2` `mcl` left join `daily_status_intermediate` `dsl` on(((`mcl`.`issue_id` = `dsl`.`issue_id`) and (cast(`mcl`.`change_created` as date) = cast(`dsl`.`date` as date)))))) `mcl2` where ((`mcl2`.`change_item_field` = 'sprint') or ((`mcl2`.`change_item_field` = 'status') and (`mcl2`.`change_item_from` in (1,10011)) and (`mcl2`.`change_item_to` not in (10011,10013,10206))))) `X` where (`X`.`row_num` = 1)) `t2`) `ssc` on(((`ssc`.`log_date` = `ssb`.`date`) and (`ssc`.`sprint_id2` = `ssb`.`sprint_id`)))) where (`ssc`.`change_type` is not null) union all select `g`.`sprint_id` AS `sprint_id`,`g`.`sprint_name` AS `sprint_name`,`g`.`date` AS `date`,concat('Day ',`g`.`day_count`) AS `track_change`,`g`.`sprint_days` AS `sprint_days`,`g`.`issue_id` AS `issue_id`,'Estimate Change' AS `change_type`,coalesce(`g`.`change_item_from_string`,0) AS `change_from`,coalesce(`g`.`change_item_to_string`,0) AS `change_to`,(to_days(curdate()) - to_days(`g`.`date`)) AS `Datediff` from (select `dsi`.`sprint_id` AS `sprint_id`,`dsi`.`sprint_name` AS `sprint_name`,`dsi`.`sprint_start_date` AS `sprint_start_date`,`dsi`.`sprint_end_date` AS `sprint_end_date`,`dsi`.`date` AS `date`,`dsi`.`day_count` AS `day_count`,`dsi`.`sprint_days` AS `sprint_days`,`dsi`.`issue_id` AS `issue_id`,`dsi`.`status_end_day` AS `status_end_day`,`dsi`.`log_date` AS `log_date`,`dsi`.`f_rank` AS `f_rank`,`ec`.`change_created` AS `change_created`,`ec`.`change_item_from_string` AS `change_item_from_string`,`ec`.`change_item_to_string` AS `change_item_to_string` from ((select `chg_est`.`issue_id` AS `issue_id`,cast(`chg_est`.`change_created` as date) AS `change_created`,`chg_est`.`change_item_from_string` AS `change_item_from_string`,`chg_est`.`change_item_to_string` AS `change_item_to_string` from (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `change_created`,`master_change_log_v2`.`change_item_from_string` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to_string` AS `change_item_to_string`,row_number() OVER (PARTITION BY `master_change_log_v2`.`issue_id`,cast(`master_change_log_v2`.`change_created` as date) ORDER BY `master_change_log_v2`.`change_created` desc )  AS `row_num` from `master_change_log_v2` where (`master_change_log_v2`.`change_item_field` = 'Original Estimate (h')) `chg_est` where (`chg_est`.`row_num` = 1)) `ec` left join `daily_status_intermediate` `dsi` on(((`ec`.`issue_id` = `dsi`.`issue_id`) and (`ec`.`change_created` = `dsi`.`date`))))) `g` where (`g`.`issue_id` is not null) union all select `g`.`sprint_id` AS `sprint_id`,`g`.`sprint_name` AS `sprint_name`,`g`.`date` AS `date`,concat('Day ',`g`.`day_count`) AS `track_change`,`g`.`sprint_days` AS `sprint_days`,`g`.`issue_id` AS `issue_id`,'Assignee Change' AS `change_type`,coalesce(`g`.`change_item_from_string`,'-') AS `change_from`,coalesce(`g`.`change_item_to_string`,'-') AS `change_to`,(to_days(curdate()) - to_days(`g`.`date`)) AS `Datediff` from (select `dsi`.`sprint_id` AS `sprint_id`,`dsi`.`sprint_name` AS `sprint_name`,`dsi`.`sprint_start_date` AS `sprint_start_date`,`dsi`.`sprint_end_date` AS `sprint_end_date`,`dsi`.`date` AS `date`,`dsi`.`day_count` AS `day_count`,`dsi`.`sprint_days` AS `sprint_days`,`dsi`.`issue_id` AS `issue_id`,`dsi`.`status_end_day` AS `status_end_day`,`dsi`.`log_date` AS `log_date`,`dsi`.`f_rank` AS `f_rank`,`ec`.`change_created` AS `change_created`,`ec`.`change_item_from_string` AS `change_item_from_string`,`ec`.`change_item_to_string` AS `change_item_to_string` from ((select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `change_created`,`master_change_log_v2`.`change_item_from_string` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to_string` AS `change_item_to_string` from `master_change_log_v2` where (`master_change_log_v2`.`change_item_field` = 'assignee')) `ec` left join `daily_status_intermediate` `dsi` on(((`ec`.`issue_id` = `dsi`.`issue_id`) and (`ec`.`change_created` = `dsi`.`date`))))) `g` where (`g`.`issue_id` is not null) union all select `g`.`sprint_id` AS `sprint_id`,`g`.`sprint_name` AS `sprint_name`,`g`.`date` AS `date`,concat('Day ',`g`.`day_count`) AS `track_change`,`g`.`sprint_days` AS `sprint_days`,`g`.`issue_id` AS `issue_id`,'Ready for Testing' AS `change_type`,coalesce(`g`.`change_item_from_string`,'-') AS `change_from`,coalesce(`g`.`change_item_to_string`,'-') AS `change_to`,(to_days(curdate()) - to_days(`g`.`date`)) AS `Datediff` from (select `dsi`.`sprint_id` AS `sprint_id`,`dsi`.`sprint_name` AS `sprint_name`,`dsi`.`sprint_start_date` AS `sprint_start_date`,`dsi`.`sprint_end_date` AS `sprint_end_date`,`dsi`.`date` AS `date`,`dsi`.`day_count` AS `day_count`,`dsi`.`sprint_days` AS `sprint_days`,`dsi`.`issue_id` AS `issue_id`,`dsi`.`status_end_day` AS `status_end_day`,`dsi`.`log_date` AS `log_date`,`dsi`.`f_rank` AS `f_rank`,`ec`.`change_created` AS `change_created`,`ec`.`change_item_from_string` AS `change_item_from_string`,`ec`.`change_item_to_string` AS `change_item_to_string` from ((select `t`.`issue_id` AS `issue_id`,`t`.`change_created` AS `change_created`,`t`.`change_item_from_string` AS `change_item_from_string`,`t`.`change_item_to_string` AS `change_item_to_string`,`t`.`change_item_to` AS `change_item_to`,`t`.`row_num` AS `row_num` from (select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `change_created`,`master_change_log_v2`.`change_item_from_string` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to_string` AS `change_item_to_string`,`master_change_log_v2`.`change_item_to` AS `change_item_to`,row_number() OVER (PARTITION BY `master_change_log_v2`.`issue_id`,cast(`master_change_log_v2`.`change_created` as date) ORDER BY `master_change_log_v2`.`change_created` desc )  AS `row_num` from `master_change_log_v2` where (`master_change_log_v2`.`change_item_field` = 'status')) `t` where ((`t`.`row_num` = 1) and (`t`.`change_item_to` = 11710))) `ec` left join `daily_status_intermediate` `dsi` on(((`ec`.`issue_id` = `dsi`.`issue_id`) and (`ec`.`change_created` = `dsi`.`date`))))) `g` where (`g`.`issue_id` is not null) union all select `g`.`sprint_id` AS `sprint_id`,`g`.`sprint_name` AS `sprint_name`,`g`.`date` AS `date`,concat('Day ',`g`.`day_count`) AS `track_change`,`g`.`sprint_days` AS `sprint_days`,`g`.`issue_id` AS `issue_id`,'Due Date Change' AS `change_type`,coalesce(`g`.`change_item_from_string`,'-') AS `change_from`,coalesce(`g`.`change_item_to_string`,'-') AS `change_to`,(to_days(curdate()) - to_days(`g`.`date`)) AS `Datediff` from (select `dsi`.`sprint_id` AS `sprint_id`,`dsi`.`sprint_name` AS `sprint_name`,`dsi`.`sprint_start_date` AS `sprint_start_date`,`dsi`.`sprint_end_date` AS `sprint_end_date`,`dsi`.`date` AS `date`,`dsi`.`day_count` AS `day_count`,`dsi`.`sprint_days` AS `sprint_days`,`dsi`.`issue_id` AS `issue_id`,`dsi`.`status_end_day` AS `status_end_day`,`dsi`.`log_date` AS `log_date`,`dsi`.`f_rank` AS `f_rank`,`ec`.`change_created` AS `change_created`,`ec`.`change_item_from_string` AS `change_item_from_string`,`ec`.`change_item_to_string` AS `change_item_to_string` from ((select `master_change_log_v2`.`issue_id` AS `issue_id`,cast(`master_change_log_v2`.`change_created` as date) AS `change_created`,`master_change_log_v2`.`change_item_from_string` AS `change_item_from_string`,`master_change_log_v2`.`change_item_to_string` AS `change_item_to_string` from `master_change_log_v2` where (`master_change_log_v2`.`change_item_field` = 'duedate')) `ec` left join `daily_status_intermediate` `dsi` on(((`ec`.`issue_id` = `dsi`.`issue_id`) and (`ec`.`change_created` = `dsi`.`date`))))) `g` where (`g`.`issue_id` is not null) union all select `summary_story_view_base_table`.`sprint_id` AS `sprint_id`,NULL AS `sprint_name`,NULL AS `date`,concat('Day ',`summary_story_view_base_table`.`day_count`) AS `track_change`,`summary_story_view_base_table`.`sprint_days` AS `sprint_days`,NULL AS `issue_id`,'Scope Removed' AS `change_type`,NULL AS `change_from`,NULL AS `change_to`,NULL AS `Datediff` from `summary_story_view_base_table` where `summary_story_view_base_table`.`sprint_id` in (select distinct `ms`.`sprint_id` from (`master_sprint` `ms` join `master_issue` `mi` on((`ms`.`sprint_id` = `mi`.`sprint_id`))) where (cast(`ms`.`sprint_start_date` as date) <> 0)) union all select `summary_story_view_base_table`.`sprint_id` AS `sprint_id`,NULL AS `sprint_name`,NULL AS `date`,concat('Day ',`summary_story_view_base_table`.`day_count`) AS `track_change`,`summary_story_view_base_table`.`sprint_days` AS `sprint_days`,NULL AS `issue_id`,'New Scope' AS `change_type`,NULL AS `change_from`,NULL AS `change_to`,NULL AS `Datediff` from `summary_story_view_base_table` where `summary_story_view_base_table`.`sprint_id` in (select distinct `ms`.`sprint_id` from (`master_sprint` `ms` join `master_issue` `mi` on((`ms`.`sprint_id` = `mi`.`sprint_id`))) where (cast(`ms`.`sprint_start_date` as date) <> 0)) union all select `summary_story_view_base_table`.`sprint_id` AS `sprint_id`,NULL AS `sprint_name`,NULL AS `date`,concat('Day ',`summary_story_view_base_table`.`day_count`) AS `track_change`,`summary_story_view_base_table`.`sprint_days` AS `sprint_days`,NULL AS `issue_id`,'Estimate Change' AS `change_type`,NULL AS `change_from`,NULL AS `change_to`,NULL AS `Datediff` from `summary_story_view_base_table` where `summary_story_view_base_table`.`sprint_id` in (select distinct `ms`.`sprint_id` from (`master_sprint` `ms` join `master_issue` `mi` on((`ms`.`sprint_id` = `mi`.`sprint_id`))) where (cast(`ms`.`sprint_start_date` as date) <> 0)) union all select `summary_story_view_base_table`.`sprint_id` AS `sprint_id`,NULL AS `sprint_name`,NULL AS `date`,concat('Day ',`summary_story_view_base_table`.`day_count`) AS `track_change`,`summary_story_view_base_table`.`sprint_days` AS `sprint_days`,NULL AS `issue_id`,'Assignee Change' AS `change_type`,NULL AS `change_from`,NULL AS `change_to`,NULL AS `Datediff` from `summary_story_view_base_table` where `summary_story_view_base_table`.`sprint_id` in (select distinct `ms`.`sprint_id` from (`master_sprint` `ms` join `master_issue` `mi` on((`ms`.`sprint_id` = `mi`.`sprint_id`))) where (cast(`ms`.`sprint_start_date` as date) <> 0)) union all select `summary_story_view_base_table`.`sprint_id` AS `sprint_id`,NULL AS `sprint_name`,NULL AS `date`,concat('Day ',`summary_story_view_base_table`.`day_count`) AS `track_change`,`summary_story_view_base_table`.`sprint_days` AS `sprint_days`,NULL AS `issue_id`,'Ready for Testing' AS `change_type`,NULL AS `change_from`,NULL AS `change_to`,NULL AS `Datediff` from `summary_story_view_base_table` where `summary_story_view_base_table`.`sprint_id` in (select distinct `ms`.`sprint_id` from (`master_sprint` `ms` join `master_issue` `mi` on((`ms`.`sprint_id` = `mi`.`sprint_id`))) where (cast(`ms`.`sprint_start_date` as date) <> 0)) union all select `summary_story_view_base_table`.`sprint_id` AS `sprint_id`,NULL AS `sprint_name`,NULL AS `date`,concat('Day ',`summary_story_view_base_table`.`day_count`) AS `track_change`,`summary_story_view_base_table`.`sprint_days` AS `sprint_days`,NULL AS `issue_id`,'Due Date Change' AS `change_type`,NULL AS `change_from`,NULL AS `change_to`,NULL AS `Datediff` from `summary_story_view_base_table` where `summary_story_view_base_table`.`sprint_id` in (select distinct `ms`.`sprint_id` from (`master_sprint` `ms` join `master_issue` `mi` on((`ms`.`sprint_id` = `mi`.`sprint_id`))) where (cast(`ms`.`sprint_start_date` as date) <> 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Build_kpi`
--

/*!50001 DROP VIEW IF EXISTS `Build_kpi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Build_kpi` AS select `a`.`sprint_id` AS `sprint_id`,`a`.`track_change` AS `track_change`,`a`.`change_type` AS `change_type`,`a`.`current_value` AS `kpi_value`,(case when (`b`.`previous_value` < `a`.`current_value`) then 1 when (`b`.`previous_value` > `a`.`current_value`) then -(1) else 0 end) AS `kpi_delta` from ((select `Build_changelog_summary`.`sprint_id` AS `sprint_id`,`Build_changelog_summary`.`track_change` AS `track_change`,`Build_changelog_summary`.`change_type` AS `change_type`,count(distinct `Build_changelog_summary`.`issue_id`) AS `current_value`,concat(substr(`Build_changelog_summary`.`track_change`,5),`Build_changelog_summary`.`change_type`) AS `row_num1` from `Build_changelog_summary` group by `Build_changelog_summary`.`sprint_id`,`Build_changelog_summary`.`track_change`,`Build_changelog_summary`.`change_type` order by `row_num1`) `a` left join (select `Build_changelog_summary`.`sprint_id` AS `sprint_id`,`Build_changelog_summary`.`track_change` AS `track_change`,`Build_changelog_summary`.`change_type` AS `change_type`,count(distinct `Build_changelog_summary`.`issue_id`) AS `previous_value`,concat((substr(`Build_changelog_summary`.`track_change`,5) + 1),`Build_changelog_summary`.`change_type`) AS `row_num2` from `Build_changelog_summary` group by `Build_changelog_summary`.`sprint_id`,`Build_changelog_summary`.`track_change`,`Build_changelog_summary`.`change_type` order by `row_num2`) `b` on(((`a`.`sprint_id` = `b`.`sprint_id`) and (`a`.`row_num1` = `b`.`row_num2`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Due_date_master`
--

/*!50001 DROP VIEW IF EXISTS `Due_date_master`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Due_date_master` AS select `ddt`.`issue_id` AS `issue_id`,`ddt`.`issue_key` AS `issue_key`,`ddt`.`issue_type_id` AS `issue_type_id`,`ddt`.`project_id` AS `project_id`,`ddt`.`sprint_id` AS `sprint_id`,`ddt`.`status_id` AS `status_id`,`ddt`.`status_category` AS `status_category`,`ddt`.`epic_name` AS `epic_name`,`ddt`.`story_point` AS `story_point`,`ddt`.`assignee_account_id` AS `assignee_account_id`,`ddt`.`creator_account_id` AS `creator_account_id`,`ddt`.`reporter_account_id` AS `reporter_account_id`,`ddt`.`fix_version` AS `fix_version`,`ddt`.`time_estimate` AS `time_estimate`,`ddt`.`time_original_estimate` AS `time_original_estimate`,`ddt`.`aggregate_time_estimate` AS `aggregate_time_estimate`,`ddt`.`aggregate_time_original_estimate` AS `aggregate_time_original_estimate`,`ddt`.`time_spent` AS `time_spent`,`ddt`.`work_ratio` AS `work_ratio`,`ddt`.`created_v2` AS `created_v2`,`ddt`.`created` AS `created`,`ddt`.`updated` AS `updated`,`ddt`.`status_category_change_date` AS `status_category_change_date`,`ddt`.`start_date` AS `start_date`,`ddt`.`change_start_date` AS `change_start_date`,`ddt`.`change_completion_date` AS `change_completion_date`,`ddt`.`priority_name` AS `priority_name`,`ddt`.`epic_name_text` AS `epic_name_text`,`ddt`.`sprint_due_date` AS `sprint_due_date`,`rs`.`Project_Name` AS `project_name`,`rs`.`Assignee` AS `assignee`,`rs`.`sprint_name` AS `sprint_name`,`rs`.`Assigned_hours` AS `assigned_hours`,`rs`.`status` AS `status`,`rs`.`priority` AS `priority` from ((select `mi`.`issue_id` AS `issue_id`,`mi`.`issue_key` AS `issue_key`,`mi`.`issue_type_id` AS `issue_type_id`,`mi`.`project_id` AS `project_id`,`mi`.`sprint_id` AS `sprint_id`,`mi`.`status_id` AS `status_id`,`mi`.`status_category` AS `status_category`,`mi`.`epic_name` AS `epic_name`,`mi`.`story_point` AS `story_point`,`mi`.`assignee_account_id` AS `assignee_account_id`,`mi`.`creator_account_id` AS `creator_account_id`,`mi`.`reporter_account_id` AS `reporter_account_id`,`mi`.`fix_version` AS `fix_version`,`mi`.`time_estimate` AS `time_estimate`,`mi`.`time_original_estimate` AS `time_original_estimate`,`mi`.`aggregate_time_estimate` AS `aggregate_time_estimate`,`mi`.`aggregate_time_original_estimate` AS `aggregate_time_original_estimate`,`mi`.`time_spent` AS `time_spent`,`mi`.`work_ratio` AS `work_ratio`,`mi`.`created` AS `created_v2`,(case when (weekday(`mi`.`created`) = 5) then (`mi`.`created` + interval 2 day) when (weekday(`mi`.`created`) = 6) then (`mi`.`created` + interval 1 day) else `mi`.`created` end) AS `created`,`mi`.`updated` AS `updated`,`mi`.`status_category_change_date` AS `status_category_change_date`,`mi`.`start_date` AS `start_date`,`mi`.`change_start_date` AS `change_start_date`,`mi`.`change_completion_date` AS `change_completion_date`,`mi`.`priority_name` AS `priority_name`,`mi`.`epic_name_text` AS `epic_name_text`,`msp`.`sprint_end_date` AS `sprint_due_date` from (`master_issue` `mi` left join `master_sprint` `msp` on((`mi`.`sprint_id` = `msp`.`sprint_id`)))) `ddt` left join (select `q1`.`issue_id` AS `issue_id`,`q1`.`issue_key` AS `issue_key`,`q1`.`project_id` AS `project_id`,`q1`.`Project_Name` AS `Project_Name`,`q1`.`epic_name` AS `epic_name`,`q1`.`display_name` AS `Assignee`,`q1`.`sprint_id` AS `sprint_id`,`q1`.`sprint_name` AS `sprint_name`,`q1`.`time_estimate` AS `time_estimate`,`pd`.`Development Hours` AS `Assigned_hours`,`q1`.`status` AS `status`,`q1`.`priority` AS `priority` from ((select `mi`.`issue_id` AS `issue_id`,`mi`.`issue_key` AS `issue_key`,`mi`.`project_id` AS `project_id`,trim(replace(replace(replace(replace(`mp`.`project_name`,'- Keystone',''),'Keystone',''),'-',''),'Financial Force – ','Financial Force')) AS `Project_Name`,`mi`.`epic_name` AS `epic_name`,`mua`.`display_name` AS `display_name`,`mi`.`sprint_id` AS `sprint_id`,trim(substring_index(replace(`ms`.`sprint_name`,'Keystone',''),' ',3)) AS `sprint_name`,`mi`.`time_estimate` AS `time_estimate`,`msa`.`status_name` AS `status`,`mi`.`priority_name` AS `priority` from ((((`master_issue` `mi` left join `master_project` `mp` on((`mi`.`project_id` = `mp`.`project_id`))) left join `master_status` `msa` on((`mi`.`status_id` = `msa`.`status_id`))) left join `master_user_account` `mua` on((`mi`.`assignee_account_id` = `mua`.`account_id`))) left join `master_sprint` `ms` on((`mi`.`sprint_id` = `ms`.`sprint_id`)))) `q1` left join `planners_data` `pd` on(((`q1`.`Project_Name` = `pd`.`ï»¿Project`) and (`q1`.`display_name` = `pd`.`Resource`) and (`q1`.`sprint_name` = `pd`.`Sprint`))))) `rs` on((`ddt`.`issue_id` = `rs`.`issue_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_CardData`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_CardData`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_CardData` AS select `proj_base_table`.`project_id` AS `kpi_project_id`,concat('Day ',`proj_base_table`.`day_count`) AS `TrackerChange`,'All' AS `fix_version`,'Completed Days' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Completed Days' AS `kpi_title1`,`proj_base_table`.`day_count` AS `kpi_value1`,'' AS `kpi_title2`,'' AS `kpi_value2`,'Grey' AS `kpi_group`,1 AS `kpi_order`,'No' AS `kpi_click`,'test' AS `kpi_icon` from `proj_base_table` union select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,'All' AS `fix_version`,'Groomed User Stories' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Percentage' AS `kpi_title1`,coalesce(`XX`.`groomed_perc`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,(case when ((`XX`.`groomed_perc` - coalesce(`YY`.`groomed_perc`,0)) = 0) then 0 when ((`XX`.`groomed_perc` - coalesce(`YY`.`groomed_perc`,0)) > 0) then 1 when ((`XX`.`groomed_perc` - coalesce(`YY`.`groomed_perc`,0)) < 0) then -(1) end) AS `kpi_value2`,'Grey' AS `kpi_group`,2 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from ((select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,round((100 * (count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `project_issue_daily_status_intermediate`.`issue_id` end)) / count(distinct `project_issue_daily_status_intermediate`.`issue_id`))),2) AS `groomed_perc` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`) `XX` left join (select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,round((100 * (count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `project_issue_daily_status_intermediate`.`issue_id` end)) / count(distinct `project_issue_daily_status_intermediate`.`issue_id`))),2) AS `groomed_perc` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`)))) union select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,'All' AS `fix_version`,'Total User Stories' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Total' AS `kpi_title1`,coalesce(`XX`.`total_stories`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,(case when ((`XX`.`total_stories` - coalesce(`YY`.`total_stories`,0)) = 0) then 0 when ((`XX`.`total_stories` - coalesce(`YY`.`total_stories`,0)) > 0) then 1 when ((`XX`.`total_stories` - coalesce(`YY`.`total_stories`,0)) < 0) then -(1) end) AS `kpi_title2`,'Light Blue' AS `kpi_group`,3 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from ((select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,count(distinct `project_issue_daily_status_intermediate`.`issue_id`) AS `total_stories` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`) `XX` left join (select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,count(distinct `project_issue_daily_status_intermediate`.`issue_id`) AS `total_stories` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`)))) union select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,'All' AS `fix_version`,'New User Stories' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Total' AS `kpi_title1`,coalesce(`XX`.`issues`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,(case when ((`XX`.`issues` - coalesce(`YY`.`issues`,0)) = 0) then 0 when ((`XX`.`issues` - coalesce(`YY`.`issues`,0)) > 0) then 1 when ((`XX`.`issues` - coalesce(`YY`.`issues`,0)) < 0) then -(1) end) AS `kpi_value2`,'Light Blue' AS `kpi_group`,4 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from ((select `pbt`.`project_id` AS `project_id`,`pbt`.`project_start_date` AS `project_start_date`,`pbt`.`project_end_date` AS `project_end_date`,`pbt`.`dt` AS `dt`,`pbt`.`day_count` AS `day_count`,coalesce(`mi`.`issues`,0) AS `issues` from (`proj_base_table` `pbt` left join (select `master_issue`.`project_id` AS `project_id`,cast(`master_issue`.`created` as date) AS `created_date`,count(distinct `master_issue`.`issue_id`) AS `issues` from `master_issue` where (`master_issue`.`issue_type_id` <> 10000) group by `master_issue`.`project_id`,cast(`master_issue`.`created` as date)) `mi` on(((`pbt`.`project_id` = `mi`.`project_id`) and (`pbt`.`dt` = `mi`.`created_date`))))) `XX` left join (select `pbt`.`project_id` AS `project_id`,`pbt`.`project_start_date` AS `project_start_date`,`pbt`.`project_end_date` AS `project_end_date`,`pbt`.`dt` AS `dt`,`pbt`.`day_count` AS `day_count`,coalesce(`mi`.`issues`,0) AS `issues` from (`proj_base_table` `pbt` left join (select `master_issue`.`project_id` AS `project_id`,cast(`master_issue`.`created` as date) AS `created_date`,count(distinct `master_issue`.`issue_id`) AS `issues` from `master_issue` where (`master_issue`.`issue_type_id` <> 10000) group by `master_issue`.`project_id`,cast(`master_issue`.`created` as date)) `mi` on(((`pbt`.`project_id` = `mi`.`project_id`) and (`pbt`.`dt` = `mi`.`created_date`))))) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`)))) union select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,'All' AS `fix_version`,'User Stories To-Do' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Total' AS `kpi_title1`,coalesce(`XX`.`to_do`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,(case when ((`XX`.`to_do` - coalesce(`YY`.`to_do`,0)) = 0) then 0 when ((`XX`.`to_do` - coalesce(`YY`.`to_do`,0)) > 0) then 1 when ((`XX`.`to_do` - coalesce(`YY`.`to_do`,0)) < 0) then -(1) end) AS `kpi_value2`,'Light Blue' AS `kpi_group`,5 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from ((select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `project_issue_daily_status_intermediate`.`issue_id` end)) AS `to_do` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`) `XX` left join (select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `project_issue_daily_status_intermediate`.`issue_id` end)) AS `to_do` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`)))) union select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,'All' AS `fix_version`,'Blocked User Stories' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Total' AS `kpi_title1`,coalesce(`XX`.`blocked`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,(case when ((`XX`.`blocked` - coalesce(`YY`.`blocked`,0)) = 0) then 0 when ((`XX`.`blocked` - coalesce(`YY`.`blocked`,0)) > 0) then 1 when ((`XX`.`blocked` - coalesce(`YY`.`blocked`,0)) < 0) then -(1) end) AS `kpi_value2`,'Light Blue' AS `kpi_group`,6 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from ((select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` = 10104) then `project_issue_daily_status_intermediate`.`issue_id` end)) AS `blocked` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`) `XX` left join (select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` = 10104) then `project_issue_daily_status_intermediate`.`issue_id` end)) AS `blocked` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`)))) union select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,'All' AS `fix_version`,'Estimate Summary' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Estimate' AS `kpi_title1`,coalesce(`XX`.`original`,0) AS `kpi_value1`,'Planned' AS `kpi_title2`,`XX`.`new_time` AS `kpi_value2`,'Grey' AS `kpi_group`,7 AS `kpi_order`,'No' AS `kpi_click`,'test' AS `kpi_icon` from (select `pdte`.`project_id` AS `project_id`,`pdte`.`day_count` AS `day_count`,sum(coalesce((case when (`pdte`.`new_estimate` <> 0) then `pdte`.`new_estimate` else `pdte`.`original_estimate` end),0)) AS `original`,sum(coalesce(`pdte`.`new_estimate`,0)) AS `new_time` from `project_daily_time_estimate` `pdte` group by `pdte`.`project_id`,`pdte`.`day_count`) `XX` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_CardData_fixversion`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_CardData_fixversion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_CardData_fixversion` AS select `fx`.`kpi_project_id` AS `kpi_project_id`,`fx`.`TrackerChange` AS `TrackerChange`,`fx`.`fix_version` AS `fix_version`,'Groomed User Stories' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Percentage' AS `kpi_title1`,coalesce(`rt`.`kpi_value1`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,coalesce(`rt`.`kpi_value2`,0) AS `kpi_value2`,'Grey' AS `kpi_group`,2 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from (`fix_version_day_intermediate` `fx` left join (select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,`XX`.`fix_version` AS `fix_version`,coalesce(`XX`.`groomed_perc`,0) AS `kpi_value1`,(case when ((coalesce(`XX`.`groomed_perc`,0) - coalesce(`YY`.`groomed_perc`,0)) = 0) then 0 when ((coalesce(`XX`.`groomed_perc`,0) - coalesce(`YY`.`groomed_perc`,0)) > 0) then 1 when ((coalesce(`XX`.`groomed_perc`,0) - coalesce(`YY`.`groomed_perc`,0)) < 0) then -(1) end) AS `kpi_value2` from ((select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,`project_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,round((100 * (count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `project_issue_daily_status_intermediate`.`issue_id` end)) / count(distinct `project_issue_daily_status_intermediate`.`issue_id`))),2) AS `groomed_perc` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`,`project_issue_daily_status_intermediate`.`fix_version`) `XX` join (select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,`project_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,round((100 * (count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `project_issue_daily_status_intermediate`.`issue_id` end)) / count(distinct `project_issue_daily_status_intermediate`.`issue_id`))),2) AS `groomed_perc` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`,`project_issue_daily_status_intermediate`.`fix_version`) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`) and (`XX`.`fix_version` = `YY`.`fix_version`))))) `rt` on(((`fx`.`kpi_project_id` = `rt`.`kpi_project_id`) and (`fx`.`TrackerChange` = `rt`.`TrackerChange`) and (`fx`.`fix_version` = `rt`.`fix_version`)))) union select `fx`.`kpi_project_id` AS `kpi_project_id`,`fx`.`TrackerChange` AS `TrackerChange`,`fx`.`fix_version` AS `fix_version`,'Total User Stories' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Total' AS `kpi_title1`,coalesce(`rt`.`kpi_value1`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,coalesce(`rt`.`kpi_value2`,0) AS `kpi_value2`,'Light Blue' AS `kpi_group`,3 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from (`fix_version_day_intermediate` `fx` left join (select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,`XX`.`fix_version` AS `fix_version`,coalesce(`XX`.`total_stories`,0) AS `kpi_value1`,(case when ((`XX`.`total_stories` - coalesce(`YY`.`total_stories`,0)) = 0) then 0 when ((`XX`.`total_stories` - coalesce(`YY`.`total_stories`,0)) > 0) then 1 when ((`XX`.`total_stories` - coalesce(`YY`.`total_stories`,0)) < 0) then -(1) end) AS `kpi_value2` from ((select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,`project_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,count(distinct `project_issue_daily_status_intermediate`.`issue_id`) AS `total_stories` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`,`project_issue_daily_status_intermediate`.`fix_version`) `XX` join (select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,`project_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,count(distinct `project_issue_daily_status_intermediate`.`issue_id`) AS `total_stories` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`,`project_issue_daily_status_intermediate`.`fix_version`) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`) and (`XX`.`fix_version` = `YY`.`fix_version`))))) `rt` on(((`fx`.`kpi_project_id` = `rt`.`kpi_project_id`) and (`fx`.`TrackerChange` = `rt`.`TrackerChange`) and (`fx`.`fix_version` = `rt`.`fix_version`)))) union select `fx`.`kpi_project_id` AS `kpi_project_id`,`fx`.`TrackerChange` AS `TrackerChange`,`fx`.`fix_version` AS `fix_version`,'New User Stories' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Total' AS `kpi_title1`,coalesce(`rt`.`kpi_value1`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,coalesce(`rt`.`kpi_value2`,0) AS `kpi_value2`,'Light Blue' AS `kpi_group`,4 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from (`fix_version_day_intermediate` `fx` left join (select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,`XX`.`fix_version` AS `fix_version`,coalesce(`XX`.`issues`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,(case when ((`XX`.`issues` - coalesce(`YY`.`issues`,0)) = 0) then 0 when ((`XX`.`issues` - coalesce(`YY`.`issues`,0)) > 0) then 1 when ((`XX`.`issues` - coalesce(`YY`.`issues`,0)) < 0) then -(1) end) AS `kpi_value2` from ((select `pbt`.`project_id` AS `project_id`,`pbt`.`project_start_date` AS `project_start_date`,`pbt`.`project_end_date` AS `project_end_date`,`pbt`.`dt` AS `dt`,`pbt`.`day_count` AS `day_count`,`mi`.`fix_version` AS `fix_version`,coalesce(`mi`.`issues`,0) AS `issues` from (`proj_base_table` `pbt` left join (select `master_issue`.`project_id` AS `project_id`,cast(`master_issue`.`created` as date) AS `created_date`,`master_issue`.`fix_version` AS `fix_version`,count(distinct `master_issue`.`issue_id`) AS `issues` from `master_issue` where (`master_issue`.`issue_type_id` <> 10000) group by `master_issue`.`project_id`,cast(`master_issue`.`created` as date),`master_issue`.`fix_version`) `mi` on(((`pbt`.`project_id` = `mi`.`project_id`) and (`pbt`.`dt` = `mi`.`created_date`))))) `XX` left join (select `pbt`.`project_id` AS `project_id`,`pbt`.`project_start_date` AS `project_start_date`,`pbt`.`project_end_date` AS `project_end_date`,`pbt`.`dt` AS `dt`,`pbt`.`day_count` AS `day_count`,`mi`.`fix_version` AS `fix_version`,coalesce(`mi`.`issues`,0) AS `issues` from (`proj_base_table` `pbt` left join (select `master_issue`.`project_id` AS `project_id`,cast(`master_issue`.`created` as date) AS `created_date`,`master_issue`.`fix_version` AS `fix_version`,count(distinct `master_issue`.`issue_id`) AS `issues` from `master_issue` where (`master_issue`.`issue_type_id` <> 10000) group by `master_issue`.`project_id`,cast(`master_issue`.`created` as date),`master_issue`.`fix_version`) `mi` on(((`pbt`.`project_id` = `mi`.`project_id`) and (`pbt`.`dt` = `mi`.`created_date`))))) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`) and (`XX`.`fix_version` = `YY`.`fix_version`))))) `rt` on(((`fx`.`kpi_project_id` = `rt`.`kpi_project_id`) and (`fx`.`TrackerChange` = `rt`.`TrackerChange`) and (`fx`.`fix_version` = `rt`.`fix_version`)))) union select `fx`.`kpi_project_id` AS `kpi_project_id`,`fx`.`TrackerChange` AS `TrackerChange`,`fx`.`fix_version` AS `fix_version`,'User Stories To-Do' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Total' AS `kpi_title1`,coalesce(`rt`.`kpi_value1`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,coalesce(`rt`.`kpi_value2`,0) AS `kpi_value2`,'Light Blue' AS `kpi_group`,5 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from (`fix_version_day_intermediate` `fx` left join (select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,`XX`.`fix_version` AS `fix_version`,coalesce(`XX`.`to_do`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,(case when ((`XX`.`to_do` - coalesce(`YY`.`to_do`,0)) = 0) then 0 when ((`XX`.`to_do` - coalesce(`YY`.`to_do`,0)) > 0) then 1 when ((`XX`.`to_do` - coalesce(`YY`.`to_do`,0)) < 0) then -(1) end) AS `kpi_value2` from ((select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,`project_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `project_issue_daily_status_intermediate`.`issue_id` end)) AS `to_do` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`,`project_issue_daily_status_intermediate`.`fix_version`) `XX` left join (select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,`project_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `project_issue_daily_status_intermediate`.`issue_id` end)) AS `to_do` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`,`project_issue_daily_status_intermediate`.`fix_version`) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`) and (`XX`.`fix_version` = `YY`.`fix_version`))))) `rt` on(((`fx`.`kpi_project_id` = `rt`.`kpi_project_id`) and (`fx`.`TrackerChange` = `rt`.`TrackerChange`) and (`fx`.`fix_version` = `rt`.`fix_version`)))) union select `fx`.`kpi_project_id` AS `kpi_project_id`,`fx`.`TrackerChange` AS `TrackerChange`,`fx`.`fix_version` AS `fix_version`,'Blocked User Stories' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Total' AS `kpi_title1`,coalesce(`rt`.`kpi_value1`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,coalesce(`rt`.`kpi_value2`,0) AS `kpi_value2`,'Light Blue' AS `kpi_group`,6 AS `kpi_order`,'yes' AS `kpi_click`,'test' AS `kpi_icon` from (`fix_version_day_intermediate` `fx` left join (select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,`XX`.`fix_version` AS `fix_version`,coalesce(`XX`.`blocked`,0) AS `kpi_value1`,'Change' AS `kpi_title2`,(case when ((`XX`.`blocked` - coalesce(`YY`.`blocked`,0)) = 0) then 0 when ((`XX`.`blocked` - coalesce(`YY`.`blocked`,0)) > 0) then 1 when ((`XX`.`blocked` - coalesce(`YY`.`blocked`,0)) < 0) then -(1) end) AS `kpi_value2` from ((select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,`project_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` = 10104) then `project_issue_daily_status_intermediate`.`issue_id` end)) AS `blocked` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`,`project_issue_daily_status_intermediate`.`fix_version`) `XX` left join (select `project_issue_daily_status_intermediate`.`project_id` AS `project_id`,`project_issue_daily_status_intermediate`.`dt` AS `dt`,`project_issue_daily_status_intermediate`.`day_count` AS `day_count`,`project_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,count(distinct (case when (`project_issue_daily_status_intermediate`.`status_end_day` = 10104) then `project_issue_daily_status_intermediate`.`issue_id` end)) AS `blocked` from `project_issue_daily_status_intermediate` group by `project_issue_daily_status_intermediate`.`project_id`,`project_issue_daily_status_intermediate`.`dt`,`project_issue_daily_status_intermediate`.`day_count`,`project_issue_daily_status_intermediate`.`fix_version`) `YY` on(((`XX`.`project_id` = `YY`.`project_id`) and ((`XX`.`day_count` - 1) = `YY`.`day_count`) and (`XX`.`fix_version` = `YY`.`fix_version`))))) `rt` on(((`fx`.`kpi_project_id` = `rt`.`kpi_project_id`) and (`fx`.`TrackerChange` = `rt`.`TrackerChange`) and (`fx`.`fix_version` = `rt`.`fix_version`)))) union select `XX`.`project_id` AS `kpi_project_id`,concat('Day ',`XX`.`day_count`) AS `TrackerChange`,`XX`.`fix_version` AS `fix_version`,'Estimate Summary' AS `kpi_name`,'sprint_requirement' AS `kpi_dashboard`,'Estimate' AS `kpi_title1`,coalesce(`XX`.`original`,0) AS `kpi_value1`,'Planned' AS `kpi_title2`,`XX`.`new_time` AS `kpi_value2`,'Grey' AS `kpi_group`,7 AS `kpi_order`,'No' AS `kpi_click`,'test' AS `kpi_icon` from (select `pdte`.`project_id` AS `project_id`,`pdte`.`day_count` AS `day_count`,`pdte`.`fix_version` AS `fix_version`,sum(coalesce((case when (`pdte`.`new_estimate` <> 0) then `pdte`.`new_estimate` else `pdte`.`original_estimate` end),0)) AS `original`,sum(coalesce(`pdte`.`new_estimate`,0)) AS `new_time` from `project_daily_time_estimate` `pdte` group by `pdte`.`project_id`,`pdte`.`day_count`,`pdte`.`fix_version`) `XX` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_EpicSummary`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_EpicSummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_EpicSummary` AS select `ebl`.`project_id` AS `project_id`,`ebl`.`epic_name` AS `Epic_name`,coalesce(`epic_name`.`epic_name_text`,`ebl`.`epic_name`) AS `Epic_name_text`,concat('Day ',`ebl`.`day_count`) AS `TrackChange`,`stories`.`groomed_stories` AS `Groomed_Stories`,`stories`.`total_stories` AS `Total_User_Stories`,`org_time`.`original_hours` AS `Original_hours`,`org_time`.`new_time` AS `New_Estimate`,coalesce(`ehe`.`estimate_hours`,0) AS `Estimate_hours` from ((((`epic_base_table` `ebl` left join (select `mi`.`project_id` AS `project_id`,`eid`.`epic_name` AS `epic_name`,`eid`.`day_count` AS `day_count`,count(distinct (case when (`eid`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `eid`.`issue_id` end)) AS `groomed_stories`,(count(`eid`.`issue_id`) - count(distinct (case when (`eid`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `eid`.`issue_id` end))) AS `total_stories`,count(`eid`.`issue_id`) AS `total_user_stories` from (`epic_issue_daily_status_intermediate` `eid` join `master_issue` `mi` on(((`eid`.`issue_id` = `mi`.`issue_id`) and (`eid`.`project_id` = `mi`.`project_id`)))) group by `mi`.`project_id`,`eid`.`epic_name`,`eid`.`day_count`) `stories` on(((`ebl`.`epic_name` = `stories`.`epic_name`) and (`ebl`.`day_count` = `stories`.`day_count`) and (`ebl`.`project_id` = `stories`.`project_id`)))) left join (select `pedts`.`project_id` AS `project_id`,`pedts`.`epic_name` AS `epic_name`,`pedts`.`day_count` AS `day_count`,sum(coalesce((case when (`pedts`.`new_estimate` <> 0) then `pedts`.`new_estimate` else `pedts`.`original_estimate` end),0)) AS `original_hours`,sum(coalesce(`pedts`.`new_estimate`,0)) AS `new_time` from (`project_epic_daily_time_estimate` `pedts` left join `master_issue` `mi` on(((`pedts`.`issue_id` = `mi`.`issue_id`) and (`pedts`.`project_id` = `mi`.`project_id`)))) group by `pedts`.`project_id`,`pedts`.`epic_name`,`pedts`.`day_count`) `org_time` on(((`ebl`.`epic_name` = `org_time`.`epic_name`) and (`ebl`.`day_count` = `org_time`.`day_count`) and (`ebl`.`project_id` = `org_time`.`project_id`)))) left join (select distinct `master_issue`.`issue_key` AS `issue_key`,`master_issue`.`epic_name_text` AS `epic_name_text` from `master_issue` where (`master_issue`.`epic_name_text` <> '')) `epic_name` on((`ebl`.`epic_name` = `epic_name`.`epic_name_text`))) left join `epic_hours_estimate` `ehe` on((`ebl`.`epic_name` = `ehe`.`epic_key`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_EpicSummary_fixversion`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_EpicSummary_fixversion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_EpicSummary_fixversion` AS select `epx`.`project_id` AS `project_id`,`epx`.`epic_name` AS `epic_name`,coalesce(`epic_name`.`epic_name_text`,`epx`.`epic_name`) AS `Epic_name_text`,concat('Day ',`epx`.`day_count`) AS `TrackChange`,`epx`.`fix_version` AS `fix_version`,coalesce(`rt`.`Groomed_Stories`,0) AS `Groomed_Stories`,coalesce(`rt`.`Total_User_Stories`,0) AS `Total_User_Stories`,coalesce(`rt`.`Original_hours`,0) AS `Original_hours`,coalesce(`rt`.`New_Estimate`,0) AS `New_Estimate`,coalesce(`ehe`.`estimate_hours`,0) AS `Estimate_hours` from (((`epic_fix_version_base` `epx` left join (select `ebl`.`project_id` AS `project_id`,`ebl`.`epic_name` AS `Epic_name`,concat('Day ',`ebl`.`day_count`) AS `TrackChange`,`stories`.`fix_version` AS `fix_version`,`stories`.`groomed_stories` AS `Groomed_Stories`,`stories`.`total_stories` AS `Total_User_Stories`,`org_time`.`original_hours` AS `Original_hours`,`org_time`.`new_time` AS `New_Estimate` from ((`epic_base_table` `ebl` left join (select `epic_issue_daily_status_intermediate`.`project_id` AS `project_id`,`epic_issue_daily_status_intermediate`.`epic_name` AS `epic_name`,`epic_issue_daily_status_intermediate`.`day_count` AS `day_count`,`epic_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,count(distinct (case when (`epic_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `epic_issue_daily_status_intermediate`.`issue_id` end)) AS `groomed_stories`,(count(`epic_issue_daily_status_intermediate`.`issue_id`) - count(distinct (case when (`epic_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `epic_issue_daily_status_intermediate`.`issue_id` end))) AS `total_stories`,count(`epic_issue_daily_status_intermediate`.`issue_id`) AS `total_user_stories` from `epic_issue_daily_status_intermediate` group by `epic_issue_daily_status_intermediate`.`project_id`,`epic_issue_daily_status_intermediate`.`epic_name`,`epic_issue_daily_status_intermediate`.`day_count`,`epic_issue_daily_status_intermediate`.`fix_version`) `stories` on(((`ebl`.`epic_name` = `stories`.`epic_name`) and (`ebl`.`day_count` = `stories`.`day_count`)))) left join (select `project_epic_daily_time_estimate`.`project_id` AS `project_id`,`project_epic_daily_time_estimate`.`epic_name` AS `epic_name`,`project_epic_daily_time_estimate`.`fix_version` AS `fix_version`,`project_epic_daily_time_estimate`.`day_count` AS `day_count`,sum(coalesce((case when (`project_epic_daily_time_estimate`.`new_estimate` <> 0) then `project_epic_daily_time_estimate`.`new_estimate` else `project_epic_daily_time_estimate`.`original_estimate` end),0)) AS `original_hours`,sum(coalesce(`project_epic_daily_time_estimate`.`new_estimate`,0)) AS `new_time` from `project_epic_daily_time_estimate` group by `project_epic_daily_time_estimate`.`project_id`,`project_epic_daily_time_estimate`.`epic_name`,`project_epic_daily_time_estimate`.`fix_version`,`project_epic_daily_time_estimate`.`day_count`) `org_time` on(((`ebl`.`epic_name` = `org_time`.`epic_name`) and (`ebl`.`day_count` = `org_time`.`day_count`) and (`stories`.`fix_version` = `org_time`.`fix_version`))))) `rt` on(((`epx`.`epic_name` = `rt`.`Epic_name`) and (`epx`.`fix_version` = `rt`.`fix_version`) and (concat('Day ',`epx`.`day_count`) = `rt`.`TrackChange`)))) left join (select distinct `master_issue`.`issue_key` AS `issue_key`,`master_issue`.`epic_name_text` AS `epic_name_text` from `master_issue` where (`master_issue`.`epic_name` <> '')) `epic_name` on((`epx`.`epic_name` = `epic_name`.`issue_key`))) left join `epic_hours_estimate` `ehe` on((`epx`.`epic_name` = `ehe`.`epic_key`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_EpicSummarytest`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_EpicSummarytest`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_EpicSummarytest` AS select `ebl`.`project_id` AS `project_id`,`ebl`.`epic_name` AS `Epic_name`,concat('Day ',`ebl`.`day_count`) AS `TrackChange`,`stories`.`groomed_stories` AS `Groomed_Stories`,`stories`.`total_stories` AS `Total_User_Stories`,`org_time`.`original_hours` AS `Original_hours`,`org_time`.`new_time` AS `New_Estimate`,coalesce(`ehe`.`estimate_hours`,0) AS `Estimate_hours` from (((`epic_base_table` `ebl` left join (select `mi`.`project_id` AS `project_id`,`eid`.`epic_name` AS `epic_name`,`eid`.`day_count` AS `day_count`,count(distinct (case when (`eid`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `eid`.`issue_id` end)) AS `groomed_stories`,(count(`eid`.`issue_id`) - count(distinct (case when (`eid`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `eid`.`issue_id` end))) AS `total_stories`,count(`eid`.`issue_id`) AS `total_user_stories` from (`epic_issue_daily_status_intermediate` `eid` join `master_issue` `mi` on(((`eid`.`issue_id` = `mi`.`issue_id`) and (`eid`.`project_id` = `mi`.`project_id`)))) group by `mi`.`project_id`,`eid`.`epic_name`,`eid`.`day_count`) `stories` on(((`ebl`.`epic_name` = `stories`.`epic_name`) and (`ebl`.`day_count` = `stories`.`day_count`) and (`ebl`.`project_id` = `stories`.`project_id`)))) left join (select `pedts`.`project_id` AS `project_id`,`pedts`.`epic_name` AS `epic_name`,`pedts`.`day_count` AS `day_count`,sum(coalesce((case when (`pedts`.`new_estimate` <> 0) then `pedts`.`new_estimate` else `pedts`.`original_estimate` end),0)) AS `original_hours`,sum(coalesce(`pedts`.`new_estimate`,0)) AS `new_time` from (`project_epic_daily_time_estimate` `pedts` left join `master_issue` `mi` on(((`pedts`.`issue_id` = `mi`.`issue_id`) and (`pedts`.`project_id` = `mi`.`project_id`)))) group by `pedts`.`project_id`,`pedts`.`epic_name`,`pedts`.`day_count`) `org_time` on(((`ebl`.`epic_name` = `org_time`.`epic_name`) and (`ebl`.`day_count` = `org_time`.`day_count`) and (`ebl`.`project_id` = `org_time`.`project_id`)))) left join `epic_hours_estimate` `ehe` on((`ebl`.`epic_name` = `ehe`.`epic_key`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_EstimateSummary`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_EstimateSummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_EstimateSummary` AS select `ebl`.`project_id` AS `project_id`,concat('Day ',`ebl`.`day_count`) AS `TrackChange`,`stories`.`groomed_stories` AS `To_do_stories`,`stories`.`requirement_complete` AS `Requirement_complete`,`stories`.`total_stories` AS `Remaining_User_Stories`,`org_time`.`original_hours` AS `Original_hours`,`org_time`.`new_time` AS `Estimated_minutes`,`stories`.`total_user_stories` AS `total_user_stories` from ((`epic_base_table` `ebl` left join (select `eid`.`project_id` AS `project_id`,`eid`.`day_count` AS `day_count`,count((case when (`eid`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `eid`.`issue_id` end)) AS `groomed_stories`,count((case when (`eid`.`status_end_day` = 11707) then `eid`.`issue_id` end)) AS `requirement_complete`,((count(`eid`.`issue_id`) - count((case when (`eid`.`status_end_day` = 11707) then `eid`.`issue_id` end))) - count(distinct (case when (`eid`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `eid`.`issue_id` end))) AS `total_stories`,count(`eid`.`issue_id`) AS `total_user_stories` from (`epic_issue_daily_status_intermediate` `eid` join `master_issue` `mi` on(((`eid`.`issue_id` = `mi`.`issue_id`) and (`eid`.`project_id` = `mi`.`project_id`)))) group by `eid`.`project_id`,`eid`.`day_count`) `stories` on(((`ebl`.`day_count` = `stories`.`day_count`) and (`ebl`.`project_id` = `stories`.`project_id`)))) left join (select `project_epic_daily_time_estimate`.`project_id` AS `project_id`,`project_epic_daily_time_estimate`.`day_count` AS `day_count`,sum(coalesce((case when (`project_epic_daily_time_estimate`.`new_estimate` <> 0) then `project_epic_daily_time_estimate`.`new_estimate` else `project_epic_daily_time_estimate`.`original_estimate` end),0)) AS `original_hours`,sum(coalesce(`project_epic_daily_time_estimate`.`new_estimate`,0)) AS `new_time` from `project_epic_daily_time_estimate` group by `project_epic_daily_time_estimate`.`project_id`,`project_epic_daily_time_estimate`.`day_count`) `org_time` on(((`ebl`.`day_count` = `org_time`.`day_count`) and (`ebl`.`project_id` = `org_time`.`project_id`)))) where (`stories`.`total_user_stories` <> 0) group by `ebl`.`project_id`,concat('Day ',`ebl`.`day_count`),`stories`.`groomed_stories`,`stories`.`requirement_complete`,`stories`.`total_stories`,`org_time`.`original_hours`,`org_time`.`new_time`,`stories`.`total_user_stories` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_EstimateSummary_fixversion`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_EstimateSummary_fixversion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_EstimateSummary_fixversion` AS select `epx`.`kpi_project_id` AS `project_id`,`epx`.`TrackerChange` AS `TrackChange`,`epx`.`fix_version` AS `fix_version`,coalesce(`rt`.`To_do_stories`,0) AS `To_do_stories`,coalesce(`rt`.`Requirement_complete`,0) AS `Requirement_complete`,coalesce(`rt`.`Remaining_User_Stories`,0) AS `Remaining_User_Stories`,coalesce(`rt`.`Original_hours`,0) AS `Original_hours`,coalesce(`rt`.`Estimated_minutes`,0) AS `Estimated_minutes`,coalesce(`rt`.`total_user_stories`,0) AS `total_user_stories` from (`fix_version_day_intermediate` `epx` left join (select `ebl`.`project_id` AS `project_id`,concat('Day ',`ebl`.`day_count`) AS `TrackChange`,`stories`.`fix_version` AS `fix_version`,`stories`.`groomed_stories` AS `To_do_stories`,`stories`.`requirement_complete` AS `Requirement_complete`,`stories`.`total_stories` AS `Remaining_User_Stories`,`org_time`.`original_hours` AS `Original_hours`,`org_time`.`new_time` AS `Estimated_minutes`,`stories`.`total_user_stories` AS `total_user_stories` from ((`epic_base_table` `ebl` left join (select `epic_issue_daily_status_intermediate`.`project_id` AS `project_id`,`epic_issue_daily_status_intermediate`.`day_count` AS `day_count`,`epic_issue_daily_status_intermediate`.`fix_version` AS `fix_version`,count((case when (`epic_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `epic_issue_daily_status_intermediate`.`issue_id` end)) AS `groomed_stories`,count((case when (`epic_issue_daily_status_intermediate`.`status_end_day` = 11707) then `epic_issue_daily_status_intermediate`.`issue_id` end)) AS `requirement_complete`,((count(`epic_issue_daily_status_intermediate`.`issue_id`) - count((case when (`epic_issue_daily_status_intermediate`.`status_end_day` = 11707) then `epic_issue_daily_status_intermediate`.`issue_id` end))) - count(distinct (case when (`epic_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `epic_issue_daily_status_intermediate`.`issue_id` end))) AS `total_stories`,count(`epic_issue_daily_status_intermediate`.`issue_id`) AS `total_user_stories` from `epic_issue_daily_status_intermediate` group by `epic_issue_daily_status_intermediate`.`project_id`,`epic_issue_daily_status_intermediate`.`day_count`,`epic_issue_daily_status_intermediate`.`fix_version`) `stories` on(((`ebl`.`day_count` = `stories`.`day_count`) and (`ebl`.`project_id` = `stories`.`project_id`)))) left join (select `project_epic_daily_time_estimate`.`project_id` AS `project_id`,`project_epic_daily_time_estimate`.`fix_version` AS `fix_version`,`project_epic_daily_time_estimate`.`day_count` AS `day_count`,sum(coalesce((case when (`project_epic_daily_time_estimate`.`new_estimate` <> 0) then `project_epic_daily_time_estimate`.`new_estimate` else `project_epic_daily_time_estimate`.`original_estimate` end),0)) AS `original_hours`,sum(coalesce(`project_epic_daily_time_estimate`.`new_estimate`,0)) AS `new_time` from `project_epic_daily_time_estimate` group by `project_epic_daily_time_estimate`.`project_id`,`project_epic_daily_time_estimate`.`fix_version`,`project_epic_daily_time_estimate`.`day_count`) `org_time` on(((`ebl`.`day_count` = `org_time`.`day_count`) and (`ebl`.`project_id` = `org_time`.`project_id`) and (`stories`.`fix_version` = `org_time`.`fix_version`)))) where (`stories`.`total_user_stories` <> 0) group by `ebl`.`project_id`,concat('Day ',`ebl`.`day_count`),`stories`.`fix_version`,`stories`.`groomed_stories`,`stories`.`requirement_complete`,`stories`.`total_stories`,`org_time`.`original_hours`,`org_time`.`new_time`,`stories`.`total_user_stories`) `rt` on(((`epx`.`kpi_project_id` = `rt`.`project_id`) and (`epx`.`fix_version` = `rt`.`fix_version`) and (`epx`.`TrackerChange` = `rt`.`TrackChange`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_MainTableView`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_MainTableView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_MainTableView` AS select `a`.`project_id` AS `project_id`,`a`.`issue_key` AS `issue_key`,`a`.`issue_type_id` AS `issue_type_id`,`a`.`issue_type_name` AS `issue_type_name`,`a`.`fix_version` AS `fix_version`,`a`.`summary` AS `summary`,`a`.`epic_name` AS `epic_name`,`a`.`status` AS `status`,`a`.`to_do_filter` AS `to_do_filter`,`a`.`blocked_filter` AS `blocked_filter`,`a`.`new_stories_filter` AS `new_stories_filter`,`a`.`original_hours` AS `original_hours`,`a`.`new_hours` AS `new_hours`,`a`.`change_hours` AS `change_hours`,`a`.`user_name` AS `user_name`,`a`.`priority_name` AS `priority_name`,`a`.`trackchange` AS `trackchange`,`a`.`New_Filter` AS `New_Filter`,`a`.`lastupdate` AS `lastupdate`,`a`.`nextupdate` AS `nextupdate` from (select `eps`.`project_id` AS `project_id`,`mi`.`issue_key` AS `issue_key`,`mi`.`issue_type_id` AS `issue_type_id`,`mit`.`issue_type_name` AS `issue_type_name`,`mi`.`fix_version` AS `fix_version`,`mi`.`summary` AS `summary`,coalesce(`mi`.`epic_name`,concat(`mi`.`project_id`,'-Unassigned')) AS `epic_name`,`ms`.`status_name` AS `status`,(case when (`eps`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then 'User Stories To-DO' else 'n' end) AS `to_do_filter`,(case when (`eps`.`status_end_day` = 10104) then 'Blocked User Stories' else 'n' end) AS `blocked_filter`,(case when (`new_stories`.`created_date` is not null) then 'New User Stories' else 'n' end) AS `new_stories_filter`,`org_time`.`original_hours` AS `original_hours`,`org_time`.`new_time` AS `new_hours`,(case when (coalesce(`org_time`.`new_time`,0) = 0) then 0 else (`org_time`.`new_time` - `org_time`.`original_hours`) end) AS `change_hours`,`mua`.`display_name` AS `user_name`,`mi`.`priority_name` AS `priority_name`,concat('Day ',`eps`.`day_count`) AS `trackchange`,'Y' AS `New_Filter`,'Need to add table' AS `lastupdate`,'Need to add table' AS `nextupdate` from (((((((`epic_issue_daily_status_intermediate` `eps` left join `master_issue` `mi` on(((`eps`.`issue_id` = `mi`.`issue_id`) and (`eps`.`project_id` = `mi`.`project_id`)))) left join (select distinct `master_issue`.`issue_key` AS `issue_key`,`master_issue`.`epic_name_text` AS `epic_name_text` from `master_issue` where (`master_issue`.`epic_name` <> '')) `epic_name` on((`mi`.`epic_name` = `epic_name`.`issue_key`))) left join `master_status` `ms` on((`eps`.`status_end_day` = `ms`.`status_id`))) left join (select `master_issue`.`issue_id` AS `issue_id`,cast(`master_issue`.`created` as date) AS `created_date` from `master_issue`) `new_stories` on(((`eps`.`issue_id` = `new_stories`.`issue_id`) and (`eps`.`dt` = `new_stories`.`created_date`)))) left join (select `project_daily_time_estimate`.`issue_id` AS `issue_id`,`project_daily_time_estimate`.`day_count` AS `day_count`,sum(coalesce(`project_daily_time_estimate`.`original_estimate`,0)) AS `original_hours`,sum(coalesce(`project_daily_time_estimate`.`new_estimate`,0)) AS `new_time` from `project_daily_time_estimate` group by `project_daily_time_estimate`.`issue_id`,`project_daily_time_estimate`.`day_count`) `org_time` on(((`eps`.`issue_id` = `org_time`.`issue_id`) and (`eps`.`day_count` = `org_time`.`day_count`)))) left join `master_user_account` `mua` on((`mi`.`assignee_account_id` = `mua`.`account_id`))) left join `master_issue_type` `mit` on((`mi`.`issue_type_id` = `mit`.`issue_type_id`)))) `a` where (`a`.`issue_key` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Requirement_MainTableView_fixversion`
--

/*!50001 DROP VIEW IF EXISTS `Requirement_MainTableView_fixversion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Requirement_MainTableView_fixversion` AS select `eps`.`project_id` AS `project_id`,`mi`.`issue_key` AS `issue_key`,`mi`.`issue_type_id` AS `issue_type_id`,`mit`.`issue_type_name` AS `issue_type_name`,`mi`.`fix_version` AS `fix_version`,`mi`.`summary` AS `summary`,`mi`.`epic_name` AS `epic_name`,(case when (coalesce(`epic_name`.`epic_name_text`,`mi`.`epic_name_text`) = '') then concat(`mi`.`project_id`,'-Unassigned') else coalesce(`epic_name`.`epic_name_text`,`mi`.`epic_name_text`) end) AS `epic_name_text`,`ms`.`status_name` AS `status`,(case when (`eps`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then 'y' else 'n' end) AS `to_do_filter`,(case when (`eps`.`status_end_day` = 10104) then 'y' else 'n' end) AS `blocked_filter`,(case when (`new_stories`.`created_date` is not null) then 'y' else 'n' end) AS `new_stories_filter`,`org_time`.`original_hours` AS `original_hours`,`org_time`.`new_time` AS `new_hours`,(case when (coalesce(`org_time`.`new_time`,0) = 0) then 0 else (`org_time`.`new_time` - `org_time`.`original_hours`) end) AS `change_hours`,`mua`.`display_name` AS `user_name`,`mi`.`priority_name` AS `priority_name`,concat('Day ',`eps`.`day_count`) AS `trackchange`,'Y' AS `New_Filter`,'Need to add table' AS `lastupdate`,'Need to add table' AS `nextupdate` from (((((((`epic_issue_daily_status_intermediate` `eps` left join `master_issue` `mi` on((`eps`.`issue_id` = `mi`.`issue_id`))) left join (select distinct `master_issue`.`issue_key` AS `issue_key`,`master_issue`.`epic_name_text` AS `epic_name_text` from `master_issue` where (`master_issue`.`epic_name` <> '')) `epic_name` on((`mi`.`epic_name` = `epic_name`.`issue_key`))) left join `master_status` `ms` on((`eps`.`status_end_day` = `ms`.`status_id`))) left join (select `master_issue`.`issue_id` AS `issue_id`,cast(`master_issue`.`created` as date) AS `created_date` from `master_issue`) `new_stories` on(((`eps`.`issue_id` = `new_stories`.`issue_id`) and (`eps`.`dt` = `new_stories`.`created_date`)))) left join (select `project_daily_time_estimate`.`issue_id` AS `issue_id`,`project_daily_time_estimate`.`day_count` AS `day_count`,sum(coalesce(`project_daily_time_estimate`.`original_estimate`,0)) AS `original_hours`,sum(coalesce(`project_daily_time_estimate`.`new_estimate`,0)) AS `new_time` from `project_daily_time_estimate` group by `project_daily_time_estimate`.`issue_id`,`project_daily_time_estimate`.`day_count`) `org_time` on(((`eps`.`issue_id` = `org_time`.`issue_id`) and (`eps`.`day_count` = `org_time`.`day_count`)))) left join `master_user_account` `mua` on((`mi`.`assignee_account_id` = `mua`.`account_id`))) left join `master_issue_type` `mit` on((`mi`.`issue_type_id` = `mit`.`issue_type_id`))) where (`eps`.`issue_id` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `build_kpi`
--

/*!50001 DROP VIEW IF EXISTS `build_kpi`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `build_kpi` AS select `a`.`sprint_id` AS `sprint_id`,`a`.`track_change` AS `track_change`,`a`.`change_type` AS `change_type`,`a`.`current_value` AS `kpi_value`,(case when (`b`.`previous_value` < `a`.`current_value`) then 1 when (`b`.`previous_value` > `a`.`current_value`) then -(1) else 0 end) AS `kpi_delta` from ((select `Build_changelog_summary`.`sprint_id` AS `sprint_id`,`Build_changelog_summary`.`track_change` AS `track_change`,`Build_changelog_summary`.`change_type` AS `change_type`,count(distinct `Build_changelog_summary`.`issue_id`) AS `current_value`,concat(substr(`Build_changelog_summary`.`track_change`,5),`Build_changelog_summary`.`change_type`) AS `row_num1` from `Build_changelog_summary` group by `Build_changelog_summary`.`sprint_id`,`Build_changelog_summary`.`track_change`,`Build_changelog_summary`.`change_type` order by `row_num1`) `a` left join (select `Build_changelog_summary`.`sprint_id` AS `sprint_id`,`Build_changelog_summary`.`track_change` AS `track_change`,`Build_changelog_summary`.`change_type` AS `change_type`,count(distinct `Build_changelog_summary`.`issue_id`) AS `previous_value`,concat((substr(`Build_changelog_summary`.`track_change`,5) + 1),`Build_changelog_summary`.`change_type`) AS `row_num2` from `Build_changelog_summary` group by `Build_changelog_summary`.`sprint_id`,`Build_changelog_summary`.`track_change`,`Build_changelog_summary`.`change_type` order by `row_num2`) `b` on(((`a`.`sprint_id` = `b`.`sprint_id`) and (`a`.`row_num1` = `b`.`row_num2`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `changelog_test`
--

/*!50001 DROP VIEW IF EXISTS `changelog_test`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `changelog_test` AS select `tab_3`.`change_id` AS `change_id`,`tab_3`.`issue_id` AS `issue_id`,`tab_3`.`start_date` AS `start_date`,`tab_3`.`initial_status` AS `initial_status`,`tab_3`.`status_rank1` AS `status_rank1`,`tab_3`.`end_date` AS `end_date`,`tab_3`.`final_status` AS `final_status`,`tab_3`.`status_rank2` AS `status_rank2`,`tab_3`.`Day_diff` AS `Day_diff`,(case when (`tab_3`.`initial_status` = 'Open') then `tab_3`.`Day_diff` else 0 end) AS `Open`,(case when (`tab_3`.`initial_status` = 'Requirements') then `tab_3`.`Day_diff` else 0 end) AS `Requirements`,(case when (`tab_3`.`initial_status` = 'To Do') then `tab_3`.`Day_diff` else 0 end) AS `To Do`,(case when (`tab_3`.`initial_status` = 'In Progress') then `tab_3`.`Day_diff` else 0 end) AS `In Progress`,(case when (`tab_3`.`initial_status` = 'Deployed') then `tab_3`.`Day_diff` else 0 end) AS `Deployed`,(case when (`tab_3`.`initial_status` = 'UAT') then `tab_3`.`Day_diff` else 0 end) AS `UAT`,(case when (`tab_3`.`initial_status` = 'SIT Testing') then `tab_3`.`Day_diff` else 0 end) AS `SIT Testing`,(case when (`tab_3`.`initial_status` = 'Dev Complete') then `tab_3`.`Day_diff` else 0 end) AS `Dev Complete`,(case when (`tab_3`.`initial_status` = 'Cancelled') then `tab_3`.`Day_diff` else 0 end) AS `Cancelled`,(case when (`tab_3`.`initial_status` = 'Ready for Release') then `tab_3`.`Day_diff` else 0 end) AS `Ready for Release` from (select `tab_2`.`change_id` AS `change_id`,`tab_2`.`issue_id` AS `issue_id`,`tab_2`.`start_date` AS `start_date`,`tab_2`.`initial_status` AS `initial_status`,`tab_2`.`status_rank1` AS `status_rank1`,`tab_2`.`end_date` AS `end_date`,`tab_2`.`final_status` AS `final_status`,`tab_2`.`status_rank2` AS `status_rank2`,((5 * ((to_days(`tab_2`.`end_date`) - to_days(`tab_2`.`start_date`)) DIV 7)) + substr('0123444401233334012222340111123400012345001234550',(((7 * weekday(`tab_2`.`start_date`)) + weekday(`tab_2`.`end_date`)) + 1),1)) AS `Day_diff` from (select `tab_1`.`change_id` AS `change_id`,`tab_1`.`issue_id` AS `issue_id`,`tab_1`.`start_date` AS `start_date`,`tab_1`.`initial_status` AS `initial_status`,`tab_1`.`status_rank1` AS `status_rank1`,`tab_1`.`end_date` AS `end_date`,`tab_1`.`final_status` AS `final_status`,row_number() OVER (PARTITION BY `tab_1`.`issue_id`,`tab_1`.`initial_status` ORDER BY `tab_1`.`end_date` )  AS `status_rank2` from (select `mcl1`.`change_id` AS `change_id`,`mcl1`.`issue_id` AS `issue_id`,`mcl1`.`change_created` AS `start_date`,`mcl1`.`change_item_to_string` AS `initial_status`,dense_rank() OVER (PARTITION BY `mcl1`.`issue_id` ORDER BY `mcl1`.`change_created` )  AS `status_rank1`,`mcl2`.`change_created` AS `end_date`,`mcl2`.`change_item_to_string` AS `final_status` from (`master_change_log` `mcl1` join `master_change_log` `mcl2` on((`mcl1`.`issue_id` = `mcl2`.`issue_id`))) where ((`mcl1`.`change_created` < `mcl2`.`change_created`) and (`mcl1`.`change_item_field` = 'status') and (`mcl2`.`change_item_field` = 'status') and (`mcl1`.`change_item_to_string` <> 'Open'))) `tab_1`) `tab_2` where (`tab_2`.`status_rank2` = 1) union all select NULL AS `change_id`,`a`.`issue_id` AS `issue_id`,`a`.`created` AS `start_date`,'Open' AS `initial_status`,'0' AS `status_rank1`,`b`.`first_change` AS `end_date`,NULL AS `final_status`,NULL AS `status_rank2`,((5 * ((to_days(`b`.`first_change`) - to_days(`a`.`created`)) DIV 7)) + substr('0123444401233334012222340111123400012345001234550',(((7 * weekday(`a`.`created`)) + weekday(`b`.`first_change`)) + 1),1)) AS `Day_diff` from ((select `mi`.`issue_id` AS `issue_id`,`mi`.`created` AS `created` from `master_issue` `mi`) `a` join (select `mcl`.`issue_id` AS `issue_id`,min(`mcl`.`change_created`) AS `first_change` from `master_change_log` `mcl` where (`mcl`.`change_item_field` = 'status') group by `mcl`.`issue_id`) `b` on((`a`.`issue_id` = `b`.`issue_id`)))) `tab_3` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `due_date_summary`
--

/*!50001 DROP VIEW IF EXISTS `due_date_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `due_date_summary` AS select `st`.`sprint_id` AS `sprint_id`,`st`.`sprint_name` AS `sprint_name`,`st`.`sprint_start_date` AS `sprint_start_date`,`st`.`issue_id` AS `issue_id`,concat('Day ',`st`.`day_count`) AS `trackchange`,coalesce(`st`.`epic_name`,concat(`st`.`project_id`,'-Unassigned')) AS `epic_name`,`st`.`time_estimate` AS `time_estimate`,`st`.`created_v2` AS `created_v2`,`st`.`priority_name` AS `priority_name`,`st`.`sprint_due_date` AS `sprint_due_date`,(case when (now() > `st`.`sprint_due_date`) then (to_days(now()) - to_days(`st`.`sprint_due_date`)) else '-' end) AS `missed_due_date`,`st`.`assignee` AS `assignee`,`st`.`project_id` AS `project_id`,`st`.`project_name` AS `project_name`,`st`.`status_name` AS `status_name` from (select `dsi`.`issue_id` AS `issue_id`,`dsi`.`sprint_name` AS `sprint_name`,`dsi`.`sprint_start_date` AS `sprint_start_date`,`dsi`.`sprint_end_date` AS `sprint_end_date`,`dsi`.`sprint_id` AS `sprint_id`,`dsi`.`day_count` AS `day_count`,`ddm`.`epic_name` AS `epic_name`,`ddm`.`time_estimate` AS `time_estimate`,`dsi`.`status_name` AS `status_name`,`dsi`.`status_end_day` AS `status_end_day`,`ddm`.`created_v2` AS `created_v2`,`ddm`.`priority_name` AS `priority_name`,`ddm`.`sprint_due_date` AS `sprint_due_date`,`ddm`.`assignee` AS `assignee`,`ddm`.`project_id` AS `project_id`,`ddm`.`project_name` AS `project_name` from ((select `dd`.`sprint_id` AS `sprint_id`,`dd`.`sprint_name` AS `sprint_name`,`dd`.`sprint_start_date` AS `sprint_start_date`,`dd`.`sprint_end_date` AS `sprint_end_date`,`dd`.`date` AS `date`,`dd`.`day_count` AS `day_count`,`dd`.`sprint_days` AS `sprint_days`,`dd`.`issue_id` AS `issue_id`,`dd`.`status_end_day` AS `status_end_day`,`dd`.`log_date` AS `log_date`,`dd`.`f_rank` AS `f_rank`,`mst`.`status_id` AS `status_id`,`mst`.`status_name` AS `status_name`,`mst`.`status_untranslated_name` AS `status_untranslated_name` from (`daily_status_intermediate` `dd` left join `master_status` `mst` on((`dd`.`status_end_day` = `mst`.`status_id`)))) `dsi` join `Due_date_master` `ddm` on((`dsi`.`issue_id` = `ddm`.`issue_id`))) where (`dsi`.`status_end_day` not in (10205,10403,11710))) `st` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `due_date_summary_test`
--

/*!50001 DROP VIEW IF EXISTS `due_date_summary_test`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `due_date_summary_test` AS select `d`.`sprint_id` AS `sprint_id`,`d`.`sprint_name` AS `sprint_name`,`d`.`date` AS `date`,concat('Day ',`d`.`day_count`) AS `trackchange`,`d`.`issue_id` AS `issue_id`,`d`.`kpi_title1` AS `kpi_title1`,`ms`.`status_name` AS `status_name` from ((select `a`.`sprint_id` AS `sprint_id`,`a`.`sprint_name` AS `sprint_name`,`a`.`sprint_start_date` AS `sprint_start_date`,`a`.`sprint_end_date` AS `sprint_end_date`,`a`.`date` AS `date`,`a`.`day_count` AS `day_count`,`a`.`sprint_days` AS `sprint_days`,`a`.`issue_id` AS `issue_id`,`a`.`status_end_day` AS `status_end_day`,`a`.`log_date` AS `log_date`,`a`.`f_rank` AS `f_rank`,'Issue Due Today' AS `kpi_title1` from (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`sprint_name` AS `sprint_name`,`ssvbt`.`sprint_start_date` AS `sprint_start_date`,`ssvbt`.`sprint_end_date` AS `sprint_end_date`,`ssvbt`.`date` AS `date`,`ssvbt`.`day_count` AS `day_count`,`ssvbt`.`sprint_days` AS `sprint_days`,`ssvbt`.`issue_id` AS `issue_id`,`ssvbt`.`status_end_day` AS `status_end_day`,`ssvbt`.`log_date` AS `log_date`,`ssvbt`.`f_rank` AS `f_rank` from `daily_status_intermediate` `ssvbt` where (((to_days((case when (weekday(`ssvbt`.`sprint_end_date`) = 5) then (`ssvbt`.`sprint_end_date` + interval -(1) day) when (weekday(`ssvbt`.`sprint_end_date`) = 6) then (`ssvbt`.`sprint_end_date` + interval -(2) day) else `ssvbt`.`sprint_end_date` end)) - to_days(`ssvbt`.`date`)) = 0) and (`ssvbt`.`status_end_day` not in (10205,10403,11710)))) `a` union all select `b`.`sprint_id` AS `sprint_id`,`b`.`sprint_name` AS `sprint_name`,`b`.`sprint_start_date` AS `sprint_start_date`,`b`.`sprint_end_date` AS `sprint_end_date`,`b`.`date` AS `date`,`b`.`day_count` AS `day_count`,`b`.`sprint_days` AS `sprint_days`,`b`.`issue_id` AS `issue_id`,`b`.`status_end_day` AS `status_end_day`,`b`.`log_date` AS `log_date`,`b`.`f_rank` AS `f_rank`,'Issue Due Tomorrow' AS `kpi_title1` from (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`sprint_name` AS `sprint_name`,`ssvbt`.`sprint_start_date` AS `sprint_start_date`,`ssvbt`.`sprint_end_date` AS `sprint_end_date`,`ssvbt`.`date` AS `date`,`ssvbt`.`day_count` AS `day_count`,`ssvbt`.`sprint_days` AS `sprint_days`,`ssvbt`.`issue_id` AS `issue_id`,`ssvbt`.`status_end_day` AS `status_end_day`,`ssvbt`.`log_date` AS `log_date`,`ssvbt`.`f_rank` AS `f_rank` from `daily_status_intermediate` `ssvbt` where (((to_days((case when (weekday(`ssvbt`.`sprint_end_date`) = 5) then (`ssvbt`.`sprint_end_date` + interval -(1) day) when (weekday(`ssvbt`.`sprint_end_date`) = 6) then (`ssvbt`.`sprint_end_date` + interval -(2) day) else `ssvbt`.`sprint_end_date` end)) - to_days(`ssvbt`.`date`)) = 1) and (`ssvbt`.`status_end_day` not in (10205,10403,11710)))) `b` union all select `c`.`sprint_id` AS `sprint_id`,`c`.`sprint_name` AS `sprint_name`,`c`.`sprint_start_date` AS `sprint_start_date`,`c`.`sprint_end_date` AS `sprint_end_date`,`c`.`date` AS `date`,`c`.`day_count` AS `day_count`,`c`.`sprint_days` AS `sprint_days`,`c`.`issue_id` AS `issue_id`,`c`.`status_end_day` AS `status_end_day`,`c`.`log_date` AS `log_date`,`c`.`f_rank` AS `f_rank`,'Issue Past Due' AS `kpi_title1` from (select `ssvbt`.`sprint_id` AS `sprint_id`,`ssvbt`.`sprint_name` AS `sprint_name`,`ssvbt`.`sprint_start_date` AS `sprint_start_date`,`ssvbt`.`sprint_end_date` AS `sprint_end_date`,`ssvbt`.`date` AS `date`,`ssvbt`.`day_count` AS `day_count`,`ssvbt`.`sprint_days` AS `sprint_days`,`ssvbt`.`issue_id` AS `issue_id`,`ssvbt`.`status_end_day` AS `status_end_day`,`ssvbt`.`log_date` AS `log_date`,`ssvbt`.`f_rank` AS `f_rank` from `daily_status_intermediate` `ssvbt` where (((to_days((case when (weekday(`ssvbt`.`sprint_end_date`) = 5) then (`ssvbt`.`sprint_end_date` + interval -(1) day) when (weekday(`ssvbt`.`sprint_end_date`) = 6) then (`ssvbt`.`sprint_end_date` + interval -(2) day) else `ssvbt`.`sprint_end_date` end)) - to_days(`ssvbt`.`date`)) < 0) and (`ssvbt`.`status_end_day` not in (10205,10403,11710)))) `c`) `d` left join `master_status` `ms` on((`d`.`status_end_day` = `ms`.`status_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `master_change_log_v2`
--

/*!50001 DROP VIEW IF EXISTS `master_change_log_v2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `master_change_log_v2` AS select `master_change_log`.`change_id` AS `change_id`,`master_change_log`.`issue_id` AS `issue_id`,`master_change_log`.`change_author_account_id` AS `change_author_account_id`,`master_change_log`.`change_created` AS `change_createdv1`,`master_change_log`.`change_item_key` AS `change_item_key`,`master_change_log`.`change_item_field` AS `change_item_field`,`master_change_log`.`change_item_field_type` AS `change_item_field_type`,`master_change_log`.`change_item_field_id` AS `change_item_field_id`,`master_change_log`.`change_item_from` AS `change_item_from`,`master_change_log`.`change_item_from_string` AS `change_item_from_string`,`master_change_log`.`change_item_to` AS `change_item_to`,`master_change_log`.`change_item_to_string` AS `change_item_to_string`,(case when (weekday(`master_change_log`.`change_created`) = 5) then (`master_change_log`.`change_created` + interval 2 day) when (weekday(`master_change_log`.`change_created`) = 6) then (`master_change_log`.`change_created` + interval 1 day) else `master_change_log`.`change_created` end) AS `change_created` from `master_change_log` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `resource_summary_chart_data`
--

/*!50001 DROP VIEW IF EXISTS `resource_summary_chart_data`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `resource_summary_chart_data` AS select `XX`.`assignee_account_id` AS `assignee_account_id`,`XX`.`sprint_id` AS `sprint_id`,`XX`.`sprint_name` AS `sprint_name`,`XX`.`avail_hours` AS `avail_hours`,`XX`.`assigned_hours` AS `assigned_hours`,`XX`.`perc_change` AS `perc_change`,`XX`.`over_flag` AS `over_flag`,(case when (`XX`.`perc_change` <= 0.1) then 'optimum' when ((`XX`.`perc_change` > 0.1) and (`XX`.`over_flag` = 1)) then 'overload' when ((`XX`.`perc_change` = 100) and (`XX`.`assigned_hours` = 0)) then 'not_part_of_sprint' when ((`XX`.`perc_change` > 0.1) and (`XX`.`over_flag` = 0)) then 'under_uitlized' end) AS `color_code` from (select `XX`.`assignee_account_id` AS `assignee_account_id`,`XX`.`sprint_id` AS `sprint_id`,`XX`.`sprint_name` AS `sprint_name`,sum(coalesce(`XX`.`available_hours`,0)) AS `avail_hours`,sum(coalesce(`XX`.`assigned_hours`,0)) AS `assigned_hours`,abs(coalesce(((sum(coalesce(`XX`.`available_hours`,0)) - sum(coalesce(`XX`.`assigned_hours`,0))) / sum(coalesce(`XX`.`available_hours`,0))),100)) AS `perc_change`,(case when ((sum(coalesce(`XX`.`available_hours`,0)) - sum(coalesce(`XX`.`assigned_hours`,0))) < 0) then 1 else 0 end) AS `over_flag` from (select coalesce(`mr`.`account_id`,`time_comp`.`assignee_account_id`) AS `assignee_account_id`,coalesce(`mr`.`sprint_name`,`time_comp`.`sprint_name`) AS `sprint_name`,`time_comp`.`sprint_id` AS `sprint_id`,`mr`.`avail_hours` AS `available_hours`,`time_comp`.`assigned_hours` AS `assigned_hours` from (`master_resource` `mr` left join (select `mi`.`assignee_account_id` AS `assignee_account_id`,`mi`.`sprint_id` AS `sprint_id`,`ms`.`sprint_name` AS `sprint_name`,sum(`mi`.`time_estimate`) AS `assigned_hours` from (`master_issue` `mi` left join `master_sprint` `ms` on((`mi`.`sprint_id` = `ms`.`sprint_id`))) group by `mi`.`assignee_account_id`,`mi`.`sprint_id`,`ms`.`sprint_name`) `time_comp` on(((`mr`.`account_id` = `time_comp`.`assignee_account_id`) and (`mr`.`sprint_name` = `time_comp`.`sprint_name`)))) union select coalesce(`mr`.`account_id`,`time_comp`.`assignee_account_id`) AS `assignee_account_id`,coalesce(`mr`.`sprint_name`,`time_comp`.`sprint_name`) AS `sprint_name`,`time_comp`.`sprint_id` AS `sprint_id`,`mr`.`avail_hours` AS `available_hours`,`time_comp`.`assigned_hours` AS `assigned_hours` from ((select `mi`.`assignee_account_id` AS `assignee_account_id`,`mi`.`sprint_id` AS `sprint_id`,`ms`.`sprint_name` AS `sprint_name`,sum(`mi`.`time_estimate`) AS `assigned_hours` from (`master_issue` `mi` left join `master_sprint` `ms` on((`mi`.`sprint_id` = `ms`.`sprint_id`))) group by `mi`.`assignee_account_id`,`mi`.`sprint_id`,`ms`.`sprint_name`) `time_comp` left join `master_resource` `mr` on(((`mr`.`account_id` = `time_comp`.`assignee_account_id`) and (`mr`.`sprint_name` = `time_comp`.`sprint_name`))))) `XX` group by `XX`.`assignee_account_id`,`XX`.`sprint_id`,`XX`.`sprint_name`) `XX` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `resource_summary_detail`
--

/*!50001 DROP VIEW IF EXISTS `resource_summary_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `resource_summary_detail` AS select coalesce(`mr`.`account_id`,`time_comp`.`assignee_account_id`) AS `assignee_account_id`,coalesce(`mr`.`sprint_name`,`time_comp`.`sprint_name`) AS `sprint_name`,`time_comp`.`sprint_id` AS `sprint_id`,`mr`.`avail_hours` AS `available_hours`,`time_comp`.`assigned_hours` AS `assigned_hours`,`time_comp`.`issue_count` AS `issue_count` from (`master_resource` `mr` left join (select `mi`.`assignee_account_id` AS `assignee_account_id`,`mi`.`sprint_id` AS `sprint_id`,`ms`.`sprint_name` AS `sprint_name`,count(`mi`.`issue_id`) AS `issue_count`,sum(`mi`.`time_estimate`) AS `assigned_hours` from (`master_issue` `mi` left join `master_sprint` `ms` on((`mi`.`sprint_id` = `ms`.`sprint_id`))) group by `mi`.`assignee_account_id`,`mi`.`sprint_id`,`ms`.`sprint_name`) `time_comp` on(((`mr`.`account_id` = `time_comp`.`assignee_account_id`) and (`mr`.`sprint_name` = `time_comp`.`sprint_name`)))) union select coalesce(`mr`.`account_id`,`time_comp`.`assignee_account_id`) AS `assignee_account_id`,coalesce(`mr`.`sprint_name`,`time_comp`.`sprint_name`) AS `sprint_name`,`time_comp`.`sprint_id` AS `sprint_id`,`mr`.`avail_hours` AS `available_hours`,`time_comp`.`assigned_hours` AS `assigned_hours`,`time_comp`.`issue_count` AS `issue_count` from ((select `mi`.`assignee_account_id` AS `assignee_account_id`,`mi`.`sprint_id` AS `sprint_id`,`ms`.`sprint_name` AS `sprint_name`,count(`mi`.`issue_id`) AS `issue_count`,sum(`mi`.`time_estimate`) AS `assigned_hours` from (`master_issue` `mi` left join `master_sprint` `ms` on((`mi`.`sprint_id` = `ms`.`sprint_id`))) group by `mi`.`assignee_account_id`,`mi`.`sprint_id`,`ms`.`sprint_name`) `time_comp` left join `master_resource` `mr` on(((`mr`.`account_id` = `time_comp`.`assignee_account_id`) and (`mr`.`sprint_name` = `time_comp`.`sprint_name`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `test`
--

/*!50001 DROP VIEW IF EXISTS `test`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`comal_jira`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `test` AS select `ebl`.`project_id` AS `project_id`,concat('Day ',`ebl`.`day_count`) AS `TrackChange`,`stories`.`groomed_stories` AS `To_do_stories`,`stories`.`requirement_complete` AS `Requirement_complete`,`stories`.`total_stories` AS `Remaining_User_Stories`,`org_time`.`original_hours` AS `Original_hours`,`org_time`.`new_time` AS `Estimated_minutes`,`stories`.`total_user_stories` AS `total_user_stories` from ((`epic_base_table` `ebl` left join (select `epic_issue_daily_status_intermediate`.`project_id` AS `project_id`,`epic_issue_daily_status_intermediate`.`day_count` AS `day_count`,count((case when (`epic_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `epic_issue_daily_status_intermediate`.`issue_id` end)) AS `groomed_stories`,count((case when (`epic_issue_daily_status_intermediate`.`status_end_day` = 11707) then `epic_issue_daily_status_intermediate`.`issue_id` end)) AS `requirement_complete`,((count(`epic_issue_daily_status_intermediate`.`issue_id`) - count((case when (`epic_issue_daily_status_intermediate`.`status_end_day` = 11707) then `epic_issue_daily_status_intermediate`.`issue_id` end))) - count(distinct (case when (`epic_issue_daily_status_intermediate`.`status_end_day` in (10000,3,11708,11709,11710,10205,10403)) then `epic_issue_daily_status_intermediate`.`issue_id` end))) AS `total_stories`,count(`epic_issue_daily_status_intermediate`.`issue_id`) AS `total_user_stories` from `epic_issue_daily_status_intermediate` group by `epic_issue_daily_status_intermediate`.`project_id`,`epic_issue_daily_status_intermediate`.`day_count`) `stories` on(((`ebl`.`day_count` = `stories`.`day_count`) and (`ebl`.`project_id` = `stories`.`project_id`)))) left join (select `project_epic_daily_time_estimate`.`project_id` AS `project_id`,`project_epic_daily_time_estimate`.`day_count` AS `day_count`,sum(coalesce((case when (`project_epic_daily_time_estimate`.`new_estimate` <> 0) then `project_epic_daily_time_estimate`.`new_estimate` else `project_epic_daily_time_estimate`.`original_estimate` end),0)) AS `original_hours`,sum(coalesce(`project_epic_daily_time_estimate`.`new_estimate`,0)) AS `new_time` from `project_epic_daily_time_estimate` group by `project_epic_daily_time_estimate`.`project_id`,`project_epic_daily_time_estimate`.`day_count`) `org_time` on(((`ebl`.`day_count` = `org_time`.`day_count`) and (`ebl`.`project_id` = `org_time`.`project_id`)))) where (`stories`.`total_user_stories` <> 0) */;
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

-- Dump completed on 2022-01-06 10:26:17
