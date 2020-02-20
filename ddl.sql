CREATE EXTENSION postgis;
CREATE TABLE Location(
    Location_Key SERIAL PRIMARY KEY,
    address VARCHAR(100),
    LAT double precision,
    LON double precision,
    NEIGHBORHOOD VARCHAR(60),
    TTL_POPULATION_ALL INTEGER,
 PCT_HISPANIC NUMERIC,
PCT_WHITE  NUMERIC,
PCT_BLACK NUMERIC,
PCT_NATIVEAM NUMERIC,
PCT_ASIAN NUMERIC,
PCT_HAWAIIANPI NUMERIC,
PCT_OTHERRACE NUMERIC,
MALE NUMERIC,
FEMALE NUMERIC,
AGE_10_TO_19 NUMERIC,
AGE_20_TO_29 NUMERIC,
AGE_30_TO_39 NUMERIC,
AGE_40_TO_49 NUMERIC,
AGE_50_TO_59 NUMERIC,
AGE_60_OVER NUMERIC,
MEDIAN_AGE_ALL  NUMERIC,
MEDIAN_AGE_MALE  NUMERIC,
MEDIAN_AGE_FEMALE  NUMERIC,
PER_CAPITA_INCOME NUMERIC,
PCT_LOW_INCOME NUMERIC

);
CREATE TABLE Weather(
    Weather_key SERIAL PRIMARY KEY,
    Temperature NUMERIC,
    Weather VARCHAR(40),
    Sunrise TIME,
    Sunset TIME
);



CREATE TABLE Stock(
    stockKey SERIAL PRIMARY KEY,
    Date DATE,
    changeOpenClose NUMERIC,
    changeLastDay NUMERIC,
    changeLastWeek NUMERIC,
    changeLastMonth NUMERIC,
    changeLastYear NUMERIC
);
CREATE TABLE SpecialEvent(
    eventKey SERIAL PRIMARY KEY,
    name VARCHAR(100),
    isOffWork INTEGER,
    type VARCHAR(75),
    outcome INTEGER check (outcome >0 and outcome <4),
    startDate DATE,
    endDate DATE,
    startTime TIME,
    endTime  TIME
);




CREATE TABLE Date(
    Date_key SERIAL PRIMARY KEY,
    Date DATE,
    Day_of_week INTEGER,
    Year INTEGER check (year>1900),
    Month INTEGER,
    Day INTEGER ,
    Week INTEGER,
    Weekend INTEGER,
    season INTEGER check (season>0 and season<5)
);

CREATE TABLE Crime(
    Crime_Key SERIAL PRIMARY KEY,
    Category VARCHAR(100),
    Details VARCHAR(100),
    TIME TIME,
    TYPE VARCHAR(100),
    end_dt TIMESTAMP,
           start_dt TIMESTAMP
);

CREATE TABLE FactTable(
    Date_key INTEGER,
eventKey INTEGER,
    Crime_key INTEGER,
    Location_key INTEGER,
    Weather_key INTEGER,
    StockKey INTEGER,
IS_FATAL INTEGER,
IS_TRAFFIC INTEGER,
Is_Nighttime INTEGER,

       FOREIGN KEY (Date_key) REFERENCES Date(Date_key),
FOREIGN KEY (Crime_key) REFERENCES Crime(Crime_key),
       FOREIGN KEY (Location_key) REFERENCES Location(Location_key),
        FOREIGN KEY (eventKey ) REFERENCES SpecialEvent(eventKey),
        FOREIGN KEY (Weather_key ) REFERENCES Weather(Weather_key ),
        FOREIGN KEY (StockKey) REFERENCES Stock(stockKey)

);

