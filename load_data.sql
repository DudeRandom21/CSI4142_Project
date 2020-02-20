copy date(date_key,date,day_of_week,year,month,day,week,weekend,season)
From '/home/jon/Documents/CSI4142/Project/datasets/final/date.csv' DELIMITER ',' CSV HEADER;


copy location(location_key,address,lat,lon,neighborhood,ttl_population_all,pct_hispanic,pct_white,pct_black,
         pct_nativeam,pct_asian,pct_hawaiianpi,pct_otherrace,male,female,age_10_to_19,age_20_to_29,
         age_30_to_39,age_40_to_49,age_50_to_59,age_60_over,median_age_all,median_age_male,median_age_female,
         per_capita_income,pct_low_income)
From '/home/jon/Documents/CSI4142/Project/datasets/final/location.csv' DELIMITER ',' CSV HEADER;

alter table location
add column coordinates geometry;
UPDATE location
SET coordinates = ST_GeomFromText('POINT(' || lon|| ' ' || lat || ')',4326);

copy specialevent(eventkey,name,isoffwork,type,outcome,startdate,enddate,starttime,endtime) 
From '/home/jon/Documents/CSI4142/Project/datasets/final/events.csv' DELIMITER ',' CSV HEADER;
copy stock(stockkey,date,changeopenclose,changelastday,changelastweek,changelastmonth,changelastyear) 
From '/home/jon/Documents/CSI4142/Project/datasets/final/stock.csv' DELIMITER ',' CSV HEADER;
copy weather(weather_key,temperature,weather,sunrise,sunset)
from '/home/jon/Documents/CSI4142/Project/datasets/final/weather.csv' DELIMITER ',' CSV HEADER;

copy crime(crime_key,category,details,time,type,end_dt,start_dt)
From '/home/jon/Documents/CSI4142/Project/datasets/final/crime.csv' DELIMITER ',' CSV HEADER;

copy facttable(date_key,eventkey,crime_key,location_key,weather_key,stockkey,is_fatal,is_traffic,is_nighttime)
From '/home/jon/Documents/CSI4142/Project/datasets/final/fact.csv' DELIMITER ',' CSV HEADER;

