CREATE DATABASE jira_poc;
USE jira_poc;

SET FOREIGN_KEY_CHECKS=0;

commit;

drop table master_project;
drop table master_user_account;
drop table master_issue_type;
drop table master_board;
drop table master_status;
drop table master_status_category;
drop table master_sprint;
drop table master_issue;
drop table master_change_log;


#project table, gets creatred first
CREATE TABLE `master_project` (
  `project_id` int NOT NULL,
  `project_key` varchar(50) DEFAULT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `project_type_key` varchar(50) DEFAULT NULL,
  `project_to_pick` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `project_id_IDX` (`project_id`)
)

CREATE TABLE `master_board` (
  `board_id` int NOT NULL,
  `board_name` varchar(50) DEFAULT NULL,
  `board_type` varchar(50) DEFAULT NULL,
  `board_project_id` int DEFAULT NULL,
  PRIMARY KEY (`board_id`),
  KEY `board_id_IDX` (`board_id`)
)

CREATE TABLE `master_issue_type` (
  `issue_type_id` int NOT NULL,
  `issue_type_desc` varchar(100) DEFAULT NULL,
  `issue_type_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`issue_type_id`),
  KEY `issue_type_id_IDX` (`issue_type_id`)
)

CREATE TABLE `master_test` (
  `test_id` int NOT NULL,
  `parent_issue_id`  int NOT NULL,
  `unique_test_id` int NOT NULL AUTO_INCREMENT,
  `status_in_parent` varchar(100) DEFAULT NULL,
  `test_key` varchar(20) DEFAULT NULL,
  `assignee_account_id` varchar(100) DEFAULT NULL,
  `created` datetime DEFAULT (CURRENT_DATE),
  `updated` datetime DEFAULT(CURRENT_DATE),
  `status_category_id` int DEFAULT NULL, 
  `test_status` varchar(100) DEFAULT NULL,
  `priority_name` varchar(100) DEFAULT NULL,
  `reporter_account_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`unique_test_id`),
  KEY `project_id_IDX` (`unique_test_id`)
) 

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
  # FOREIGN KEY (board_id) REFERENCES master_board(board_id)
)

CREATE TABLE `master_status` (
  `status_id` int NOT NULL,
  `status_name` varchar(10) DEFAULT NULL,
  `status_untranslated_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`status_id`),
  KEY `status_id_IDX` (`status_id`)
)

CREATE TABLE `master_status_category` (
  `status_category_id` int NOT NULL,
  `status_category_key` varchar(20) DEFAULT NULL,
  `status_category_color_name` varchar(20) DEFAULT NULL,
  `status_category_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`status_category_id`),
  KEY `status_category_id_IDX` (`status_category_id`)
)

CREATE TABLE `master_user_account` (
  `account_id` varchar(100) NOT NULL,
  `account_type` varchar(20) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `active` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  KEY `account_id_IDX` (`account_id`)
)

CREATE TABLE `master_fix_version` (
  `fix_version_id` INT NOT NULL,
  `fix_version_description` varchar(50) DEFAULT NULL,
  `fix_version_name` varchar(20) DEFAULT NULL,
  `fix_version_archived` varchar(20) DEFAULT NULL, 
  `fix_version_released` varchar(20) DEFAULT NULL,
  `project_id` INT DEFAULT NULL,
  PRIMARY KEY (`fix_version_id`),
  KEY `fix_version_id_IDX` (`fix_version_id`)
)


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
  `fix_version` varchar(700) DEFAULT NULL,
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
  
	#FOREIGN KEY (issue_type_id) REFERENCES master_issue_type(issue_type_id),
    #FOREIGN KEY (project_id) REFERENCES master_project(project_id),
    #FOREIGN KEY (sprint_id) REFERENCES master_sprint(sprint_id),
    #FOREIGN KEY (status_id) REFERENCES master_status(status_id),
    #FOREIGN KEY (status_category) REFERENCES master_status_category(status_category_id),

    #FOREIGN KEY (issue_id) REFERENCES master_test(parent_issue_id),
    
    #FOREIGN KEY (assignee_account_id) REFERENCES master_user_account(account_id),
    #FOREIGN KEY (creator_account_id) REFERENCES master_user_account(account_id),
    #FOREIGN KEY (reporter_account_id) REFERENCES master_user_account(account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `master_change_log` (
  `change_unique_id` int NOT NULL AUTO_INCREMENT,
  `change_id` int NOT NULL,
  `issue_id` int DEFAULT NULL,
  `change_author_account_id` varchar(100) DEFAULT NULL,
  `change_created` datetime DEFAULT NULL,
  `change_item_key` int NOT NULL,
  `change_item_field` varchar(400) DEFAULT NULL,
  `change_item_field_type` varchar(20) DEFAULT NULL,
  `change_item_field_id` varchar(20) DEFAULT NULL,
  `change_item_from` varchar(400) DEFAULT NULL,
  `change_item_from_string` varchar(400) DEFAULT NULL,
  `change_item_to` varchar(400) DEFAULT NULL,
  `change_item_to_string` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`change_unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `db_refresh_table` (
  `serial_no` int NOT NULL AUTO_INCREMENT,
  `refresh_type` varchar(50) NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `schdule_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `schdule_date` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `complete_date` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `complete_time` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `refresh_projects`varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`serial_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


