-- Create the table
CREATE TABLE results (
	-- Create track column
	track VARCHAR(200),
    -- Create artist column
	artist VARCHAR(120),
    -- Create album column
	album VARCHAR(160),
	-- Create track_length_mins
	track_length_mins INT,
	);

-- Select all columns from the table
SELECT 
  track, 
  artist, 
  album, 
  track_length_mins 
FROM 
  results;

-- Create the table
CREATE TABLE tracks(
  -- Create track column
  track VARCHAR(200), 
  -- Create album column
  album VARCHAR(160), 
  -- Create track_length_mins column
  track_length_mins INT
);
-- Complete the statement to enter the data to the table         
INSERT INTO tracks
-- Specify the destination columns
(track, album, track_length_mins)
-- Insert the appropriate values for track, album and track length
VALUES
  ('Basket Case', 'Dookie', 3);
-- Select all columns from the new table
SELECT 
  *
FROM 
  tracks;

-- Select the album
SELECT 
  title 
FROM 
  album 
WHERE 
  album_id = 213;
-- UPDATE the title of the album
UPDATE 
  album 
SET 
  title = 'Pure Cult: The Best Of The Cult' 
WHERE 
  album_id = 213;
-- Run the query again
SELECT 
  title 
FROM 
  album
WHERE 
  album_id = 213;

-- Run the query
SELECT 
  * 
FROM 
  album 
  -- DELETE the record
DELETE FROM 
  album 
WHERE 
  album_id = 1 
  -- Run the query again
SELECT 
  * 
FROM 
  album;

-- Declare the variable @region
DECLARE @region VARCHAR(10)

-- Update the variable value
SET @region = 'RFC'

SELECT description,
       nerc_region,
       demand_loss_mw,
       affected_customers
FROM grid
WHERE nerc_region = @region;

-- Declare your variables
DECLARE @start DATE
DECLARE @stop DATE
DECLARE @affected INT;
-- SET the relevant values for each variable
SET @start = '2014-01-24'
SET @stop  = '2014-07-02'
SET @affected =  5000 ;

SELECT 
  description,
  nerc_region,
  demand_loss_mw,
  affected_customers
FROM 
  grid
-- Specify the date range of the event_date and the value for @affected
WHERE
  event_date >= @start AND
  event_date <= @stop AND
  affected_customers >= @affected;

-- Create the temporary table #maxtracks and insert data via a SELECT statement
SELECT
  album.title AS album_title,
  artist.name AS artist,
  MAX(track.milliseconds / (1000 * 60) % 60) AS max_track_length_mins
INTO #maxtracks
FROM album
-- Join album to artist using artist_id
INNER JOIN artist ON album.artist_id = artist.artist_id
-- Join track to album using album_id
INNER JOIN track ON track.album_id = album.album_id
GROUP BY album.album_id, album.title, artist.artist_id, artist.name;

-- Run the final SELECT query to retrieve the results from the temporary table
SELECT album_title, artist, max_track_length_mins
FROM #maxtracks
ORDER BY max_track_length_mins DESC, artist;
