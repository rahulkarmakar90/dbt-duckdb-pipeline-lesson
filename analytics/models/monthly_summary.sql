WITH totals as (
    SELECT month, sum(postings) as total_postings
    from {{ref('jobs_per_month')}}
    group by month
),
remote as (
    SELECT MONTHNAME(search_date) as month, 
    count(*) as remote_postings
    from {{ref('job_postings')}}
    where job_work_from_home = TRUE
    group by month
)
select month, total_postings, remote_postings, (remote_postings/total_postings) as remote_percentage
from totals
join remote using (month)
order by month