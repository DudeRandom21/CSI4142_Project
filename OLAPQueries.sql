-- OLAP QUERIES 

-- DRILL DOWN QUERIES 
-- 2017 in Denver
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Denver'
GROUP BY c.TYPE 

-- July 2017 in Denver
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Denver' AND d.Month = 7
GROUP BY c.TYPE 

-- July 4th 2017 in Denver
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Denver' AND d.Month = 7 AND d.Day = 4
GROUP BY c.TYPE


-- ROLL UP QUERIES
-- On Abbott Street in 2017
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Vancouver' AND l.NEIGHBORHOOD = 'central business district' AND l.address LIKE '%ABBOTT ST'
GROUP BY c.TYPE

-- In central business district in 2017
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Vancouver' AND l.NEIGHBORHOOD = 'central business district'
GROUP BY c.TYPE

-- In Vancouver in 2017
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Vancouver'
GROUP BY c.TYPE


-- SLICE QUERIES
-- Crime per city during March 2016
SELECT c.TYPE, l.City, d.Month, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2016 AND d.Month = 3
GROUP BY c.TYPE, l.City, d.Month

-- Crime per city in 2015 depending on the time
SELECT c.TYPE, l.City, f.Is_Nighttime count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2015
GROUP BY c.TYPE, l.City, f.Is_Nighttime


-- DICE QUERIES
-- subset of crimes during December, January and February 2015
SELECT c.TYPE, l.City, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE (d.Year = 2015 AND (d.Month = 1 OR d.Month = 2)) OR (d.Year = 2014 AND d.Month = 12)
GROUP BY c.TYPE, l.City

-- Crime per city in 2015 at nighttime
SELECT c.TYPE, l.City, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2015 AND f.Is_Nighttime = 1
GROUP BY c.TYPE, l.City

-- Crime per city in 2015 at day time
SELECT c.TYPE, l.City, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2015 AND f.Is_Nighttime = 0
GROUP BY c.TYPE, l.City


-- COMBINATION QUERIES
-- Crime per city during sport events
SELECT c.TYPE, d.Month, d.Year, l.City, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
INNER JOIN SpecialEvent as e ON f.eventKey = e.eventKey
WHERE e.type = 'Sport'
GROUP BY c.TYPE, d.Month, d.Year, l.City

-- Crime per city during different seasons in 2017
SELECT c.TYPE, l.City, d.season, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 
GROUP BY c.TYPE, l.City, d.season


-- ICEBERG QUERIES
-- zeli working on it



-- WINDOWING QUERIES      ??????????
-- Crime per month in Vancouver Neighborhoods
SELECT DISTINCT l.neighborhood, d.year, d.Month,
count(f.Crime_Key)
    OVER (PARTITION BY (l.neighborhood, d.year, d.month))
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE l.City = 'Vancouver'


-- WINDOW CLAUSE QUERIES

















