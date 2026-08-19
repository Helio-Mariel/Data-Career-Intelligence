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
    /*    WITH vagas_por_cargo AS (
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
SELECT 
        job_title_short,
    ROUND(AVG(salary_year_avg), 2) AS salario_medio
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY salario_medio DESC;

05 - salário por cargo ajustado à quantidade de vagas
Quais cargos combinam maior volume de oportunidades com maior salário médio?
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
