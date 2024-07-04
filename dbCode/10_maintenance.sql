update master_issue
set epic_name_text = (
		select summary
		from (
				select issue_key,
					summary
				from master_issue
				where issue_type_id = '10000'
			) epic
		where master_issue.epic_name = epic.issue_key
	);
commit;
select issue_key,
	epic_name_text
from master_issue;