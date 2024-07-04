Drop Table master_resource ;

Create table master_resource ( master_account_id varchar(100), user_name varchar(255), sprint_key varchar(30), available_hours float , last_updated datetime, company varchar(255) ) ;

INSERT
	INTO
	master_resource
values('5ecd44f7aa47a00c1987a330', 'Akhil', 'Pangea Sprint 1', 40, '2020-10-31 09:28:52', 'Pangea');

INSERT
	INTO
	master_resource
values('5ecd44d4c9160f0c1d1f8aec', 'Siddharth', 'Pangea Sprint 1', 20, '2020-10-31 09:28:52', 'Pangea');

select
	sprint_id as kpi_sprint_id,
	'' as TrackerChange,
	'Resource Summary' as kpi_name,
	'Build Dashboard' as kpi_dashboard,
	'Over Capacity' as kpi_title1,
	sum(over_flag) as kpi_value1,
	'' as kpi_title2,
	'' kpi_value,
	'Chart' as kpi_group,
	0 as kpi_order,
	'No' as kpi_click,
	"test" as kpi_icon
from
	(
	select
		assignee_account_id, sprint_id, sprint_name,
		Case
			when sum(COALESCE(available_hours, 0)) - sum(COALESCE(assigned_hours, 0)) < 0 then 1
			else 0
		end as over_flag
	from
		(
		select
			*
		from
			master_resource mr
		left join (
			select
				assignee_account_id , mi.sprint_id , ms.sprint_name , sum(time_original_estimate)/ 3600 as assigned_hours
			from
				master_issue mi
			left join master_sprint ms on
				mi.sprint_id = ms.sprint_id
			group by
				1, 2, 3 )time_comp on
			mr.master_account_id = time_comp.assignee_account_id
			and mr.sprint_key = time_comp.sprint_name
	UNION
		select
			*
		from
			master_resource mr
		Right join (
			select
				assignee_account_id , mi.sprint_id , ms.sprint_name , sum(time_original_estimate)/ 3600 as assigned_hours
			from
				master_issue mi
			left join master_sprint ms on
				mi.sprint_id = ms.sprint_id
			group by
				1, 2, 3 )time_comp on
			mr.master_account_id = time_comp.assignee_account_id
			and mr.sprint_key = time_comp.sprint_name ) XX
	group by
		1, 2, 3 ) Y
group by
	1
UNION /* this is for available capacity */
select
	sprint_id as kpi_sprint_id,
	'' as TrackerChange,
	'Resource Summary' as kpi_name,
	'Build Dashboard' as kpi_dashboard,
	'Available Capacity' as kpi_title1,
	sum(avail_flag) as kpi_value1,
	'' as kpi_title2,
	'' kpi_value,
	'Chart' as kpi_group,
	0 as kpi_order,
	'No' as kpi_click,
	"test" as kpi_icon
from
	(
	select
		assignee_account_id, sprint_id, sprint_name,
		Case
			when sum(COALESCE(available_hours, 0)) - sum(COALESCE(assigned_hours, 0)) >= 0 then 1
			else 0
		end as avail_flag
	from
		(
		select
			*
		from
			master_resource mr
		left join (
			select
				assignee_account_id , mi.sprint_id , ms.sprint_name , sum(time_original_estimate)/ 3600 as assigned_hours
			from
				master_issue mi
			left join master_sprint ms on
				mi.sprint_id = ms.sprint_id
			group by
				1, 2, 3 )time_comp on
			mr.master_account_id = time_comp.assignee_account_id
			and mr.sprint_key = time_comp.sprint_name
	UNION
		select
			*
		from
			master_resource mr
		Right join (
			select
				assignee_account_id , mi.sprint_id , ms.sprint_name , sum(time_original_estimate)/ 3600 as assigned_hours
			from
				master_issue mi
			left join master_sprint ms on
				mi.sprint_id = ms.sprint_id
			group by
				1, 2, 3 )time_comp on
			mr.master_account_id = time_comp.assignee_account_id
			and mr.sprint_key = time_comp.sprint_name ) XX
	group by
		1, 2, 3 ) Y
group by
	1 ;