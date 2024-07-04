Drop table if exists live_date ;

Create table live_date as (
select
	dt
from
	(
	select
		dt,
		RANK() over(
	order by
		dt desc ) as row_rank
	from
		calendar_table
	where
		dt <= CURDATE()
		and isWeekday = 1
	ORDER by
		dt desc ) X
where
	row_rank = 1 );



Drop TABLE if exists yest_date;

create table yest_date as (
select
	dt
from
	(
	select
		dt,
		RANK() over(
	order by
		dt desc ) as row_rank
	from
		calendar_table
	where
		dt <= CURDATE()
		and isWeekday = 1
	ORDER by
		dt desc ) X
where
	row_rank = 2 );


Drop table if exists `Project_Summary_View`;

/* creating table */
Create TABLE `Project_Summary_View` AS
select
	base_table.project_id,
	mp.project_name,
	base_table.groomed_perc_today,
	base_table.groomed_perc_yesterday,
	base_table.total_stories_today,
	base_table.total_stories_yesterday,
	COALESCE(new_issues.new_issues_today, 0) as new_issues_today,
	COALESCE(new_issues.new_issues_yesterday, 0) as new_issues_yesterday ,
	COALESCE(activities.issues_with_activity_today, 0) as issues_with_activity_today,
	COALESCE(activities.issues_with_activity_yesterday, 0) as issues_with_activity_yesterday,
	COALESCE(activities.total_activities_today, 0) as total_activities_today,
	COALESCE(activities.total_activities_yesterday, 0) as total_activities_yesterday,
	base_table.original_estimate as original_estimate ,
	base_table.new_estimate as new_estimate
from
	(
	select
		project_id,
		COALESCE(Sum(case when dt = (select dt from live_date) then groomed_issues else 0 end ) / NULLIF(Sum(case when dt = (select dt from live_date) then issues else 0 end ), 0), 0) as groomed_perc_today ,
		COALESCE(Sum(case when dt = (select dt from yest_date) then groomed_issues else 0 end ) / NULLIF(Sum(case when dt = (select dt from yest_date) then issues else 0 end ), 0), 0) as groomed_perc_yesterday ,
		Sum(case when dt = (select dt from live_date) then issues else 0 end ) as total_stories_today ,
		Sum(case when dt = (select dt from yest_date) then issues else 0 end ) as total_stories_yesterday,
		count(distinct case when dt = (select dt from live_date) and ( (groomed_issues / NULLIF(issues, 0)) < 0.3 OR COALESCE(new_estimate / Nullif(original_estimate, 0), 0) > 1 ) then epic_name end ) as epics_at_risk_today,
		count(distinct case when dt = (select dt from yest_date) and ( (groomed_issues / NULLIF(issues, 0)) < 0.3 OR COALESCE(new_estimate / Nullif(original_estimate, 0), 0) > 1 ) then epic_name end ) as epics_at_risk_yesterday,
		sum(distinct case when dt = (select dt from live_date) and epic_name LIKE '%%Unassigned%%' then issues else 0 end ) as unassigned_stories_today,
		sum(distinct case when dt = (select dt from yest_date) and epic_name LIKE '%%Unassigned%%' then issues else 0 end ) as unassigned_stories_yesterday,
		sum(case when dt = (select dt from live_date) then original_estimate else 0 end) as original_estimate,
		sum(case when dt = (select dt from live_date) then new_estimate else 0 end ) as new_estimate
	from
		(
		select
			lt.project_id,
			lt.epic_name,
			lt.day_count,
			lt.dt,
			lt.issues,
			lt.groomed_issues,
			rt.original_estimate,
			rt.new_estimate
		from
			(
			select
				pidst.project_id,
				day_count,
				dt,
				case
					when epic_name is null then Concat(pidst.project_id, '-Unassigned')
					else epic_name
				end as epic_name,
				count(distinct pidst.issue_id ) as issues ,
				count(distinct case when status_end_day IN (10000, 3, 11708, 11709, 11710, 10205, 10403) then pidst.issue_id end ) as groomed_issues
			from
				project_issue_daily_status_intermediate pidst
			left join master_issue mi on
				pidst.issue_id = mi.issue_id
			group by
				1,
				2,
				3,
				4 ) lt
		left join (
			select
				pdts.project_id,
				day_count,
				dt,
				case
					when epic_name is null then Concat(pdts.project_id, '-Unassigned')
					else epic_name
				end as epic_name,
				sum(COALESCE(original_estimate, 0)) as original_estimate,
				sum(case when COALESCE(new_estimate, 0) = 0 then 0 else coalesce(new_estimate, 0) - COALESCE(original_estimate, 0) end) as new_estimate
			from
				project_daily_time_estimate pdts
			left join master_issue mi2 on
				pdts.issue_id = mi2.issue_id
			group by
				1,
				2,
				3,
				4) rt on
			lt.project_id = rt.project_id
			and lt.dt = rt.dt
			and lt.epic_name = rt.epic_name ) agg
	group by
		1 ) base_table
left join (
	select
		project_id,
		SUM(case when created_date = (select dt from live_date) then issues else 0 end ) as new_issues_today,
		SUM(case when created_date = (select dt from yest_date) then issues else 0 end ) as new_issues_yesterday
	from
		(
		SELECT
			project_id,
			CAST(created AS date) AS created_date,
			count(DISTINCT issue_id ) AS issues
		FROM
			master_issue
		WHERE
			issue_type_id NOT IN (10000)
			and Cast(created as Date ) IN ((
			select
				dt
			from
				live_date),
			(
			select
				dt
			from
				yest_date))
		GROUP BY
			1 ,
			2 ) X
	group by
		1 ) new_issues on
	base_table.project_id = new_issues.project_id
left join (
	select
		project_id,
		count(distinct case when change_date = (select dt from live_date) then issue_id end ) as issues_with_activity_today,
		count(distinct case when change_date = (select dt from yest_date) then issue_id end ) as issues_with_activity_yesterday,
		SUM(case when change_date = (select dt from live_date) then activities end ) as total_activities_today,
		SUM(case when change_date = (select dt from yest_date) then activities end ) as total_activities_yesterday
	from
		(
		select
			mcl.issue_id,
			mi.project_id,
			cast(change_created as Date ) as change_date,
			count(change_id) as activities
		from
			master_change_log mcl
		left join (
			select
				distinct issue_id,
				project_id
			from
				master_issue) mi on
			mcl.issue_id = mi.issue_id
		where
			cast(change_created as Date ) in ((
			select
				dt
			from
				live_date),
			(
			select
				dt
			from
				yest_date))
			and change_item_field not in ('link', 'feature link')
		group by
			1 ,
			2 ,
			3 ) XX
	group by
		1 ) activities on
	base_table.project_id = activities.project_id
left join master_project mp on
	base_table.project_id = mp.project_id
where
	base_table.project_id in (
	select
		Distinct project_id
	from
		project_issue_daily_status_intermediate pidsi
	where
		project_start_date < (
		select
			dt
		from
			live_date)
		and project_end_date >= (
		select
			dt
		from
			live_date)) ;

