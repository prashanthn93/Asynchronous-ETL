create or replace view build_compliance_total_stories as
select mi.project_id,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id, sprint_name,
case when (mua.display_name is null or mua.display_name='') then 'Unassigned'  else mua.display_name end as display_name,
count(issue_id) as total_stories from 
master_issue mi
left join master_sprint ms
on mi.sprint_id = ms.sprint_id
left join master_project mp
on mi.project_id = mp.project_id
left join master_user_account mua 
on mua.account_id = mi.assignee_account_id
where issue_type_id in (10001) and status_id not in (1,11707,10000) and sprint_state != 'future'
group by project_id,sprint_id, sprint_name,Project_Name,display_name;

create or replace view build_noncompliance as select distinct mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id,
msp.sprint_name,
'UAT Stories with Incomplete tests' as nc_type , 'Build Phase Non-Compliances' as nc_type2 ,cast(mi.created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
mi.priority_name ,mi.status_id,ms.status_name
from master_issue mi 
left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
left join master_test mt on mt.parent_issue_id=mi.issue_id
left join master_sprint msp on msp.sprint_id=mi.sprint_id
where mt.status_in_parent in ('TODO','EXECUTING','ABORTED') and mi.status_id in (11710) and mi.issue_type_id = 10001 and sprint_state != 'future'

union all

select distinct mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id,
msp.sprint_name,
'Stories with no Linked tests' as nc_type , 'Build Phase Non-Compliances' as nc_type2 ,cast(mi.created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
mi.priority_name ,mi.status_id, ms.status_name
from master_issue mi 
left join master_test mt on mt.parent_issue_id=mi.issue_id
left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
left join master_sprint msp on msp.sprint_id=mi.sprint_id
where mt.test_id is null and mi.status_id in (11709,11710) and mi.issue_type_id = 10001 and sprint_state != 'future'

union all

select distinct mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id,
msp.sprint_name,
'UAT Stories with Failed tests' as nc_type , 'Build Phase Non-Compliances' as nc_type2 ,cast(mi.created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
mi.priority_name ,mi.status_id,ms.status_name
from master_issue mi 
left join master_test mt on mt.parent_issue_id=mi.issue_id
left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
left join master_sprint msp on msp.sprint_id=mi.sprint_id
where mt.status_in_parent in ('FAIL') and mi.status_id in (11710) and mi.issue_type_id = 10001 and sprint_state != 'future'

union all

select t1.issue_id,mi.issue_key,
mi.project_id,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –','')) as Project_Name,
mi.sprint_id,
sprint_name,'Assignee changed more than 2 times' as nc_type,
'Build Phase Non-Compliances' as nc_type2,
cast(mi.created as date ) as created,
'-' as display_name,
priority_name,
mi.status_id,
status_name
 from (select a.issue_id,sprint_name,count(*) no_of_changes from (select distinct issue_id,sprint_id,sprint_name,sprint_end_date,sprint_start_date from 
(select *,if(change_item_from is null and rank1 = 1,'Exclude','Include') first_null_occurance from (select * , rank() over(partition by issue_id,change_item_field order by change_created asc) rank1 from
master_change_log_v2) a) cl
left join master_sprint ms
on ms.sprint_id = cl.change_item_to
where sprint_state !='future'
and first_null_occurance = 'Include'
and change_item_field in ('sprint') 
and change_created < sprint_end_date
and change_created > sprint_start_date) a
left join (select issue_id,change_created,change_item_from_string,change_item_to_string from (select *,if(change_item_from is null and rank1 = 1,'Exclude','Include') first_null_occurance from (select * , rank() over(partition by issue_id,change_item_field order by change_created asc) rank1 from
master_change_log_v2) a) cl
where change_item_field in ('assignee')) b
on a.issue_id = b.issue_id
where change_created < sprint_end_date
and change_created > sprint_start_date
group by a.issue_id,sprint_name) t1
left join master_issue mi 
on mi.issue_id = t1.issue_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_project mp on mp.project_id=mi.project_id
left join master_status ms on ms.status_id=mi.status_id
where no_of_changes > 2 and
issue_type_id in (10001) and mi.status_id not in (1,11707,10000)

union all

select distinct issue_id , issue_key , project_id , Project_Name,sprint_id,sprint_name, 'Requirement Phase Non-Compliances' as nc_type, nc_type2 , created, display_name , 
priority_name ,status_id,status_name
 from (
select mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id,
msp.sprint_name,
'Missing Epic' as nc_type2 ,cast(mi.created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
mi.priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
left join master_test mt on mt.parent_issue_id=mi.issue_id
left join master_sprint msp on msp.sprint_id=mi.sprint_id
where mi.issue_type_id in (10001) and mi.epic_name is null and mi.status_id in (1,11707,10000) and sprint_state != 'future'

union all

select distinct mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id,
msp.sprint_name,
'Missing Fix Version' as nc_type2 , cast(mi.created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  ,
 mi.priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
left join master_test mt on mt.parent_issue_id=mi.issue_id
left join master_sprint msp on msp.sprint_id=mi.sprint_id
where mi.issue_type_id in (10001) and (mi.fix_version is null or mi.fix_version =0) and mi.status_id in (1,11707,10000) and sprint_state != 'future'

union all

select distinct mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id,
msp.sprint_name,
'Missing time estimate' as nc_type2 , cast(mi.created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
 mi.priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
left join master_test mt on mt.parent_issue_id=mi.issue_id
left join master_sprint msp on msp.sprint_id=mi.sprint_id
where mi.issue_type_id in (10001) and (mi.time_estimate is null  ) and mi.status_id in (1,11707,10000) and sprint_state != 'future'

union all

select distinct mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id,
msp.sprint_name,
'Missing Assignee' as nc_type2 , cast(mi.created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name , 
 mi.priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
left join master_test mt on mt.parent_issue_id=mi.issue_id
left join master_sprint msp on msp.sprint_id=mi.sprint_id
where mi.issue_type_id in (10001) and (mi.assignee_account_id is null or mi.assignee_account_id='' ) and mi.status_id in (1,11707,10000) and sprint_state != 'future'

union all 

select distinct mi.issue_id , mi.issue_key , mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id,
msp.sprint_name,
'Zero time estimate' as nc_type2 , cast(mi.created as date ) as created, case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  , 
 mi.priority_name ,mi.status_id
, ms.status_name
 from master_issue mi  left join master_project mp on mp.project_id=mi.project_id
left join master_user_account mua on mua.account_id=mi.assignee_account_id
left join master_status ms on ms.status_id=mi.status_id
left join master_test mt on mt.parent_issue_id=mi.issue_id
left join master_sprint msp on msp.sprint_id=mi.sprint_id
where mi.issue_type_id in (10001) and (mi.time_estimate = 0 or mi.time_estimate='' ) and mi.status_id in (1,11707,10000) and sprint_state != 'future') t1