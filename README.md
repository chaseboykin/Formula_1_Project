A SQL and Tableau project based on Ergast's Formula 1 dataset.

[Formula 1 Dataset](https://ergast.com/mrd/db/)

[SQL Code](https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/blob/main/Experience.sql)

1. Who has been the most dominant team since 2000?

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

Results:

<img width="251" alt="Screen Shot 2023-10-01 at 9 03 38 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/3361ea79-646f-4efc-8ade-e96d12e62661">

**Mercedes has been the best team since 2000**

2. How many drivers born in or after 1998 have won a race?

SELECT forename, surname
FROM drivers
JOIN driverstandings
ON drivers.driverid = driverstandings.driverid
WHERE dob > '1998-01-01' AND wins >= 1
GROUP BY forename, surname;

Results:

<img width="297" alt="Screen Shot 2023-10-01 at 9 07 39 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/bcb07425-2930-486f-a5cf-db5d97261495">

**Experience matters in Formula 1**

3. How often do drivers win the race when they qualify in 1st place?

WITH 
X1 AS (SELECT COUNT(ds.wins) AS wins FROM driverstandings AS ds
JOIN qualifying AS q ON ds.driverid = q.driverid
WHERE q.position = 1 AND ds.wins = 1),
X2 AS (SELECT COUNT(resultid) AS races FROM results)
SELECT (CAST(X1.wins AS FLOAT) / CAST(X2.races AS FLOAT)) * 100 AS Pct_Wins_Starting_1st
FROM X1, X2;

Results:

<img width="189" alt="Screen Shot 2023-10-01 at 9 19 16 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/3ca94369-d225-4ac9-98df-0e43292ee4f0">

**Drivers who qualify in 1st place win the race ~62% of the time**
