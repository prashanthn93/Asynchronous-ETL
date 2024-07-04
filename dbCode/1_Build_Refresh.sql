 /* TO adjust weekends in changelog to nearest monday */

create or replace view master_change_log_v2 as
select  mcl.change_id , mcl.issue_id ,mcl.change_author_account_id ,mcl.change_created as change_createdv1 ,mcl.change_item_key ,mcl.change_item_field,mcl.change_item_field_type,
mcl.change_item_field_id, mcl.change_item_from , mcl.change_item_from_string,mcl.change_item_to , mcl.change_item_to_string ,
case when weekday(change_created) = 5 then DATE_ADD(change_created, INTERVAL 2 DAY)
				when weekday(change_created) = 6 then DATE_ADD(change_created, INTERVAL 1 DAY)
				else change_created end as change_created from master_change_log mcl
				inner join master_issue mi on mcl.issue_id=mi.issue_id and mi.issue_type_id in (10001);






Create or replace view `Due_date_master` as
select 
mi.issue_id,
mi.issue_key,
mi.issue_type_id,
mi.project_id,
mi.sprint_id,
mi.status_id,
mi.status_category,
mi.epic_name,
mi.story_point,
mi.assignee_account_id,
mi.creator_account_id,
mi.reporter_account_id,
mi.fix_version,
mi.time_estimate,
mi.time_original_estimate,
mi.aggregate_time_estimate,
mi.aggregate_time_original_estimate,
mi.time_spent,
mi.work_ratio,
mi.created as created_v2,
case when weekday(mi.created) = 5 then DATE_ADD(mi.created, INTERVAL 2 DAY)
when weekday(mi.created) = 6 then DATE_ADD(mi.created, INTERVAL 1 DAY)
else mi.created end as created,
mi.updated,
mi.status_category_change_date,
mi.start_date,
mi.change_start_date,
mi.change_completion_date,
mi.priority_name,
mi.epic_name_text,
COALESCE(mi.due_date , case when weekday(msp.sprint_end_date) = 5 then DATE_ADD(msp.sprint_end_date, INTERVAL -1 DAY)
						when weekday(msp.sprint_end_date) = 6 then DATE_ADD(msp.sprint_end_date, INTERVAL -2 DAY) 
						else msp.sprint_end_date end) as due_date
from master_issue mi 
left join master_sprint msp
on mi.sprint_id = msp.sprint_id 
left join master_project mp
on mi.project_id=mp.project_id
left join master_status msa
on mi.status_id = msa.status_id
left join master_user_account mua
on mi.assignee_account_id=mua.account_id
left join master_sprint ms
on mi.sprint_id=ms.sprint_id
WHERE mi.issue_type_id IN (10001);


/* code Begins */


 drop table if exists summary_story_view_base_table;

create table summary_story_view_base_table as (
select
	ms.sprint_id,
	ms.sprint_name,
	cast(sprint_start_date as date) as sprint_start_date,
	cast(sprint_end_date as date) as sprint_end_date,
	ct.dt as date,
	rank() over(PARTITION BY sprint_id
order by
	ct.dt asc) as day_count,
	sum(1) over(PARTITION BY sprint_id) as sprint_days
from
	master_sprint ms
join calendar_table ct on
	cast(ms.sprint_start_date as date) <= ct.dt
	and cast(ms.sprint_end_date as date) >= ct.dt
where
	sprint_state in ('active', 'closed')
	and ct.isWeekday = 1 );

/* table to get the sprint associated with issue on a daily basis for further calculation 8*/
Drop Table if exists issue_sprint_data ;

Create Table issue_sprint_data as (
select
	issue_data.issue_id as issue_id,
	issue_data.sprint_id as original_sprint_id,
	ct.dt ,
	issue_created as issue_start_date,
	issue_data.end_date as issue_end_date,
	COALESCE(status_end_day_to.change_item_to, status_end_day_from.change_item_from,
	case when issue_data.issue_id not in (select distinct issue_id from master_change_log_v2 where change_item_field='Sprint' ) then issue_data.sprint_id end) as current_sprint_id
from
	calendar_table ct
right join (
	SELECT
		issue_id,
		sprint_id,
		cast(created as date ) as issue_created,
		CURDATE() as end_date,
		status_id
	from
		Due_date_master ) issue_data on
	ct.dt >= issue_data.issue_created
	and ct.dt <= issue_data.end_Date
left join (
	select
		f.issue_id,
		f.log_date as start_date,
		COALESCE(s.log_date, CURDATE()) as end_date,
		case when LENGTH(f.change_item_to) - LENGTH(REPLACE(f.change_item_to, ',', '')) + 1 = 1 then f.change_item_to 
else Cast(Substring_index(f.change_item_to, ',', 1) as UNSIGNED) end as change_item_to
	from
		(
		select
			*
		from
			(
			select
				issue_id ,
				cast(change_created as date) as log_date ,
				change_item_to,
				change_item_from,
				dense_rank() over(PARTITION BY issue_id
			order BY
				cast(change_created as Date)) as rank_date,
				ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
			order by
				change_created desc) as row_num
			from
				master_change_log_v2
			where
				change_item_field = 'sprint' ) a
		where
			row_num = 1 )f
	left join (
		select
			*
		from
			(
			select
				issue_id ,
				cast(change_created as date) as log_date ,
				change_item_to,
				change_item_from,
				dense_rank() over(PARTITION BY issue_id
			order BY
				cast(change_created as Date)) as rank_date,
				ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
			order by
				change_created desc) as row_num
			from
				master_change_log_v2
			where
				change_item_field = 'sprint')a
		where
			row_num = 1 )s on
		f.issue_id = s.issue_id
		and f.rank_date + 1 = s.rank_date ) status_end_day_to on
	status_end_day_to.issue_id = issue_data.issue_id
	and status_end_day_to.start_date <= ct.dt
	and status_end_day_to.end_date >= ct.dt 
left JOIN (
	select
		*
	from
		(
		select
			issue_id ,
			cast(change_created as date) as log_date ,
			change_item_from,
			dense_rank() over(PARTITION BY issue_id
		order BY
			cast(change_created as Date)) as rank_date,
			ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
		order by
			change_created desc) as row_num
		from
			master_change_log_v2
		where
			change_item_field = 'sprint' ) X
	where
		rank_date = 1
		and row_num = 1 ) status_end_day_from on
	status_end_day_from.issue_id = issue_data.issue_id
	and status_end_day_from.log_date >= ct.dt ) ;


Drop Table if exists daily_status_intermediate;

Create table daily_status_intermediate as (
select * from
	(select
	ssv.*,
	isd.issue_id as issue_id,
	COALESCE(status_end_day_to.change_item_to, status_end_day_from.change_item_from, mi.status_id) as status_end_day,
	status_end_day_from.log_date, row_number() over(partition by ssv.sprint_id, ssv.sprint_start_date, ssv.sprint_end_date,
	ssv.date, ssv.day_count, ssv.sprint_days, isd.issue_id order by datediff(status_end_day_from.log_date, ssv.date) asc) as f_rank
	from
	summary_story_view_base_table ssv
	left join issue_sprint_data isd on
	ssv.sprint_id = isd.current_sprint_id
	and ssv.`date` = isd.dt
	left join (
			select
			f.issue_id,
			f.log_date as start_date,
			COALESCE(s.log_date, CURDATE()) as end_date,
			f.change_item_to as change_item_to
			from
			(
			select
			a.issue_id, a.log_date, a.change_item_to, a.change_item_from, a.row_num, rank() over (partition by a.issue_id
			order by a.log_date) as rank_date
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
			change_created desc) as row_num
			from
			master_change_log_v2
			where
			change_item_field = 'status' )a
			where
			row_num = 1 )f
			left join (
			select
			b.issue_id, b.log_date, b.change_item_to, b.change_item_from, b.row_num, rank() over (partition by b.issue_id
			order by b.log_date) as rank_date
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
			change_created desc) as row_num
			from
			master_change_log_v2
			where
			change_item_field = 'status')b
			where
			row_num = 1 )s on
			f.issue_id = s.issue_id
			and f.rank_date + 1 = s.rank_date ) status_end_day_to on
	isd.issue_id = status_end_day_to.issue_id
	and status_end_day_to.start_date <= ssv.`date`
	and status_end_day_to.end_date > ssv.`date`
	LEFT JOIN (
	select
	a.issue_id, a.log_date, a.change_item_to, a.change_item_from, a.row_num, rank() over (partition by a.issue_id
	order by a.log_date) as rank_date
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
	change_created desc) as row_num
	from
	master_change_log_v2
	where
	change_item_field = 'status' )a
	where
	row_num = 1
	) status_end_day_from on
	isd.issue_id = status_end_day_from.issue_id
	and status_end_day_from.log_date > ssv.`date`
	left join (
	select
	issue_id,
	status_id
	from
	Due_date_master ) mi on
	isd.issue_id = mi.issue_id) dsi1
	where f_rank =1);






Create or Replace View `Build_SummaryStoryView`
as
(
select
#sprint_table.project_id,
agg.sprint_id,
agg.sprint_name,
CONCAT('Day ', day_count) as 'TrackerChange',
total_time , time_spent,
COALESCE((total_time) - (((total_time) / sprint_days) *(day_count -1 )), 0 ) as ideal_burndown,
total_time - time_spent as remaining_effort,
remaining_tasks,
uat_tasks,
completed_tasks



from




(select
dsl.sprint_id,
dsl.sprint_name,
dsl.date,
dsl.day_count,
dsl.sprint_days,
count(distinct dsl.issue_id) as total_tasks,
count(distinct case when dsl.status_end_day in (10205, 10403) then dsl.issue_id end ) as completed_tasks,
count(distinct case when dsl.status_end_day in (11710) then dsl.issue_id end ) as uat_tasks,
count(distinct case when dsl.status_end_day not in (10205, 10403,11710) then dsl.issue_id end ) as remaining_tasks,
COALESCE(sum(case when status_end_day in (10205, 10403) then mi.time_estimate end), 0) as time_spent ,
coalesce(sum(mi.time_estimate), 0) as total_time
from daily_status_intermediate dsl
inner join
Due_date_master mi
on dsl.issue_id = mi.issue_id
group by 1, 2, 3, 4, 5
) agg



) ;



drop view if exists Build_changelog_summary;

create view Build_changelog_summary as 

select ssb.sprint_id,ssb.sprint_name,ssb.`date` ,concat('Day ',ssb.day_count) as track_change,ssb.sprint_days , issue_id_sr as issue_id , 
change_type , change_from , change_to , datediff(CURDATE(),ssb.`date`) as Datediff
 from
   ((select * from summary_story_view_base_table
	where sprint_id in 
	(select distinct ms.sprint_id from master_sprint ms inner join master_issue mi on ms.sprint_id=mi.sprint_id
where cast(sprint_start_date as date) <>0) ) ssb
left join 
	(select issue_id as issue_id_sr ,log_date ,sprint_id1, case when sprint_id1 is not null then 'Scope Removed'  end as change_type,
    change_to, change_from 
    from
	(select issue_id, log_date,change_to, change_from,
		Case
		when change_item_field = 'sprint' and LENGTH(change_item_from) = LENGTH(REPLACE(change_item_from, ',', ''))  then change_item_from
		when change_item_field = 'sprint' and LENGTH(change_item_from) <> LENGTH(REPLACE(change_item_from, ',', ''))  then Cast(Substring_index(change_item_from, ',', -1) as UNSIGNED)
		end as sprint_id1
		from		
		(select
		issue_id, cast(change_created as Date) as log_date,
		row_number() over(partition by issue_id, cast(change_created as Date) order by change_created desc ) as row_num ,
		change_item_field, change_item_to, change_item_from ,        
        Case
		when change_item_field = 'sprint' and LENGTH(change_item_from_string) = LENGTH(REPLACE(change_item_from_string, ',', ''))  then change_item_from_string
		when change_item_field = 'sprint' and LENGTH(change_item_from_string) <> LENGTH(REPLACE(change_item_from_string, ',', ''))  then (Substring_index(change_item_from_string, ',', -1))
		end as change_from,
        Case
		when change_item_field = 'sprint' and LENGTH(change_item_to_string) = LENGTH(REPLACE(change_item_to_string, ',', ''))  then change_item_to_string
		when change_item_field = 'sprint' and LENGTH(change_item_to_string) <> LENGTH(REPLACE(change_item_to_string, ',', ''))  then (Substring_index(change_item_to_string, ',', -1))
		end as change_to
		from
		master_change_log_v2
		where
		change_item_field = 'sprint' and change_item_from is not null) X
		where row_num = 1 )t1 )ssa
		on ssa.log_date=ssb.date and ssa.sprint_id1=ssb.sprint_id) where change_type is not null
		
		
UNION ALL

select ssb.sprint_id,ssb.sprint_name,ssb.`date`,concat('Day ',ssb.day_count) as track_change,ssb.sprint_days , issue_id_ns as issue_id , 
change_type ,change_from , change_to , datediff(CURDATE(),ssb.`date`) as Datediff
from
   ((select * from summary_story_view_base_table
	where sprint_id in 
	(select distinct ms.sprint_id from master_sprint ms inner join master_issue mi on ms.sprint_id=mi.sprint_id
where cast(sprint_start_date as date) <>0)) ssb

left join
(select issue_id as issue_id_ns,log_date ,sprint_id2,case when sprint_id2 is not null then 'New Scope' else 'n' end as change_type , change_to, change_from
from
    (select issue_id, log_date,change_to, change_from,
		case when status_end_day not in (1) then
			Case
			when change_item_field = 'sprint' and LENGTH(change_item_to) = LENGTH(REPLACE(change_item_to, ',', ''))  then change_item_to
			when change_item_field = 'sprint' and LENGTH(change_item_to) <> LENGTH(REPLACE(change_item_to, ',', ''))  then Cast(Substring_index(change_item_to, ',', -1) as UNSIGNED)
			when change_item_field='status' then  sprint_id_dsl
            else change_item_to
			end end as sprint_id2
		from
		
		(
		select
		issue_id, cast(change_created as Date) as log_date,sprint_id_dsl,
		row_number() over(partition by issue_id, cast(change_created as Date) order by change_created desc ) as row_num ,
		change_item_field, change_item_to, change_item_from , status_end_day,
		Case
		when change_item_field = 'sprint' and LENGTH(change_item_from_string) = LENGTH(REPLACE(change_item_from_string, ',', ''))  then change_item_from_string
		when change_item_field = 'sprint' and LENGTH(change_item_from_string) <> LENGTH(REPLACE(change_item_from_string, ',', ''))  then (Substring_index(change_item_from_string, ',', -1))
		else change_item_from_string
		end as change_from,
        Case
		when change_item_field = 'sprint' and LENGTH(change_item_to_string) = LENGTH(REPLACE(change_item_to_string, ',', ''))  then change_item_to_string
		when change_item_field = 'sprint' and LENGTH(change_item_to_string) <> LENGTH(REPLACE(change_item_to_string, ',', ''))  then (Substring_index(change_item_to_string, ',', -1))
		else change_item_to_string
		end as change_to
		from
			(
			select mcl.* , dsl.status_end_day,dsl.sprint_id as sprint_id_dsl from master_change_log_v2 mcl left join 
			daily_status_intermediate dsl on mcl.issue_id=dsl.issue_id and 
			cast(mcl.change_created as date)=cast(dsl.`date` as date) 
			) mcl2
		where
		change_item_field = 'sprint' or 
		(change_item_field = 'status'
		and change_item_from in (1, 10011)
		and change_item_to not in (10011, 10013, 10206))) X
		where row_num = 1 )t2 ) ssc
		on ssc.log_date=ssb.date and ssc.sprint_id2=ssb.sprint_id) where change_type is not null 
		
UNION ALL

select g.sprint_id , g.sprint_name , g.`date`,concat('Day ',g.day_count) as track_change,g.sprint_days, g.issue_id , 'Estimate Change' as 
change_type , coalesce(change_item_from_string,0) as change_from , coalesce(change_item_to_string,0) as change_to ,
datediff(CURDATE(),g.`date`) as Datediff
from
(select dsi.* , change_created , change_item_from_string , change_item_to_string
		 from 
			 (
			 select issue_id , cast(change_created as date) as change_created, change_item_from_string , change_item_to_string from (select issue_id , cast(change_created as date) as change_created, change_item_from_string , change_item_to_string 
			,row_number() over(partition by issue_id, cast(change_created as Date) order by change_created desc ) as row_num
			 from master_change_log_v2
			 where change_item_field='Original Estimate (h' ) chg_est where row_num=1
			 ) ec left join daily_status_intermediate dsi 
			 on ec.issue_id= dsi.issue_id and ec.change_created=dsi.`date`) g
				where g.issue_id is not null
				
UNION ALL

select g.sprint_id , g.sprint_name , g.`date`,concat('Day ',g.day_count) as track_change,g.sprint_days, g.issue_id , 'Assignee Change' as 
change_type , coalesce(change_item_from_string,'-') as change_from , coalesce(change_item_to_string,'-') as change_to ,
datediff(CURDATE(),g.`date`) as Datediff
from
(select dsi.* , change_created , change_item_from_string , change_item_to_string
		 from 
			 (
			 select issue_id , cast(change_created as date) as change_created, change_item_from_string , change_item_to_string 
			 from master_change_log_v2
			 where change_item_field='assignee' 
			 ) ec left join daily_status_intermediate dsi 
			 on ec.issue_id= dsi.issue_id and ec.change_created=dsi.`date`) g
				where g.issue_id is not null
				
UNION ALL

select g.sprint_id , g.sprint_name , g.`date`,concat('Day ',g.day_count) as track_change,g.sprint_days, g.issue_id , 'Ready for Testing' as 
change_type , coalesce(change_item_from_string,'-') as change_from , coalesce(change_item_to_string,'-') as change_to 
,datediff(CURDATE(),g.`date`) as Datediff
 from
(select dsi.* , change_created , change_item_from_string , change_item_to_string
		 from 
			 (
			 select issue_id , cast(change_created as date) as change_created, change_item_from_string , change_item_to_string 
			 from master_change_log_v2
			 where change_item_field='status' and change_item_to in (11710) 
			 ) ec left join daily_status_intermediate dsi 
			 on ec.issue_id= dsi.issue_id and ec.change_created=dsi.`date`) g
				where g.issue_id is not null
				
UNION ALL

select g.sprint_id , g.sprint_name , g.`date`,concat('Day ',g.day_count) as track_change,g.sprint_days, g.issue_id , 'Due Date Change' as 
change_type , coalesce(change_item_from_string,'-') as change_from , coalesce(change_item_to_string,'-') as change_to 
,datediff(CURDATE(),g.`date`) as Datediff
from
(select dsi.* , change_created , change_item_from_string , change_item_to_string
		 from 
			 (
			 select issue_id , cast(change_created as date) as change_created, change_item_from_string , change_item_to_string 
			 from master_change_log_v2
			 where change_item_field='duedate' 
			 ) ec left join daily_status_intermediate dsi 
			 on ec.issue_id= dsi.issue_id and ec.change_created=dsi.`date`) g
				where g.issue_id is not null
				
UNION ALL   /* Following code is for Tableau functionality , it doesnot have any logical reasoning */
select sprint_id , 
null as sprint_name , null as `date`,
concat('Day ',day_count) as track_change,sprint_days ,
null as issue_id , 
'Scope Removed' as change_type , null as change_from , null as change_to , null as Datediff from summary_story_view_base_table where
sprint_id in (select distinct ms.sprint_id  from master_sprint ms inner join master_issue mi on ms.sprint_id=mi.sprint_id
where cast(sprint_start_date as date) <>0 )
union all
select sprint_id , 
null as sprint_name , null as `date`,
concat('Day ',day_count) as track_change,sprint_days ,
null as issue_id , 
'New Scope' as change_type , null as change_from , null as change_to , null as Datediff from summary_story_view_base_table where
sprint_id in (select distinct ms.sprint_id  from master_sprint ms inner join master_issue mi on ms.sprint_id=mi.sprint_id
where cast(sprint_start_date as date) <>0 )
union all
select sprint_id , 
null as sprint_name , null as `date`,
concat('Day ',day_count) as track_change,sprint_days ,
null as issue_id , 
'Estimate Change' as change_type , null as change_from , null as change_to , null as Datediff from summary_story_view_base_table where
sprint_id in (select distinct ms.sprint_id  from master_sprint ms inner join master_issue mi on ms.sprint_id=mi.sprint_id
where cast(sprint_start_date as date) <>0 )
union all
select sprint_id , 
null as sprint_name , null as `date`,
concat('Day ',day_count) as track_change,sprint_days ,
null as issue_id , 
'Assignee Change' as change_type , null as change_from , null as change_to , null as Datediff from summary_story_view_base_table where
sprint_id in (select distinct ms.sprint_id  from master_sprint ms inner join master_issue mi on ms.sprint_id=mi.sprint_id
where cast(sprint_start_date as date) <>0 )
union all
select sprint_id , 
null as sprint_name , null as `date`,
concat('Day ',day_count) as track_change,sprint_days ,
null as issue_id , 
'Ready for Testing' as change_type , null as change_from , null as change_to , null as Datediff from summary_story_view_base_table where
sprint_id in (select distinct ms.sprint_id  from master_sprint ms inner join master_issue mi on ms.sprint_id=mi.sprint_id
where cast(sprint_start_date as date) <>0 )
union all
select sprint_id , 
null as sprint_name , null as `date`,
concat('Day ',day_count) as track_change,sprint_days ,
null as issue_id , 
'Due Date Change' as change_type , null as change_from , null as change_to , null as Datediff from summary_story_view_base_table where
sprint_id in (select distinct ms.sprint_id  from master_sprint ms inner join master_issue mi on ms.sprint_id=mi.sprint_id
where cast(sprint_start_date as date) <>0 );



/* code begins */ 

#----------------------------- Table post clicking on the detail view ---------------------------# 


Drop view if exists `Build_CardData`;

Create view `Build_CardData` as (
/* code for sprint status */
	select
		s1.sprint_id as kpi_sprint_id,
		s1.TrackerChange,
		'Sprint Status' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Status' as kpi_title1,
		case
			when (s1.remaining_effort / s1.ideal_burndown) <= 0.9 then '1'
			when (s1.remaining_effort / s1.ideal_burndown) >0.9
			and (s1.remaining_effort / s1.ideal_burndown) <= 1.1 then '2'
			when (s1.remaining_effort / s1.ideal_burndown) > 1.1 then '3'
		end as kpi_value1 ,
		'Change' as kpi_title2 ,
		COALESCE((s1.remaining_effort / s1.ideal_burndown), 0) - COALESCE((s2.remaining_effort / s2.ideal_burndown), 0) as kpi_value2
		
	from
		Build_SummaryStoryView s1
	left join Build_SummaryStoryView s2 on
		s1.sprint_id = s2.sprint_id
		and ltrim(REPLACE(s1.TrackerChange, 'Day ', ''))-1 = ltrim(REPLACE(s2.TrackerChange, 'Day ', ''))/* Code for Sprint Days */
UNION
	select
		sprint_id as kpi_sprint_id,
		CONCAT('Day ', day_count ) as 'TrackerChange',
		'Sprint Days' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Remain' as kpi_title1,
		sprint_days - day_count as kpi_value1,
		'Complete' as kpi_title2,
		day_count -1 as kpi_title2
	from
		summary_story_view_base_table 
		
		/* the code is for issues due tomorrow */
UNION
	Select
		YY.sprint_id as kpi_sprint_id,
		CONCAT('Day ', YY.day_count ) as 'TrackerChange',
		'Due Date Summary' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Issue Due Tomorrow' as kpi_title1,
		COALESCE(YY.due_tomo, 0) as kpi_value1,
		'' as kpi_title2,
		'' kpi_value
	from
		(
		SELECT
			ssvbt.*,
			XX.due_tomo
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				ssvbt.sprint_id,
				ssvbt.`date` as change_date,
				count(distinct isd.issue_id) as due_tomo
			from
				summary_story_view_base_table ssvbt
			left join issue_sprint_data isd on
				ssvbt.sprint_id = isd.current_sprint_id
				and ssvbt.date = isd.dt
			left join Due_date_master mi on
				isd.issue_id = mi.issue_id
			left join daily_status_intermediate dsi on
				isd.issue_id = dsi.issue_id
				and ssvbt.date = dsi.date
			
			where
				datediff(
						COALESCE(mi.due_date , case when weekday(ssvbt.sprint_end_date) = 5 then DATE_ADD(ssvbt.sprint_end_date, INTERVAL -1 DAY)
						when weekday(ssvbt.sprint_end_date) = 6 then DATE_ADD(ssvbt.sprint_end_date, INTERVAL -2 DAY) 
						else ssvbt.sprint_end_date end),
						
                 ssvbt.date) = 1 and dsi.status_end_day not in (10205, 10403,11710)
			group by
				1,
				2 ) XX on
			ssvbt.sprint_id = XX.sprint_id
			and ssvbt.date = XX.change_date) YY 
			
			/* Issues due today */
UNION
	Select
		YY.sprint_id as kpi_sprint_id,
		CONCAT('Day ', YY.day_count ) as 'TrackerChange',
		'Due Date Summary' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Issue Due Today' as kpi_title1,
		COALESCE(YY.due_today, 0) as kpi_value1,
		'' as kpi_title2,
		'' kpi_value
	from
		(
		SELECT
			ssvbt.*,
			XX.due_today
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				ssvbt.sprint_id,
				ssvbt.`date` as change_date,
				count(distinct isd.issue_id) as due_today
			from
				summary_story_view_base_table ssvbt
			left join issue_sprint_data isd on
				ssvbt.sprint_id = isd.current_sprint_id
				and ssvbt.date = isd.dt
			left join Due_date_master mi on
				isd.issue_id = mi.issue_id
			left join daily_status_intermediate dsi on
				isd.issue_id = dsi.issue_id
				and ssvbt.date = dsi.date
			
			where
				datediff(
						coalesce(mi.due_date,case when weekday(ssvbt.sprint_end_date) = 5 then DATE_ADD(ssvbt.sprint_end_date, INTERVAL -1 DAY)
						when weekday(ssvbt.sprint_end_date) = 6 then DATE_ADD(ssvbt.sprint_end_date, INTERVAL -2 DAY) 
						else ssvbt.sprint_end_date end),  
                 ssvbt.date) = 0 and dsi.status_end_day not in (10205, 10403,11710)
			group by
				1,
				2 ) XX on
			ssvbt.sprint_id = XX.sprint_id
			and ssvbt.date = XX.change_date) YY /* this code is for issues that are past due - post removing the completed tasks */
UNION
	Select
		YY.sprint_id as kpi_sprint_id,
		CONCAT('Day ', YY.day_count ) as 'TrackerChange',
		'Due Date Summary' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Issue Past Due' as kpi_title1,
		COALESCE(YY.past_due, 0) as kpi_value1,
		'' as kpi_title2,
		'' kpi_value
	from
		(
		SELECT
			ssvbt.*,
			XX.past_due
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				ssvbt.sprint_id,
				ssvbt.`date` as change_date,
				count(distinct isd.issue_id) as past_due
			from
				summary_story_view_base_table ssvbt
			left join issue_sprint_data isd on
				ssvbt.sprint_id = isd.current_sprint_id
				and ssvbt.date = isd.dt
			left join Due_date_master mi on
				isd.issue_id = mi.issue_id
			left join daily_status_intermediate dsi on
				isd.issue_id = dsi.issue_id
				and ssvbt.date = dsi.date
			where
				datediff(
						coalesce(mi.due_date,case when weekday(ssvbt.sprint_end_date) = 5 then DATE_ADD(ssvbt.sprint_end_date, INTERVAL -1 DAY)
						when weekday(ssvbt.sprint_end_date) = 6 then DATE_ADD(ssvbt.sprint_end_date, INTERVAL -2 DAY) 
						else ssvbt.sprint_end_date end),  
                 ssvbt.date) < 0
				and dsi.status_end_day not in (10205, 10403,11710)
			group by
				1,
				2 ) XX on
			ssvbt.sprint_id = XX.sprint_id
			and ssvbt.date = XX.change_date ) YY );
			
drop view if exists Build_kpi ;
create view Build_kpi as 
select a.sprint_id , a.track_change , a.change_type , a.current_value as kpi_value,
case when previous_value<current_value then 1  
     when previous_Value>current_value then -1 
	 else 0 end as kpi_delta
from( 
		(select sprint_id , track_change, change_type , count(distinct issue_id) as current_value ,
					concat(substring(track_change,5 ),change_type)  as row_num1 from  Build_changelog_summary group by 1,2,3 order by row_num1)a 
					left join 
		(select sprint_id , track_change, change_type , count(distinct issue_id) as previous_value,
					concat(substring(track_change,5 )+1,change_type) as row_num2 from  Build_changelog_summary group by 1,2,3 order by row_num2)b
		on a.sprint_id=b.sprint_id and a.row_num1=b.row_num2 );
		
		


/* Now creating a code for table below for the resource summary detail view */
Drop view if exists resource_summary_detail ;

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
		sum(time_estimate) as assigned_hours
	from
		Due_date_master mi
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
		sum(time_estimate) as assigned_hours
	from
		Due_date_master mi
	left join master_sprint ms on
		mi.sprint_id = ms.sprint_id
	group by
		1,
		2,
		3 )time_comp on
	mr.account_id = time_comp.assignee_account_id
	and mr.sprint_name = time_comp.sprint_name ) ;
	
	
	

	
	












