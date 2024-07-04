#!/bin/bash
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/0_calendar_table_creation.sql
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/0_maintenance.sql
echo '0 level done'
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/1_Build_summary_story_view.sql
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/1_Requirement_Card_Data.sql
echo '1 level done'
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/2_Build_Summary_storytrack_storyview.sql
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/2_Requirement_Epic_estimate_and_summary.sql
echo '2 level done'
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/3_Build_Card_Data.sql
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/3_Requirement_Maintableview.sql
echo '3 level done'
mysql -u comal_jira -ppassword -D jira_comal < /home/jirauser/Client/ComAl/jira-backend/dbCode/4_Project_Summary.sql
echo '4 level done'

