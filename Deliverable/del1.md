# Facts Table

Other than the obvious keys tracked in the facts table, we decided to track exactly what that description of the crime committed was.
In addition to the description of the crime we also track the type of crime, which should be one of:
* Crimes Against a Person
* Crimes Against a Property
* Crimes Against Society

For the moment no other information is tracked in the facts table.

# Datetime

Our datetime dimension is fairly simple and contains only basic date and time information (see diagram for specific fields).
Datetime entries will exist at non-regular intervals and will exist at the specific time of any given crime.
The granularity of this field is down to the minute.
Tracking at a finer interval seems unlikely to yield better insights, and by keeping a finer grain we can decide to roll up as needed.

# Special Event

The special events dimension is to track the presence of special events: both local events such as festivals and sporting events, and holidays such as Christmas and New Year.
In the event that there are two or more events going on at the same time as a crime there will be two entries in the facts table, one with each associated EventKey (queries will be adjusted accordingly).
The type field in the events table will be associated with types such as:
* Holiday (Christmas, New Year, Halloween, St-Patrick's day, etc)
* Sporting Event (Football game, hockey Game, Olympics Games, etc.)
* Concert (Individual concert, music festivals, etc.)
* Family Events (Winterlude, Santa Claus Parades)

New types may emerge or types may change as we construct the actual database system.

# Stock

This is a dimension to track markets.
This dimension will have a rough granularity, it will contain only an aggregate of general market values.
We decided on this coarse grain because tracking specific stock prices are unlikely to yield meaningful correlations and would require an enormous amount of time/computation to process.
We do however track several intervals for trends:
* Change from open to close
* Change from day before
* Change from last week
* Change from last month
* Change from last year

# Location

This dimension allows us to track where crimes took place.
We track longitude and latitude to allow us to see density of crimes as well as average proximity of crimes to one another.
We track the city they are in simply to allow us to compare and contrast the two cities.
We track the neighbourhood to see if particular areas are more at risk and should have more policing.
We also track address but only to the level of granularity provided in the dataset.
This is very limiting because if exact address is not provided in the dataset this field acts very similarly to the neighbourhood field, and as such may be removed in the future.

# Weather

We also elected to track weather because we believe certain weather patterns may be correlated to crime rates.
For example sunrise and sunset can be used to see how much more common crimes are at night than during the day (or vice versa).
Also warm weather seems to have a correlation to crime rates according to [1].
We also look forward to investigating if there are any correlations between precipitation and crime rates.


# References

[1] Drexel University, "Violent crime increases during warmer weather, no matter the season, study finds.", *Science Daily*, 2017, [Online]. Available [https://www.sciencedaily.com/releases/2017/09/170925132948.htm](https://www.sciencedaily.com/releases/2017/09/170925132948.htm) [Accessed Jan, 31, 2020]
