/* code begins */ 

DROP TABLE if exists proj_base_table ;

CREATE TABLE proj_base_table AS (
SELECT
	project_id,
	project_start_date,
	project_end_date,
	ct.dt,
	RANK() OVER(PARTITION BY project_id
ORDER BY
	dt ASC) AS day_count
FROM
	(
	SELECT
		project_id,
		CAST(Now() AS date) AS project_end_date,
		min(CAST(created AS date)) AS project_start_date
	FROM
		master_issue mi
		where issue_type_id in (10001)
	GROUP BY
		1,
		2 ) proj
JOIN calendar_table ct ON
	proj.project_start_date <= ct.dt
	AND proj.project_end_date >= ct.dt
WHERE
	isweekday = 1 );

#---------------- Query to create an intermediate table with issue and their daily status, mapped to project ids ----# 

DROP TABLE if exists project_issue_daily_status_intermediate;

CREATE TABLE project_issue_daily_status_intermediate AS (
SELECT
	base_table.*,
	mi.issue_id,
	mi.fix_version, 
	status_end_day_to.change_item_to,
	change_item_from,
	COALESCE(status_end_day_to.change_item_to, status_end_day_from.change_item_from, mi.status_id) as status_end_day
FROM
	proj_base_table base_table
LEFT JOIN (
	SELECT
		*
	FROM
		master_issue
	WHERE
		issue_type_id IN (10001)) mi ON
	base_table.project_id = mi.project_id
	AND base_table.dt >= CAST(mi.created AS date )
left join (
	select
		f.issue_id,
		f.log_date as start_date,
		case when s.log_date is null then DATE_ADD(CURDATE(), INTERVAL 1 day ) else s.log_date end as end_Date , 
		f.change_item_to as change_item_to
	from
		(
		select
			a.*, 
			rank() over(PARTITION BY issue_id
			order BY
				log_date) as rank_date
		from
			(
			select
				issue_id ,
				cast(change_created as date) as log_date ,
				change_item_to,
				change_item_from,
				ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
			order by
				change_created desc) as row_num
			from
				master_change_log
			where
				change_item_field = 'status' )a
		where
			row_num = 1 )f
	left join (
		select
			b.*, 
			rank() over(PARTITION BY issue_id
			order BY
				log_date) as rank_date
		from
			(
			select
				issue_id ,
				cast(change_created as date) as log_date ,
				change_item_to,
				change_item_from,
				ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
			order by
				change_created desc) as row_num
			from
				master_change_log
			where
				change_item_field = 'status')b
		where
			row_num = 1 )s on
		f.issue_id = s.issue_id
		and f.rank_date + 1 = s.rank_date 
) status_end_day_to on
	mi.issue_id = status_end_day_to.issue_id
	and status_end_day_to.start_date <= base_table.dt
	and status_end_day_to.end_date > base_table.dt
LEFT JOIN (
	select
		*		
	from
		(
		select
			issue_id ,
			cast(change_created as date) as log_date ,
			change_item_to,
			change_item_from,
			rank() over(PARTITION BY issue_id
		order BY
			cast(change_created as Date)) as rank_date,
			ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
		order by
			change_created asc) as row_num
		from
			master_change_log
		where
			change_item_field= 'status' )a
	where
		row_num = 1
		and rank_date = 1 ) status_end_day_from on
	mi.issue_id = status_end_day_from.issue_id
	and status_end_day_from.log_date > base_table.dt ) ;


#---- Now creating required tables for time estimate change log -----# 

DROP table if exists time_estimate_change_log ;

Create Table time_estimate_change_log as (
select
	ts.issue_id,
	case
		when ct.dayName = 'Saturday' then Date_ADD(ts.change_date, INTERVAL  2 day )
		when ct.dayName = 'Sunday' then Date_ADD(ts.change_date, INTERVAL  1 day ) 
		else ts.change_date
	end as change_date,
	ts.start_date,
	ts.end_date,
	ts.change_item_from_string,
	ts.change_item_to_string
from
	(
	select
		mi.issue_id,
		cast(created as Date) as change_date,
		cast(created as Date) as start_date,
		case
			when COALESCE(first_change.change_date, CURDATE()) = CURDATE() then cast(curdate()+ interval 1 day as date)
			else first_change.change_date
		end as end_date,
		NULL as change_item_from_string,
		case when first_change.issue_id is not null then first_change.change_item_from_string else mi.time_estimate end as change_item_to_string
		
	from
		master_issue mi
	left  join (
		select
			*
		from
			(
			select
				issue_id,
				cast(change_created as Date) as change_date,
				change_item_from_string ,
				change_item_to_string,
				ROW_NUMBER() OVER(PARTITION By issue_id
			order by
				change_created asc) as row_num
			from
				master_change_log
			where
				change_item_field = 'Original Estimate (h' ) X
		where
			row_num = 1) first_change on
		mi.issue_id = first_change.issue_id
		where mi.issue_type_id in (10001)

	UNION

#---- Now let us get the change log entries - start date and end date for a change of time estimate ----# 
	select
		f.issue_id,
		f.change_date as change_date,
		f.change_date as start_date,
		case
			when COALESCE(s.change_date, CURDATE()) = CURDATE() then cast(curdate()+ interval 1 day as date)
			else s.change_date
		end as end_date,
		f.change_item_from_string as change_item_from_string,
		f.change_item_to_string as change_item_to_string
	from
		(
		select
			X.*, 
			rank() over(PARTITION BY issue_id
			order BY
				change_date) as rank_date
		from
			(
			select
				issue_id,
				cast(change_created as Date) as change_date,
				change_item_from_string ,
				change_item_to_string,
				ROW_NUMBER() OVER(PARTITION By issue_id,
				cast(change_created as Date)
			order by
				change_created desc) as row_num
			from
				master_change_log
			where
				change_item_field = 'Original Estimate (h' ) X
		where
			row_num = 1 ) f
	Left join (
		select
			X.*, 
			rank() over(PARTITION BY issue_id
			order BY
				change_date) as rank_date
		from
			(
			select
				issue_id,
				cast(change_created as Date) as change_date,
				change_item_from_string ,
				change_item_to_string,
				ROW_NUMBER() OVER(PARTITION By issue_id,
				cast(change_created as Date)
			order by
				change_created desc) as row_num
			from
				master_change_log
			where
				change_item_field = 'Original Estimate (h' ) X
		where
			row_num = 1 ) s on
		f.issue_id = s.issue_id
		and f.rank_date + 1 = s.rank_date )ts
left join calendar_table ct on
	ts.change_date = ct.dt 
	) ; 


create index join_index on time_estimate_change_log(issue_id, start_date, end_date) ; 

Drop table if exists project_daily_time_estimate ;

create table project_daily_time_estimate as
select
	pidsi.project_id,
	pidsi.project_start_date,
	pidsi.project_end_date,
	pidsi.dt,
	pidsi.day_count,
	pidsi.issue_id,
	pidsi.fix_version,
	pidsi2.status_end_day as change_date_status,
	tl.change_item_from_string, 
	tl.change_item_to_string,
	case
		when pidsi2.status_end_day IN (1, 11707) then tl.change_item_to_string 
		when pidsi2.status_end_day IN (1, 11707) and tl.change_item_to_string is not NULL then tl.change_item_to_string
		when pidsi2.status_end_day in (10000,3,10205,10206,10403,11708,11709,11710) and tl.change_item_from_string is NULL then tl.change_item_to_string
		when pidsi2.status_end_day  in (10000,3,10205,10206,10403,11708,11709,11710) and tl.change_item_from_string  is not null then tl.change_item_from_string 
	end as original_estimate,
	case
		when pidsi2.status_end_day IN (1, 11707) then 0
		when pidsi2.status_end_day in (10000,3,10205,10206,10403,11708,11709,11710) and tl.change_item_from_string is null then 0 
		when pidsi2.status_end_day in (10000,3,10205,10206,10403,11708,11709,11710) and tl.change_item_from_string is not null then tl.change_item_to_string
	end as new_estimate
from
	project_issue_daily_status_intermediate pidsi
left join time_estimate_change_log tl on
	pidsi.issue_id = tl.issue_id
	and tl.start_date <= pidsi.dt
	and tl.end_date > pidsi.dt
left join project_issue_daily_status_intermediate pidsi2 on
	pidsi2.dt = tl.change_date
	and pidsi2.issue_id = tl.issue_id  ;

#---- change estimate done ---# 


/*--- DROP VIEW `Requirement_CardData`---*/

CREATE or replace VIEW `Requirement_CardData` AS
SELECT
	project_id AS kpi_project_id,
	CONCAT('Day ', day_count) AS TrackerChange ,
	"All" as fix_version, 
	'Completed Days' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Completed Days' AS kpi_title1,
	day_count AS kpi_value1,
	'' AS kpi_title2 ,
	'' kpi_value2,
	'Grey' AS kpi_group,
	1 AS kpi_order,
	'No' AS kpi_click,
	"test" AS kpi_icon
FROM
	proj_base_table
UNION
/*#----- The code is for Groomed User Stories ------ # */
 SELECT
	XX.project_id AS kpi_project_id,
	CONCAT('Day ', XX.day_count) AS TrackerChange ,
	"All" as fix_version, 
	'Groomed User Stories' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Percentage' AS kpi_title1,
	COALESCE(XX.groomed_perc,
	0) AS kpi_value1,
	'Change' AS kpi_title2 ,
	CASE
		WHEN XX.groomed_perc - COALESCE(YY.groomed_perc, 0) = 0 THEN 0
		WHEN XX.groomed_perc - COALESCE(YY.groomed_perc, 0) > 0 THEN 1
		WHEN XX.groomed_perc - COALESCE(YY.groomed_perc, 0) < 0 THEN -1
	END AS kpi_value2,
	'Grey' AS kpi_group,
	2 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
FROM
	(
	SELECT
		project_id, dt, day_count, Round(100 *(count(DISTINCT CASE WHEN status_end_day IN (10000, 3, 11708, 11709, 11710, 10205, 10403) THEN issue_id END ) / count(DISTINCT issue_id)), 2 ) AS groomed_perc
	FROM
		project_issue_daily_status_intermediate
	GROUP BY
		1, 2, 3 ) XX
LEFT JOIN (
	SELECT
		project_id, dt, day_count, Round(100 *(count(DISTINCT CASE WHEN status_end_day IN (10000, 3, 11708, 11709, 11710, 10205, 10403) THEN issue_id END ) / count(DISTINCT issue_id)), 2 ) AS groomed_perc
	FROM
		project_issue_daily_status_intermediate
	GROUP BY
		1, 2, 3 ) YY ON
	XX.project_id = YY.project_id
	AND XX.day_count - 1 = YY.day_count
UNION
#-- Code for Total Stories ----------------- # 
 SELECT
	XX.project_id AS kpi_project_id,
	CONCAT('Day ', XX.day_count) AS TrackerChange ,
	"All" as fix_version, 
	'Total User Stories' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Total' AS kpi_title1,
	COALESCE(XX.total_stories,
	0) AS kpi_value1,
	'Change' AS kpi_title2 ,
	CASE
		WHEN XX.total_stories - COALESCE(YY.total_stories, 0) = 0 THEN 0
		WHEN XX.total_stories - COALESCE(YY.total_stories, 0) > 0 THEN 1
		WHEN XX.total_stories - COALESCE(YY.total_stories, 0) < 0 THEN -1
	END AS kpi_title2,
	'Light Blue' AS kpi_group,
	3 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
FROM
	(
	SELECT
		project_id, dt, day_count, count(DISTINCT issue_id) AS total_stories
	FROM
		project_issue_daily_status_intermediate
	GROUP BY
		1, 2, 3 ) XX
LEFT JOIN (
	SELECT
		project_id, dt, day_count, count(DISTINCT issue_id) AS total_stories
	FROM
		project_issue_daily_status_intermediate
	GROUP BY
		1, 2, 3 ) YY ON
	XX.project_id = YY.project_id
	AND XX.day_count - 1 = YY.day_count
UNION
#-- Code for New User Stories ---------------------------#  
 SELECT
	XX.project_id AS kpi_project_id,
	CONCAT('Day ', XX.day_count) AS TrackerChange ,
	"All" as fix_version, 
	'New User Stories' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Total' AS kpi_title1,
	COALESCE(XX.issues,
	0) AS kpi_value1,
	'Change' AS kpi_title2 ,
	CASE
		WHEN XX.issues - COALESCE(YY.issues, 0) = 0 THEN 0
		WHEN XX.issues - COALESCE(YY.issues, 0) > 0 THEN 1
		WHEN XX.issues - COALESCE(YY.issues, 0) < 0 THEN -1
	END AS kpi_value2,
	'Light Blue' AS kpi_group,
	4 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
FROM
	(
	SELECT
		pbt.*, COALESCE(mi.issues,
		0) AS issues
	FROM
		proj_base_table pbt
	LEFT JOIN (
		SELECT
			project_id, CAST(created AS date) AS created_date, count(DISTINCT issue_id ) AS issues
		FROM
			master_issue
		WHERE
			issue_type_id  IN (10001)
			GROUP BY 1 , 2) mi ON
		pbt.project_id = mi.project_id
		AND pbt.dt = mi.created_date ) XX
LEFT JOIN (
	SELECT
		pbt.*, COALESCE(mi.issues,
		0) AS issues
	FROM
		proj_base_table pbt
	LEFT JOIN (
		SELECT
			project_id, CAST(created AS date) AS created_date, count(DISTINCT issue_id ) AS issues
		FROM
			master_issue
		WHERE
			issue_type_id IN (10001)
			GROUP BY 1 , 2) mi ON
		pbt.project_id = mi.project_id
		AND pbt.dt = mi.created_date ) YY ON
	XX.project_id = YY.project_id
	AND XX.day_count - 1 = YY.day_count
UNION
#-----------------------Code for To-DO stories ------------#
 SELECT
	XX.project_id AS kpi_project_id,
	CONCAT('Day ', XX.day_count) AS TrackerChange ,
	"All" as fix_version, 
	'User Stories To-Do' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Total' AS kpi_title1,
	COALESCE(XX.to_do,
	0) AS kpi_value1,
	'Change' AS kpi_title2 ,
	CASE
		WHEN XX.to_do - COALESCE(YY.to_do, 0) = 0 THEN 0
		WHEN XX.to_do - COALESCE(YY.to_do, 0) > 0 THEN 1
		WHEN XX.to_do - COALESCE(YY.to_do, 0) < 0 THEN -1
	END AS kpi_value2,
	'Light Blue' AS kpi_group,
	5 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
FROM
	(
	SELECT
		project_id, dt, day_count, count(DISTINCT CASE WHEN status_end_day  IN (10000, 3, 11708, 11709, 11710, 10205, 10403) THEN issue_id END ) AS to_do
	FROM
		project_issue_daily_status_intermediate
	GROUP BY
		1, 2, 3 ) XX
LEFT JOIN (
	SELECT
		project_id, dt, day_count, count(DISTINCT CASE WHEN status_end_day  IN (10000, 3, 11708, 11709, 11710, 10205, 10403) THEN issue_id END ) AS to_do
	FROM
		project_issue_daily_status_intermediate
	GROUP BY
		1, 2, 3 ) YY ON
	XX.project_id = YY.project_id
	AND XX.day_count - 1 = YY.day_count
UNION
#--------------------- Code for BLocked user stories ------------------= # 
 SELECT
	XX.project_id AS kpi_project_id,
	CONCAT('Day ', XX.day_count) AS TrackerChange ,
	"All" as fix_version, 
	'Blocked User Stories' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Total' AS kpi_title1,
	COALESCE(XX.blocked,
	0) AS kpi_value1,
	'Change' AS kpi_title2 ,
	CASE
		WHEN XX.blocked - COALESCE(YY.blocked, 0) = 0 THEN 0
		WHEN XX.blocked - COALESCE(YY.blocked, 0) > 0 THEN 1
		WHEN XX.blocked - COALESCE(YY.blocked, 0) < 0 THEN -1
	END AS kpi_value2,
	'Light Blue' AS kpi_group,
	6 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
FROM
	(
	SELECT
		project_id, dt, day_count, count(DISTINCT CASE WHEN status_end_day IN (10104) THEN issue_id END ) AS blocked
	FROM
		project_issue_daily_status_intermediate
	GROUP BY
		1, 2, 3 ) XX
LEFT JOIN (
	SELECT
		project_id, dt, day_count, count(DISTINCT CASE WHEN status_end_day IN (10104) THEN issue_id END ) AS blocked
	FROM
		project_issue_daily_status_intermediate
	GROUP BY
		1, 2, 3 ) YY ON
	XX.project_id = YY.project_id
	AND XX.day_count - 1 = YY.day_count
UNION
#-------------------------- code for Estimate Summary --------------___#
 SELECT
	XX.project_id AS kpi_project_id,
	concat('Day ', day_count) AS TrackerChange ,
	"All" as fix_version, 
	'Estimate Summary' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Estimate' AS kpi_title1,
	COALESCE(XX.original,
	0) AS kpi_value1,
	'Planned' AS kpi_title2 ,
	XX.new_time kpi_value2,
	'Grey' AS kpi_group,
	7 AS kpi_order,
	'No' AS kpi_click,
	"test" AS kpi_icon
	
from 
(
select 
project_id, 
day_count, 
sum(COALESCE(case when new_estimate <> 0 then new_estimate else original_estimate end, 0)) as original, 
sum(COALESCE(new_estimate, 0)) as new_time
from project_daily_time_estimate pdte   
group by 1, 2 
) XX
; 


#------------------------------------------------------ fix version code ---------------------__# 



Drop table if exists fix_version_day_intermediate ;

Create table fix_version_day_intermediate as (
select
	pidsi.project_id as kpi_project_id,
	concat('Day ', day_count) as TrackerChange,
	mi.fix_version
from
	(
	select
		Distinct project_id,
		day_count
	from
		project_issue_daily_status_intermediate) pidsi
left join (
	select
		distinct project_id,
		fix_version
	from
		master_issue
		where issue_type_id in (10001)) mi on
	pidsi.project_id = mi.project_id ) ;



Create index join_condition on
fix_version_day_intermediate(kpi_project_id,
TrackerChange,
fix_version) ;



 

CREATE or replace
VIEW `Requirement_CardData_fixversion` AS
select
	fx.*,
	'Groomed User Stories' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Percentage' AS kpi_title1,
	COALESCE(kpi_value1, 0) as kpi_value1,
	'Change' as kpi_title2,
	COALESCE(kpi_value2, 0) as kpi_value2,
	'Grey' AS kpi_group,
	2 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
from
	fix_version_day_intermediate fx
LEFT JOIN (
	SELECT
		XX.project_id AS kpi_project_id,
		CONCAT('Day ', XX.day_count) AS TrackerChange ,
		XX.fix_version as fix_version ,
		COALESCE(XX.groomed_perc, 0) AS kpi_value1,
		CASE
			WHEN coalesce(XX.groomed_perc, 0) - COALESCE(YY.groomed_perc, 0) = 0 THEN 0
			WHEN coalesce(XX.groomed_perc, 0) - COALESCE(YY.groomed_perc, 0) > 0 THEN 1
			WHEN coalesce(XX.groomed_perc, 0) - COALESCE(YY.groomed_perc, 0) < 0 THEN -1
		END AS kpi_value2
	FROM
		(
		SELECT
			project_id,
			dt,
			day_count,
			fix_version,
			Round(100 *(count(DISTINCT CASE WHEN status_end_day IN (10000, 3, 11708, 11709, 11710, 10205, 10403) THEN issue_id END ) / count(DISTINCT issue_id)), 2 ) AS groomed_perc
		FROM
			project_issue_daily_status_intermediate
		GROUP BY
			1,
			2,
			3,
			4) XX
	INNER JOIN (
		SELECT
			project_id,
			dt,
			day_count,
			fix_version,
			Round(100 *(count(DISTINCT CASE WHEN status_end_day IN (10000, 3, 11708, 11709, 11710, 10205, 10403) THEN issue_id END ) / count(DISTINCT issue_id)), 2 ) AS groomed_perc
		FROM
			project_issue_daily_status_intermediate
		GROUP BY
			1,
			2,
			3,
			4 ) YY ON
		XX.project_id = YY.project_id
		AND XX.day_count - 1 = YY.day_count
		and XX.fix_version = YY.fix_version ) rt on
	fx.kpi_project_id = rt.kpi_project_id
	and fx.TrackerChange = rt.TrackerChange
	and fx.fix_version = rt.fix_version
UNION
select
	fx.*,
	'Total User Stories' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Total' AS kpi_title1,
	COALESCE(kpi_value1, 0) as kpi_value1,
	'Change' as kpi_title2,
	COALESCE(kpi_value2, 0) as kpi_value2,
	'Light Blue' AS kpi_group,
	3 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
from
	fix_version_day_intermediate fx
LEFT JOIN (
	SELECT
		XX.project_id AS kpi_project_id,
		CONCAT('Day ', XX.day_count) AS TrackerChange ,
		XX.fix_version as fix_version ,
		COALESCE(XX.total_stories, 0) AS kpi_value1,
		CASE
			WHEN XX.total_stories - COALESCE(YY.total_stories, 0) = 0 THEN 0
			WHEN XX.total_stories - COALESCE(YY.total_stories, 0) > 0 THEN 1
			WHEN XX.total_stories - COALESCE(YY.total_stories, 0) < 0 THEN -1
		END AS kpi_value2
	FROM
		(
		SELECT
			project_id,
			dt,
			day_count,
			fix_version,
			count(DISTINCT issue_id) AS total_stories
		FROM
			project_issue_daily_status_intermediate
		GROUP BY
			1,
			2,
			3,
			4 ) XX
	inner JOIN (
		SELECT
			project_id,
			dt,
			day_count,
			fix_version,
			count(DISTINCT issue_id) AS total_stories
		FROM
			project_issue_daily_status_intermediate
		GROUP BY
			1,
			2,
			3,
			4) YY ON
		XX.project_id = YY.project_id
		AND XX.day_count - 1 = YY.day_count
		and XX.fix_version = YY.fix_version ) rt on
	fx.kpi_project_id = rt.kpi_project_id
	and fx.TrackerChange = rt.TrackerChange
	and fx.fix_version = rt.fix_version
UNION
select
	fx.*,
	'New User Stories' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Total' AS kpi_title1,
	COALESCE(kpi_value1, 0) as kpi_value1,
	'Change' as kpi_title2,
	COALESCE(kpi_value2, 0) as kpi_value2,
	'Light Blue' AS kpi_group,
	4 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
from
	fix_version_day_intermediate fx
LEFT JOIN (
	SELECT
		XX.project_id AS kpi_project_id,
		CONCAT('Day ', XX.day_count) AS TrackerChange ,
		XX.fix_version as fix_version ,
		COALESCE(XX.issues, 0) AS kpi_value1,
		'Change' AS kpi_title2 ,
		CASE
			WHEN XX.issues - COALESCE(YY.issues, 0) = 0 THEN 0
			WHEN XX.issues - COALESCE(YY.issues, 0) > 0 THEN 1
			WHEN XX.issues - COALESCE(YY.issues, 0) < 0 THEN -1
		END AS kpi_value2
	FROM
		(
		SELECT
			pbt.*,
			mi.fix_version,
			COALESCE(mi.issues, 0) AS issues
		FROM
			proj_base_table pbt
		LEFT JOIN (
			SELECT
				project_id,
				CAST(created AS date) AS created_date,
				fix_version,
				count(DISTINCT issue_id ) AS issues
			FROM
				master_issue
			WHERE
				issue_type_id IN (10001)
			GROUP BY
				1 ,
				2,
				3) mi ON
			pbt.project_id = mi.project_id
			AND pbt.dt = mi.created_date ) XX
	LEFT JOIN (
		SELECT
			pbt.*,
			mi.fix_version,
			COALESCE(mi.issues, 0) AS issues
		FROM
			proj_base_table pbt
		LEFT JOIN (
			SELECT
				project_id,
				CAST(created AS date) AS created_date,
				fix_version,
				count(DISTINCT issue_id ) AS issues
			FROM
				master_issue
			WHERE
				issue_type_id IN (10001)
			GROUP BY
				1 ,
				2,
				3) mi ON
			pbt.project_id = mi.project_id
			AND pbt.dt = mi.created_date ) YY ON
		XX.project_id = YY.project_id
		AND XX.day_count - 1 = YY.day_count
		and XX.fix_version = YY.fix_version ) rt on
	fx.kpi_project_id = rt.kpi_project_id
	and fx.TrackerChange = rt.TrackerChange
	and fx.fix_version = rt.fix_version
UNION
select
	fx.*,
	'User Stories To-Do' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Total' AS kpi_title1,
	COALESCE(kpi_value1, 0) as kpi_value1,
	'Change' as kpi_title2,
	COALESCE(kpi_value2, 0) as kpi_value2,
	'Light Blue' AS kpi_group,
	5 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
from
	fix_version_day_intermediate fx
LEFT JOIN (
	SELECT
		XX.project_id AS kpi_project_id,
		CONCAT('Day ', XX.day_count) AS TrackerChange ,
		XX.fix_version as fix_version ,
		COALESCE(XX.to_do, 0) AS kpi_value1,
		'Change' AS kpi_title2 ,
		CASE
			WHEN XX.to_do - COALESCE(YY.to_do, 0) = 0 THEN 0
			WHEN XX.to_do - COALESCE(YY.to_do, 0) > 0 THEN 1
			WHEN XX.to_do - COALESCE(YY.to_do, 0) < 0 THEN -1
		END AS kpi_value2
	FROM
		(
		SELECT
			project_id,
			dt,
			day_count,
			fix_version,
			count(DISTINCT CASE WHEN status_end_day IN (10000, 3, 11708, 11709, 11710, 10205, 10403) THEN issue_id END ) AS to_do
		FROM
			project_issue_daily_status_intermediate
		GROUP BY
			1,
			2,
			3,
			4 ) XX
	LEFT JOIN (
		SELECT
			project_id,
			dt,
			day_count,
			fix_version,
			count(DISTINCT CASE WHEN status_end_day IN (10000, 3, 11708, 11709, 11710, 10205, 10403) THEN issue_id END ) AS to_do
		FROM
			project_issue_daily_status_intermediate
		GROUP BY
			1,
			2,
			3,
			4 ) YY ON
		XX.project_id = YY.project_id
		AND XX.day_count - 1 = YY.day_count
		and XX.fix_version = YY.fix_version ) rt on
	fx.kpi_project_id = rt.kpi_project_id
	and fx.TrackerChange = rt.TrackerChange
	and fx.fix_version = rt.fix_version
UNION
select
	fx.*,
	'Blocked User Stories' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Total' AS kpi_title1,
	COALESCE(kpi_value1, 0) as kpi_value1,
	'Change' as kpi_title2,
	COALESCE(kpi_value2, 0) as kpi_value2,
	'Light Blue' AS kpi_group,
	6 AS kpi_order,
	'yes' AS kpi_click,
	"test" AS kpi_icon
from
	fix_version_day_intermediate fx
LEFT JOIN (
	SELECT
		XX.project_id AS kpi_project_id,
		CONCAT('Day ', XX.day_count) AS TrackerChange ,
		XX.fix_version as fix_version ,
		COALESCE(XX.blocked, 0) AS kpi_value1,
		'Change' AS kpi_title2 ,
		CASE
			WHEN XX.blocked - COALESCE(YY.blocked, 0) = 0 THEN 0
			WHEN XX.blocked - COALESCE(YY.blocked, 0) > 0 THEN 1
			WHEN XX.blocked - COALESCE(YY.blocked, 0) < 0 THEN -1
		END AS kpi_value2
	FROM
		(
		SELECT
			project_id,
			dt,
			day_count,
			fix_version,
			count(DISTINCT CASE WHEN status_end_day IN (10104) THEN issue_id END ) AS blocked
		FROM
			project_issue_daily_status_intermediate
		GROUP BY
			1,
			2,
			3,
			4 ) XX
	LEFT JOIN (
		SELECT
			project_id,
			dt,
			day_count,
			fix_version,
			count(DISTINCT CASE WHEN status_end_day IN (10104) THEN issue_id END ) AS blocked
		FROM
			project_issue_daily_status_intermediate
		GROUP BY
			1,
			2,
			3,
			4 ) YY ON
		XX.project_id = YY.project_id
		AND XX.day_count - 1 = YY.day_count
		and XX.fix_version = YY.fix_version ) rt on
	fx.kpi_project_id = rt.kpi_project_id
	and fx.TrackerChange = rt.TrackerChange
	and fx.fix_version = rt.fix_version
UNION
 SELECT
	XX.project_id AS kpi_project_id,
	concat('Day ', day_count) AS TrackerChange ,
	fix_version as fix_version, 
	'Estimate Summary' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Estimate' AS kpi_title1,
	COALESCE(XX.original,
	0) AS kpi_value1,
	'Planned' AS kpi_title2 ,
	XX.new_time kpi_value2,
	'Grey' AS kpi_group,
	7 AS kpi_order,
	'No' AS kpi_click,
	"test" AS kpi_icon
	
from 
(
select 
project_id, 
day_count, 
fix_version,
sum(COALESCE(case when new_estimate <> 0 then new_estimate else original_estimate end, 0)) as original,
sum(COALESCE(new_estimate, 0)) as new_time
from project_daily_time_estimate pdte   
group by 1, 2, 3 
) XX;

/* code begins */ 
Drop table if exists epic_base_table ;

create table epic_base_table as (
select
	proj.project_id ,
	proj.epic_name,
	proj1.epic_start_date ,
	proj.epic_end_date,
	ct.dt,
	rank() over(PARTITION BY epic_name, project_id order by dt asc) as day_count
from
	(
	select
		project_id,
		case
			when epic_name is NULL then Concat(project_id, '-Unassigned')
			when epic_name='' then Concat(project_id, '-Unassigned')
			else epic_name
		end as epic_name,
		Cast(Now() as date) as epic_end_date
	from
		master_issue mi
		where issue_type_id in (10001)
	group by
		1,
		2 ) proj
left join (
	select
		project_id,
		min(cast(created as date)) as epic_start_date
	from
		master_issue mi
		where issue_type_id in (10001)
	group by
		1 ) proj1 on
	proj.project_id = proj1.project_id
join calendar_table ct on
	proj1.epic_start_date <= ct.dt
	and proj.epic_end_date >= ct.dt
where
	isweekday = 1 );
#------------------ Query for creating daily status for every issue in an epic -------------# 
 Drop table if exists epic_issue_daily_status_intermediate;

Create table epic_issue_daily_status_intermediate as (
select
	base_table.* ,
	mi.issue_id,
	mi.fix_version, 
	COALESCE(status_end_day_to.change_item_to, status_end_day_from.change_item_from, mi.status_id) as status_end_day
from
	epic_base_table base_table
left join (
	select
		*,
		case
			when epic_name is NULL then Concat(project_id, '-Unassigned')
			when epic_name='' then Concat(project_id, '-Unassigned')
			else epic_name
		end as epic_name_1
	from
		master_issue
	WHERE
		issue_type_id IN (10001) ) mi on
	base_table.epic_name = mi.epic_name_1
	and base_table.dt >= cast(mi.created as date )
left join (
	select
		f.issue_id,
		f.log_date as start_date,
		case when s.log_date is null then DATE_ADD(CURDATE(), INTERVAL 1 day ) else s.log_date end as end_Date , 
		f.change_item_to as change_item_to
	from
		(
		select
			a.*, 
			rank() over(PARTITION BY issue_id
			order BY
				log_date) as rank_date
		from
			(
			select
				issue_id ,
				cast(change_created as date) as log_date ,
				change_item_to,
				change_item_from,
				ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
			order by
				change_created desc) as row_num
			from
				master_change_log
			where
				change_item_field = 'status' )a
		where
			row_num = 1 )f
	left join (
		select
			b.*, 
			rank() over(PARTITION BY issue_id
			order BY
				log_date) as rank_date
		from
			(
			select
				issue_id ,
				cast(change_created as date) as log_date ,
				change_item_to,
				change_item_from,
				ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
			order by
				change_created desc) as row_num
			from
				master_change_log
			where
				change_item_field = 'status')b
		where
			row_num = 1 )s on
		f.issue_id = s.issue_id
		and f.rank_date + 1 = s.rank_date 
) status_end_day_to on
	mi.issue_id = status_end_day_to.issue_id
	and status_end_day_to.start_date <= base_table.dt
	and status_end_day_to.end_date > base_table.dt
LEFT JOIN (
	select
		*
	from
		(
		select
			issue_id ,
			cast(change_created as date) as log_date ,
			change_item_to,
			change_item_from,
			rank() over(PARTITION BY issue_id
		order BY
			cast(change_created as Date)) as rank_date,
			ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
		order by
			change_created asc) as row_num
		from
			master_change_log
		where
			change_item_field =   'status' )a
	where
		row_num = 1
		and rank_date = 1 ) status_end_day_from on
	mi.issue_id = status_end_day_from.issue_id
	and status_end_day_from.log_date >= base_table.dt ) ;

#----- Code for daily time estimate change -----# 

DROP table if exists project_epic_daily_time_estimate ; 
create table project_epic_daily_time_estimate as
select
	pidsi.project_id,
	pidsi.epic_name,
	pidsi.epic_start_date,
	pidsi.epic_end_date,
	pidsi.dt,
	pidsi.day_count,
	pidsi.issue_id,
	pidsi.fix_version,
	pidsi2.status_end_day as change_date_status,
	tl.change_item_from_string, 
	tl.change_item_to_string,
	case
		when pidsi2.status_end_day IN (1, 11707) then tl.change_item_to_string 
		when pidsi2.status_end_day IN (1, 11707) and tl.change_item_to_string is not NULL then tl.change_item_to_string
		when pidsi2.status_end_day in (10000,3,10205,10206,10403,11708,11709,11710) and tl.change_item_from_string is NULL then tl.change_item_to_string
		when pidsi2.status_end_day  in (10000,3,10205,10206,10403,11708,11709,11710) and tl.change_item_from_string  is not null then tl.change_item_from_string 
	end as original_estimate,
	case
		when pidsi2.status_end_day IN (1, 11707) then 0
		when pidsi2.status_end_day in (10000,3,10205,10206,10403,11708,11709,11710) and tl.change_item_from_string is null then 0 
		when pidsi2.status_end_day in (10000,3,10205,10206,10403,11708,11709,11710) and tl.change_item_from_string is not null then tl.change_item_to_string
	end as new_estimate
from
	epic_issue_daily_status_intermediate pidsi
left join time_estimate_change_log tl on
	pidsi.issue_id = tl.issue_id
	and tl.start_date <= pidsi.dt
	and tl.end_date > pidsi.dt
left join epic_issue_daily_status_intermediate pidsi2 on
	pidsi2.dt = tl.change_date
	and pidsi2.issue_id = tl.issue_id 
;

#---------------------------------------- Now creating an ADS for Epic Summary ---------------------------# 
#--- the below block computes the groomed stories and the total stories for a every epic ----# 

CREATE or replace
VIEW `Requirement_EpicSummary` AS
select
	ebl.project_id as 'project_id',
	
	 case
			when ebl.epic_name is NULL then Concat(ebl.project_id, '-Unassigned')
			when ebl.epic_name='' then Concat(ebl.project_id, '-Unassigned')
			else ebl.epic_name end as 'Epic_name',
	
	COALESCE(epic_name.epic_name_text, ebl.epic_name) as 'Epic_name_text',
	CONCAT('Day ', ebl.day_count) as 'TrackChange' ,
	stories.groomed_stories as 'Groomed_Stories',
	stories.total_stories as 'Total_User_Stories',
	org_time.original_hours as 'Original_hours',
	org_time.new_time as 'New_Estimate'
	/*,COALESCE(ehe.estimate_hours, 0) as 'Estimate_hours' */
from
	epic_base_table ebl
LEFT JOIN (
	select
	mi.project_id,
	eid.epic_name,
	day_count,
	count(distinct case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then eid.issue_id end) as groomed_stories,
	count(eid.issue_id) - count(distinct case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then eid.issue_id end) as total_stories,
	count(eid.issue_id) as total_user_stories
	from
	epic_issue_daily_status_intermediate eid
	inner join 
	master_issue  mi
	on eid.issue_id = mi.issue_id
	and eid.project_id = mi.project_id
	where mi.issue_type_id in (10001)
	group by
	1,
	2,
	3 )stories ON
	ebl.epic_name = stories.epic_name
	and ebl.day_count = stories.day_count
    and ebl.project_id = stories.project_id
	#--- the below code block computes the original time estimate i.e the time estimated while creating a task ---# 
	LEFT JOIN (select
	pedts.project_id,
	pedts.epic_name,
	day_count,
	sum(COALESCE(case when new_estimate <> 0 then new_estimate else original_estimate end, 0)) as original_hours,
	sum(COALESCE(new_estimate, 0)) as new_time
	from project_epic_daily_time_estimate pedts
	left join
	master_issue mi
	on pedts.issue_id = mi.issue_id
	and pedts.project_id = mi.project_id
	where mi.issue_type_id in (10001)
	group by 1,2,3
		
)org_time on
	ebl.epic_name = org_time.epic_name
	and ebl.day_count = org_time.day_count
    and ebl.project_id = org_time.project_id
left join (
	SELECT
		DISTINCT issue_key,
		epic_name_text
	from
		master_issue
	where
		epic_name_text <> '' 
		and issue_type_id in (10001)) epic_name on
	ebl.epic_name = epic_name.epic_name_text; /* adding the epic hours from the manually updated table */
#left join epic_hours_estimate ehe on ebl.epic_name = ehe.epic_key ;
	#---------------------------------------- Now creating an ADS for Estimate Summary ---------------------------# 
#--- the below block computes the groomed stories and the total stories for a every epic ----# 

CREATE or replace VIEW `Requirement_EstimateSummary` AS
select
	ebl.project_id as 'project_id',
	CONCAT('Day ', ebl.day_count) as 'TrackChange' ,
	stories.groomed_stories as 'To_do_stories',
	stories.requirement_complete as 'Requirement_complete',
	stories.total_stories as 'Remaining_User_Stories',
	org_time.original_hours as 'Original_hours',
	org_time.new_time as 'Estimated_minutes',
	stories.total_user_stories
from
	epic_base_table ebl
LEFT JOIN (
	select
		eid.project_id, eid.day_count, count(case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then eid.issue_id end) as groomed_stories, 
		count(case when status_end_day in (11707) then eid.issue_id end) as requirement_complete, 
		(count(eid.issue_id) - (count(case when status_end_day in (11707) then eid.issue_id end))-count(distinct case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then eid.issue_id end)) as total_stories,
		 count(eid.issue_id) as total_user_stories
	from
		epic_issue_daily_status_intermediate eid
		inner join
		master_issue  mi
		on eid.issue_id = mi.issue_id
		and eid.project_id = mi.project_id
		where mi.issue_type_id in (10001)

	group by
		1, 2 )stories ON
	ebl.day_count = stories.day_count
	and ebl.project_id = stories.project_id
	#--- the below code block computes the original time estimate i.e the time estimated while creating a task ---# 
LEFT JOIN (
	select
		project_id,
		day_count,
		sum(COALESCE(case when new_estimate <> 0 then new_estimate else original_estimate end, 0)) as original_hours, 
		sum(COALESCE(new_estimate, 0)) as new_time	
		from project_epic_daily_time_estimate  
		group by 1,2
)org_time on
	ebl.day_count = org_time.day_count
	and ebl.project_id = org_time.project_id
where
	stories.total_user_stories <> 0
group by
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8 ;


#------------------------------- Fix version Codes ---------------------------------# 


Drop table if exists epic_fix_version_base ;

Create table epic_fix_version_base as (
select
	ebt.*,
	fix_version
from
	epic_base_table ebt
left join (
	select
		Distinct
		case
			when epic_name is NULL then Concat(project_id, '-Unassigned')
			else epic_name
		end as epic_name ,
		fix_version
	from
		master_issue
		where issue_type_id in (10001)
		) epic_fix on
	ebt.epic_name = epic_fix.epic_name ) ;

Create index join_condition on
epic_fix_version_base(epic_name,
dt,
fix_version) ;

CREATE OR REPLACE VIEW Requirement_EpicSummary_fixversion As
select
	epx.project_id as project_id,
	epx.epic_name as epic_name,
	coalesce(epic_name.epic_name_text, epx.epic_name) AS Epic_name_text,
	concat('Day ', epx.day_count) as TrackChange,
	epx.fix_version as fix_version,
	COALESCE(Groomed_Stories, 0 ) as Groomed_Stories,
	COALESCE(Total_User_Stories, 0) as Total_User_Stories,
	COALESCE(Original_hours, 0) as Original_hours,
	COALESCE(New_Estimate, 0) as New_Estimate
	#,coalesce(ehe.estimate_hours, 0) AS Estimate_hours
from
	epic_fix_version_base epx
left join (
	select
		ebl.project_id AS project_id,
		ebl.epic_name AS Epic_name,
		concat('Day ', ebl.day_count) AS TrackChange,
		stories.fix_version AS fix_version,
		stories.groomed_stories AS Groomed_Stories,
		stories.total_stories AS Total_User_Stories,
		org_time.original_hours AS Original_hours,org_time.new_time AS New_Estimate 
	from
		((((epic_base_table ebl
	left join (
		select
			epic_issue_daily_status_intermediate.project_id AS project_id,
			epic_issue_daily_status_intermediate.epic_name AS epic_name,
			epic_issue_daily_status_intermediate.day_count AS day_count,
			epic_issue_daily_status_intermediate.fix_version AS fix_version,
			count(distinct (case when (epic_issue_daily_status_intermediate.status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403)) then epic_issue_daily_status_intermediate.issue_id end)) AS groomed_stories,
			(count(epic_issue_daily_status_intermediate.issue_id) - count(distinct (case when (epic_issue_daily_status_intermediate.status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403)) then epic_issue_daily_status_intermediate.issue_id end))) AS total_stories,
			count(epic_issue_daily_status_intermediate.issue_id) AS total_user_stories
		from
			epic_issue_daily_status_intermediate
		group by
			epic_issue_daily_status_intermediate.project_id,
			epic_issue_daily_status_intermediate.epic_name,
			epic_issue_daily_status_intermediate.day_count,
			epic_issue_daily_status_intermediate.fix_version) stories on
		(((ebl.epic_name = stories.epic_name)
		and (ebl.day_count = stories.day_count))))
	left join (
	select
		project_id,
		epic_name,
		fix_version,
		day_count,
		sum(COALESCE(case when new_estimate <> 0 then new_estimate else original_estimate end, 0)) as original_hours, 
		sum(COALESCE(new_estimate, 0)) as new_time	
		from project_epic_daily_time_estimate  
		group by 1,2,3,4
		) org_time on
		(((ebl.epic_name = org_time.epic_name)
		and (ebl.day_count = org_time.day_count)
		and (stories.fix_version = org_time.fix_version)))) ) ) )rt on
	epx.epic_name = rt.epic_name
	and epx.fix_version = rt.fix_version
	and concat('Day ', epx.day_count) = rt.TrackChange
left join (
	select
		distinct master_issue.issue_key AS issue_key,
		master_issue.epic_name_text AS epic_name_text
	from
		master_issue
	where
		(master_issue.epic_name <> '')
		and  master_issue.issue_type_id in (10001)) epic_name on
	epx.epic_name = epic_name.issue_key;
#left join epic_hours_estimate ehe on
#	((epx.epic_name = ehe.epic_key))     



/*---------------------------------------- Estimate summary Fix version -----# */

CREATE OR REPLACE VIEW Requirement_EstimateSummary_fixversion As
select
epx.kpi_project_id  as project_id, 
epx.TrackerChange  as TrackChange, 
epx.fix_version as fix_version, 
COALESCE(To_do_stories, 0 ) as To_do_stories, 
COALESCE(Requirement_complete, 0) as Requirement_complete, 
COALESCE(Remaining_User_Stories, 0) as Remaining_User_Stories, 
COALESCE(Original_hours, 0) as Original_hours, 
COALESCE(Estimated_minutes, 0) as Estimated_minutes, 
COALESCE(total_user_stories, 0) as total_user_stories 
from
	fix_version_day_intermediate epx
left join (select
	ebl.project_id as 'project_id',
	CONCAT('Day ', ebl.day_count) as 'TrackChange' ,
	stories.fix_version as fix_version, 
	stories.groomed_stories as 'To_do_stories',
	stories.requirement_complete as 'Requirement_complete',
	stories.total_stories as 'Remaining_User_Stories',
	org_time.original_hours as 'Original_hours',
	org_time.new_time as 'Estimated_minutes',
	stories.total_user_stories
from
	epic_base_table ebl
LEFT JOIN (
	select
		project_id, day_count, fix_version , count(case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then issue_id end) as groomed_stories, 
		count(case when status_end_day in (11707) then issue_id end) as requirement_complete, 
		(count(issue_id) - (count(case when status_end_day in (11707) then issue_id end))-count(distinct case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then issue_id end)) as total_stories,
		 count(issue_id) as total_user_stories
	from
		epic_issue_daily_status_intermediate
	group by
		1, 2, 3 )stories ON
	ebl.day_count = stories.day_count
	and ebl.project_id = stories.project_id
	#--- the below code block computes the original time estimate i.e the time estimated while creating a task ---# 
LEFT JOIN (	
		select
		project_id,
		fix_version,
		day_count,
		sum(COALESCE(case when new_estimate <> 0 then new_estimate else original_estimate end, 0)) as original_hours, 
		sum(COALESCE(new_estimate, 0)) as new_time	
		from project_epic_daily_time_estimate  
		group by 1,2,3 )org_time on
	ebl.day_count = org_time.day_count
	and ebl.project_id = org_time.project_id
	and stories.fix_version = org_time.fix_version
where
	stories.total_user_stories <> 0
group by
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8, 
	9 )rt on
	epx.kpi_project_id = rt.project_id
	and epx.fix_version = rt.fix_version
	and epx.TrackerChange = rt.TrackChange ; 




 
Create or Replace View Requirement_MainTableView as 

select * from
(
select
	eps.project_id AS project_id,
	mi.issue_key AS issue_key,
	mi.issue_type_id AS issue_type_id,
	mit.issue_type_name AS issue_type_name,
	mi.fix_version as fix_version,
	mi.summary AS summary,
	COALESCE( case
			when mi.epic_name is NULL then Concat(mi.project_id, '-Unassigned')
			when mi.epic_name='' then Concat(mi.project_id, '-Unassigned')
			else mi.epic_name end
	,concat(mi.project_id, '-Unassigned')) AS epic_name,
	ms.status_name AS status,
	(case
		when (eps.status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) ) then 'User Stories To-DO'
		else 'n'
	end) AS to_do_filter,
	(case
		when (eps.status_end_day = 10104) then 'Blocked User Stories'
		else 'n'
	end) AS blocked_filter,
	(case
		when (new_stories.created_date is not null) then 'New User Stories'
		else 'n'
	end) AS new_stories_filter,
	org_time.original_hours AS original_hours,
	org_time.new_time AS new_hours,
	case when coalesce(org_time.new_time,0) = 0  then 0 else  (org_time.new_time - org_time.original_hours) end  AS change_hours,
	mua.display_name AS user_name,
	mi.priority_name AS priority_name,
	concat('Day ', eps.day_count) AS trackchange,
	'Y' AS New_Filter,
	'Need to add table' AS lastupdate,
	'Need to add table' AS nextupdate
from
	(((((((epic_issue_daily_status_intermediate eps
left join master_issue mi on
	((eps.issue_id = mi.issue_id
	and eps.project_id = mi.project_id)))
left join (
	select
		distinct master_issue.issue_key AS issue_key,
		master_issue.epic_name_text AS epic_name_text
	from
		master_issue
	where
		(master_issue.epic_name <> '')
		and master_issue.issue_type_id in (10001)) epic_name on
	((mi.epic_name = epic_name.issue_key)))
left join master_status ms on
	((eps.status_end_day = ms.status_id)))
left join (
	select
		master_issue.issue_id AS issue_id,
		cast(master_issue.created as date) AS created_date
	from
		master_issue
		where master_issue.issue_type_id in (10001)) new_stories on
	(((eps.issue_id = new_stories.issue_id)
	and (eps.dt = new_stories.created_date))))
left join (
	select
		issue_id,
		day_count,
		sum(COALESCE(original_estimate, 0)) as original_hours,
		sum(COALESCE(new_estimate, 0)) as new_time
	from
		project_daily_time_estimate
	group by
		1,
		2 ) org_time on
	(((eps.issue_id = org_time.issue_id)
	and (eps.day_count = org_time.day_count))))
left join master_user_account mua on
	((mi.assignee_account_id = mua.account_id)))
left join master_issue_type mit on
	((mi.issue_type_id = mit.issue_type_id)))
) a where a.issue_key is not null ;




Create or Replace View Requirement_MainTableView_fixversion as
 select
	eps.project_id AS project_id,
	mi.issue_key AS issue_key,
	mi.issue_type_id AS issue_type_id,
	mit.issue_type_name AS issue_type_name,
	mi.fix_version as fix_version,
	mi.summary AS summary,
	mi.epic_name AS epic_name,
	(case
		when (coalesce(epic_name.epic_name_text, mi.epic_name_text) = '') then concat(mi.project_id, '-Unassigned')
		else coalesce(epic_name.epic_name_text, mi.epic_name_text)
	end) AS epic_name_text,
	ms.status_name AS status,
	(case
		when (eps.status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) ) then 'y'
		else 'n'
	end) AS to_do_filter,
	(case
		when (eps.status_end_day = 10104) then 'y'
		else 'n'
	end) AS blocked_filter,
	(case
		when (new_stories.created_date is not null) then 'y'
		else 'n'
	end) AS new_stories_filter,
	org_time.original_hours AS original_hours,
	org_time.new_time AS new_hours,
	case when coalesce(org_time.new_time,0) = 0  then 0 else  (org_time.new_time - org_time.original_hours) end  AS change_hours,
	mua.display_name AS user_name,
	mi.priority_name AS priority_name,
	concat('Day ', eps.day_count) AS trackchange,
	'Y' AS New_Filter,
	'Need to add table' AS lastupdate,
	'Need to add table' AS nextupdate
from
	(((((((epic_issue_daily_status_intermediate eps
left join master_issue mi on
	((eps.issue_id = mi.issue_id))
	)
left join (
	select
		distinct master_issue.issue_key AS issue_key,
		master_issue.epic_name_text AS epic_name_text
	from
		master_issue
	where
		(master_issue.epic_name <> '')
		and master_issue.issue_type_id in (10001)) epic_name on
	((mi.epic_name = epic_name.issue_key)))
left join master_status ms on
	((eps.status_end_day = ms.status_id)))
left join (
	select
		master_issue.issue_id AS issue_id,
		cast(master_issue.created as date) AS created_date
	from
		master_issue
		where master_issue.issue_type_id in (10001)) new_stories on
	(((eps.issue_id = new_stories.issue_id)
	and (eps.dt = new_stories.created_date))))
left join (
	select
		issue_id,
		day_count,
		sum(COALESCE(original_estimate, 0)) as original_hours,
		sum(COALESCE(new_estimate, 0)) as new_time
	from
		project_daily_time_estimate
	group by
		1,
		2 
) org_time on
	(((eps.issue_id = org_time.issue_id)
	and (eps.day_count = org_time.day_count))))
left join master_user_account mua on
	((mi.assignee_account_id = mua.account_id)))
left join master_issue_type mit on
	((mi.issue_type_id = mit.issue_type_id)))
where
	(eps.issue_id is not null)
	; 