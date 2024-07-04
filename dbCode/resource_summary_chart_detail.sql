Drop View resource_summary_chart_data ;

create View resource_summary_chart_data as (
select
	XX.*,
	case
		when perc_change <= 0.1 then 'optimum'
		when perc_change > 0.1
		and over_flag = 1 then 'overload'
		when perc_change = 100
		and assigned_hours = 0 then 'not_part_of_sprint'
		when perc_change >0.1
		and over_flag = 0 then 'under_uitlized'
	end as color_code
from
	(
	select
		assignee_account_id,
		sprint_id,
		sprint_name,
		sum(COALESCE(available_hours, 0)) as avail_hours,
		sum(COALESCE(assigned_hours, 0)) as assigned_hours,
		abs(COALESCE((sum(COALESCE(available_hours, 0)) - sum(COALESCE(assigned_hours, 0)) )/ sum(COALESCE(available_hours, 0)), 100)) as perc_change ,
		Case
			when sum(COALESCE(available_hours, 0)) - sum(COALESCE(assigned_hours, 0)) < 0 then 1
			else 0
		end as over_flag
	from
		(
		select
			COALESCE(mr.account_id,
			time_comp.assignee_account_id) as assignee_account_id,
			COALESCE(mr.sprint_name,
			time_comp.sprint_name ) as sprint_name ,
			sprint_id,
			mr.avail_hours as available_hours ,
			time_comp.assigned_hours as assigned_hours
		from
			master_resource mr
		left join (
			select
				assignee_account_id ,
				mi.sprint_id ,
				ms.sprint_name ,
				sum(time_original_estimate)/ 3600 as assigned_hours
			from
				master_issue mi
			left join master_sprint ms on
				mi.sprint_id = ms.sprint_id
			group by
				1,
				2,
				3 )time_comp on
			mr.account_id = time_comp.assignee_account_id
			and mr.sprint_name = time_comp.sprint_name
	UNION
		select
			COALESCE(mr.account_id,
			time_comp.assignee_account_id) as assignee_account_id,
			COALESCE(mr.sprint_name,
			time_comp.sprint_name ) as sprint_name ,
			sprint_id,
			mr.avail_hours as available_hours ,
			time_comp.assigned_hours as assigned_hours
		from
			master_resource mr
		Right join (
			select
				assignee_account_id ,
				mi.sprint_id ,
				ms.sprint_name ,
				sum(time_original_estimate)/ 3600 as assigned_hours
			from
				master_issue mi
			left join master_sprint ms on
				mi.sprint_id = ms.sprint_id
			group by
				1,
				2,
				3 )time_comp on
			mr.account_id = time_comp.assignee_account_id
			and mr.sprint_name = time_comp.sprint_name ) XX
	group by
		1,
		2,
		3 ) XX ) ;

/* Now creating a code for table below for the resource summary detail view */
Drop view resource_summary_detail ;

Create view resource_summary_detail as (
select
	COALESCE(mr.account_id,
	time_comp.assignee_account_id) as assignee_account_id,
	COALESCE(mr.sprint_name,
	time_comp.sprint_name ) as sprint_name ,
	sprint_id,
	mr.avail_hours as available_hours ,
	time_comp.assigned_hours as assigned_hours,
	time_comp.issue_count
from
	master_resource mr
left join (
	select
		assignee_account_id ,
		mi.sprint_id ,
		ms.sprint_name ,
		count(issue_id) as issue_count,
		sum(time_original_estimate)/ 3600 as assigned_hours
	from
		master_issue mi
	left join master_sprint ms on
		mi.sprint_id = ms.sprint_id
	group by
		1,
		2,
		3 )time_comp on
	mr.account_id = time_comp.assignee_account_id
	and mr.sprint_name = time_comp.sprint_name
UNION
select
	COALESCE(mr.account_id,
	time_comp.assignee_account_id) as assignee_account_id,
	COALESCE(mr.sprint_name,
	time_comp.sprint_name ) as sprint_name ,
	sprint_id,
	mr.avail_hours as available_hours ,
	time_comp.assigned_hours as assigned_hours,
	time_comp.issue_count
from
	master_resource mr
Right join (
	select
		assignee_account_id ,
		mi.sprint_id ,
		ms.sprint_name ,
		count(issue_id) as issue_count,
		sum(time_original_estimate)/ 3600 as assigned_hours
	from
		master_issue mi
	left join master_sprint ms on
		mi.sprint_id = ms.sprint_id
	group by
		1,
		2,
		3 )time_comp on
	mr.account_id = time_comp.assignee_account_id
	and mr.sprint_name = time_comp.sprint_name ) ;