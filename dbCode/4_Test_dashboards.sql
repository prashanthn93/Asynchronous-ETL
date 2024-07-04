create or replace view 
`testview1` as 
select 
t1.created, 
t1.status,  
t1.priority_name, 
t1.project_name, 
t1.test_type,
count(t1.test_key) as issue_count_actual,
sum(t1.retest) as retest,
null as issue_count_ideal,
null as issue_count_expected from
(SELECT distinct
cast(mt.created as date) as created, 
mt.test_key, 
case when mt.status_in_parent = "TODO" then "In Progress"
when mt.status_in_parent = "EXECUTING" then "In Progress"
else mt.status_in_parent end as status, 
case when mt.test_status = "Retest" then 1
else 0 end as retest,
mt.priority_name,
mp.project_name,
case when mt.labels is null then "Single Vendor"
when locate(",", mt.labels) > 0 and locate("Cross", mt.labels) = 0 then "Multiple Vendors"
when locate("UAT", mt.labels) > 0 and locate(",", mt.labels) = 0 then "UAT"
when (locate("Split", mt.labels) > 0 or locate("split", mt.labels) > 0) and locate(",", mt.labels) = 0 then "Split"
when locate("Cross", mt.labels) > 0 then "Cross Functional" 
else "Single Vendor" end
as test_type 
FROM master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent != "Aborted") t1
group by 1,2,3,4,5

union all
/*calculating ideal close time */
select * from
(select t9.expected_end_date as created, null as `status`, null as priority_name, t9.project_name, null as test_type,
null as issue_count_actual,null as retest, count(t9.expected_end_date) as issue_count_ideal,
null as issue_count_expected  from
(select t8.*, 
cast(case when t8.retest = 0 then DATE_ADD(t8.created, INTERVAL t8.test_close_avg DAY) 
when t8.retest = 1 then DATE_ADD(t8.updated, INTERVAL t8.test_close_avg DAY) end as date) as expected_end_date from
(select 
distinct mp.project_name,
mt.test_key,
mt.created,
mt.updated,
t7.test_close_avg,
case when mt.test_status = "Retest" then 1
else 0 end as retest
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
left join
(select t2.project_name, round(avg(t2.diff_create_update),0) as test_close_avg from
(select 
distinct mt.test_key,
mp.project_name,
5 * (DATEDIFF(mt.updated, mt.created) DIV 7) + MID('0123444401233334012222340111123400012345001234550', 7 * WEEKDAY(mt.created) + WEEKDAY(mt.updated) + 1, 1)
as diff_create_update
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent = 'PASS') t2
group by 1) t7
on mp.project_name = t7.project_name
where mt.status_in_parent in ('TODO', 'EXECUTING')
or mt.test_status = 'Retest') t8) t9
where t9.expected_end_date > cast(now() as date)
group by t9.expected_end_date,t9.project_name) t23
union
(/*calculating actual close time */
select  t22.expected_end_date as created, null as `status`, null as priority_name, t22.project_name, null as test_type,
null as issue_count_actual,null as retest, null as issue_count_ideal,
count(t22.expected_end_date) as issue_count_expected from
(select t21.* from
(select t19.*, t20.failed_issues,
row_number() over(partition by project_name order by created desc) as rank1 from
(select t8.*, 
cast(case when t8.retest = 0 then DATE_ADD(t8.created, INTERVAL t8.test_close_avg*2 DAY) 
when t8.retest = 1 then DATE_ADD(t8.updated, INTERVAL t8.test_close_avg DAY) end as date) as expected_end_date from
(select 
distinct mp.project_name,
mt.test_key,
mt.created,
mt.updated,
t7.test_close_avg,
case when mt.test_status = "Retest" then 1
else 0 end as retest
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
left join
(select t2.project_name, round(avg(t2.diff_create_update),0) as test_close_avg from
(select 
distinct mt.test_key,
mp.project_name,
5 * (DATEDIFF(mt.updated, mt.created) DIV 7) + MID('0123444401233334012222340111123400012345001234550', 7 * WEEKDAY(mt.created) + WEEKDAY(mt.updated) + 1, 1)
as diff_create_update
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent = 'PASS') t2
group by 1) t7
on mp.project_name = t7.project_name
where mt.status_in_parent in ('TODO', 'EXECUTING')
or mt.test_status = 'Retest') t8) t19
left join
(select t17.*, t18.fail_perc, round(t17.total_issue_count*t18.fail_perc) as failed_issues from
(select t16.project_name, count(t16.test_key) as total_issue_count from
(select 
distinct mp.project_name,
mt.test_key,
mt.created,
mt.updated,
case when mt.test_status = "Retest" then 1
else 0 end as retest
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('TODO', 'EXECUTING')
or mt.test_status = 'Retest') t16
group by 1) t17
left join
(select t15.project_name, t15.fail_perc from
(select t13.*, t14.total_tests, t13.status_count/t14.total_tests as fail_perc from
(select distinct mp.project_name, 
mt.status_in_parent,
count(mt.status_in_parent) as status_count
from (select distinct test_id,test_key,status_in_parent,created,updated,test_status,priority_name,reporter_account_id from master_test) mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('PASS', 'FAIL')
group by 1,2) t13
left join
(select distinct mp.project_name,
count(mt.status_in_parent) as total_tests
from (select distinct test_id,test_key,status_in_parent,created,updated,test_status,priority_name,reporter_account_id from master_test) mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('PASS', 'FAIL')
group by 1) t14
on t13.project_name = t14.project_name) t15
where t15.status_in_parent = 'FAIL') t18
on t17.project_name = t18.project_name) t20
on t19.project_name = t20.project_name) t21
where t21.rank1 <= t21.failed_issues) t22
where t22.expected_end_date > cast(now() as date)
group by t22.expected_end_date,t22.project_name);


 
create or replace view testview2 as
select t27.*, pd.`Development Hours` from
(select distinct mt.test_key,
mt.priority_name,
mt.status_in_parent,
mt.created, mt.updated,
mp.project_name,
mua.display_name,
mi.time_estimate,
trim(Substring_index(replace(ms.sprint_name,'Keystone',''),' ',3)) as 'sprint_name',
case when mt.labels is null then "Single Vendor"
when locate(",", mt.labels) > 0 and locate("Cross", mt.labels) = 0 then "Multiple Vendors"
when locate("UAT", mt.labels) > 0 and locate(",", mt.labels) = 0 then "UAT"
when (locate("Split", mt.labels) > 0 or locate("split", mt.labels) > 0) and locate(",", mt.labels) = 0 then "Split"
when locate("Cross", mt.labels) > 0 then "Cross Functional" 
else "Single Vendor" end
as test_type,
case when mt.test_status = "Retest" then 1
else 0 end as retest,
t26.expected_end_date
from master_test mt
left join
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
left join
master_user_account mua
on mt.assignee_account_id = mua.account_id
left join
master_sprint ms
on mi.sprint_id = ms.sprint_id
left join
(select t25.* from
(select t19.*, t20.failed_issues,
row_number() over(partition by project_name order by created desc) as rank1 from
(select t8.*, 
cast(case when t8.retest = 0 then DATE_ADD(t8.created, INTERVAL t8.test_close_avg*2 DAY) 
when t8.retest = 1 then DATE_ADD(t8.updated, INTERVAL t8.test_close_avg DAY) end as date) as expected_end_date from
(select 
distinct mp.project_name,
mt.test_key,
mt.created,
mt.updated,
t7.test_close_avg,
case when mt.test_status = "Retest" then 1
else 0 end as retest
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
left join
(select t2.project_name, round(avg(t2.diff_create_update),0) as test_close_avg from
(select 
distinct mt.test_key,
mp.project_name,
5 * (DATEDIFF(mt.updated, mt.created) DIV 7) + MID('0123444401233334012222340111123400012345001234550', 7 * WEEKDAY(mt.created) + WEEKDAY(mt.updated) + 1, 1)
as diff_create_update
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent = 'PASS') t2
group by 1) t7
on mp.project_name = t7.project_name
where mt.status_in_parent in ('TODO', 'EXECUTING')
or mt.test_status = 'Retest') t8) t19
left join
(select t17.*, t18.fail_perc, round(t17.total_issue_count*t18.fail_perc) as failed_issues from
(select t16.project_name, count(t16.test_key) as total_issue_count from
(select 
distinct mp.project_name,
mt.test_key,
mt.created,
mt.updated,
case when mt.test_status = "Retest" then 1
else 0 end as retest
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('TODO', 'EXECUTING')
or mt.test_status = 'Retest') t16
group by 1) t17
left join
(select t15.project_name, t15.fail_perc from
(select t13.*, t14.total_tests, t13.status_count/t14.total_tests as fail_perc from
(select distinct mp.project_name, 
mt.status_in_parent,
count(mt.status_in_parent) as status_count
from (select distinct test_id,test_key,status_in_parent,created,updated,test_status,priority_name,reporter_account_id from master_test) mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('PASS', 'FAIL')
group by 1,2) t13
left join
(select distinct mp.project_name,
count(mt.status_in_parent) as total_tests
from (select distinct test_id,test_key,status_in_parent,created,updated,test_status,priority_name,reporter_account_id from master_test) mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('PASS', 'FAIL')
group by 1) t14
on t13.project_name = t14.project_name) t15
where t15.status_in_parent = 'FAIL') t18
on t17.project_name = t18.project_name) t20
on t19.project_name = t20.project_name) t25
where t25.rank1 <= t25.failed_issues

union

select t25.* from
(select t19.*, t20.failed_issues,
row_number() over(partition by project_name order by created desc) as rank1 from
(select t8.*, 
cast(case when t8.retest = 0 then DATE_ADD(t8.created, INTERVAL t8.test_close_avg DAY) 
when t8.retest = 1 then DATE_ADD(t8.updated, INTERVAL t8.test_close_avg DAY) end as date) as expected_end_date from
(select 
distinct mp.project_name,
mt.test_key,
mt.created,
mt.updated,
t7.test_close_avg,
case when mt.test_status = "Retest" then 1
else 0 end as retest
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
left join
(select t2.project_name, round(avg(t2.diff_create_update),0) as test_close_avg from
(select 
distinct mt.test_key,
mp.project_name,
5 * (DATEDIFF(mt.updated, mt.created) DIV 7) + MID('0123444401233334012222340111123400012345001234550', 7 * WEEKDAY(mt.created) + WEEKDAY(mt.updated) + 1, 1)
as diff_create_update
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent = 'PASS') t2
group by 1) t7
on mp.project_name = t7.project_name
where mt.status_in_parent in ('TODO', 'EXECUTING')
or mt.test_status = 'Retest') t8) t19
left join
(select t17.*, t18.fail_perc, round(t17.total_issue_count*t18.fail_perc) as failed_issues from
(select t16.project_name, count(t16.test_key) as total_issue_count from
(select 
distinct mp.project_name,
mt.test_key,
mt.created,
mt.updated,
case when mt.test_status = "Retest" then 1
else 0 end as retest
from master_test mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('TODO', 'EXECUTING')
or mt.test_status = 'Retest') t16
group by 1) t17
left join
(select t15.project_name, t15.fail_perc from
(select t13.*, t14.total_tests, t13.status_count/t14.total_tests as fail_perc from
(select distinct mp.project_name, 
mt.status_in_parent,
count(mt.status_in_parent) as status_count
from (select distinct test_id,test_key,status_in_parent,created,updated,test_status,priority_name,reporter_account_id from master_test) mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('PASS', 'FAIL')
group by 1,2) t13
left join
(select distinct mp.project_name,
count(mt.status_in_parent) as total_tests
from (select distinct test_id,test_key,status_in_parent,created,updated,test_status,priority_name,reporter_account_id from master_test) mt
left join 
master_issue mi
on mt.test_key = mi.issue_key
left join
master_project mp
on mi.project_id = mp.project_id
where mt.status_in_parent in ('PASS', 'FAIL')
group by 1) t14
on t13.project_name = t14.project_name) t15
where t15.status_in_parent = 'FAIL') t18
on t17.project_name = t18.project_name) t20
on t19.project_name = t20.project_name) t25
where t25.failed_issues < t25.rank1) t26
on mt.test_key = t26.test_key) t27
left join
planners_data pd
on t27.project_name = pd.Project
and t27.sprint_name = pd.Sprint
and t27.display_name = pd.Resource;