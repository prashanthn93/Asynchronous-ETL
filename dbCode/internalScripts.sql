Drop Table calendar_table;
CREATE TABLE calendar_table (
  dt DATE NOT NULL PRIMARY KEY,
  y SMALLINT NULL,
  q tinyint NULL,
  m tinyint NULL,
  d tinyint NULL,
  dw tinyint NULL,
  monthName VARCHAR(9) NULL,
  dayName VARCHAR(9) NULL,
  w tinyint NULL,
  isWeekday BINARY(1) NULL,
  isHoliday BINARY(1) NULL,
  holidayDescr VARCHAR(32) NULL,
  isPayday BINARY(1) NULL
);
CREATE TABLE ints (i tinyint);

INSERT INTO ints
VALUES (0),
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9);

INSERT INTO calendar_table (dt)
  SELECT DATE('2020-01-01') + INTERVAL a.i * 10000 + b.i * 1000 + c.i * 100 + d.i * 10 + e.i DAY
  FROM ints a
    JOIN ints b
    JOIN ints c
    JOIN ints d
    JOIN ints e
  WHERE (a.i * 10000 + b.i * 1000 + c.i * 100 + d.i * 10 + e.i) <= 11322
  ORDER BY 1;

UPDATE calendar_table
SET isWeekday = CASE
    WHEN dayofweek(dt) IN (1, 7) THEN 0
    ELSE 1
  END,
  isHoliday = 0,
  isPayday = 0,
  y = YEAR(dt),
  q = quarter(dt),
  m = MONTH(dt),
  d = dayofmonth(dt),
  dw = dayofweek(dt),
  monthname = monthname(dt),
  dayname = dayname(dt),
  w = week(dt),
  holidayDescr = '';
drop table ints;

update master_issue
set epic_name_text = (
    select epic.summary
    from (
        select issue_key,
          summary
        from master_issue
        where issue_type_id = '10000'
      ) epic
    where master_issue.epic_name = epic.issue_key
  );
truncate table master_issue_test;
ALTER TABLE master_issue_test
MODIFY COLUMN status_category_change_date VARCHAR(250) NULL;
ALTER TABLE master_issue_test
MODIFY COLUMN start_date VARCHAR(250) NULL;
ALTER TABLE master_issue_test
MODIFY COLUMN change_start_date VARCHAR(250) NULL;
ALTER TABLE master_issue_test
MODIFY COLUMN change_completion_date VARCHAR(250) NULL;
ALTER TABLE master_issue_test
MODIFY COLUMN due_date VARCHAR(250) NULL;
insert into master_issue_test
select *
from master_issue
where issue_type_id in ('10105', '10106', '10107', '10109', '10110');
Update master_issue_test
set status_category_change_date = null
where status_category_change_date = '0000-00-00 00:00:00';
Update master_issue_test
set start_date = null
where start_date = '0000-00-00 00:00:00';
Update master_issue_test
set change_start_date = null
where change_start_date = '0000-00-00 00:00:00';
Update master_issue_test
set change_completion_date = null
where change_completion_date = '0000-00-00 00:00:00';
Update master_issue_test
set due_date = null
where due_date = '0000-00-00 00:00:00';
ALTER TABLE master_issue_test
MODIFY COLUMN status_category_change_date DATETIME NULL;
ALTER TABLE master_issue_test
MODIFY COLUMN start_date DATETIME NULL;
ALTER TABLE master_issue_test
MODIFY COLUMN change_start_date DATETIME NULL;
ALTER TABLE master_issue_test
MODIFY COLUMN change_completion_date DATETIME NULL;
ALTER TABLE master_issue_test
MODIFY COLUMN due_date DATETIME NULL;
delete from master_issue
where issue_type_id in ('10105', '10106', '10107', '10109', '10110');
drop table summary_story_view_base_table;
create table summary_story_view_base_table as (
  select ms.sprint_id,
    ms.sprint_name,
    cast(sprint_start_date as date) as sprint_start_date,
    cast(sprint_end_date as date) as sprint_end_date,
    ct.dt as date,
    rank() over(
      PARTITION BY sprint_id
      order by ct.dt asc
    ) as day_count,
    sum(1) over(PARTITION BY sprint_id) as sprint_days
  from master_sprint ms
    join calendar_table ct on cast(ms.sprint_start_date as date) <= ct.dt
    and cast(ms.sprint_end_date as date) >= ct.dt
  where sprint_state in ('active', 'closed')
    and ct.isWeekday = 1
);


Drop Table issue_sprint_data;

Create Table issue_sprint_data as (
  select issue_data.issue_id as issue_id,
    issue_data.sprint_id as original_sprint_id,
    ct.dt,
    issue_created as issue_start_date,
    issue_data.end_date as issue_end_date,
    COALESCE(
      status_end_day_to.change_item_to,
      status_end_day_from.change_item_from,
      issue_data.sprint_id
    ) as current_sprint_id
  from calendar_table ct
    right join (
      SELECT issue_id,
        sprint_id,
        cast(created as date) as issue_created,
        CURDATE() as end_date,
        status_id
      from master_issue
    ) issue_data on ct.dt >= issue_data.issue_created
    and ct.dt <= issue_data.end_Date
    left join (
      select f.issue_id,
        f.log_date as start_date,
        COALESCE(s.log_date, CURDATE()) as end_date,
        SUBSTRING_INDEX(REVERSE(f.change_item_to), ',', 1) as change_item_to
      from (
          select *
          from (
              select issue_id,
                cast(change_created as date) as log_date,
                change_item_to,
                change_item_from,
                rank() over(
                  PARTITION BY issue_id
                  order BY cast(change_created as Date)
                ) as rank_date,
                ROW_NUMBER() OVER(
                  PARTITION By issue_id,
                  cast(change_created as date)
                  order by change_created desc
                ) as row_num
              from master_change_log
              where change_item_field = 'sprint'
            ) a
          where row_num = 1
        ) f
        left join (
          select *
          from (
              select issue_id,
                cast(change_created as date) as log_date,
                change_item_to,
                change_item_from,
                rank() over(
                  PARTITION BY issue_id
                  order BY cast(change_created as Date)
                ) as rank_date,
                ROW_NUMBER() OVER(
                  PARTITION By issue_id,
                  cast(change_created as date)
                  order by change_created desc
                ) as row_num
              from master_change_log
              where change_item_field = 'sprint'
            ) a
          where row_num = 1
        ) s on f.issue_id = s.issue_id
        and f.rank_date + 1 = s.rank_date
    ) status_end_day_to on status_end_day_to.issue_id = issue_data.issue_id
    and status_end_day_to.start_date <= ct.dt
    and status_end_day_to.end_date > ct.dt
    left JOIN (
      select *
      from (
          select issue_id,
            cast(change_created as date) as log_date,
            change_item_from,
            rank() over(
              PARTITION BY issue_id
              order BY cast(change_created as Date)
            ) as rank_date,
            ROW_NUMBER() OVER(
              PARTITION By issue_id,
              cast(change_created as date)
              order by change_created desc
            ) as row_num
          from master_change_log
          where change_item_field = 'sprint'
        ) X
      where rank_date = 1
        and row_num = 1
    ) status_end_day_from on status_end_day_from.issue_id = issue_data.issue_id
    and status_end_day_from.log_date > ct.dt
);

Drop Table daily_status_intermediate;

Create table daily_status_intermediate as (
  select ssv.*,
    isd.issue_id as issue_id,
    COALESCE(
      status_end_day_to.change_item_to,
      status_end_day_from.change_item_from,
      mi.status_id
    ) as status_end_day
  from summary_story_view_base_table ssv
    left join issue_sprint_data isd on ssv.sprint_id = isd.current_sprint_id
    and ssv.`date` = isd.dt
    left join (
      select f.issue_id,
        f.log_date as start_date,
        COALESCE(s.log_date, CURDATE()) as end_date,
        f.change_item_to as change_item_to
      from (
          select *
          from (
              select issue_id,
                cast(change_created as date) as log_date,
                change_item_to,
                change_item_from,
                rank() over(
                  PARTITION BY issue_id
                  order BY cast(change_created as Date)
                ) as rank_date,
                ROW_NUMBER() OVER(
                  PARTITION By issue_id,
                  cast(change_created as date)
                  order by change_created desc
                ) as row_num
              from master_change_log
              where change_item_field_id = 'status'
            ) a
          where row_num = 1
        ) f
        left join (
          select *
          from (
              select issue_id,
                cast(change_created as date) as log_date,
                change_item_to,
                change_item_from,
                rank() over(
                  PARTITION BY issue_id
                  order BY cast(change_created as Date)
                ) as rank_date,
                ROW_NUMBER() OVER(
                  PARTITION By issue_id,
                  cast(change_created as date)
                  order by change_created desc
                ) as row_num
              from master_change_log
              where change_item_field = 'status'
            ) b
          where row_num = 1
        ) s on f.issue_id = s.issue_id
        and f.rank_date + 1 = s.rank_date
    ) status_end_day_to on isd.issue_id = status_end_day_to.issue_id
    and status_end_day_to.start_date <= ssv.`date`
    and status_end_day_to.end_date > ssv.`date`
    LEFT JOIN (
      select *
      from (
          select issue_id,
            cast(change_created as date) as log_date,
            change_item_to,
            change_item_from,
            rank() over(
              PARTITION BY issue_id
              order BY cast(change_created as Date)
            ) as rank_date,
            ROW_NUMBER() OVER(
              PARTITION By issue_id,
              cast(change_created as date)
              order by change_created desc
            ) as row_num
          from master_change_log
          where change_item_field_id = 'status'
        ) a
      where row_num = 1
        and rank_date = 1
    ) status_end_day_from on isd.issue_id = status_end_day_from.issue_id
    and status_end_day_from.log_date > ssv.`date`
    left join (
      select issue_id,
        status_id
      from master_issue
    ) mi on isd.issue_id = mi.issue_id
);

Create or replace View `Build_SummaryStoryView` as (
    select sprint_table.project_id,
      agg.sprint_id,
      agg.sprint_name,
      CONCAT('Day ', day_count) as 'TrackerChange',
      COALESCE(
        (total_time) - (((total_time) / sprint_days) *(day_count -1)),
        0
      ) as ideal_burndown,
      total_time - time_spent as remaining_effort,
      remaining_tasks,
      uat_tasks,
      completed_tasks
    from (
        (
          select dsl.sprint_id,
            dsl.sprint_name,
            dsl.date,
            dsl.day_count,
            dsl.sprint_days,
            count(distinct dsl.issue_id) as total_tasks,
            count(
              distinct case
                when dsl.status_end_day in (10205, 10403) then dsl.issue_id
              end
            ) as completed_tasks,
            count(
              distinct case
                when dsl.status_end_day in (11710) then dsl.issue_id
              end
            ) as uat_tasks,
            count(
              distinct case
                when dsl.status_end_day not in (10205, 10403) then dsl.issue_id
              end
            ) as remaining_tasks,
            COALESCE(
              sum(
                case
                  when status_end_day in (10205, 10403) then mi.time_original_estimate
                end
              ) / 3600,
              0
            ) as time_spent
          from daily_status_intermediate dsl
            inner join master_issue mi on dsl.issue_id = mi.issue_id
          group by 1,
            2,
            3,
            4,
            5
        ) agg
        LEFT JOIN (
          select sprint_id,
            project_id,
            sum(time_original_estimate) / 3600 as total_time
          from master_issue mi
          group by 1,
            2
        ) sprint_table on agg.sprint_id = sprint_table.sprint_id
      )
  );


/* code begins */ 

DROP TABLE proj_base_table ;

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
	GROUP BY
		1,
		2 ) proj
JOIN calendar_table ct ON
	proj.project_start_date <= ct.dt
	AND proj.project_end_date >= ct.dt
WHERE
	isweekday = 1 );
#---------------- Query to create an intermediate table with issue and their daily status, mapped to project ids ----# 
 DROP TABLE project_issue_daily_status_intermediate;

CREATE TABLE project_issue_daily_status_intermediate AS (
SELECT
	base_table.*,
	mi.issue_id,
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
		issue_type_id NOT IN (10000)) mi ON
	base_table.project_id = mi.project_id
	AND base_table.dt >= CAST(mi.created AS date )
left join (
	select
		f.issue_id,
		f.log_date as start_date,
		case when COALESCE(s.log_date, CURDATE()) = CURDATE() then cast(curdate()+ 1 as date) else s.log_date end  as end_date,
		f.change_item_to as change_item_to
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
				rank() over(PARTITION BY issue_id
			order BY
				cast(change_created as Date)) as rank_date,
				ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
			order by
				change_created desc) as row_num
			from
				master_change_log
			where
				change_item_field_id = 'status' )a
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
				rank() over(PARTITION BY issue_id
			order BY
				cast(change_created as Date)) as rank_date,
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
		and f.rank_date + 1 = s.rank_date ) status_end_day_to on
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
			change_created desc) as row_num
		from
			master_change_log
		where
			change_item_field_id = 'status' )a
	where
		row_num = 1
		and rank_date = 1 ) status_end_day_from on
	mi.issue_id = status_end_day_from.issue_id
	and status_end_day_from.log_date >= base_table.dt ) ;
/*
---
-- Creating the final ADS -----------------__# 
*/


CREATE or replace VIEW `Requirement_CardData` AS
SELECT
	project_id AS kpi_project_id,
	CONCAT('Day ', day_count) AS TrackerChange ,
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
	END AS kpi_title2,
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
	END AS kpi_title2,
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
			issue_type_id NOT IN (10000)
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
			issue_type_id NOT IN (10000)
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
	END AS kpi_title2,
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
	END AS kpi_title2,
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
	'' AS TrackerChange ,
	'Estimate Summary' AS kpi_name,
	'sprint_requirement' AS kpi_dashboard,
	'Original' AS kpi_title1,
	COALESCE(XX.original,
	0) AS kpi_value1,
	'New' AS kpi_title2 ,
	YY.new_time kpi_title2,
	'Grey' AS kpi_group,
	7 AS kpi_order,
	'No' AS kpi_click,
	"test" AS kpi_icon
FROM
	(
	SELECT
		mi.project_id, Round(SUM(COALESCE(mcl.change_item_to, mi.time_original_estimate, 0)) / 3600, 2) AS original
	FROM
		master_issue mi
	LEFT JOIN (
		SELECT
			*
		FROM
			(
			SELECT
				issue_id, change_created , change_item_to, RANK() OVER(PARTITION BY issue_id
			ORDER BY
				change_created) AS rank_1
			FROM
				master_change_log
			WHERE
				change_item_field = 'timeoriginalestimate' ) t
		WHERE
			rank_1 = 1 )mcl ON
		mi.issue_id = mcl.issue_id
	WHERE
		issue_type_id NOT IN (10000)
	GROUP BY
		1 ) XX
RIGHT JOIN (
	SELECT
		mi.project_id, Round(SUM(COALESCE(mcl.change_item_to, mi.time_original_estimate, 0)) / 3600, 2) AS new_time
	FROM
		master_issue mi
	LEFT JOIN (
		SELECT
			*
		FROM
			(
			SELECT
				issue_id, change_created , change_item_to, RANK() OVER(PARTITION BY issue_id
			ORDER BY
				change_created DESC) AS rank_1
			FROM
				master_change_log
			WHERE
				change_item_field = 'timeoriginalestimate' ) t
		WHERE
			rank_1 = 1 )mcl ON
		mi.issue_id = mcl.issue_id
	WHERE
		issue_type_id NOT IN (10000)
	GROUP BY
		1 ) YY ON
	XX.project_id = YY.project_id ;

/* code ends */

/* code begins */ 


CREATE OR REPLACE VIEW `Build_StoryTrack` AS
Select
	i.project_id as project_id,
	i.sprint_id AS sprint_id,
	sp.sprint_name as sprint_name,
	i.summary as issue_summary,
	i.epic_name as epic_name,
	case
		when COALESCE(epic_name.epic_name_text, i.epic_name_text) = '' then i.issue_key
		else COALESCE(epic_name.epic_name_text, i.epic_name_text)
	end as epic_name_text,
	i.issue_key as issue_key,
	st.status_name as status_name,
	ac.display_name as user_name,
	(i.aggregate_time_estimate /(60 * 60)) as estimated_hours,
	((i.aggregate_time_estimate /(60 * 60))-(i.time_spent /(60 * 60))) as remaining_hours,
	i.due_date as due_date,
	i.priority_name as priority_name,
	datediff(now(),
	i.due_date) as missedduedate,
	datediff(now(),
	sp.sprint_start_date) as trackchange,
	"Need to add table" as nextupdate,
	sp.sprint_state as sprint_status
from
	(select mi.issue_id , mi.issue_key , mi.issue_type_id , mi.project_id , inter.sprint_id, mi.status_id , mi.status_category , mi.epic_name, mi.story_point, 
mi.assignee_account_id , mi.creator_account_id , mi.reporter_account_id , mi.summary , mi.description , mi.fix_version , mi.time_estimate , mi.time_original_estimate , 
mi.aggregate_time_estimate , mi.aggregate_time_original_estimate , mi.time_spent , mi.aggregate_time_spent , mi.work_ratio, mi.created , mi.updated , mi.status_category_change_date , mi.start_date , 
mi.change_start_date , mi.change_completion_date , mi.due_date , mi.epic_name_text, mi.priority_name 
from 
master_issue mi 
left join 
(select 
Distinct  issue_id , sprint_id
from daily_status_intermediate) inter 
on mi.issue_id = inter.issue_id) i
left join master_sprint as sp on
	i.sprint_id = sp.sprint_id
left join master_status as st on
	i.status_id = st.status_id
left join master_user_account as ac on
	i.assignee_account_id = ac.account_id
left join (
	SELECT
		DISTINCT issue_key, epic_name_text
	from
		master_issue
	where
		epic_name_text <> '' ) epic_name on
	i.epic_name = epic_name.issue_key ;

Drop table change_view_intermediate ;

Create table change_view_intermediate as (
select
	dsi.issue_id as issue_id,
	mi.issue_key as issue_key,
	mi.summary as summary, 
	dsi.sprint_id as sprint_id,
	mi.project_id AS project_id,
	CONCAT('Day ', day_count) as TrackChange,
	dsi.date,
	ms.status_name as status,
	mua.display_name as assigned_to
from
	daily_status_intermediate dsi
left join master_issue mi on
	dsi.issue_id = mi.issue_id
left join master_status ms on
	dsi.status_end_day = ms.status_id
left join master_user_account mua on
	mi.assignee_account_id = mua.account_id ) ;

/* View for Build Change View */

CREATE or replace VIEW `Build_ChangeView` AS /* code for New Scope */

select 
interim.project_id as project_id, 
interim.issue_id as issue_id, 
interim.issue_key as issue_key, 
interim.summary as summary, 
interim.sprint_id as sprint_id, 
interim.TrackChange as TrackChange, 
interim.status as status, 
interim.assigned_to,
interim.change_type,
interim.change_item_from_string,
interim.change_item_to_string,
interim.change_created,
mua.display_name as change_author, 
interim.Datediff as DateDiff



from 

(select
	project_id,
	issue_id,
	issue_key, 
	summary,
	sprint_id,
	TrackChange,
	status,
	assigned_to,
	"New Scope" as change_type,
	change_item_from_string,
	change_item_to_string,
	date as change_created,
	change_author_account_id,
	datediff(CURDATE(),
	date) as Datediff
from
	(
	select
		cvi.*,
		Case
			when change_item_field = 'sprint'
			and sprint_id_change = sprint_id then 1
			when change_item_field = 'status' then 1
			else 0
		end as filter_flag, change_item_field, change_item_from_string, change_item_to_string, change_author_account_id
	from
		change_view_intermediate cvi
	inner join (
		select
			issue_id, cast(change_created as Date) as log_date, change_item_field ,
			Case
				when change_item_field = 'Sprint' then SUBSTRING_INDEX(REVERSE(change_item_to), ',', 1)
			end as sprint_id_change, change_item_from, change_item_to , change_item_from_string, change_item_to_string, change_author_account_id
		from
			master_change_log
		where
			(change_item_field = 'sprint' )
			or (change_item_field_id = 'status'
			and change_item_from in (1, 10011)
			and change_item_to not in (10011, 10013) ) ) new_scope on
		new_scope.issue_id = cvi.issue_id
		and new_scope.log_date = cvi.date ) X
where
	filter_flag = 1
UNION /* code for Scope removed */
select
	project_id,
	issue_id,
	issue_key, 
	summary,
	sprint_id,
	TrackChange,
	status,
	assigned_to,
	"Scope Removed" as change_type,
	change_item_from_string,
	change_item_to_string,
	date as change_created,
	change_author_account_id,
	datediff(CURDATE(),
	date) as Datediff
from
	(
	select
		cvi.*, change_item_from_string, change_item_to_string,change_author_account_id,
		case
			when sprint_id != sprint_id_change then 1
			else 0
		end filter_flag
	from
		change_view_intermediate cvi
	inner join (
		select
			issue_id, cast(change_created as Date) as log_date,
			Case
				when change_item_field = 'Sprint' then SUBSTRING_INDEX(REVERSE(change_item_to), ',', 1)
			end as sprint_id_change, change_item_from_string, change_item_to_string, change_author_account_id
		from
			master_change_log
		where
			change_item_field = 'sprint' )scope_removed on
		cvi.issue_id = scope_removed.issue_id
		and cvi.date = scope_removed.log_date ) X
where
	filter_flag = 1
UNION /* Code for estimate change */
select
	cvi.project_id,
	cvi.issue_id,
	issue_key, 
	summary,
	sprint_id,
	TrackChange,
	status,
	assigned_to,
	"Estimate Changed" as change_type,
	change_item_from_string,
	change_item_to_string,
	date as change_created,
	change_author_account_id,
	datediff(CURDATE(),
	date) as Datediff
from
	change_view_intermediate cvi
inner join (
	select
		issue_id, cast(change_created as Date) as log_date, change_item_from / 3600 as change_item_from_string, change_item_to / 3600 as change_item_to_string, change_author_account_id
	from
		master_change_log
	where
		change_item_field = 'timeoriginalestimate' ) time_change on
	cvi.issue_id = time_change.issue_id
	and cvi.date = time_change.log_date
UNION /* code for assignee change */
select
	cvi.project_id,
	cvi.issue_id,
	issue_key, 
	summary,
	sprint_id,
	TrackChange,
	status,
	assigned_to,
	"Assignee Change" as change_type,
	change_item_from_string,
	change_item_to_string,
	date as change_created,
	change_author_account_id,
	datediff(CURDATE(),
	date) as Datediff
from
	change_view_intermediate cvi
inner join (
	select
		issue_id, cast(change_created as Date) as log_date, change_item_from_string, change_item_to_string, change_author_account_id
	from
		master_change_log
	where
		change_item_field = 'assignee' ) time_change on
	cvi.issue_id = time_change.issue_id
	and cvi.date = time_change.log_date
UNION /* code for Ready for Testing */
select
	cvi.project_id,
	issue_key, 
	summary,
	cvi.issue_id,
	sprint_id,
	TrackChange,
	status,
	assigned_to,
	"Ready for Testing" as change_type,
	change_item_from_string,
	change_item_to_string,
	date as change_created,
	change_author_account_id,
	datediff(CURDATE(),
	date) as Datediff
from
	change_view_intermediate cvi
inner join (
	select
		issue_id, cast(change_created as Date) as log_date, change_item_from_string, change_item_to_string, change_author_account_id
	from
		master_change_log
	where
		change_item_field = 'status'
		and change_item_to = 11710 ) uat on
	cvi.issue_id = uat.issue_id
	and cvi.date = uat.log_date
UNION /* Code for Due Date Change */
select
	cvi.project_id,
	cvi.issue_id,
	issue_key, 
	summary, 
	sprint_id,
	TrackChange,
	status,
	assigned_to,
	"Due Date Change" as change_type,
	change_item_from_string,
	change_item_to_string,
	date as change_created,
	change_author_account_id, 
	datediff(CURDATE(),
	date) as Datediff
from
	change_view_intermediate cvi
inner join (
	select
		issue_id, cast(change_created as Date) as log_date, Cast(change_item_from_string as date) as change_item_from_string, Cast(change_item_to_string as date) as change_item_to_string, change_author_account_id
	from
		master_change_log
	where
		change_item_field = 'duedate' ) ddc on
	cvi.issue_id = ddc.issue_id
	and cvi.date = ddc.log_date
) interim 

left join 
master_user_account mua  
on interim.change_author_account_id = mua.account_id ;

/* code ends */ 


/* code begins */ 
Drop table epic_base_table ;

create table epic_base_table as (
select
	proj.project_id ,
	proj.epic_name,
	proj1.epic_start_date ,
	proj.epic_end_date,
	ct.dt,
	rank() over(PARTITION BY epic_name
order by
	dt asc) as day_count
from
	(
	select
		project_id,
		case
			when epic_name is NULL then Concat(project_id, '-Unassigned')
			else epic_name
		end as epic_name,
		Cast(Now() as date) as epic_end_date
	from
		master_issue mi
	group by
		1,
		2 ) proj
left join (
	select
		project_id,
		min(cast(created as date)) as epic_start_date
	from
		master_issue mi
	group by
		1 ) proj1 on
	proj.project_id = proj1.project_id
join calendar_table ct on
	proj1.epic_start_date <= ct.dt
	and proj.epic_end_date >= ct.dt
where
	isweekday = 1 );
#------------------ Query for creating daily status for every issue in an epic -------------# 
 Drop table epic_issue_daily_status_intermediate;

Create table epic_issue_daily_status_intermediate as (
select
	base_table.* ,
	mi.issue_id,
	COALESCE(status_end_day_to.change_item_to, status_end_day_from.change_item_from, mi.status_id) as status_end_day
from
	epic_base_table base_table
left join (
	select
		*,
		case
			when epic_name is NULL then Concat(project_id, '-Unassigned')
			else epic_name
		end as epic_name_1
	from
		master_issue
	WHERE
		issue_type_id NOT IN (10000) ) mi on
	base_table.epic_name = mi.epic_name_1
	and base_table.dt >= cast(mi.created as date )
left join (
	select
		f.issue_id,
		f.log_date as start_date,
		case when COALESCE(s.log_date, CURDATE()) = CURDATE() then cast(curdate()+ 1 as date) else s.log_date end  as end_date,
		f.change_item_to as change_item_to
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
				rank() over(PARTITION BY issue_id
			order BY
				cast(change_created as Date)) as rank_date,
				ROW_NUMBER() OVER(PARTITION By issue_id, cast(change_created as date)
			order by
				change_created desc) as row_num
			from
				master_change_log
			where
				change_item_field_id = 'status' )a
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
				rank() over(PARTITION BY issue_id
			order BY
				cast(change_created as Date)) as rank_date,
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
		and f.rank_date + 1 = s.rank_date ) status_end_day_to on
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
			change_created desc) as row_num
		from
			master_change_log
		where
			change_item_field_id = 'status' )a
	where
		row_num = 1
		and rank_date = 1 ) status_end_day_from on
	mi.issue_id = status_end_day_from.issue_id
	and status_end_day_from.log_date >= base_table.dt ) ;
#---------------------------------------- Now creating an ADS for Epic Summary ---------------------------# 
#--- the below block computes the groomed stories and the total stories for a every epic ----# 

CREATE or replace
VIEW `Requirement_EpicSummary` AS
select
	ebl.project_id as 'project_id',
	ebl.epic_name as 'Epic_name',
	COALESCE(epic_name.epic_name_text, ebl.epic_name) as 'Epic_name_text',
	CONCAT('Day ', ebl.day_count) as 'TrackChange' ,
	stories.groomed_stories as 'Groomed_Stories',
	stories.total_stories as 'Total_User_Stories',
	org_time.original_hours as 'Original_hours',
	org_time.new_time as 'New_Estimate',
	COALESCE(ehe.estimate_hours, 0) as 'Estimate_hours'
from
	epic_base_table ebl
LEFT JOIN (
	select
		project_id,
		epic_name,
		day_count,
		count(distinct case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then issue_id end) as groomed_stories,
		count(issue_id) - count(distinct case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then issue_id end) as total_stories,
		count(issue_id) as total_user_stories
	from
		epic_issue_daily_status_intermediate
	group by
		1,
		2,
		3 )stories ON
	ebl.epic_name = stories.epic_name
	and ebl.day_count = stories.day_count
	#--- the below code block computes the original time estimate i.e the time estimated while creating a task ---# 
LEFT JOIN (
	select
		project_id,
		epic_name,
		day_count,
		#issue_id, 
 coalesce(Sum(original) / 3600, 0) as original_hours,
		sum(COALESCE(new_time, original, 0))/ 3600 as new_time
	from
		(
		select
			es.*,
			original_time.original,
			new_time.changed_date,
			new_time.new_time,
			RANK() OVER(PARTITION BY es.issue_id,
			es.day_count
		ORDER BY
			changed_date desc) as row_rank
		from
			epic_issue_daily_status_intermediate es
		left join (
			select
				mi.project_id,
				mi.issue_id,
				case
					when mi.epic_name is NULL then concat(mi.project_id, '-Unassigned')
					else mi.epic_name
				end as epic_name,
				cast(created as date) as created_date,
				COALESCE(mcl.change_item_to, mi.time_original_estimate, 0) as original
			from
				master_issue mi
			left join (
				select
					*
				from
					(
					select
						issue_id,
						change_created ,
						change_item_to,
						Rank() over(PARTITION BY issue_id
					order by
						change_created) as rank_1
					from
						master_change_log
					where
						change_item_field = 'timeoriginalestimate' ) t
				where
					rank_1 = 1 ) mcl on
				mi.issue_id = mcl.issue_id )original_time on
			es.issue_id = original_time.issue_id
		LEFT JOIN (
			#----- Now code for New Estimate 
			select
				mi.project_id,
				mi.issue_id,
				mi.epic_name,
				cast(mcl.change_created as date ) as changed_date,
				mcl.change_item_to as new_time
			from
				master_issue mi
			left join (
				select
					*
				from
					(
					select
						issue_id,
						change_created ,
						change_item_to,
						Rank() over(PARTITION BY issue_id
					order by
						change_created DESC) as rank_1
					from
						master_change_log
					where
						change_item_field = 'timeoriginalestimate' ) t
				where
					rank_1 = 1 ) mcl on
				mi.issue_id = mcl.issue_id ) new_time on
			es.issue_id = new_time.issue_id ) X
	where
		row_rank = 1
	group by
		1,
		2,
		3 )org_time on
	ebl.epic_name = org_time.epic_name
	and ebl.day_count = org_time.day_count
left join (
	SELECT
		DISTINCT issue_key,
		epic_name_text
	from
		master_issue
	where
		epic_name_text <> '' ) epic_name on
	ebl.epic_name = epic_name.issue_key /* adding the epic hours from the manually updated table */
left join epic_hours_estimate ehe on
	ebl.epic_name = ehe.epic_key ;
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
		project_id, day_count, count(case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then issue_id end) as groomed_stories, 
		count(case when status_end_day in (11707) then issue_id end) as requirement_complete, 
		(count(issue_id) - (count(case when status_end_day in (11707) then issue_id end))-count(distinct case when status_end_day in (10000, 3, 11708, 11709, 11710, 10205, 10403) then issue_id end)) as total_stories,
		 count(issue_id) as total_user_stories
	from
		epic_issue_daily_status_intermediate
	group by
		1, 2 )stories ON
	ebl.day_count = stories.day_count
	and ebl.project_id = stories.project_id
	#--- the below code block computes the original time estimate i.e the time estimated while creating a task ---# 
LEFT JOIN (
	select
		project_id, day_count,
		#issue_id, 
 Coalesce(Sum(original) / 3600,
		0) as original_hours, sum(COALESCE(new_time, original, 0))/ 3600 as new_time
	from
		(
		select
			es.*, original_time.original, new_time.changed_date, new_time.new_time, RANK() OVER(PARTITION BY es.issue_id,
			es.day_count
		ORDER BY
			changed_date desc) as row_rank
		from
			epic_issue_daily_status_intermediate es
		left join (
			select
				mi.project_id, mi.issue_id,
				case
					when mi.epic_name is NULL then concat(mi.project_id, '-Unassigned')
					else mi.epic_name
				end as epic_name, cast(created as date) as created_date, COALESCE(mcl.change_item_to,
				mi.time_original_estimate,
				0) as original
			from
				master_issue mi
			left join (
				select
					*
				from
					(
					select
						issue_id, change_created , change_item_to, Rank() over(PARTITION BY issue_id
					order by
						change_created) as rank_1
					from
						master_change_log
					where
						change_item_field = 'timeoriginalestimate' ) t
				where
					rank_1 = 1 ) mcl on
				mi.issue_id = mcl.issue_id )original_time on
			es.issue_id = original_time.issue_id
		LEFT JOIN (
			#----- Now code for New Estimate 
			select
				mi.project_id, mi.issue_id, mi.epic_name, cast(mcl.change_created as date ) as changed_date, mcl.change_item_to as new_time
			from
				master_issue mi
			left join (
				select
					*
				from
					(
					select
						issue_id, change_created , change_item_to, Rank() over(PARTITION BY issue_id
					order by
						change_created DESC) as rank_1
					from
						master_change_log
					where
						change_item_field = 'timeoriginalestimate' ) t
				where
					rank_1 = 1 ) mcl on
				mi.issue_id = mcl.issue_id ) new_time on
			es.issue_id = new_time.issue_id ) X
	where
		row_rank = 1
	group by
		1, 2 )org_time on
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


/* code begins */ 

#----------------------------- Table post clicking on the detail view ---------------------------# 
drop table card_data_intermediate;

Create table card_data_intermediate as
select
	dsi.issue_id as issue_id,
	mi.issue_key as issue_key,
	dsi.sprint_id,
	concat('Day ', dsi.day_count ) as TrackChange ,
	ms.status_name as status,
	mua.display_name as assigned_to ,
	Case
		when new_scope.change_item_field = 'sprint'
		and new_scope.sprint_id_change = dsi.sprint_id then 'y'
		when new_scope.change_item_field = 'status' then 'y'
		else 'n'
	end as new_scope_flag ,
	case
		when scope_removed.sprint_id_change != dsi.sprint_id then 'y'
		else 'n'
	end as scope_removed_flag,
	case
		when time_change.issue_id is not null then 'y'
		else 'n'
	end as estimate_changed_flag,
	case
		when assignee_change.issue_id is not null then 'y'
		else 'n'
	end as assignee_change_flag,
	case
		when uat.change_item_to = 11710 then 'y'
		else 'n'
	end as ready_for_testing_flag ,
	case
		when duedate_change.issue_id is not null then 'y'
		else 'n'
	end as duedate_change_flag
from
	daily_status_intermediate dsi
left join master_issue mi on
	dsi.issue_id = mi.issue_id
left join master_status ms on
	dsi.status_end_day = ms.status_id
left join master_user_account mua on
	mi.assignee_account_id = mua.account_id
left JOIn /* this is for new scope column */
	(
	select
		issue_id, cast(change_created as Date) as log_date, change_item_field,
		Case
			when change_item_field = 'Sprint' then SUBSTRING_INDEX(REVERSE(change_item_to), ',', 1)
		end as sprint_id_change, change_item_from, change_item_to
	from
		master_change_log
	where
		(change_item_field = 'sprint' )
		or (change_item_field_id = 'status'
		and change_item_from in (1, 10011)
		and change_item_to not in (10011, 10013) ) ) new_scope on
	dsi.issue_id = new_scope.issue_id
	and dsi.date = new_scope.log_date /* this is for scope removed column */
left join (
	select
		issue_id, cast(change_created as Date) as log_date,
		Case
			when change_item_field = 'Sprint' then SUBSTRING_INDEX(REVERSE(change_item_to), ',', 1)
		end as sprint_id_change
	from
		master_change_log
	where
		change_item_field = 'sprint' ) scope_removed on
	dsi.issue_id = scope_removed.issue_id
	and dsi.date = scope_removed.log_date /* this code is for time estimate change */
left join (
	select
		issue_id, cast(change_created as Date) as log_date
	from
		master_change_log
	where
		change_item_field = 'timeoriginalestimate' ) time_change on
	dsi.issue_id = time_change.issue_id
	and dsi.date = time_change.log_date /* this code is for assignee change */
left join (
	select
		issue_id, cast(change_created as Date) as log_date
	from
		master_change_log
	where
		change_item_field = 'assignee' ) assignee_change on
	dsi.issue_id = assignee_change.issue_id
	and dsi.date = assignee_change.log_date /* this code is for ready for testing change */
left join (
	select
		issue_id, cast(change_created as Date) as log_date , change_item_to
	from
		master_change_log
	where
		change_item_field = 'status'
		and change_item_to = 11710 ) uat on
	dsi.issue_id = uat.issue_id
	and dsi.date = uat.log_date /* this code is for due date change */
left join (
	select
		issue_id, cast(change_created as Date) as log_date
	from
		master_change_log
	where
		change_item_field = 'duedate' ) duedate_change on
	dsi.issue_id = duedate_change.issue_id
	and dsi.date = duedate_change.log_date ;


Create or Replace view `Build_CardData` as (
select
	mi.project_id as kpi_project_id,
	interim.*
from
	(/* code for sprint status */
	select
		s1.sprint_id as kpi_sprint_id,
		s1.TrackerChange,
		'Sprint Status' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Status' as kpi_title1,
		case
			when (s1.remaining_effort / s1.ideal_burndown) <= 0.9 then 'green'
			when (s1.remaining_effort / s1.ideal_burndown) >0.9
			and (s1.remaining_effort / s1.ideal_burndown) <= 1.1 then 'yellow'
			when (s1.remaining_effort / s1.ideal_burndown) > 1.1 then 'red'
		end as kpi_value1 ,
		'Change' as kpi_title2 ,
		COALESCE((s1.remaining_effort / s1.ideal_burndown), 0) - COALESCE((s2.remaining_effort / s2.ideal_burndown), 0) as kpi_value2,
		'Grey' as kpi_group,
		1 as kpi_order,
		'No' as kpi_click,
		"test" as kpi_icon
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
		day_count -1 as kpi_title2,
		'Grey' as kpi_group,
		2 as kpi_order,
		'No' as kpi_click,
		"test" as kpi_icon
	from
		summary_story_view_base_table /* code for New Scope */
UNION
	Select
		XX.sprint_id as kpi_sprint_id,
		CONCAT('Day ', XX.day_count ) as 'TrackerChange',
		'New Scope' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Total' as kpi_title1,
		XX.new_scope as kpi_value1,
		'Change' as kpi_title2,
		case
			when XX.new_scope - COALESCE(YY.new_scope,
			0) = 0 then 0
			when XX.new_scope - COALESCE(YY.new_scope,
			0) > 0 then 1
			when XX.new_scope - COALESCE(YY.new_scope,
			0) < 0 then -1
		end as kpi_title2,
		'Orange' as kpi_group,
		4 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
	from
		(
		select
			ssvbt.*,
			COALESCE(change_count, 0) as new_scope
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				new_scope_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) XX
	LEFT JOIN (
		select
			ssvbt.*,
			COALESCE(change_count, 0) as new_scope
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				new_scope_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) YY on
		XX.sprint_id = YY.sprint_id
		and XX.day_count - 1 = YY.day_count /* code for  Scope removed */
UNION
	Select
		XX.sprint_id as kpi_sprint_id,
		CONCAT('Day ', XX.day_count ) as 'TrackerChange',
		'Scope Removed' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Total' as kpi_title1,
		XX.scope_change as kpi_value1,
		'Change' as kpi_title2,
		case
			when XX.scope_change - COALESCE(YY.scope_change,
			0) = 0 then 0
			when XX.scope_change - COALESCE(YY.scope_change,
			0) > 0 then 1
			when XX.scope_change - COALESCE(YY.scope_change,
			0) < 0 then -1
		end as kpi_title2,
		'Orange' as kpi_group,
		5 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
	from
		(
		select
			ssvbt.*,
			COALESCE(change_count, 0) as scope_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				scope_removed_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) XX
	LEFT JOIN (
		select
			ssvbt.*,
			COALESCE(change_count, 0) as scope_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				scope_removed_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) YY on
		XX.sprint_id = YY.sprint_id
		and XX.day_count - 1 = YY.day_count /* code for esitmate change */
UNION
	Select
		XX.sprint_id as kpi_sprint_id,
		CONCAT('Day ', XX.day_count ) as 'TrackerChange',
		'Estimate Changed' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Total' as kpi_title1,
		XX.time_change as kpi_value1,
		'Change' as kpi_title2,
		case
			when XX.time_change - COALESCE(YY.time_change,
			0) = 0 then 0
			when XX.time_change - COALESCE(YY.time_change,
			0) > 0 then 1
			when XX.time_change - COALESCE(YY.time_change,
			0) < 0 then -1
		end as kpi_title2,
		'Orange' as kpi_group,
		6 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
	from
		(
		select
			ssvbt.*,
			COALESCE(change_count, 0) as time_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				estimate_changed_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) XX
	LEFT JOIN (
		select
			ssvbt.*,
			COALESCE(change_count, 0) as time_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				estimate_changed_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) YY on
		XX.sprint_id = YY.sprint_id
		and XX.day_count - 1 = YY.day_count /* code for assignee change */
UNION
	Select
		XX.sprint_id as kpi_sprint_id,
		CONCAT('Day ', XX.day_count ) as 'TrackerChange',
		'Assignee Change' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Total' as kpi_title1,
		XX.assignee_change as kpi_value1,
		'Change' as kpi_title2,
		case
			when XX.assignee_change - COALESCE(YY.assignee_change,
			0) = 0 then 0
			when XX.assignee_change - COALESCE(YY.assignee_change,
			0) > 0 then 1
			when XX.assignee_change - COALESCE(YY.assignee_change,
			0) < 0 then -1
		end as kpi_title2,
		'Orange' as kpi_group,
		7 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
	from
		(
		select
			ssvbt.*,
			COALESCE(change_count, 0) as assignee_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				assignee_change_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) XX
	LEFT JOIN (
		select
			ssvbt.*,
			COALESCE(change_count, 0) as assignee_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				assignee_change_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) YY on
		XX.sprint_id = YY.sprint_id
		and XX.day_count - 1 = YY.day_count /* code for Ready for testing */
UNION
	Select
		XX.sprint_id as kpi_sprint_id,
		CONCAT('Day ', XX.day_count ) as 'TrackerChange',
		'Ready for Testing' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Total' as kpi_title1,
		XX.uat_change as kpi_value1,
		'Change' as kpi_title2,
		case
			when XX.uat_change - COALESCE(YY.uat_change,
			0) = 0 then 0
			when XX.uat_change - COALESCE(YY.uat_change,
			0) > 0 then 1
			when XX.uat_change - COALESCE(YY.uat_change,
			0) < 0 then -1
		end as kpi_title2,
		'Orange' as kpi_group,
		8 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
	from
		(
		select
			ssvbt.*,
			COALESCE(change_count, 0) as uat_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				ready_for_testing_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) XX
	LEFT JOIN (
		select
			ssvbt.*,
			COALESCE(change_count, 0) as uat_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				ready_for_testing_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) YY on
		XX.sprint_id = YY.sprint_id
		and XX.day_count - 1 = YY.day_count /* code for Due date change */
UNION
	Select
		XX.sprint_id as kpi_sprint_id,
		CONCAT('Day ', XX.day_count ) as 'TrackerChange',
		'Due Date Change' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Total' as kpi_title1,
		XX.due_change as kpi_value1,
		'Change' as kpi_title2,
		case
			when XX.due_change - COALESCE(YY.due_change,
			0) = 0 then 0
			when XX.due_change - COALESCE(YY.due_change,
			0) > 0 then 1
			when XX.due_change - COALESCE(YY.due_change,
			0) < 0 then -1
		end as kpi_title2,
		'Orange' as kpi_group,
		9 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
	from
		(
		select
			ssvbt.*,
			COALESCE(change_count, 0) as due_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				duedate_change_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) XX
	LEFT JOIN (
		select
			ssvbt.*,
			COALESCE(change_count, 0) as due_change
		from
			summary_story_view_base_table ssvbt
		left join (
			select
				sprint_id,
				REPLACE(TrackChange, "Day ", '') as day_count,
				count(distinct issue_id) as change_count
			from
				card_data_intermediate
			where
				duedate_change_flag = 'y'
			group by
				1,
				2) X on
			ssvbt.sprint_id = X.sprint_id
			and ssvbt.day_count = X.day_count ) YY on
		XX.sprint_id = YY.sprint_id
		and XX.day_count - 1 = YY.day_count /* the following code is for the pie chart in the front end data */
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
		'' kpi_value,
		'Chart' as kpi_group,
		0 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
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
			left join master_issue mi on
				isd.issue_id = mi.issue_id
			where
				datediff( mi.due_date, ssvbt.date) = 1
			group by
				1,
				2 ) XX on
			ssvbt.sprint_id = XX.sprint_id
			and ssvbt.date = XX.change_date) YY /* Issues due today */
UNION
	Select
		YY.sprint_id as kpi_sprint_id,
		CONCAT('Day ', YY.day_count ) as 'TrackerChange',
		'Due Date Summary' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Issue Due Today' as kpi_title1,
		COALESCE(YY.due_today, 0) as kpi_value1,
		'' as kpi_title2,
		'' kpi_value,
		'Chart' as kpi_group,
		0 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
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
			left join master_issue mi on
				isd.issue_id = mi.issue_id
			where
				datediff( mi.due_date, ssvbt.date) = 0
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
		'' kpi_value,
		'Chart' as kpi_group,
		0 as kpi_order,
		'yes' as kpi_click,
		"test" as kpi_icon
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
			left join master_issue mi on
				isd.issue_id = mi.issue_id
			left join daily_status_intermediate dsi on
				isd.issue_id = dsi.issue_id
				and ssvbt.date = dsi.date
			where
				datediff( mi.due_date, ssvbt.date) < 0
				and status_end_day not in (10205)
			group by
				1,
				2 ) XX on
			ssvbt.sprint_id = XX.sprint_id
			and ssvbt.date = XX.change_date ) YY /* the below code is for the Resource Summary view in the frontend - the data is not available hence the dummy sql query below, but this has to be replaced 
 * when Haley provides the data */
UNION
	Select
		mi.sprint_id as kpi_sprint_id,
		'' as TrackerChange,
		'Resource Summary' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Over Capacity' as kpi_title1,
		2 as kpi_value1,
		'' as kpi_title2,
		'' kpi_value,
		'Chart' as kpi_group,
		0 as kpi_order,
		'No' as kpi_click,
		"test" as kpi_icon
	from
		master_issue mi
UNION
	#------------------------------------- the below is for Resource  --------------------------__# 
	Select
		mi.sprint_id as kpi_sprint_id,
		'' as TrackerChange,
		'Resource Summary' as kpi_name,
		'Build Dashboard' as kpi_dashboard,
		'Available Capacity' as kpi_title1,
		3 as kpi_value1,
		'' as kpi_title2,
		'' kpi_value,
		'Chart' as kpi_group,
		0 as kpi_order,
		'No' as kpi_click,
		"test" as kpi_icon
	from
		master_issue mi ) interim
LEFT JOIN (
	select
		DISTINCT sprint_id,
		project_id
	from
		master_issue ) mi on
	interim.kpi_sprint_id = mi.sprint_id ) ;
/* code ends */ 

/* code begins */ 

CREATE OR REPLACE
ALGORITHM = UNDEFINED VIEW `jira_comal`.`Requirement_MainTableView` AS
select
    `eps`.`project_id` AS `project_id`,
    `mi`.`issue_key` AS `issue_key`,
    `mi`.`issue_type_id` AS `issue_type_id`,
    `mit`.`issue_type_name` AS `issue_type_name`,
    `mi`.`summary` AS `summary`,
    `mi`.`epic_name` AS `epic_name`,
    (case
        when (coalesce(`epic_name`.`epic_name_text`,
        `mi`.`epic_name_text`) = '') then concat(`mi`.`project_id`, '-Unassigned')
        else coalesce(`epic_name`.`epic_name_text`,
        `mi`.`epic_name_text`) end) AS `epic_name_text`,
    `ms`.`status_name` AS `status`,
    (case
        when (`eps`.`status_end_day`  in (10000, 3, 11708, 11709, 11710, 10205, 10403) ) then 'y'
        else 'n' end) AS `to_do_filter`,
    (case
        when (`eps`.`status_end_day` = 10104) then 'y'
        else 'n' end) AS `blocked_filter`,
    (case
        when (`new_stories`.`created_date` is not null) then 'y'
        else 'n' end) AS `new_stories_filter`,
    `org_time`.`original_hours` AS `original_hours`,
    `org_time`.`new_time` AS `new_hours`,
    (`org_time`.`original_hours` - `org_time`.`new_time`) AS `change_hours`,
    `mua`.`display_name` AS `user_name`,
    `mi`.`priority_name` AS `priority_name`,
    concat('Day ', `eps`.`day_count`) AS `trackchange`,
    'Y' AS `New_Filter`,
    'Need to add table' AS `lastupdate`,
    'Need to add table' AS `nextupdate`
from
    (((((((`jira_comal`.`epic_issue_daily_status_intermediate` `eps`
left join `jira_comal`.`master_issue` `mi` on
    ((`eps`.`issue_id` = `mi`.`issue_id`)))
left join (
    select
        distinct `jira_comal`.`master_issue`.`issue_key` AS `issue_key`,
        `jira_comal`.`master_issue`.`epic_name_text` AS `epic_name_text`
    from
        `jira_comal`.`master_issue`
    where
        (`jira_comal`.`master_issue`.`epic_name_text` <> '')) `epic_name` on
    ((`mi`.`epic_name` = `epic_name`.`issue_key`)))
left join `jira_comal`.`master_status` `ms` on
    ((`eps`.`status_end_day` = `ms`.`status_id`)))
left join (
    select
        `jira_comal`.`master_issue`.`issue_id` AS `issue_id`,
        cast(`jira_comal`.`master_issue`.`created` as date) AS `created_date`
    from
        `jira_comal`.`master_issue`) `new_stories` on
    (((`eps`.`issue_id` = `new_stories`.`issue_id`)
    and (`eps`.`dt` = `new_stories`.`created_date`))))
left join (
    select
        `X`.`issue_id` AS `issue_id`,
        `X`.`day_count` AS `day_count`,
        coalesce((sum(`X`.`original`) / 3600),
        0) AS `original_hours`,
        (sum(coalesce(`X`.`new_time`, `X`.`original`, 0)) / 3600) AS `new_time`
    from
        (
        select
            `es`.`project_id` AS `project_id`,
            `es`.`epic_name` AS `epic_name`,
            `es`.`epic_start_date` AS `epic_start_date`,
            `es`.`epic_end_date` AS `epic_end_date`,
            `es`.`dt` AS `dt`,
            `es`.`day_count` AS `day_count`,
            `es`.`issue_id` AS `issue_id`,
            `es`.`status_end_day` AS `status_end_day`,
            `original_time`.`original` AS `original`,
            `new_time`.`changed_date` AS `changed_date`,
            `new_time`.`new_time` AS `new_time`,
            rank() OVER (PARTITION BY `es`.`issue_id`,
            `es`.`day_count`
        ORDER BY
            `new_time`.`changed_date` desc ) AS `row_rank`
        from
            ((`jira_comal`.`epic_issue_daily_status_intermediate` `es`
        left join (
            select
                `mi`.`project_id` AS `project_id`,
                `mi`.`issue_id` AS `issue_id`,
                (case
                    when (`mi`.`epic_name` is null) then concat(`mi`.`project_id`, '-Unassigned')
                    else `mi`.`epic_name` end) AS `epic_name`,
                cast(`mi`.`created` as date) AS `created_date`,
                coalesce(`mcl`.`change_item_to`,
                `mi`.`time_original_estimate`,
                0) AS `original`
            from
                (`jira_comal`.`master_issue` `mi`
            left join (
                select
                    `t`.`issue_id` AS `issue_id`,
                    `t`.`change_created` AS `change_created`,
                    `t`.`change_item_to` AS `change_item_to`,
                    `t`.`rank_1` AS `rank_1`
                from
                    (
                    select
                        `jira_comal`.`master_change_log`.`issue_id` AS `issue_id`,
                        `jira_comal`.`master_change_log`.`change_created` AS `change_created`,
                        `jira_comal`.`master_change_log`.`change_item_to` AS `change_item_to`,
                        rank() OVER (PARTITION BY `jira_comal`.`master_change_log`.`issue_id`
                    ORDER BY
                        `jira_comal`.`master_change_log`.`change_created` ) AS `rank_1`
                    from
                        `jira_comal`.`master_change_log`
                    where
                        (`jira_comal`.`master_change_log`.`change_item_field` = 'timeoriginalestimate')) `t`
                where
                    (`t`.`rank_1` = 1)) `mcl` on
                ((`mi`.`issue_id` = `mcl`.`issue_id`)))) `original_time` on
            ((`es`.`issue_id` = `original_time`.`issue_id`)))
        left join (
            select
                `mi`.`project_id` AS `project_id`,
                `mi`.`issue_id` AS `issue_id`,
                `mi`.`epic_name` AS `epic_name`,
                cast(`mcl`.`change_created` as date) AS `changed_date`,
                `mcl`.`change_item_to` AS `new_time`
            from
                (`jira_comal`.`master_issue` `mi`
            left join (
                select
                    `t`.`issue_id` AS `issue_id`,
                    `t`.`change_created` AS `change_created`,
                    `t`.`change_item_to` AS `change_item_to`,
                    `t`.`rank_1` AS `rank_1`
                from
                    (
                    select
                        `jira_comal`.`master_change_log`.`issue_id` AS `issue_id`,
                        `jira_comal`.`master_change_log`.`change_created` AS `change_created`,
                        `jira_comal`.`master_change_log`.`change_item_to` AS `change_item_to`,
                        rank() OVER (PARTITION BY `jira_comal`.`master_change_log`.`issue_id`
                    ORDER BY
                        `jira_comal`.`master_change_log`.`change_created` desc ) AS `rank_1`
                    from
                        `jira_comal`.`master_change_log`
                    where
                        (`jira_comal`.`master_change_log`.`change_item_field` = 'timeoriginalestimate')) `t`
                where
                    (`t`.`rank_1` = 1)) `mcl` on
                ((`mi`.`issue_id` = `mcl`.`issue_id`)))) `new_time` on
            ((`es`.`issue_id` = `new_time`.`issue_id`)))) `X`
    where
        (`X`.`row_rank` = 1)
    group by
        `X`.`issue_id`,
        `X`.`day_count`) `org_time` on
    (((`eps`.`issue_id` = `org_time`.`issue_id`)
    and (`eps`.`day_count` = `org_time`.`day_count`))))
left join `jira_comal`.`master_user_account` `mua` on
    ((`mi`.`assignee_account_id` = `mua`.`account_id`)))
left join `jira_comal`.`master_issue_type` `mit` on
    ((`mi`.`issue_type_id` = `mit`.`issue_type_id`)))
where
    (`eps`.`issue_id` is not null);


Drop table if exists live_date ; 
Create table live_date as 
(
		select dt
		from (
				select dt,
					RANK() over(
						order by dt desc
					) as row_rank
				from calendar_table
				where dt <= CURDATE()
					and isWeekday = 1
				ORDER by dt desc
			) X
		where row_rank = 1
	);
	

Drop TABLE if exists yest_date ; 
create table yest_date as 
(
		select dt
		from (
				select dt,
					RANK() over(
						order by dt desc
					) as row_rank
				from calendar_table
				where dt <= CURDATE()
					and isWeekday = 1
				ORDER by dt desc
			) X
		where row_rank = 2
	);

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
		COALESCE(Sum(case when dt = (select dt from live_date) then groomed_issues else 0 end ) / NULLIF(Sum(case when dt = (select dt from live_date) then issues else 0 end ),0),0) as groomed_perc_today ,
		COALESCE(Sum(case when dt = (select dt from yest_date) then groomed_issues else 0 end ) / NULLIF(Sum(case when dt = (select dt from yest_date) then issues else 0 end ),0),0) as groomed_perc_yesterday ,
		Sum(case when dt = (select dt from live_date) then issues else 0 end ) as total_stories_today ,
		Sum(case when dt = (select dt from yest_date) then issues else 0 end ) as total_stories_yesterday,
		count(distinct case when dt = (select dt from live_date) and ( (groomed_issues / NULLIF(issues,0)) < 0.3 OR COALESCE(new_estimate / Nullif(original_estimate, 0), 0) > 1 ) then epic_name end ) as epics_at_risk_today,
		count(distinct case when dt = (select dt from yest_date) and ( (groomed_issues / NULLIF(issues,0)) < 0.3 OR COALESCE(new_estimate / Nullif(original_estimate, 0), 0) > 1 ) then epic_name end ) as epics_at_risk_yesterday,
		sum(distinct case when dt = (select dt from live_date) and epic_name LIKE '%%Unassigned%%' then issues else 0 end ) as unassigned_stories_today,
		sum(distinct case when dt = (select dt from yest_date) and epic_name LIKE '%%Unassigned%%' then issues else 0 end ) as unassigned_stories_yesterday,
		sum(case when dt = (select dt from live_date) then original_estimate else 0 end)/ 3600 as original_estimate,
		sum(case when dt = (select dt from live_date) then new_estimate else 0 end )/ 3600 as new_estimate
	from
		(
		select
			project_id,
			case
				when epic_name is null then Concat(project_id, '-Unassigned')
				else epic_name
			end as epic_name,
			dt,
			count(distinct base_data.issue_id) as issues ,
			count(distinct case when status_end_day  IN (10000, 3, 11708, 11709, 11710, 10205, 10403) then base_data.issue_id end ) as groomed_issues ,
			sum(original_hours) as original_estimate,
			sum(new_time) as new_estimate
		from
			(
			select
				project_id,
				dt,
				issue_id,
				status_end_day ,
				COALESCE(original, 0) as original_hours,
				COALESCE(new_time, 0) as new_time
			from
				(
				select
					es.*,
					original_time.original,
					new_time.changed_date,
					new_time.new_time,
					RANK() OVER(PARTITION BY es.issue_id,
					es.day_count
				ORDER BY
					changed_date desc) as row_rank
				from
					project_issue_daily_status_intermediate es
				left join (
					select
						mi.project_id,
						mi.issue_id,
						cast(created as date) as created_date,
						COALESCE(mcl.change_item_to, mi.time_original_estimate, 0) as original
					from
						master_issue mi
					left join (
						select
							*
						from
							(
							select
								issue_id,
								change_created ,
								change_item_to,
								Rank() over(PARTITION BY issue_id
							order by
								change_created) as rank_1
							from
								master_change_log
							where
								change_item_field = 'timeoriginalestimate' ) t
						where
							rank_1 = 1 ) mcl on
						mi.issue_id = mcl.issue_id )original_time on
					es.issue_id = original_time.issue_id
				LEFT JOIN (
					#----- Now code for New Estimate 
					select
						mi.project_id,
						mi.issue_id,
						mi.epic_name,
						cast(mcl.change_created as date ) as changed_date,
						mcl.change_item_to as new_time
					from
						master_issue mi
					left join (
						select
							*
						from
							(
							select
								issue_id,
								change_created ,
								change_item_to,
								Rank() over(PARTITION BY issue_id
							order by
								change_created DESC) as rank_1
							from
								master_change_log
							where
								change_item_field = 'timeoriginalestimate' ) t
						where
							rank_1 = 1 ) mcl on
						mi.issue_id = mcl.issue_id ) new_time on
					es.issue_id = new_time.issue_id ) X
			where
				row_rank = 1
				and dt in ((select dt from live_date),
				(select dt from yest_date)) ) base_data
		left join (
			select
				issue_id,
				epic_name
			from
				master_issue) mmi on
			base_data.issue_id = mmi.issue_id
		group by
			1,
			2,
			3 ) agg_table
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
			and Cast(created as Date ) IN ((select dt from live_date),
			(select dt from yest_date))
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
			cast(change_created as Date ) in ((select dt from live_date),
			(select dt from yest_date))
			and change_item_field not in ('link',
			'feature link')
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
		project_start_date < (select dt from live_date)
		and project_end_date >= (select dt from live_date))