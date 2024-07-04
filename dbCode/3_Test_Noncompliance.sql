create or replace view test_compliance_total_stories as
select mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id, sprint_name,
count(distinct issue_id) as total_stories  
from 
master_issue mi
left join master_sprint ms
on mi.sprint_id = ms.sprint_id
left join master_project mp
on mi.project_id = mp.project_id
where issue_type_id in (10001)
and status_id != 10206 and sprint_state != 'future'
group by project_id,sprint_id, sprint_name,Project_Name;


create or replace view test_compliance_total_bugs as 
select mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id, sprint_name
, count(issue_id) as total_bugs  from 
master_issue mi
left join master_sprint ms
on mi.sprint_id = ms.sprint_id
left join master_project mp
on mi.project_id = mp.project_id
where issue_type_id in (10004)
and status_id != 10206 and sprint_state != 'future'
group by project_id,sprint_id,project_name,sprint_name;


create or replace view test_compliance_total_tests as
select mi.project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
mi.sprint_id, sprint_name,
count(issue_id) as total_tests from 
master_issue mi
left join master_sprint ms
on mi.sprint_id = ms.sprint_id
left join master_project mp
on mi.project_id = mp.project_id
where issue_type_id in (10105)
and status_id != 10206 and sprint_state != 'future'
group by project_id,sprint_id;


create or replace view test_noncompliance as
/*bugs which didn't have a priority change before moving to To Do*/
select
mi.issue_id,
mi.issue_key,
mi.project_id,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
'Bug Priority unchanged before To Do' as nc_type,
cast(mi.created as date) as created,
case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  ,
mi.priority_name,
mi.status_id,
ms.status_name,
mi.sprint_id,
sprint_name
from master_issue mi
left join master_project mp
on mi.project_id = mp.project_id
left join master_user_account mua
on mi.assignee_account_id = mua.account_id
left join master_status ms 
on ms.status_id = mi.status_id
left join master_sprint msp
on mi.sprint_id = msp.sprint_id
where mi.issue_type_id = 10004
and mi.status_id = 10000
and sprint_state != 'future'
and mi.issue_id not in (select distinct issue_id from master_change_log
where change_item_field = 'priority')
union all
/*priority missing for test cases*/
select
distinct
mi.issue_id,
mi.issue_key,
mi.project_id,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
'Test case without priority' as nc_type,
cast(mi.created as date ) as created,
case when (mi.assignee_account_id is null or mi.assignee_account_id='' ) then 'Unassigned' else mua.display_name end as display_name  ,
mi.priority_name,
mi.status_id,
ms.status_name,
mi.sprint_id,
sprint_name from master_issue mi
left join master_project mp
on mi.project_id = mp.project_id
left join master_user_account mua
on mi.assignee_account_id = mua.account_id
left join master_status ms on ms.status_id = mi.status_id
left join master_sprint msp
on mi.sprint_id = msp.sprint_id
where mi.priority_name is null
or mi.priority_name = ''
and sprint_state != 'future'
union all
/*bugs which are not deployed after UAT Release*/
select issue_id , issue_key , project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
'Bugs not deployed after UAT Release' as nc_type,
cast(created as date ) as created, case when (assignee_account_id is null or assignee_account_id='' ) then 'Unassigned' else display_name end as display_name  , 
 priority_name ,status_id
, status_name,
sprint_id,
sprint_name
from (select t1.*, project_name, display_name, status_name, mfv1.fix_version_name fix_version_name_1, mfv2.fix_version_name fix_version_name_2, mfv3.fix_version_name fix_version_name_3 from
(SELECT issue_id, created, priority_name, mi.sprint_id, sprint_name, project_id, assignee_account_id, status_id, issue_key, fix_version, char_length(fix_version) as fv_len,
SUBSTRING_INDEX(mi.fix_version, ',', 1) as fix_version1,
SUBSTRING_INDEX((SUBSTRING_INDEX(mi.fix_version, ',', 2)),',',-1) as fix_version2,
SUBSTRING_INDEX(mi.fix_version, ',', -1) as fix_version3
FROM master_issue mi
left join master_sprint msp
on mi.sprint_id = msp.sprint_id
where mi.issue_type_id = 10004 and mi.status_id != 10206
and sprint_state != 'future') t1
left join master_fix_version mfv1
on t1.fix_version1 = mfv1.fix_version_id
left join master_fix_version mfv2
on t1.fix_version2 = mfv2.fix_version_id
left join master_fix_version mfv3
on t1.fix_version3 = mfv3.fix_version_id
left join master_project mp on mp.project_id=t1.project_id
left join master_user_account mua on mua.account_id=t1.assignee_account_id
left join master_status ms on ms.status_id=t1.status_id) t2
where fix_version_name_3 like '%UAT%' and status_name != 'Deployed'
union all
/*Stories which are not in UAT after UAT Release*/
select issue_id , issue_key , project_id ,
trim(Replace(Replace (Replace (Replace (REPLACE(project_name, ('- Keystone'), ''),'Keystone' , ''), '-', ''), 'Financial Force – ', 'Financial Force'),' –',''))
as Project_Name,
'Stories not in UAT after UAT Release' as nc_type, 
cast(created as date ) as created, case when (assignee_account_id is null or assignee_account_id='' ) then 'Unassigned' else display_name end as display_name  , 
 priority_name ,status_id
, status_name,
sprint_id,
sprint_name
from (select t1.*, project_name, display_name, status_name, mfv1.fix_version_name fix_version_name_1, mfv2.fix_version_name fix_version_name_2, mfv3.fix_version_name fix_version_name_3 from
(SELECT issue_id, created, priority_name, mi.sprint_id,sprint_name, project_id , assignee_account_id, status_id, issue_key, fix_version, char_length(fix_version) as fv_len,
SUBSTRING_INDEX(mi.fix_version, ',', 1) as fix_version1,
SUBSTRING_INDEX((SUBSTRING_INDEX(mi.fix_version, ',', 2)),',',-1) as fix_version2,
SUBSTRING_INDEX(mi.fix_version, ',', -1) as fix_version3
FROM master_issue mi
left join master_sprint msp
on mi.sprint_id = msp.sprint_id
where mi.issue_type_id = 10001 and mi.status_id != 10206
and sprint_state != 'future') t1
left join master_fix_version mfv1
on t1.fix_version1 = mfv1.fix_version_id
left join master_fix_version mfv2
on t1.fix_version2 = mfv2.fix_version_id
left join master_fix_version mfv3
on t1.fix_version3 = mfv3.fix_version_id
left join master_project mp on mp.project_id=t1.project_id
left join master_user_account mua on mua.account_id=t1.assignee_account_id
left join master_status ms on ms.status_id=t1.status_id) t2
where fix_version_name_3 like '%UAT%' and status_name != 'UAT'
