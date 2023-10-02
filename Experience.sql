--Who has been the most dominant team since 2000?

SELECT constructors.name, constructorstandings.wins
FROM constructors
JOIN constructorstandings
ON constructors.constructorid = constructorstandings.constructorid
JOIN races
ON constructorstandings.raceid = races.raceid
WHERE date > '2000-01-01'
GROUP BY constructors.name, constructorstandings.wins
ORDER BY constructorstandings.wins DESC
LIMIT 10;

--—How many drivers born after 2000 have won a race?
Experience (Join):
SELECT *
FROM drivers
JOIN driverstandings
ON drivers.driverid = driverstandings.driverid
WHERE dob > '2000-01-01' AND wins >= 1;

--How often do drivers win the race when they qualify in 1st place?

WITH 
X1 AS (SELECT COUNT(ds.wins) AS wins FROM driverstandings AS ds
JOIN qualifying AS q ON ds.driverid = q.driverid
WHERE q.position = 1 AND ds.wins = 1),
X2 AS (SELECT COUNT(resultid) AS races FROM results)
SELECT (CAST(X1.wins AS FLOAT) / CAST(X2.races AS FLOAT)) * 100 AS Pct_Wins_Starting_1st
FROM X1, X2;
