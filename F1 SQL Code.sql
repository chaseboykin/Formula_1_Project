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
