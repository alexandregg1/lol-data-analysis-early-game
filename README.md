# Análise de Dados - League of Legends (Early Game)


Este projeto tem como objetivo analisar fatores do early game (primeiros 10 minutos)
que influenciam a vitória em partidas ranqueadas de League of Legends.

A análise foi realizada utilizando R, SQL e Power BI, explorando dados de partidas
para identificar padrões e relações entre desempenho e resultado final.


## Objetivo

Identificar quais fatores nos primeiros 10 minutos de jogo possuem maior impacto
na probabilidade de vitória em partidas ranqueadas de League of Legends.


## 📊 Tecnologias utilizadas

- R (análise exploratória)
- SQL (consultas e validação)
- Power BI (visualização e dashboard)


## 📁 Dataset

O dataset contém informações de partidas ranqueadas,
com foco nos primeiros 10 minutos do jogo, incluindo:

- Ouro total
- Kills
- Dragões
- Arauto
- Torres
- Farm (CS)


## 🧹 Tratamento de Dados

O projeto utiliza duas versões do dataset:

- **Dados brutos (`data/raw/ranked_10min_nao_tratado.csv`)**: versão original do dataset, sem modificações.
- **Dados tratados (`data/processed/ranked_10min_tratado.csv`)**: versão após limpeza e transformação realizada em R.

O processo de tratamento inclui:
- Ajuste de tipos de dados
- Criação de variáveis derivadas (ex: diferença de ouro, kills e objetivos)
- Organização das informações para análise e visualização

Essa separação permite manter a integridade dos dados originais e garantir reprodutibilidade no processo de análise.



## 📈 Principais Insights

- A vantagem de ouro no early game é o fator mais fortemente associado à vitória.
- Times com vantagem simultânea em kills e farm apresentam a maior taxa de vitória (~77%).
- O controle de objetivos como dragões e arauto aumenta significativamente as chances de vitória.
- Vantagem isolada de farm não garante sucesso, sendo necessário convertê-la em pressão no jogo.


## 📊 Dashboard

Visualização dos principais insights obtidos na análise:

![Dashboard](./images/Dashboard-1.png)


## Conclusão

Os resultados indicam que a vitória está fortemente relacionada à capacidade de gerar
vantagem no early game e convertê-la em pressão no jogo.

A combinação entre fatores econômicos (ouro e farm) e estratégicos (kills e objetivos)
se mostra determinante para o sucesso das equipes.