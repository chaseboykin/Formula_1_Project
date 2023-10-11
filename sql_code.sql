--Who are the 10 teams currently in Formula 1?

SELECT constructors.name, constructors.nationality
FROM constructors
JOIN constructorstandings
ON constructors.constructorid = constructorstandings.constructorid
JOIN races
ON constructorstandings.raceid = races.raceid
WHERE races.year = 2022
GROUP by constructors.name, constructors.nationality;

--Who are the most dominant teams of all time?

SELECT constructors.name
FROM constructors
JOIN constructorstandings
ON constructors.constructorid = constructorstandings.constructorid
JOIN races
ON constructorstandings.raceid = races.raceid
GROUP BY constructors.name
ORDER BY SUM(constructorstandings.points) DESC
LIMIT 10;

--Who are the most dominant teams in the last 10 years?

SELECT constructors.name
FROM constructors
JOIN constructorstandings
ON constructors.constructorid = constructorstandings.constructorid
JOIN races
ON constructorstandings.raceid = races.raceid
WHERE year >= 2012
GROUP BY constructors.name
ORDER BY SUM(constructorstandings.points) DESC
LIMIT 10;

--Who has driven in Formula 1 since 2022?

SELECT forename, surname, nationality, dob
FROM drivers
JOIN driverstandings
ON drivers.driverid = driverstandings.driverid
JOIN races
ON driverstandings.raceid = races.raceid
WHERE year = 2022
GROUP BY forename, surname, nationality, dob
ORDER BY dob;

--Who are the best 10 drivers of all time?

SELECT forename, surname
FROM driverstandings
JOIN drivers
ON driverstandings.driverid = drivers.driverid
JOIN results
ON drivers.driverid = results.driverid
GROUP BY forename, surname
ORDER BY SUM(results.points) DESC
LIMIT 10;

--Who are the best 10 drivers in the last 10 years?

SELECT forename, surname, nationality, dob
FROM driverstandings
JOIN drivers
ON driverstandings.driverid = drivers.driverid
JOIN results
ON drivers.driverid = results.driverid
JOIN races
ON results.raceid = races.raceid
WHERE year >= 2012
GROUP BY forename, surname, nationality, dob
ORDER BY SUM(results.points) DESC
LIMIT 10;

--How many drivers born in or after 1998 have won a race?

SELECT forename, surname
FROM drivers
JOIN driverstandings
ON drivers.driverid = driverstandings.driverid
WHERE dob > '1998-01-01' AND wins >= 1
GROUP BY forename, surname;

--How often do drivers win the race when they qualify in 1st place?

WITH 
X1 AS (SELECT COUNT(ds.wins) AS wins FROM driverstandings AS ds
JOIN qualifying AS q ON ds.driverid = q.driverid
WHERE q.position = 1 AND ds.wins = 1),
X2 AS (SELECT COUNT(resultid) AS races FROM results)
SELECT (CAST(X1.wins AS FLOAT) / CAST(X2.races AS FLOAT)) * 100 AS Pct_Wins_Starting_1st
FROM X1, X2;
