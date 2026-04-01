/*Criação da Tabela*/
CREATE TABLE matches (
    gameId BIGINT PRIMARY KEY,
    blueWins INT,
    blueWardsPlaced INT,
    blueWardsDestroyed INT,
    blueFirstBlood INT,
    blueKills INT,
    blueDeaths INT,
    blueAssists INT,
    blueEliteMonsters INT,
    blueDragons INT,
    blueHeralds INT,
    blueTowersDestroyed INT,
    blueTotalGold INT,
    blueAvgLevel FLOAT,
    blueTotalExperience INT,
    blueTotalMinionsKilled INT,
    blueTotalJungleMinionsKilled INT,
    blueGoldDiff INT,
    blueExperienceDiff INT,
    blueCSPerMin FLOAT,
    blueGoldPerMin FLOAT,
    redWardsPlaced INT,
    redWardsDestroyed INT,
    redFirstBlood INT,
    redKills INT,
    redDeaths INT,
    redAssists INT,
    redEliteMonsters INT,
    redDragons INT,
    redHeralds INT,
    redTowersDestroyed INT,
    redTotalGold INT,
    redAvgLevel FLOAT,
    redTotalExperience INT,
    redTotalMinionsKilled INT,
    redTotalJungleMinionsKilled INT,
    redGoldDiff INT,
    redExperienceDiff INT,
    redCSPerMin FLOAT,
    redGoldPerMin FLOAT
);
/*Importar Dados para Tabela*/
COPY matches
FROM 'D:\projeto-data_analyst-lol\ranked_10min.csv'
DELIMITER ','
CSV HEADER;
/*Primeira Query - Winrate Geral*/
SELECT AVG(blueWins) AS winrate_blue
FROM matches;
/*Winrate Por Dragão*/
SELECT blueDragons,
	   COUNT(*) AS total_games,
	   AVG(blueWins) AS winrate
FROM matches
GROUP BY blueDragons
ORDER BY blueDragons;
/*Winrate Por Arauto*/
SELECT blueHeralds,
	   COUNT(*) AS total_games,
	   AVG(blueWins) AS winrate
FROM matches
GROUP BY blueHeralds
ORDER BY blueHeralds;
/*GoldDiff aos 10min*/
SELECT (blueTotalGold - redTotalGold) AS GoldDiff,
		blueWins
FROM matches
LIMIT 10;
/*Vantagem de Gold aos 10min*/
SELECT 
    CASE 
        WHEN (blueTotalGold - redTotalGold) > 0 THEN 'Vantagem'
        ELSE 'Desvantagem'
    END AS goldLead,
    COUNT(*) AS total_games,
    AVG(blueWins) AS winrate
FROM matches
GROUP BY goldLead;
/*Faixas de gold*/
SELECT 
    CASE 
        WHEN (blueTotalGold - redTotalGold) < -1000 THEN 'Muito atrás'
        WHEN (blueTotalGold - redTotalGold) < 0 THEN 'Atrás'
        WHEN (blueTotalGold - redTotalGold) < 1000 THEN 'Leve vantagem'
        ELSE 'Grande vantagem'
    END AS goldCategory,
    COUNT(*) AS total_games,
    AVG(blueWins) AS winrate
FROM matches
GROUP BY goldCategory
ORDER BY winrate DESC;
/*Análise combinada*/
SELECT 
    blueDragons,
    CASE 
        WHEN (blueTotalGold - redTotalGold) > 0 THEN 'Vantagem'
        ELSE 'Desvantagem'
    END AS goldLead,
    COUNT(*) AS total_games,
    AVG(blueWins) AS winrate
FROM matches
GROUP BY blueDragons, goldLead
ORDER BY blueDragons, goldLead;
/*Comparação de controle de visão (wards colocadas)*/
SELECT 
    CASE 
        WHEN (blueWardsPlaced - redWardsPlaced) > 0 THEN 'Vantagem de Visão'
        WHEN (blueWardsPlaced - redWardsPlaced) < 0 THEN 'Desvantagem de Visão'
        ELSE 'Empate'
    END AS visionStatus,
    COUNT(*) AS total_games, 
    AVG(blueWins) AS winrate
FROM matches
GROUP BY visionStatus
ORDER BY winrate DESC; /*Vantagem de visão afeta significativamente a taxa de vitória, em 4605 jogos a vantagem de visão afetou a taxa de vitória em 52%, em 742 houve empate o que resultou em uma taxa de vitória de 50% e na desvantagem 46% */
/*Comparação de cs por minuto (até 10 minutos)*/
SELECT
	CASE 
		WHEN (bluecspermin - redcspermin) > 0 THEN 'Vantagem de farm'
		WHEN (bluecspermin - redcspermin) < 0 THEN 'Desvantagem de farm'
		ELSE 'Empate'
	END AS CSpermiStatus,
	COUNT(*) AS total_games,
	AVG(blueWins) AS winrate
FROM matches
GROUP BY CSpermiStatus
ORDER BY winrate DESC; /*A vantagem de cs é uma das coisas que mais impactam na taxa de vitória, pois afeta diretamente na vantagem de gold, uma vez que o farm representa o acumulo de gold assim como as kills, dragões e torres, 4777 partidas com vantagem no cs a taxa de vitória aumenta em 62%, nas 129 partidas que ocorreu empate a taxa continuou empatada em 50%, e nas 4973 Partidas que ocorreram desvantagem de cs a taxa de vitória caiu apra 37%*/
/*Comparação de peso das Kills vs CS por minuto*/
SELECT 
    CASE 
        WHEN (blueKills - redKills) > 0 AND (bluecspermin - redcspermin) < 0 THEN 'Agressividade (Mais Kills, menos Farm)'
        WHEN (bluecspermin - redcspermin) > 0 AND (blueKills - redKills) < 0 THEN 'Macro/Farm (Mais Farm, menos Kills)'
        WHEN (blueKills - redKills) > 0 AND (bluecspermin - redcspermin) > 0 THEN 'Dominância Total (Lidera ambos)'
        ELSE 'Atrás em ambos / Empate'
    END AS estilo_de_jogo,
    COUNT(*) AS total_games,
    AVG(blueWins) AS winrate
FROM matches
GROUP BY estilo_de_jogo
ORDER BY winrate DESC; /*Em 2871 partidas ocorreram um caso de snowball, onde kills e cs foi implacaveis abrindo uma vantagem de gold enorme afetando a taxa de vitória em 77%, nos casos de agressividade nos 1557 onde kills foram mais impactantes que o farm o winrate ficou em 63%, nos 1442 jogos onde o farm foi o fator dominante em relação as kills o winrate foi afetado em 36% e nos 4009 jogos onde os times ficaram empatados ou atropelados o winrate foi afetado em 29%*/
/*Impacto das Torres*/
SELECT
	CASE 
		WHEN (bluetowersdestroyed - redtowersdestroyed) > 0 THEN 'Vantagem de mapa'
		WHEN (bluetowersdestroyed - redtowersdestroyed) < 0 THEN 'Desvantagem de mapa'
		ELSE 'Empate'
	END AS TowersStatus,
	COUNT(*) AS total_games,
	AVG(blueWins) AS winrate
FROM matches
GROUP BY TowersStatus
ORDER BY winrate DESC;/*Nas 441 partidas onde ocorreu a Vantagem de mapa, destruindo as torres nos 10 minutos, houve um impacto de 75% no winrate, em 9064 houve empates onde  o winrate foi impactado em 50%, e em 374 jogos que houveram casos de desvantagens claras do mapa 21%*/