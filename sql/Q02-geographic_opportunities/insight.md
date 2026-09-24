# Business Question

Como as oportunidades de trabalho estão distribuídas geograficamente e como a disponibilidade de trabalho remoto varia entre os principais cargos?

## Methodology

A Q2 foi dividida em três camadas: **localização**, **trabalho remoto por cargo** e **relação entre Anywhere e job_work_from_home**.

## Result - [sql_analysis](/sql/Q02-skills_intelligence/sql_analysis.sql).


**Q2.1 — Distribuição por localização**

| Localização                 |  Vagas | Participação |
| --------------------------- | -----: | -----------: |
| Anywhere                    | 69.606 |        8,84% |
| Singapore                   | 23.423 |        2,97% |
| Paris, France               | 12.354 |        1,57% |
| Bengaluru, Karnataka, India | 11.517 |        1,46% |
| London, UK                  | 10.578 |        1,34% |
| Madrid, Spain               |  9.805 |        1,24% |
| New York, NY                |  8.193 |        1,04% |
| India                       |  7.671 |        0,97% |
| United States               |  7.449 |        0,95% |
| Hong Kong                   |  7.362 |        0,93% |

**Q2.2 — Trabalho remoto por cargo**

| Cargo                     |   Total | Remotas |   % remoto |
| ------------------------- | ------: | ------: | ---------: |
| Senior Data Engineer      |  44.692 |   6.564 | **14,69%** |
| Data Engineer             | 186.679 |  21.261 | **11,39%** |
| Machine Learning Engineer |  14.106 |   1.480 | **10,49%** |
| Senior Data Scientist     |  37.076 |   3.809 | **10,27%** |
| Data Scientist            | 172.726 |  14.534 |  **8,41%** |
| Senior Data Analyst       |  29.289 |   2.352 |  **8,03%** |
| Data Analyst              | 196.593 |  13.331 |  **6,78%** |
| Software Engineer         |  45.019 |   2.918 |  **6,48%** |
| Business Analyst          |  49.160 |   2.786 |  **5,67%** |
| Cloud Engineer            |  12.346 |     571 |  **4,62%** |

**Q2.3 — Anywhere vs job_work_from_home**

| Grupo               | Remote TRUE | Remote FALSE |
| ------------------- | ----------: | -----------: |
| Anywhere            |  **69.606** |        **0** |
| Outras localizações |       **0** |  **718.080** |

## Insight

**Análise consolidada da Q2**

**1. O mercado geográfico é fragmentado**

Não existe uma única localização responsável por uma parcela dominante das oportunidades. Anywhere é a maior categoria individual, com 8,84%, seguida por Singapore com 2,97%.

Isso sugere um mercado de dados distribuído entre diferentes localidades.

**2. O trabalho remoto representa uma parcela minoritária**

Das 787.686 vagas, apenas 69.606 (8,84%) são classificadas como remotas.

Logo, aproximadamente 91,16% das vagas são presenciais/não-remotas segundo job_work_from_home.

**3. A disponibilidade de remoto varia por cargo**
Existe uma diferença considerável entre os cargos.

A distância entre o maior e o menor percentual é:

14,69% − 4,62% = 10,07 pontos percentuais.

Ou seja, Senior Data Engineer possui uma proporção de vagas remotas mais de 10 p.p. superior à de Cloud Engineer neste conjunto.

Para o objetivo do projeto, isso é mais relevante do que simplesmente saber o número total de vagas remotas: a estrutura da oportunidade remota depende do cargo.

**4. Anywhere e remoto são praticamente a mesma dimensão neste dataset**

Q2.3 revela que não existe, neste dataset, uma separação entre:

Anywhere mas não remoto

ou

localização específica mas remoto.

A codificação é binária e perfeitamente alinhada.

Isso significa que, nas análises seguintes, devemos evitar tratar Anywhere como uma variável independente de disponibilidade remota. O campo **job_work_from_home** é semanticamente mais direto para responder à pergunta sobre trabalho remoto.

**Insight principal da Q2**

As oportunidades de trabalho em dados estão geograficamente dispersas, enquanto o trabalho remoto representa 8,84% das vagas e apresenta diferenças relevantes entre cargos. Funções como Senior Data Engineer, Data Engineer e Machine Learning Engineer apresentam as maiores proporções de oportunidades remotas, enquanto Data Analyst e Business Analyst apresentam proporções menores. Neste dataset, **Anywhere** está perfeitamente alinhado com **job_work_from_home = TRUE**, indicando que a categoria **Anywhere** representa essencialmente as vagas remotas.