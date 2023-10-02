A SQL and Tableau project based on Ergast's [Formula 1 Dataset](https://ergast.com/mrd/db/)

This Formula 1 Dataset captures every team, driver, race, and outcome from the first race ever in 1950 through the end of the 2022 season. Many teams and drivers have come and gone in the 72 years since Formula 1 was created. There are a lot of teams in this dataset because new investors come into the sport and change the name of the team, which resets the team's points and wins. Therefore, I want to look at the all-time leaders in the sport, as well as the leaders in the past 10 years.

Here is strictly the code of each answer:
[SQL Code](https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/blob/main/Experience.sql)

Firstly, I want to look at Formula 1 teams:

1. Who are the 10 teams currently in Formula 1?

```SELECT constructors.name, constructors.nationality
FROM constructors
JOIN constructorstandings
ON constructors.constructorid = constructorstandings.constructorid
JOIN races
ON constructorstandings.raceid = races.raceid
WHERE races.year = 2022
GROUP by constructors.name, constructors.nationality;```

Result:

<img width="296" alt="Screen Shot 2023-10-02 at 9 03 38 AM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/c4f2a16b-00f2-4559-8663-c1f180769876">

**The majority of teams are British with 3 and then Italian with 2**


2. Who are the most dominant teams of all time?

`SELECT constructors.name
FROM constructors
JOIN constructorstandings
ON constructors.constructorid = constructorstandings.constructorid
JOIN races
ON constructorstandings.raceid = races.raceid
GROUP BY constructors.name
ORDER BY SUM(constructorstandings.points) DESC
LIMIT 10;`

Result:

<img width="290" alt="Screen Shot 2023-10-02 at 4 56 36 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/819fab11-abc8-41c5-8d1e-95b4d32259f8">


**Ferrari is the best team of all time**


3. Who are the most dominant teams in the last 10 years?

`SELECT constructors.name
FROM constructors
JOIN constructorstandings
ON constructors.constructorid = constructorstandings.constructorid
JOIN races
ON constructorstandings.raceid = races.raceid
WHERE year >= 2012
GROUP BY constructors.name
ORDER BY SUM(constructorstandings.points) DESC
LIMIT 10;`

Result:

<img width="302" alt="Screen Shot 2023-10-02 at 4 58 13 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/da6d6e0b-7f8b-444d-ab1d-fabf51126486">


**Mercedes is the best team in the last 10 years**


Now let's look into the drivers:

4. Who has driven in Formula 1 since 2022?

`SELECT forename, surname, nationality, dob
FROM drivers
JOIN driverstandings
ON drivers.driverid = driverstandings.driverid
JOIN races
ON driverstandings.raceid = races.raceid
WHERE year = 2022
GROUP BY forename, surname, nationality, dob
ORDER BY dob;`

Result:

<img width="509" alt="Screen Shot 2023-10-02 at 4 43 01 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/9d80450f-1550-4a9d-948c-d4594d324168">
<img width="506" alt="Screen Shot 2023-10-02 at 4 43 21 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/09146d71-6a69-41f5-a235-1b04a7f60d70">


**The majority of drivers now are British 3 drivers**


5. Who are the best 10 drivers of all time?

`SELECT forename, surname
FROM driverstandings
JOIN drivers
ON driverstandings.driverid = drivers.driverid
JOIN results
ON drivers.driverid = results.driverid
GROUP BY forename, surname
ORDER BY SUM(results.points) DESC
LIMIT 10;`

Result:

<img width="506" alt="Screen Shot 2023-10-02 at 5 00 28 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/e07216fb-fb11-4559-838a-a835f5e7c6e9">


**Lewis Hamilton is the best Formula 1 driver of all time**


6. Who are the best 10 drivers in the last 10 years?

`SELECT forename, surname, nationality, dob
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
LIMIT 10;`

Result:

<img width="502" alt="Screen Shot 2023-10-02 at 5 02 37 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/6b19e7d7-c15c-403a-b34e-b517ff05cc73">

**Lewis Hamilton is the best driver in the last 10 years**


Lastly, let's look at insights into the drivers and races:

7. How many drivers born in or after 1998 have won a race?

`SELECT forename, surname
FROM drivers
JOIN driverstandings
ON drivers.driverid = driverstandings.driverid
WHERE dob > '1998-01-01' AND wins >= 1
GROUP BY forename, surname;`

Result:

<img width="297" alt="Screen Shot 2023-10-01 at 9 07 39 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/bcb07425-2930-486f-a5cf-db5d97261495">

**Experience matters in Formula 1**


8. How often do drivers win the race when they qualify in 1st place?

`WITH 
X1 AS (SELECT COUNT(ds.wins) AS wins FROM driverstandings AS ds
JOIN qualifying AS q ON ds.driverid = q.driverid
WHERE q.position = 1 AND ds.wins = 1),
X2 AS (SELECT COUNT(resultid) AS races FROM results)
SELECT (CAST(X1.wins AS FLOAT) / CAST(X2.races AS FLOAT)) * 100 AS Pct_Wins_Starting_1st
FROM X1, X2;`

Result:

<img width="189" alt="Screen Shot 2023-10-01 at 9 19 16 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/3ca94369-d225-4ac9-98df-0e43292ee4f0">

**Drivers who qualify in 1st place win the race ~62% of the time**

