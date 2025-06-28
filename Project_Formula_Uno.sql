/*
PROYECT F1 ANALYSIS - UNICORN 
*/
USE formula_unicorn;

-- Part I - Answer for business questions.
-- 1. How many diferents circuits exist in the dataset?

SELECT  COUNT( DISTINCT circuitid) AS Total_Circuits
FROM 	circuits;
-- R/ F1 has 77 different circuits.

-- 2. How many pilots have compited in F1 history?	

SELECT  COUNT( DISTINCT driverId) AS Total_pilots
FROM 	results;
-- R/ In total had been 861 F1 drivers 

-- 3. Which are the teams with the most victorys in the history?

SELECT	c.name,
        COUNT(*) AS Victorys
FROM 	results r
JOIN 	constructors c ON r.constructorId = c. constructorId
WHERE 	position = 1
GROUP BY c.name
ORDER BY Victorys DESC;

-- 4. What has been the laptime average in each circuit?

SELECT 
	c.name,
    ROUND ( AVG (r.milliseconds / r.laps) / 1000,2) AS Time_in_seconds
FROM results r
JOIN races r_1 ON r.raceId = r_1.raceId
JOIN circuits c ON r_1.circuitId = c.circuitId
WHERE r.milliseconds IS NOT NULL
GROUP BY c.name;

-- 5. Which pilot has the most quantity of fast laps?

SELECT 
	d.surname,
    COUNT(*) AS Quantity_fastlaps
FROM results r
JOIN drivers d ON r.driverId = d.driverId
WHERE rankValue ='1'
GROUP BY d.surname
ORDER BY Quantity_fastlaps DESC;

-- 6. How many races has been realized in each season?

SELECT 
	year,
    COUNT(*) AS races_each_season
FROM races 
GROUP BY year
ORDER BY races_each_season DESC;

-- 7. What has been the pits strategy more effective?

SELECT
	stop,
    ROUND (AVG (milliseconds /1000),2) AS Pits_time
FROM pit_stops
GROUP BY stop
ORDER BY Pits_time;

-- R/ the best strategy has been in the stop 52 with 23.81 min
	
-- 8 Which pilot has obteined more pudiums in the history?
SELECT 
	d.surname,
	COUNT(*) Pudiums
FROM drivers d
JOIN results r ON d.driverId = r.driverId
WHERE positionOrder IN (1,2,3)
GROUP BY d.surname
ORDER BY Pudiums DESC;

-- R/ Hamilton with 202 pudiums.

-- 9. Which have been the 5 pilots with the best average in finals positions? 
SELECT 
	d.surname,
	ROUND(AVG(r.positionOrder),2) AS promedio
FROM drivers d
JOIN results r ON d.driverId = r.driverId
GROUP BY d.surname
ORDER BY promedio DESC;

-- 10. Which team has reached much quantity poles position?
SELECT 
	c.name AS constructor,
    COUNT(*) AS Position
FROM qualifying q
JOIN constructors c ON q.constructorId = c.constructorId
WHERE position = 1
GROUP BY constructor
ORDER BY position DESC;

-- R/ Mercedes

-- 11. How many points have reached each team in a specific season?

SELECT
	ra.year AS year,
	c.name AS Constructor,
    FORMAT(SUM(r.points),0) AS Total_points 
FROM results r
JOIN constructors c ON r.constructorId = c.constructorId
JOIN races ra ON r.raceId = ra.raceId
GROUP BY year, Constructor
ORDER BY year DESC, Total_points DESC;

-- 12. What is the circuit where it has produced more retirements?

SELECT
	c.name AS Circuit,
	s.status AS Reason,
    COUNT(*) AS Total_Retirement
FROM results r
JOIN status s ON r.statusId = s.statusId
JOIN races ra ON r.raceId = ra.raceId
JOIN circuits c ON ra.circuitId = c.circuitId
WHERE s.status NOT IN ('finished', 'Disqualified')
				AND s.status NOT LIKE '%lap%'
                AND s.status NOT LIKE 'Did%'
GROUP BY Circuit, Reason
ORDER BY Total_Retirement DESC;

-- R/ The circuit with more retirements is Autodromo Nazionale di Monza.

-- 13. Which pilot has improved more positions since the departure in grid?

SELECT
	d.surname AS Pilot,
	ROUND(AVG( r.positionOrder - r.grid ),1) AS Points_average
FROM results r
JOIN drivers d ON r.driverId = d.driverId
WHERE grid IS NOT NULL AND grid < positionOrder
GROUP BY Pilot
ORDER BY Points_average DESC;

-- R/ the pilot who has improved more positions is Bertaggia. 

-- 14. Which are the teams with the largest quantity of doubles (1st and 2nd lap race)?
SELECT
	c.name AS Driver,
    COUNT(*) AS Doubles
FROM results r1 
JOIN results r2 ON r1.raceId = r2.raceId AND
	 r1.constructorId = r2.constructorId	-- for one constructor
JOIN constructors c ON r1.constructorId = c.constructorId -- for 2nd constructor
WHERE r1.position = 1 AND
		r2.position = 2
GROUP BY Driver
ORDER BY Doubles DESC;

-- 15. Which have been the 5 GP with less difference between 1st and 2nd place?

SELECT
	ra.name AS Race,
    ra.year AS year,
    MIN(ABS(re.milliseconds - re2.milliseconds)) AS Difference
FROM results re
JOIN races ra ON re.raceId = ra.raceId
JOIN results re2 ON re.raceId = re2.raceId AND
	re.position = 1 AND
    re2.position = 2
WHERE re.milliseconds IS NOT NULL AND
	re2.milliseconds IS NOT NULL
GROUP BY Race, year
ORDER BY Difference
LIMIT 5;

-- 16. How many pilots have participated in each season?

SELECT
	ra.year AS Year,
    COUNT(DISTINCT(d.driverId)) AS Total_driver
FROM results re
JOIN races ra ON re.raceId = ra.raceId
JOIN drivers d ON re.driverId = d.driverId
GROUP BY Year
ORDER BY Year;

-- 17. Ranking of 5 best pilots with more points in a season.
SELECT
	driverId,
    surname,
    year,
    total_points,
    RANK() OVER (PARTITION BY year
				ORDER BY  total_points DESC) AS Ranking
FROM (
	SELECT re.driverId,
			d.surname AS surname,
            ra.year,
            ROUND(SUM(re.points),0) AS total_points
	FROM results re
    JOIN races ra ON re.raceId = ra.raceId
    JOIN drivers d ON re.driverId = d.driverId
    GROUP BY re.driverId, ra.year
    ) AS Subquery
ORDER BY year DESC, Ranking	ASC
LIMIT 5;

-- 18. Obtain the final position for each pilot in each race.
SELECT raceId, driverId, 
DENSE_RANK() OVER (PARTITION BY raceId ORDER BY positionOrder ASC) AS position
FROM results;

-- 19. How many points has obtained each team?
SELECT constructors.name,
COALESCE(SUM(results.points), 0) AS total_points
FROM constructors
LEFT JOIN results ON constructors.constructorId = results.constructorId
GROUP BY constructors.name
ORDER BY total_points DESC;

SELECT 
	raceId AS Circuit_code,
    driverId AS Driver_code,
	RANK() OVER (PARTITION BY raceId
				ORDER BY positionOrder ASC) AS Position, -- Screen function
	DENSE_RANK() OVER (PARTITION BY raceId
				ORDER BY positionOrder ASC) AS Position
FROM results;
					

-- 20. Determinar la clasificación de un piloto en una carrera.
SELECT driverId, raceId,
    CASE
        WHEN positionOrder = 1 THEN 'Ganador'
        WHEN positionOrder BETWEEN 2 AND 3 THEN 'Podio'
        WHEN positionOrder BETWEEN 4 AND 10 THEN 'Puntos'
        ELSE 'Fuera de puntos'
    END AS clasificacion
FROM results;

-- Part II - Automatization
-- 1. Create a view that translate the race status in spanish.

CREATE VIEW  estado_carrera_ES AS
	SELECT statusId,
		CASE
			WHEN status = 'Finished' THEN 'Finalizado'
            WHEN status = 'Disqualified' THEN 'Descalificado'
            WHEN status = 'Accident' THEN 'Accidente'
            WHEN status = 'Collision' THEN 'Colisión'
            WHEN status = 'Engine' THEN 'Falla de motor'
            WHEN status = 'Gearbox' THEN 'Falla de caja de cambios'
            WHEN status = 'Hydraulics' THEN 'Falla hidráulica'
            WHEN status = 'Electrical' THEN 'Falla electrica'
            WHEN status = 'Spun off' THEN 'Salida de pista'
            ELSE 'Otro'
		END AS Estado_en_español
	FROM status;
    
-- 2. Create a Stored Procedure (SP) that calculate the victorys numbers for a team in a given year.
DELIMITER //
CREATE PROCEDURE victorys_by_team (IN team_id INT, IN year INT)
BEGIN
	SELECT constructors.name AS Team,
		COUNT(*) AS Victorys
	FROM results re
    JOIN races ra ON re.raceId = ra.raceId
    JOIN constructors ON re.constructorId = ra.constructorId
    WHERE re.position = 1 
		AND constructors.constructorId = team_id
        AND races.year = year
	GROUP BY constructors.name;
END //
DELIMITER ;

SHOW ERRORS;