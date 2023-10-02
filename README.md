A SQL and Tableau project based on Ergast's Formula 1 dataset.

[Formula 1 Dataset](https://ergast.com/mrd/db/)

[SQL Analysis (Code)](https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/blob/main/Experience.sql)

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

2. How many drivers born in or after 1998 have won a race?

SELECT forename, surname
FROM drivers
JOIN driverstandings
ON drivers.driverid = driverstandings.driverid
WHERE dob > '1998-01-01' AND wins >= 1
GROUP BY forename, surname;

Results:

<img width="297" alt="Screen Shot 2023-10-01 at 9 07 39 PM" src="https://github.com/chaseboykin/SQL-and-Data-Visualization-Project/assets/140556718/bcb07425-2930-486f-a5cf-db5d97261495">
