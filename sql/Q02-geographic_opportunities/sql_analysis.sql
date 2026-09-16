WITH job_count AS (
    SELECT job_location,
        COUNT(DISTINCT job_id) as vagas
    FROM job_postings_fact
    GROUP BY job_location
),
market_share AS (
    SELECT job_location,
        vagas,
        ROUND(vagas * 100.0 / SUM(vagas) OVER (), 2) AS mercado
    FROM job_count
)
SELECT job_location,
    vagas,
    mercado,
    RANK() OVER (
        ORDER BY vagas DESC
    ) AS job_rank,
    ROUND(
        SUM(mercado) OVER (
            ORDER BY vagas DESC
        ),
        2
    ) AS acumulado
FROM market_share ----------------------------------------------------------------
    WITH remoto AS (
        SELECT job_title_short,
            COUNT(DISTINCT job_id) AS total_job_postings,
            COUNT(
                DISTINCT CASE
                    WHEN job_work_from_home = TRUE THEN job_id
                END
            ) AS remote_job_postings
        FROM job_postings_fact
        GROUP BY job_title_short
    )
SELECT *,
    ROUND(
        remote_job_postings * 100.0 / total_job_postings,
        2
    ) AS remote_percentage
FROM remoto
ORDER BY remote_percentage DESC ----------------------------------------------------------------
    WITH anywhere AS (
        SELECT COUNT(
                DISTINCT CASE
                    WHEN job_work_from_home = TRUE THEN job_id
                END
            ) AS remote_true,
            COUNT(
                DISTINCT CASE
                    WHEN job_work_from_home = FALSE THEN job_id
                END
            ) AS non_false
        FROM job_postings_fact
        WHERE job_location = 'Anywhere'
    ),
    localizacao AS (
        SELECT COUNT(
                DISTINCT CASE
                    WHEN job_work_from_home = TRUE THEN job_id
                END
            ) AS remote_true,
            COUNT(
                DISTINCT CASE
                    WHEN job_work_from_home = FALSE THEN job_id
                END
            ) AS non_false
        FROM job_postings_fact
        WHERE job_location <> 'Anywhere'
            OR job_location IS NULL
    )
SELECT 'anywhere' AS grupo,
    a.remote_true,
    a.non_false
FROM anywhere AS a
UNION ALL
SELECT 'outras_localizacoes' AS grupo,
    l.remote_true,
    l.non_false
FROM localizacao AS l;