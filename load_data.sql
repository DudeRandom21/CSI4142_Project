copy date(date_key,date,day_of_week,year,month,day,week,weekend,season)
From '/home/jon/Documents/CSI4142/Project/final/date.csv' DELIMITER ',' CSV HEADER;


copy location(location_key,address,lat,lon,neighborhood,ttl_population_all,pct_hispanic,pct_white,pct_black,
         pct_nativeam,pct_asian,pct_hawaiianpi,pct_otherrace,male,female,age_10_to_19,age_20_to_29,
         age_30_to_39,age_40_to_49,age_50_to_59,age_60_over,median_age_all,median_age_male,median_age_female,
         per_capita_income,pct_low_income)
From '/home/jon/Documents/CSI4142/Project/final/location.csv' DELIMITER ',' CSV HEADER;

alter table location
add column coordinates geometry;
UPDATE location
SET coordinates = ST_GeomFromText('POINT(' || lon|| ' ' || lat || ')',4326);

copy specialevent(eventkey,name,isoffwork,type,outcome,startdate,enddate,starttime,endtime) 
From '/home/jon/Documents/CSI4142/Project/final/events.csv' DELIMITER ',' CSV HEADER;
copy stock(stockkey,date,changeopenclose,changelastday,changelastweek,changelastmonth,changelastyear) 
From '/home/jon/Documents/CSI4142/Project/final/stock.csv' DELIMITER ',' CSV HEADER;
copy weather(weather_key,temperature,weather,sunrise,sunset)
from '/home/jon/Documents/CSI4142/Project/final/weather.csv' DELIMITER ',' CSV HEADER;

copy crime(crime_key,category,details,time,type,end_dt,start_dt)
From '/home/jon/Documents/CSI4142/Project/final/crime.csv' DELIMITER ',' CSV HEADER;

copy facttable(date_key,eventkey,crime_key,location_key,weather_key,stockkey,is_fatal,is_traffic,is_nighttime)
From '/home/jon/Documents/CSI4142/Project/final/fact.csv' DELIMITER ',' CSV HEADER;

CREATE MATERIALIZED VIEW crime_rate AS
SELECT d.year, d.month, l.neighborhood, CAST(COUNT(DISTINCT f.crime_key) AS float)*100000.0/CAST(l.TTL_POPULATION_ALL AS float) AS crime_rate
FROM date as d, facttable as f, location as l
WHERE d.date_key = f.date_key AND l.location_key = f.location_key
GROUP BY CUBE( d.year, d.month, (l.neighborhood, l.TTL_POPULATION_ALL) )
ORDER BY l.neighborhood, d.year, d.month;
