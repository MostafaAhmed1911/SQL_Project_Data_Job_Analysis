# Introduction
This project focuses on analyzing the data job market using SQL to uncover insights about job opportunities, salaries, and in-demand skills.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
This project aims to answer five key questions:

1. **What are the top-paying data analyst jobs?**
2. **What skills are required for the top-paying data analyst jobs?**
3. **What are the most in-demand skills for data analysts?**
4. **What are the top skills based on salary?**
5. **What are the most optimal skills to learn (high demand + high salary)?**

By answering these questions, this analysis provides insights into the current data analyst job market and helps identify skills that can maximize career opportunities.

The dataset used comes from [Luke Barousse's SQL Course](https://www.lukebarousse.com/sql)

# Tools I Used
- **PostgreSQL:** Used PostgreSQL as the database management system to store, query, and analyze data.

- **Visual Studio Code:**: Used VS Code as the development environment to write SQL queries, organize project files, and document the analysis workflow.

- **Git & GitHub:** Used Git for version control and GitHub to track project changes, manage the repository, and share the project publicly.

# The Analysis
## 1. What are the top-paying Data Analyst jobs?

### Objective

The goal of this analysis was to identify the highest-paying Data Analyst roles in 2023 and understand which companies and positions offer the highest compensation.

I filtered Data Analyst job postings with available salary information and focused on remote opportunities to identify the top-paying roles.

### SQL Query

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

### Results

| Job Title | Company | Salary |
|---|---|---:|
| Data Analyst | Mantys | $650,000 |
| Director of Analytics | Meta | $336,500 |
| Associate Director - Data Insights | AT&T | $255,830 |
| Data Analyst, Marketing | Pinterest Job Advertisements | $232,423 |
| Data Analyst (Hybrid/Remote) | UCLA Health Careers | $217,000 |
| Principal Data Analyst (Remote) | SmartAsset | $205,000 |
| Director, Data Analyst - Hybrid | Inclusively | $189,309 |
| Principal Data Analyst, AV Performance Analysis | Motional | $189,000 |
| Principal Data Analyst | SmartAsset | $186,000 |
| ERM Data Analyst | Get It Recruit - Information Technology | $184,000 |

### Key Insights

- The highest-paying Data Analyst role in this dataset reached **$650K/year**, significantly higher than the rest of the positions.
- Leadership and senior-level positions appear frequently among the highest-paying roles, including:
  - Director of Analytics
  - Associate Director of Data Insights
  - Principal Data Analyst
- Companies offering the highest salaries include large organizations such as **Meta, AT&T, Pinterest, and UCLA Health**.
- Although the title "Data Analyst" appears in the highest-paying role, the overall trend shows that advanced experience, leadership responsibilities, and specialized analytical skills contribute significantly to compensation.

### Visualization

![Top Paying Data Analyst Jobs 2023](assets\top_paying_data_analyst_jobs_2023.png)
*Figure 1: Top 10 highest-paying Data Analyst jobs in 2023 based on average yearly salary.*

## 2. What skills are required for the top-paying Data Analyst jobs?

### Objective

After identifying the highest-paying Data Analyst jobs in 2023, the next step was to analyze the skills required for these positions.

The goal of this analysis was to understand which technical skills are commonly requested in high-paying Data Analyst roles and identify the skill combinations that help professionals succeed in these opportunities.

---

### SQL Query

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    skills,
    COUNT(skills) AS skill_count
FROM
    top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    skills
ORDER BY
    skill_count DESC;
```

---

### Results

The analysis identified the most common skills required among the top-paying Data Analyst jobs:

| Skill | Number of Jobs |
|---|---:|
| SQL | 8 |
| Python | 7 |
| Tableau | 6 |
| R | 4 |
| Excel | 3 |
| Pandas | 3 |
| Snowflake | 3 |
| AWS | 2 |
| Azure | 2 |
| Power BI | 2 |

---

### Key Insights

- **SQL is the most consistent skill among high-paying Data Analyst roles**, appearing in almost every top-paying position.
- **Python is highly demanded**, showing that programming and automation skills are becoming increasingly important for Data Analysts.
- **Tableau remains a key visualization skill**, highlighting the importance of communicating insights effectively.
- High-paying Data Analyst positions require skills beyond traditional analytics, including:
  - Cloud platforms such as AWS and Azure
  - Data warehouses such as Snowflake
  - Data processing tools such as Pandas, PySpark, and Databricks

The results show that high-paying Data Analyst roles are becoming more technical, combining:

```
SQL
+
Python
+
Visualization
+
Cloud & Data Engineering Skills
```

---

### Visualization

![Skills Required for Top Paying Data Analyst Jobs](assets\top_paying_job_skills.png)

*Figure 2: Most common skills required for the top-paying Data Analyst jobs in 2023.*

---

## 3. What are the most in-demand skills for Data Analysts?

### Objective

The goal of this analysis was to identify the most frequently requested skills across Data Analyst job postings in 2023.

Unlike the previous analysis, which focused on skills associated with top-paying roles, this analysis looks at overall market demand to understand which skills employers request most often.

---

### SQL Query

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

---

### Results

The analysis identified the top 5 most in-demand skills for Data Analyst roles:

| Skill | Number of Job Postings |
|---|---:|
| SQL | 7,291 |
| Excel | 4,611 |
| Python | 4,330 |
| Tableau | 3,745 |
| Power BI | 2,609 |

---

### Key Insights

- **SQL is the most requested skill by a large margin**, appearing in 7,291 Data Analyst job postings, making it the core requirement across the market.
- **Excel remains highly valuable**, showing that spreadsheet analysis and business reporting continue to be important despite the growth of programming tools.
- **Python ranks among the top skills**, reflecting the increasing demand for automation, data manipulation, and advanced analysis capabilities.
- **Business Intelligence tools are essential**, with Tableau and Power BI showing strong demand for data visualization and reporting.

The most common skill foundation for Data Analyst roles is:

```
SQL
+
Excel
+
Python
+
BI Tools
```

---

## 4. What are the top skills based on salary?

### Objective

The goal of this analysis was to identify which skills are associated with the highest average salaries for Data Analyst roles in 2023.

By comparing average salaries across different skills, I aimed to understand which technical skills provide the highest earning potential in the data job market.

---

### SQL Query

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25;
```

---

### Results

The analysis identified the skills with the highest average salaries among Data Analyst roles:

| Skill | Average Salary |
|---|---:|
| SVN | $400,000 |
| Solidity | $179,000 |
| Couchbase | $160,515 |
| DataRobot | $155,486 |
| Golang | $155,000 |
| MXNet | $149,000 |
| dplyr | $147,633 |
| VMware | $147,500 |
| Terraform | $146,734 |
| Twilio | $138,500 |

---

### Key Insights

- The highest-paying skills are mainly specialized technologies rather than the most commonly requested Data Analyst skills.
- Many high-salary skills are connected to:
  - **Machine Learning and AI** (DataRobot, MXNet, PyTorch, TensorFlow, Hugging Face)
  - **Cloud and Infrastructure** (Terraform, VMware, Ansible, Puppet)
  - **Data Engineering** (Kafka, Cassandra, Airflow, Scala)
  - **Software Development** (Golang, Solidity)

- The results suggest that higher salaries are often associated with skills that require deeper technical expertise and overlap with software engineering, data engineering, and machine learning.

---

### Key Takeaway

While skills such as SQL, Excel, and Tableau are essential for entering the Data Analyst field, higher-paying opportunities often involve additional technical skills in:

```
Machine Learning
+
Cloud Infrastructure
+
Data Engineering
+
Software Development
```
## 5. What are the most optimal skills to learn?

### Objective

The goal of this analysis was to identify the most valuable skills for Data Analysts by finding the intersection between **high demand** and **high salary potential**.

A skill is considered optimal when it appears frequently in job postings while also being associated with competitive salaries.

---

### SQL Query

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        skills_dim
    INNER JOIN skills_job_dim
        ON skills_dim.skill_id = skills_job_dim.skill_id
    INNER JOIN job_postings_fact
        ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_title_short = 'Data Analyst'
    GROUP BY
        skills_dim.skill_id,
        skills
),

skills_salary AS (
    SELECT
        skills_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM
        skills_dim
    INNER JOIN skills_job_dim
        ON skills_dim.skill_id = skills_job_dim.skill_id
    INNER JOIN job_postings_fact
        ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id,
        skills
)

SELECT
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN skills_salary
    ON skills_demand.skill_id = skills_salary.skill_id
WHERE
    demand_count > 100
ORDER BY
    average_salary DESC,
    demand_count DESC;
```

---

### Results

The analysis identified skills that provide a strong balance between demand and salary potential among remote Data Analyst roles in 2023.

| Skill | Demand Count | Average Salary |
|---|---:|---:|
| Python | 236 | $101,397 |
| Tableau | 230 | $99,288 |
| R | 148 | $100,499 |
| SAS | 63 | $98,902 |
| Looker | 49 | $103,795 |
| Snowflake | 37 | $112,948 |
| Oracle | 37 | $104,534 |
| SQL Server | 35 | $97,786 |
| Azure | 34 | $111,225 |
| AWS | 32 | $108,317 |
| Go | 27 | $115,320 |
| Hadoop | 22 | $113,193 |

### Key Insights

1. Python and Tableau provide the strongest balance between demand and salary, appearing in over 200 job postings with average salaries around $100K.

2. R remains a valuable analytical skill, with 148 job postings and an average salary of $100,499.

3. Cloud technologies such as Snowflake, Azure, and AWS show strong salary potential, with average salaries above $108K despite lower demand compared to Python and Tableau.

4. Specialized technologies such as Go and Hadoop have higher average salaries ($115,320 and $113,193 respectively), but they appear in fewer job postings, making them more niche skills.

5. The most optimal learning path is to combine highly demanded analytical skills with specialized technologies that increase salary potential.

### Key Takeaway

The analysis suggests that the best strategy for aspiring Data Analysts is to build a strong analytical foundation first, then expand into modern data technologies.

A balanced skill path would be:

1. SQL → Data extraction and querying
2. Excel + BI Tools → Reporting and visualization
3. Python → Automation and advanced analysis
4. Cloud/Data Platforms → Higher-level analytics capabilities

# What I Learned
Through this project, I strengthened my SQL skills and developed a better understanding of how to approach real-world data analysis problems.

- **SQL & Query Building** - I improved my ability to write SQL queries to answer business questions by using JOINs, aggregations, GROUP BY, CTEs, subqueries, ORDER BY, and LIMIT to extract meaningful insights from data.

- **Analytical Thinking** - I learned how to break down broad business questions into smaller analytical steps and identify the data needed to answer each question.

- **Problem Solving** - I strengthened my ability to approach data problems systematically by translating questions into SQL solutions, analyzing results, and generating insights from the data.
# Conclusions

### Insights

1. **Top-paying Data Analyst Jobs:** The highest-paying roles were mainly senior and specialized positions, showing that experience, leadership responsibilities, and advanced technical skills have a strong impact on salary potential.

2. **Skills Required for Top-Paying Jobs:** High-paying Data Analyst roles commonly require a combination of SQL, Python, visualization tools, and modern data technologies such as cloud platforms and data engineering tools.

3. **Most In-Demand Skills:** SQL was the most requested skill across Data Analyst job postings, followed by Excel, Python, Tableau, and Power BI, highlighting the importance of strong analytical and reporting foundations.

4. **Top Skills Based on Salary:** The highest-paying skills were often related to specialized areas such as machine learning, cloud infrastructure, data engineering, and software development.

5. **Most Optimal Skills to Learn:** The best skills to learn are those that balance high demand with strong salary potential, with SQL, Python, BI tools, and cloud technologies providing strong career value.

### Closing Thoughts

This project provided a deeper understanding of the 2023 Data Analyst job market and demonstrated how SQL can be used to answer real-world business questions.

By analyzing job postings, salaries, and skill requirements, I learned how data can reveal valuable patterns and support better decision-making. This project strengthened my SQL, analytical thinking, and problem-solving skills while giving me a clearer understanding of the skills needed to succeed in the Data Analytics field.