SELECT job_title_short,
    COUNT(DISTINCT job_id) AS total_job_postings
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY total_job_postings DESC;
--------------------
WITH vagas_de_cargos AS (
    SELECT job_title_short,
        COUNT(DISTINCT job_id) AS total_vagas_cargos
    FROM job_postings_fact
    GROUP BY job_title_short
),
total_de_vagas AS (
    SELECT SUM(total_vagas_cargos) AS total_vagas
    FROM vagas_de_cargos
)
SELECT job_title_short,
    total_vagas_cargos,
    ROUND ((total_vagas_cargos * 100.0 / total_vagas), 2) AS percentage_job_postings
FROM vagas_de_cargos,
    total_de_vagas
ORDER BY vagas_de_cargos.total_vagas_cargos DESC;
-----------------------
WITH vagas_de_cargos AS (
    SELECT job_title_short,
        COUNT(DISTINCT job_id) AS total_vagas_cargos
    FROM job_postings_fact
    GROUP BY job_title_short
),
total_de_vagas AS (
    SELECT job_title_short,
        total_vagas_cargos,
        total_vagas_cargos * 100.0 / SUM(total_vagas_cargos) OVER () AS distruicao_vagas
    FROM vagas_de_cargos
)
SELECT job_title_short,
    total_vagas_cargos,
    ROUND(distruicao_vagas, 2) AS distruicao_vagas,
    ROUND(
        SUM(distruicao_vagas) OVER (
            ORDER BY total_vagas_cargos DESC
        ),
        2
    ) AS distribuicao_acumulada
FROM total_de_vagas
ORDER BY total_vagas_cargos DESC ----------------------------------
    Insight O mercado analisado apresenta forte concentração em três famílias profissionais — Data Analyst,
    Data Engineer e Data Scientist — que,
    em conjunto,
    representam 70,
    59 % das vagas.E essa conclusão leva naturalmente à próxima pergunta: Se esses cargos concentram a maior parte das oportunidades,
    onde estão essas oportunidades e qual é a presença do trabalho remoto ?