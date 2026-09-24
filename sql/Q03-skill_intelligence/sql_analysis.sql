WITH skills_count AS (
    SELECT skills as skill_name,
        COUNT(DISTINCT job_id) as vagas
    FROM skills_job_dim
        INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY skills
    ORDER BY COUNT(DISTINCT job_id) DESC
    LIMIT 10
)
SELECT skills_count.skill_name,
    skills_count.vagas,
    ROUND(
        skills_count.vagas * 100.0 / (
            SELECT COUNT(DISTINCT job_id)
            FROM job_postings_fact
        ),
        2
    ) AS percentage_vagas,
    RANK() OVER (
        ORDER BY skills_count.vagas DESC
    ) as rank
FROM skills_count ---------------------------------------------
    WITH skills_count AS (
        SELECT skills as skill_name,
            COUNT(DISTINCT job_id) as vagas
        FROM skills_job_dim
            INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        GROUP BY skills
    ),
    skills_percentage AS (
        SELECT skill_name,
            vagas,
            ROUND(
                vagas * 100.0 / (
                    SELECT COUNT(DISTINCT job_id)
                    FROM job_postings_fact
                ),
                2
            ) AS percentage_vagas
        FROM skills_count
    )
SELECT RANK() OVER (
        ORDER BY vagas DESC
    ) as rank,
    skill_name,
    vagas,
    percentage_vagas,
    SUM(percentage_vagas) OVER (
        ORDER BY vagas DESC
    ) as cumulative_percentage
FROM skills_percentage ---------------------------------------------
    ------------------------------------
    WITH relation_count AS (
        SELECT type as categoria,
            COUNT(DISTINCT skills_job_dim.skill_id) as categoria_skills,
            COUNT(DISTINCT skills_job_dim.job_id) as categoria_postings,
            COUNT(*) as total_relation
        FROM skills_job_dim
            INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        GROUP BY type
    ),
    relative_percentage AS (
        SELECT categoria,
            categoria_skills,
            categoria_postings,
            total_relation,
            ROUND(
                categoria_postings * 100.0 / (
                    SELECT COUNT(DISTINCT job_id)
                    FROM job_postings_fact
                ),
                2
            ) AS postings_percentage,
            ROUND(
                total_relation * 100.0 / (
                    SELECT COUNT(*)
                    FROM skills_job_dim
                ),
                2
            ) AS relative_percentage
        FROM relation_count
    )
SELECT categoria,
    categoria_skills,
    categoria_postings,
    postings_percentage,
    total_relation,
    relative_percentage.relative_percentage
FROM relative_percentage
ORDER BY total_relation DESC