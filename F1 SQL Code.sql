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
