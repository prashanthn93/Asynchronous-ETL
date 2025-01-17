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
  `fix_version` INT DEFAULT NULL,
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
  `priority_name` varchar(10) DEFAULT NULL,
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
) 