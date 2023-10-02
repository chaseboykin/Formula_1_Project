SELECT circuits.name, races.name, date, constructors.name, results.time, fastestlap,
wins, forename, surname
FROM circuits
JOIN races
ON circuits.circuitid = races.circuitid
JOIN results
ON races.raceid = results.raceid
JOIN driverstandings
ON results.driverid = driverstandings.driverid
JOIN constructors
ON results.constructorid = constructors.constructorid
JOIN drivers
ON results.driverid = drivers.driverid;