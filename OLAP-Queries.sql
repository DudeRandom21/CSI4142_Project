EXport to csv
copy(select c.type, c.details, c.time,c.category, l.coordinates, l.neighborhood, l.address, l.city,d.date, 
	 w.sunset,w.sunrise,w.weather
from crime c inner join facttable f on c.crime_key=f.crime_key 
inner join location l on l.location_key=f.location_key 
inner join date d on d.date_key=f.date_key
inner join weather w on w.weather_key=f.weather_key
) to 'C:\Users\zemdy\Documents\csi4142\Project\final\combined1.csv' with (FORMAT CSV, HEADER);

Drill down
#1 
## Number "of theft from vehicle" crimes that happened in
## in vancovour for chirstmas day 2015 per neighborhood.
select l.neighborhood, count(*) from location l
inner join facttable f on l.location_key=f.location_key
inner join crime c on f.crime_key=c.crime_key
inner join date d  on d.date_key=f.date_key
where d.year=2015 and d.month=12 and d.day=25 and l.city='Vancouver'
and c.type='Theft from Vehicle'
group by (l.neighborhood)

#2
## number of crimes that happened in vancouver during a hockey event
## per crime type
select c.type, count(*) from crime c 
inner join facttable f on f.crime_key=c.crime_key
inner join specialevent s on f.eventkey=s.eventkey
inner join date d  on d.date_key=f.date_key
inner join location l on l.location_key=f.location_key
where d.year=2015 and d.month=4 and l.city='Vancouver' and s.name='Hockey'
group by (c.type)


#Slice
#1
## the number of crimes per category per neighborhood in vancouver during october  2016
select c.Category,l.neighborhood,d.month count(*) from crime c 
inner join facttable f on f.crime_key=c.crime_key
inner join date d  on d.date_key=f.date_key
inner join location l on l.location_key=f.location_key
where d.year=2016 and d.month=10 and l.city='Vancouver'
group by (c.category,l.neighborhood,d.month)
