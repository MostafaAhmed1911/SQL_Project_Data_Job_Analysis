/* 
Find job postings from the first quarter that have a slary greater than $70k
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an avg yearly salary > $70k
*/


SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM(
    SELECT
        *
    FROM
        january_job

    UNION ALL

    SELECT
        *
    FROM
        february_job

    UNION ALL

    SELECT
        *
    FROM
        march_job
) AS quarter1_job_postings
WHERE
    quarter1_job_postings.salary_year_avg > 70000
    AND quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg DESC