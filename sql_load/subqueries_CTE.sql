SELECT *
FROM( -- subqeury starts here
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    )AS january_job;
-- subquery ends here
    

WITH january_jobs AS ( -- CTE starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) -- CTE ends here

SELECT *
FROM january_jobs; 

SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM 
        job_postings_fact
    WHERE 
        job_no_degree_mention = true
    ORDER BY company_id
    );


/*
Find the compannies that have the most job openings.
- Get the total num of job postings per company id (job_postings_fact)
- Retrun total num of jobs with company name (company_dim)
*/

WITH company_job_count AS(SELECT
    company_id,
    COUNT(*)
FROM
    job_postings_fact
GROUP BY
    company_id)

SELECT 
    company_dim.name AS compnay_name,
    company_job_count.count AS total_job_postings
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_job_postings DESC;



/*
Find the count of the num of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill Id, name, and count of posting requiring that skill
*/

WITH remote_job_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = True AND job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id 
ORDER BY skill_count DESC
LIMIT 5