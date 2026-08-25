/*
Question: What are the top skills based on salary?
- Look at the avg salary associated with each skill for Data Analyst postioins
- Focuses on roles with specified salaries, regardless of loccation
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg)) AS salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    salary DESC
LIMIT 25

/*
The salary trend shows a shift:

Traditional Data Analyst → Analytics Engineer → AI/Data Engineer

The biggest salary premiums come from skills that sit closer to:

AI/ML
Cloud infrastructure
Data pipelines
Software engineering

For someone targeting high-paying data roles, the strongest combination from this list would be:

Python + SQL + Cloud (AWS/Azure) + Airflow + Kafka/Snowflake + ML framework (PyTorch/TensorFlow).
*/