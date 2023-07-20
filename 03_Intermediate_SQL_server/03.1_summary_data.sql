-- Calculate the average, minimum and maximum
SELECT avg(DurationSeconds) AS Average, 
       min(DurationSeconds) AS Minimum, 
       max(DurationSeconds) AS Maximum
FROM Incidents

-- Calculate the aggregations by Shape
SELECT Shape,
       AVG(DurationSeconds) AS Average, 
       MIN(DurationSeconds) AS Minimum, 
       MAX(DurationSeconds) AS Maximum
FROM Incidents
GROUP BY Shape
-- Return records where minimum of DurationSeconds is greater than 1
HAVING MIN(DurationSeconds) > 1

-- Return the specified columns
SELECT *
FROM Incidents
-- Exclude all the missing values from IncidentState  
WHERE IncidentState IS NOT NULL

-- Check the IncidentState column for missing values and replace them with the City column
SELECT IncidentState, ISNULL(IncidentState, City) AS Location
FROM Incidents
-- Filter to only return missing values from IncidentState
WHERE IncidentState IS NULL

-- Replace missing values 
SELECT Country, COALESCE(Country, IncidentState, City) AS Location
FROM Incidents
WHERE Country IS NULL

SELECT Country, 
       CASE WHEN Country = 'us'  THEN 'USA'
       ELSE 'International'
       END AS SourceCountry
FROM Incidents

SELECT DurationSeconds,
       CASE 
          WHEN DurationSeconds <= 120 THEN 1
          WHEN DurationSeconds > 120 AND DurationSeconds <= 600 THEN 2
          WHEN DurationSeconds > 601 AND DurationSeconds <= 1200 THEN 3
          WHEN DurationSeconds > 1201 AND DurationSeconds <= 5000 THEN 4
          ELSE 5
       END AS SecondGroup
FROM Incidents;