# Business Question

Quais competências são mais procuradas nas vagas do mercado de trabalho de dados?

## Methodology

A Q2 foi dividida em três camadas: **localização**, **trabalho remoto por cargo** e **relação entre Anywhere e job_work_from_home**.

## Result - [sql_analysis](/sql/Q03-skill_intelligence/sql_analysis.sql).

**Q3.1 — Skills mais procuradas no mercado**
Quais skills aparecem no maior número de vagas?

| Rank | Skill    |   Vagas | % das vagas |
| ---: | -------- | ------: | ----------: |
|    1 | SQL      | 385.750 |      48,97% |
|    2 | Python   | 381.863 |      48,48% |
|    3 | AWS      | 145.718 |      18,50% |
|    4 | Azure    | 132.851 |      16,87% |
|    5 | R        | 131.285 |      16,67% |
|    6 | Tableau  | 127.500 |      16,19% |
|    7 | Excel    | 127.341 |      16,17% |
|    8 | Spark    | 114.928 |      14,59% |
|    9 | Power BI |  98.363 |      12,49% |
|   10 | Java     |  85.854 |      10,90% |

**Q3.2 — Concentração da procura por skills**
Quanto da procura por skills está concentrada nas competências mais frequentes?

| Skills acumuladas | Cobertura acumulada |
| ----------------: | ------------------: |
|                 1 |              48,97% |
|                 2 |              97,45% |
|                 3 |             115,95% |
|                 5 |             149,49% |
|                10 |             219,83% |
|                20 |             285,54% |
|                30 |             331,68% |
|                50 |             390,58% |
 
**Q3.3 Skills por categoria**
Quais categorias de competências são mais representadas nas vagas?

| Categoria     | Nº de skills |   Vagas | % das vagas | Relações job-skill | % das relações |
| ------------- | -----------: | ------: | ----------: | -----------------: | -------------: |
| Programming   |           55 | 562.058 |      71,36% |          1.398.696 |         38,12% |
| Analyst Tools |           29 | 324.711 |      41,22% |            632.696 |         17,24% |
| Cloud         |           19 | 297.608 |      37,78% |            552.271 |         15,05% |
| Libraries     |           44 | 236.736 |      30,05% |            521.217 |         14,20% |
| Other         |           22 | 151.668 |      19,25% |            260.389 |          7,10% |
| Databases     |           18 | 101.709 |      12,91% |            152.168 |          4,15% |
| OS            |           13 |  47.488 |       6,03% |             60.279 |          1,64% |
| Webframeworks |           32 |  34.574 |       4,39% |             44.241 |          1,21% |
| Async         |           15 |  29.372 |       3,73% |             39.697 |          1,08% |
| Sync          |           12 |   7.345 |       0,93% |              7.950 |          0,22% |

## Insight

**1. Skills individuais**

SQL e Python formam o núcleo mais recorrente da procura por competências no dataset. Depois delas, a procura se distribui entre cloud, programação, ferramentas analíticas e visualização.
Isso não significa que uma vaga exija necessariamente SQL e Python simultaneamente: cada percentual representa a proporção de vagas que possui aquela skill, e uma mesma vaga pode exigir várias competências.


**2. Ranking acumulado**


A procura por competências não está distribuída uniformemente entre as 259 skills. Um conjunto relativamente pequeno de competências aparece repetidamente nos anúncios, enquanto muitas outras possuem presença muito menor.

**3. Categorias**


Isso mostra que a procura não está concentrada apenas em linguagens de programação. Ferramentas analíticas, cloud e libraries também representam componentes relevantes do conjunto de competências exigidas.

**Insight principal da Q3**

A procura por competências no mercado analisado é concentrada em um conjunto relativamente pequeno de skills, com SQL e Python ocupando as primeiras posições. Em nível de categoria, Programming apresenta a maior presença nas vagas, enquanto Analyst Tools, Cloud e Libraries também possuem participação relevante. Isso indica que a demanda por profissionais de dados combina competências de programação com ferramentas analíticas, infraestrutura cloud e bibliotecas especializadas.