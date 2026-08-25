01 — Quantas vagas existem ? Qual é o número total de vagas presentes no dataset job_postings_fact ? O dataset contém 787.686 vagas únicas.
SELECT COUNT(DISTINCT job_id) AS Vagas
FROM job_postings_fact;
02 — Qual é o período dos dados ? Que período do mercado de trabalho estamos analisando ? data_inicial | 2022 -12 -31 data_final | 2023 -12 -31
SELECT MIN(job_posted_date)::DATE as data_inical,
    MAX(job_posted_date)::DATE as data_final
FROM job_postings_fact;
03 — Como as vagas estão distribuídas por cargo ? 
    {
 "job_title_short": "Data Analyst",
    "vagas": "196593"
  {
    "job_title_short": "Data Engineer",
    "vagas": "186679"
  {
    "job_title_short": "Data Scientist",
    "vagas": "172726"
  {
    "job_title_short": "Business Analyst",
    "vagas": "49160"
  {
    "job_title_short": "Software Engineer",
    "vagas": "45019"
 SELECT job_title_short,
        COUNT(DISTINCT job_id) AS VAGAS
    FROM job_postings_fact
    GROUP BY job_title_short
    ORDER BY VAGAS DESC
03.1 - Quais cargos concentram o maior número de oportunidades no dataset ?
[
  {
    "job_title_short": "Data Analyst",
    "percentual_vagas": "24.96%"
  },
  {
    "job_title_short": "Data Engineer",
    "percentual_vagas": "23.70%"
  },
  {
    "job_title_short": "Data Scientist",
    "percentual_vagas": "21.93%"
  },
  {
    "job_title_short": "Business Analyst",
    "percentual_vagas": "6.24%"
  },
  {
    "job_title_short": "Software Engineer",
    "percentual_vagas": "5.72%"
  },
]
 WITH vagas_por_cargo AS (
    SELECT job_title_short,
        COUNT(DISTINCT job_id) AS VAGAS
    FROM job_postings_fact
    GROUP BY job_title_short
    ORDER BY VAGAS DESC
)
SELECT job_title_short,
    VAGAS,
    ROUND((VAGAS / SUM(VAGAS) OVER()) * 100.0, 2) AS percentual_vagas
FROM vagas_por_cargo
ORDER BY percentual_vagas DESC
      WITH vagas_por_cargo AS (
     SELECT
     job_title_short,
     COUNT(DISTINCT job_id) AS vagas
     FROM job_postings_fact
     GROUP BY job_title_short
     ),
     
     total_de_vagas AS (
     SELECT
     SUM(vagas) AS total_vagas
     FROM vagas_por_cargo
     )
     
     SELECT
     v.job_title_short,
     v.vagas,
     ROUND((v.vagas * 100.0 / t.total_vagas), 2) AS percentual_vagas
     FROM vagas_por_cargo AS v
     CROSS JOIN total_de_vagas AS t
     ORDER BY percentual_vagas DESC;
     
     */
04 — Qual é a cobertura salarial ?
Quais cargos apresentam os maiores salários médios?
[
{
    "job_title_short": "Senior Data Scientist",
    "salario_medio": "154050.03"
  {
    "job_title_short": "Senior Data Engineer",
    "salario_medio": "145866.87"
  {
    "job_title_short": "Data Scientist",
    "salario_medio": "135929.48"
  {
    "job_title_short": "Data Engineer",
    "salario_medio": "130266.87"
  {
    "job_title_short": "Machine Learning Engineer",
    "salario_medio": "126785.91"
  {
]
SELECT 
        job_title_short,
    ROUND(AVG(salary_year_avg), 2) AS salario_medio
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY salario_medio DESC;

05 - salário por cargo ajustado à quantidade de vagas
Quais cargos combinam maior volume de oportunidades com maior salário médio?
[
  {
    "job_title_short": "Data Scientist",
    "vagas": "5926",
  {
    "job_title_short": "Data Analyst",
    "vagas": "5463",
  {
    "job_title_short": "Data Engineer",
    "vagas": "4509",
  {
    "job_title_short": "Senior Data Scientist",
    "vagas": "1686",
  {
    "job_title_short": "Senior Data Engineer",
    "vagas": "1594",
  {
    "job_title_short": "Senior Data Analyst",
    "vagas": "1132",
  {
    "job_title_short": "Business Analyst",
    "vagas": "617",
  {
    "job_title_short": "Machine Learning Engineer",
    "vagas": "573",
  {
    "job_title_short": "Software Engineer",
    "vagas": "469",
  {
    "job_title_short": "Cloud Engineer",
    "vagas": "65",
  }
]
    WITH vagas_e_salarios AS (
        SELECT job_title_short,
            COUNT(DISTINCT job_id) AS vagas,
            ROUND(AVG(salary_year_avg), 2) AS salario_medio
        FROM job_postings_fact
        WHERE salary_year_avg IS NOT NULL
        GROUP BY job_title_short
    )
    SELECT * 
    FROM vagas_e_salarios
    ORDER BY vagas DESC, salario_medio DESC;

06 - Quão representativa é a nossa análise salarial em relação ao total de vagas?
[
  {
    "job_title_short": "Senior Data Scientist",
    "total_vagas": "37076",
    "percentual_com_salario": "4.55"
  {
    "job_title_short": "Machine Learning Engineer",
    "total_vagas": "14106",
    "percentual_com_salario": "4.06"
  {
    "job_title_short": "Senior Data Analyst",
    "total_vagas": "29289",
    "percentual_com_salario": "3.86"
  {
    "job_title_short": "Senior Data Engineer",
    "total_vagas": "44692",
    "percentual_com_salario": "3.57"
  {
    "job_title_short": "Data Scientist",
    "total_vagas": "172726",
    "percentual_com_salario": "3.43"
  {
    "job_title_short": "Data Analyst",
    "total_vagas": "196593",
    "percentual_com_salario": "2.78"
  {
    "job_title_short": "Data Engineer",
    "total_vagas": "186679",
    "percentual_com_salario": "2.42"
  {
    "job_title_short": "Business Analyst",
    "total_vagas": "49160",
    "percentual_com_salario": "1.26"
  {
    "job_title_short": "Software Engineer",
    "total_vagas": "45019",
    "percentual_com_salario": "1.04"
  {
    "job_title_short": "Cloud Engineer",
    "total_vagas": "12346",
    "percentual_com_salario": "0.53"
  }
]
WITH vagas_por_cargo AS (
    SELECT
        job_title_short,
        COUNT(DISTINCT job_id) AS total_vagas,
        COUNT(DISTINCT CASE 
            WHEN salary_year_avg IS NOT NULL THEN job_id 
        END) AS vagas_com_salario
    FROM job_postings_fact
    GROUP BY job_title_short
)
SELECT
    job_title_short,
    total_vagas,
    vagas_com_salario,
    ROUND(
        (vagas_com_salario * 100.0) / total_vagas,
        2
    ) AS percentual_com_salario
FROM vagas_por_cargo
ORDER BY percentual_com_salario DESC;

07 - Quais colunas possuem valores NULL e qual é a proporção de dados ausentes?
apenas 2,80% das vagas com salary_year_avg;
apenas 1,35% com salary_hour_avg.
job_title_short → 100% preenchido;
company_id → 100% preenchido;
job_work_from_home → 100% preenchido;
job_location → 99,87% preenchido.

SELECT 
    'job_title_short' AS coluna,
    COUNT(*) AS quantidade_null,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_postings_fact), 2) AS percentual_null
FROM job_postings_fact
WHERE job_title_short IS NULL

UNION ALL

SELECT 
    'job_location',
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_postings_fact), 2)
FROM job_postings_fact
WHERE job_location IS NULL

UNION ALL

SELECT 
    'salary_year_avg',
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_postings_fact), 2)
FROM job_postings_fact
WHERE salary_year_avg IS NULL

UNION ALL

SELECT 
    'salary_hour_avg',
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_postings_fact), 2)
FROM job_postings_fact
WHERE salary_hour_avg IS NULL

UNION ALL

SELECT 
    'company_id',
    COUNT(*),
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_postings_fact), 2)
FROM job_postings_fact
WHERE company_id IS NULL

UNION ALL

08 - Queremos verificar se existem múltiplos registos com o mesmo job_id.?
job_id é único em job_postings_fact; não foram identificados registros duplicados.
SELECT 
    job_id,
    COUNT(*) AS quantidade_registros
FROM job_postings_fact
GROUP BY job_id
HAVING COUNT(*) > 1

09 - Quais localizações concentram o maior número de vagas?

      SELECT job_location,
          COUNT(*) AS vagas_loc
      FROM job_postings_fact
      GROUP BY job_location
    ORDER BY vagas_loc DESC
    LIMIT 10;
