CREATE TABLE Location(
    locationKey SERIAL PRIMARY KEY,
    address VARCHAR(100),
    city VARCHAR(20),
    LAT, FLOAT,
    LON, FLOAT,
    coordinates GEOGRAPHY,
    neighbourhood VARCHAR(40)
    TTL_POPULATION_ALL FLOAT,
    PCT_HISPANIC FLOAT,
    PCT_WHITE FLOAT,
    PCT_BLACK FLOAT,
    PCT_NATIVEAM FLOAT,
    PCT_ASIAN FLOAT,
    PCT_HAWAIIANPI FLOAT,
    PCT_OTHERRACE FLOAT,
    MALE FLOAT,
    FEMALE FLOAT,
    AGE_10_TO_19 FLOAT,
    AGE_20_TO_29 FLOAT,
    AGE_30_TO_39 FLOAT,
    AGE_40_TO_49 FLOAT,
    AGE_50_TO_59 FLOAT,
    AGE_60_OVER FLOAT,
    MEDIAN_AGE_ALL FLOAT,
    MEDIAN_AGE_MALE FLOAT,
    MEDIAN_AGE_FEMALE FLOAT,
    PER_CAPITA_INCOME FLOAT,
    PCT_LOW_INCOME FLOAT
);
CREATE TABLE Weather(
    weatherKey SERIAL PRIMARY KEY,
    temperature INTEGER,
    weather VARCHAR(50), --sun, cloud, rain, etc
    sunrise TIME,
    sunset TIME
);
CREATE TABLE Stock(
    stockKey SERIAL PRIMARY KEY,
    changeOpenClose FLOAT,
    changeLastDay FLOAT,
    changeLastWeek FLOAT,
    changeLastMonth FLOAT,
    changeLastYear FLOAT
);
CREATE TABLE SpecialEvent(
    eventKey SERIAL PRIMARY KEY,
    name VARCHAR(100),
    isOffWork INTEGER,
    type VARCHAR(75),
    outcome INTEGER check (outcome >0 and outcome <4),
    startDate DATE,
    endDate DATE
);
CREATE TABLE Date(
    dateKey SERIAL PRIMARY KEY,
    day INTEGER,
    month INTEGER,
    year INTEGER check (year>1900),
    dayOfWeek INTEGER check (dayOfWeek>0 and dayOfWeek<8),
    season INTEGER check (season>0 and season<5)
);

CREATE TABLE Crime(
    crimeKey SERIAL PRIMARY KEY,
    category VARCHAR(100),
    details VARCHAR(100),
    time TIME,
    type VARCHAR(100),
    end_dt DATETIME,
    start_dt DATETIME
);

CREATE TABLE FactTable(
    DateKey INTEGER,
    EventKey INTEGER,
    CrimeKey INTEGER,
    LocationKey INTEGER,
    WeatherKey INTEGER,
    StockKey INTEGER,
    is_fatal INTEGER,
    is_traffic INTEGER,
    is_nighttime INTEGER,

    FOREIGN KEY (DateKey) REFERENCES Date(dateKey),
    FOREIGN KEY (CrimeKey) REFERENCES Crime(crimeKey),
    FOREIGN KEY (LocationKey) REFERENCES Location(locationKey),
    FOREIGN KEY (EventKey) REFERENCES SpecialEvent(eventKey),
    FOREIGN KEY (WeatherKey) REFERENCES Weather(weatherkey),
    FOREIGN KEY (StockKey) REFERENCES Stock(stockKey)

);

