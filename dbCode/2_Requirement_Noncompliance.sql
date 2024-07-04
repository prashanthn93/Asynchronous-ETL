drop view if exists requirement_compliance_total_stories;
create view requirement_compliance_total_stories as 
select project_id , count(issue_id) as total_stories from master_issue where issue_type_id in (10001) and status_id in (1,11707,10000) group by project_id;

drop view if exists requirement_compliance_total_stories_assignee;
create view requirement_compliance_total_stories_assignee as 
select case when mua.display_name is null then 'Unassigned' else mua.display_name end as display_name , mi.project_id , count(issue_id) as total_stories from master_issue mi
left join master_user_account mua on mua.account_id=mi.assignee_account_id
where issue_type_id in (10001) and status_id in (1,11707,10000) group by mua.display_name,project_id;

drop view if exists requirement_noncompliance;
create view requirement_noncompliance as select mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
 'Missing Epic' as nc_type , cast(created as date) as created , case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
 priority_name ,mi.status_id
, ms.status_name 
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
where mi.issue_type_id in (10001) and mi.epic_name is null and mi.status_id in (1,11707,10000)

union all

select mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
 'Missing Fix Version' as nc_type , cast(created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  ,
 priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
where mi.issue_type_id in (10001) and (mi.fix_version is null or mi.fix_version =0) and mi.status_id in (1,11707,10000)

union all

select mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
 'Missing time estimate' as nc_type , cast(created as date ) as created,  case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
 priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
where mi.issue_type_id in (10001) and (mi.time_estimate is null  ) and mi.status_id in (1,11707,10000)

union all

select mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
 'Missing Assignee' as nc_type , cast(created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name , 
 priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
where mi.issue_type_id in (10001) and (mi.assignee_account_id is null or mi.assignee_account_id='' ) and mi.status_id in (1,11707,10000)

union all 

select mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
 'Zero time estimate' as nc_type , cast(created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
 priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
where mi.issue_type_id in (10001) and (mi.time_estimate = 0 or mi.time_estimate='' ) and mi.status_id in (1,11707,10000) ;
