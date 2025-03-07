-- OLAP QUERIES 

-- DRILL DOWN QUERIES 
-- 2017 in Denver
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Denver'
GROUP BY c.TYPE;

-- July 2017 in Denver
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Denver' AND d.Month = 7
GROUP BY c.TYPE;

-- July 4th 2017 in Denver
SELECT c.TYPE, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Denver' AND d.Month = 7 AND d.Day = 4
GROUP BY c.TYPE;

--crimes in vancouver in 2015
select c.type, count(*) from crime c 
inner join facttable f on f.crime_key=c.crime_key
inner join specialevent s on f.eventkey=s.eventkey
inner join date d  on d.date_key=f.date_key
inner join location l on l.location_key=f.location_key
where d.year=2015 
group by (c.type);

--crimes in vancouver in April, 2015 
select c.type, count(*) from crime c 
inner join facttable f on f.crime_key=c.crime_key
inner join specialevent s on f.eventkey=s.eventkey
inner join date d  on d.date_key=f.date_key
inner join location l on l.location_key=f.location_key
where d.year=2015 and d.month=4 
group by (c.type);

--crimes in vancouver in April, 2015 during a hockey event
select c.type, count(*) from crime c 
inner join facttable f on f.crime_key=c.crime_key
inner join specialevent s on f.eventkey=s.eventkey
inner join date d  on d.date_key=f.date_key
inner join location l on l.location_key=f.location_key
where d.year=2015 and d.month=4 and l.city='Vancouver' and s.name='Hockey'
group by (c.type);

-- ROLL UP QUERIES
-- Number of crimes when temperature is high per neighborhood per crime in Vancouver

SELECT c.type, l.neighborhood, GROUPING(c.type, l.neighborhood),SUM(cast(w.Temperature > 293 as int)) as total
FROM Weather as w 
INNER JOIN FactTable as f ON f.Weather_key = w.Weather_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
where l.city='Vancouver'                                                                     
GROUP BY ROLLUP(c.type, l.neighborhood)
ORDER BY c.type, l.neighborhood;

-- Number of crimes that are no traffic crimes per neighborhood per crime
-- IF ONE ABOVE DOESN'T WORK
SELECT c.type, l.neighborhood, GROUPING(c.type, l.neighborhood),SUM(!f.IS_TRAFFIC)
FROM FactTable as f
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
GROUP BY ROLLUP(c.type, l.neighborhood)
ORDER BY c.type, l.neighborhood;

-- Fatality per neighborhood per crime in Denver
SELECT c.type, l.neighborhood, GROUPING(c.type, l.neighborhood), SUM(f.is_fatal)
FROM crime as c 
INNER JOIN facttable as f ON f.crime_key = c.crime_key
INNER JOIN location as l ON l.location_key = f.location_key
where l.city='Denver'
GROUP BY ROLLUP(c.type, l.neighborhood)
ORDER BY c.type, l.neighborhood;

-- SLICE QUERIES
-- Crime per city during March 2016
SELECT c.TYPE, l.City, d.Month, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2016 AND d.Month = 3
GROUP BY c.TYPE, l.City, d.Month;

-- Crime per city in 2015 depending on the time
SELECT c.TYPE, l.City, f.Is_Nighttime, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2015
GROUP BY c.TYPE, l.City, f.Is_Nighttime;

-- the number of crimes per category per neighborhood in vancouver during october  2016
SELECT c.Category, l.neighborhood,d.month, count(*) FROM crime c 
INNER JOIN facttable f ON f.crime_key=c.crime_key
INNER JOIN date d ON d.date_key=f.date_key
INNER JOIN location l ON l.location_key=f.location_key
WHERE d.year=2016 AND d.month=10 AND l.city='Vancouver'
GROUP BY (c.category,l.neighborhood,d.month)

-- DICE QUERIES
-- subset of crimes during December 2015, January and February 2016
SELECT c.TYPE, l.City, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE (d.Year = 2016 AND (d.Month = 1 OR d.Month = 2))
OR (d.Year = 2015 AND d.Month = 12)
GROUP BY c.TYPE, l.City;

-- Crime per city in 2015 at nighttime
SELECT c.TYPE, l.City, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2015 AND f.Is_Nighttime = 1
GROUP BY c.TYPE, l.City;

-- Crime per city in 2015 at day time
SELECT c.TYPE, l.City, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2015 AND f.Is_Nighttime = 0
GROUP BY c.TYPE, l.City;


-- COMBINATION QUERIES
-- Crime per city during sport events
SELECT c.TYPE, d.Month, d.Year, l.City, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
INNER JOIN SpecialEvent as e ON f.eventKey = e.eventKey
WHERE e.type = 'Sport'
GROUP BY c.TYPE, d.Month, d.Year, l.City;

-- Crime per city during different seasons in 2015
SELECT c.TYPE, l.City, d.season, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2015 
GROUP BY c.TYPE, l.City, d.season;

-- Crime in Denver in 2017 in neighborhood where the per capita income is lower than 30k
SELECT c.TYPE, d.Month, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Denver' AND l.PER_CAPITA_INCOME < 30000
GROUP BY c.TYPE, d.Month, d.Year, l.City;

-- Crime in Denver in 2017 in neighborhood where the proportion of asian is high
-- Note : it is said that the highest paid community in Denver is the Asian community
SELECT c.TYPE, d.Month, l.NEIGHBORHOOD, count(*) 
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Crime as c ON f.Crime_key = c.Crime_Key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE d.Year = 2017 AND l.City = 'Denver' AND l.PCT_ASIAN > 2
GROUP BY c.TYPE, d.Month, l.NEIGHBORHOOD;

-- ICEBERG QUERIES
-- top 10 crime counts grouped by crime type and neighborhood in Vancouver
select c.type, l.neighborhood, count(*) as total from 
location as l inner join
facttable f on l.location_key=f.location_key
inner join crime c on f.crime_key=c.crime_key
where l.city='Vancouver'
group by (c.type, l.neighborhood)
order by total DESC
limit 10;

-- top 10 crime counts grouped by crime type and neighborhood in Denver
select c.type, l.neighborhood, count(*) as total from 
location as l inner join
facttable f on l.location_key=f.location_key
inner join crime c on f.crime_key=c.crime_key
where l.city='Denver'
group by (c.type, l.neighborhood)
order by total DESC
limit 10;
 
-- top 10 crime counts grouped by crime type and during a sports event in Denver
select c.type,s.name , count(*) as total from 
location as l inner join
facttable f on l.location_key=f.location_key
inner join crime c on f.crime_key=c.crime_key
inner join specialevent s on f.eventkey=s.eventkey
where l.city='Denver' and s.type='Sport' 
group by (c.type, s.name)
order by total DESC
limit 10;

-- WINDOWING QUERIES
-- Crime per month in Vancouver Neighborhoods
SELECT DISTINCT l.neighborhood, d.year, d.Month,
count(f.Crime_Key)
    OVER (PARTITION BY (l.neighborhood, d.year, d.month))
FROM Date as d 
INNER JOIN FactTable as f ON f.Date_key = d.Date_key 
INNER JOIN Location as l ON f.Location_key = l.Location_Key
WHERE l.City = 'Vancouver';

-- Ranked number of crimes per type per neighborhood
SELECT DISTINCT l.neighborhood, c.type, count(*) as crimes,
RANK()
    OVER (PARTITION BY l.neighborhood ORDER BY count(*) DESC)
FROM facttable as f
INNER JOIN crime as c ON f.crime_key = c.crime_key
INNER JOIN location as l ON f.location_key = l.location_key
WHERE c.type IS NOT NULL
GROUP BY (l.neighborhood, c.type)
ORDER BY l.neighborhood ASC, crimes DESC;

                        
-- WINDOW CLAUSE QUERIES
-- Number of crimes in Vancouver by month with prev and next
SELECT d.year, d.month,
LAG(count(distinct f.crime_key), 1) OVER w AS "prev",
count(distinct f.crime_key) AS crime_count,
LEAD(count(distinct f.crime_key), 1) OVER w AS "next"
FROM facttable AS f
INNER JOIN location AS l ON f.location_key = l.location_key
INNER JOIN date AS d ON f.date_key = d.date_key
WHERE l.city = 'Vancouver'
GROUP BY (d.year, d.month)
WINDOW w AS (ORDER BY d.year, d.month)
ORDER BY d.year, d.month;

-- Most and least common crime types by neighborhood by year
SELECT DISTINCT t.year, t.neighborhood,
FIRST_VALUE(t.type) OVER down AS "most_common",
FIRST_VALUE(t.crime_count) OVER down AS "mcount",
FIRST_VALUE(t.type) OVER up AS "least_common",
FIRST_VALUE(t.crime_count) OVER up AS "lcount"
FROM (
    SELECT d.year, l.neighborhood, c.type,
    count(distinct f.crime_key) AS crime_count
    FROM facttable AS f
    INNER JOIN location AS l ON f.location_key = l.location_key
    INNER JOIN date AS d ON f.date_key = d.date_key
    INNER JOIN crime AS c ON f.crime_key = c.crime_key
    WHERE c.type IS NOT NULL
    GROUP BY (d.year, l.neighborhood, c.type)
) AS t
WINDOW  down AS (PARTITION BY t.year, t.neighborhood ORDER BY t.crime_count DESC),
        up AS (PARTITION BY t.year, t.neighborhood ORDER BY t.crime_count ASC)
ORDER BY t.neighborhood, t.year;







