# Data-warehousing-project
## Main goal of this project
Choosen data set includes over 300,000 accidents in Australia in 2006-2019. Using this data, we can find many interesting statistics, e.g. depending on the year/month/day of the week in which more accidents occur in Australia. How the number of accidents depends on the weather, holidays or weekends. How the severity of accidents depends on the weather, etc.
___
I worked on this project from October 2021 to February 2022 in the "Data warehousing design" class. This project was divided into 3 phases:
-	Data warehouse model.
-	Data warehouse implementation.
-	Data warehouse exploration.

From the first two phases, I got 100% and in the last phase, I got 90%.
##	Data warehouse model.
At this phase, we needed to find an interesting dataset, then clean it if we need to, make a diagram and 10 sample user questions for my future data warehouse. 
<br/>I choosed this dataset: https://www.kaggle.com/mgray39/australia-new-zealand-road-crash-dataset.

This dataset interested me because I saw a lot of stats about crashes from different countries, but I always wanted to make something similar but only on my own. So i have started to making a diagram of my future data warehouse.

This was my prototype of my first Data Warehouse, and at the beginning, it seemed quite good and it was, but for the third phase of my "Data warehousing design" class, this database structure doesn't fit well. So in the future, I have changed it.

![image](https://user-images.githubusercontent.com/63752476/159497913-1604e053-73be-4b0a-825c-58fa8329c555.png)

### To make the dataset looks like this, i have had to make a lot of refactoring:

1. I deleted the "Casualties" table.
2. I took only the "weather" and  "severity" attributes from the (original) "description" table and made them separate tables.
3. From the (original) table "Vehicles" I took only the "pedestrian" attribute and made a separate table from it. But in the original table "Vehicles" in column "pedestrians" was the number of pedestrians involved in the accident,  I binarized this column in my solution. Now this column just only says if there are any pedestrians involved in the accident or not.
4. There were problems with the date_time table in the original dataset:
a. PK date_time_id was supposed to be of datetime type, but it was not possible to set this type, therefore the decision was made on setting type varchar (20).
b. In the date_time table, 27% of the records had nulls in the column “Day_of_month”, so I decided to make cascade deletion of records from the table "date_time", because of this deleting I deleted all records with the same "date_time_id" key from the "crash" table what caused a reduction of records in the "crash" table from 1.5 million to 400 thousand!
5. Later I have noticed 65 thousand. records with a null value in the "lat_long" column (table location), I also had to delete these records so that they would not be there cases in which we do not know where accidents were at all.
6. After that, I've noticed that after removing 27% of records from the "date_time" table we do not have any records related to New Zealand, therefore I removed the country attribute from the original "location" table, so from this moment we only have data from Australia.

### Then i needed to make some sample user questions for this database and thats them:

1. How many accidents depending on the month and state were in the years 2006-2019?
2. How many accidents depending on the month and severity were in 2006-2019?
3. How many accidents were depending on the day of the week and pedestrian participation in 2006-2019?
4. How many accidents were depending on the day of the week and the weather in 2006-2019?
5. How many accidents were depending on the state and severity in 2006-2019?
6. How many accidents occurred depending on the participation of pedestrians and state in 2006-2019?
7. How many accidents depending on the state and weather were in 2006-2019?
8. How many accidents depending on the participation of pedestrians and severity were in 2006-2019?
9. How many accidents depending on severity and weather were in 2006-2019?
10. How many accidents were there depending on the participation of pedestrians and weather in 2006-2019?

As you can see, all these questions have the same time interval, because at the time of writing these questions, my task was to add the same time interval to all requests and nothing more.

## Data warehouse implementation.
The second phase was much more interesting! I love implementing things and I love implementing DB diagrams into real databases. In this case, my DB was a Data Warehouse and that was really intriguing.

So there are my main goals for this phase:
- Implement Data Warehouse.
- Visualize user questions from phase 1, perform analysis of these questions and make some conclusions.

In addition to these main goals, I have done additional work, which will be discussed in the future.

### Data Warehouse implementation

In order to perform the analysis, I first imported the data from the kaggle.com file into __SQL Server__. I divided data into tables according to the refactored model:

![image](https://user-images.githubusercontent.com/63752476/159523336-9fc2b04d-2e9c-4c75-91ab-8a1ad9cc75e8.png)

Database creation script snippet below (you also can find entire this script in the DB_setup.sql file).

``` SQL
if exists(select 1 from master.dbo.sysdatabases where name = 'crashes') drop database crashes
GO
CREATE DATABASE crashes
GO

create table severity
(
    severity_id   tinyint     not null
        constraint severity_temp_pk
            primary key nonclustered,
    severity_type varchar(15) not null
)
go

create unique index severity_temp_severity_id_uindex
    on severity (severity_id)
go

```

**Here's snippet of inserts to DB (you can find all data in "data.zip)":**
``` SQL
INSERT INTO crashes.dbo.weather (weather_id, weather_type) VALUES (1, N'unknown');
INSERT INTO crashes.dbo.weather (weather_id, weather_type) VALUES (2, N'fine');
INSERT INTO crashes.dbo.weather (weather_id, weather_type) VALUES (3, N'rain');
INSERT INTO crashes.dbo.weather (weather_id, weather_type) VALUES (4, N'fog');
INSERT INTO crashes.dbo.weather (weather_id, weather_type) VALUES (6, N'smoke_dust');
INSERT INTO crashes.dbo.weather (weather_id, weather_type) VALUES (8, N'high_wind');
```

### Visualize user questions from phase 1, perform analysis of these questions.

![image](https://upload.wikimedia.org/wikipedia/commons/4/4b/Tableau_Logo.png)

For data visualization - I used "Tableau". I've used this tool because it's quite simple in usage, I've never used BI tools before and saw an opportunity to learn something new, plus with "Tableau" I can simply connect to any RDBMS, read almost every text file, this software is popular and many companies want their employees to know at least one of BI tools. So there were many reasons to choose "Tableau".

__All visualizations and their analysations are in the file "Analysed.pdf"__
> This report is writen in polish

## Data warehouse exploration.

![uawj2cfy3tbl-corporate_full_color](https://user-images.githubusercontent.com/63752476/159866598-b4bae19b-69d2-4883-9833-80f3e499a49c.png)

I have heard about the "RapidMiner" for a long time. From a friend who works in data science at a mid-position, on forums, in videos - that's why my choice fell on him. I was just interested in trying a program designed for data science.

When I open the program for first time - I couldn't understand what I need to click to do something useful. Then I googled, read some information, watched some videos from an official account of RapidMiner on YouTube, and made my first data preparation and data exploration using data science tool. 

I can divide this whole process into 3 phases:
1. Connect to and read database.
2. Prepare data.
3. Make a data exploration.

### Connect to and read database.

I connected to a database with an inbuilt JAR driver.
<br/>In RapidMIner you can create folders with processes, so I divided 3 processes above into 2 folders.

In RapidMIner you can create folders with processes, so I divided the 3 processes above into 2 folders. In RapidMiner we can do everything using "Drag and drop", and the database reading process uses only one "tile" so I joined database reading and data preparation processes in one folder.

### Prepare data.

Then I tried to make my first data preparation. I tried to read all crashes without weather conditions and with pedestrians' participation. For this I read all the crashes from DB:
``` SQL
SELECT  "dbo"."date_time"."day_of_week" AS "dbo.date_time__day_of_week", "dbo"."intersection"."isIntersection" AS "dbo.intersection__isIntersection", "dbo"."pedestrian"."is_pedestrian" AS "dbo.pedestrian__is_pedestrian", "dbo"."severity"."severity_type" AS "dbo.severity__severity_type"
FROM "dbo"."date_time", "dbo"."intersection", "dbo"."pedestrian", "dbo"."severity"
```

Then I used from standard RapidMiner FIlter.

![image](https://user-images.githubusercontent.com/63752476/159872906-ea09401e-b683-42f9-98f5-c1eb7d81d637.png)

I know I could do this filter using SQL query with a where clause, but my main goal of using RapidMiner was to learn as much as I can learn while I was doing this project.

Full process looks like this:

![image](https://user-images.githubusercontent.com/63752476/159873935-bcc10bc0-eca0-4d7f-9795-d87369dd5818.png)

Then i tried something more complicated:

![image](https://user-images.githubusercontent.com/63752476/159875786-cab519a3-866b-49e3-99a1-b6481965d19a.png)

There firstly I read all crash and weather rows. Then I filtered all weather rows with weather type=unknown. And joined these 2 tables. 
<br/>Then I read date_time and lat_long tables:
 ```SQL
--date_time
SELECT "date_time_id", "month"
FROM "dbo"."date_time"

--lat_long
SELECT "lat_long", "state"
FROM "dbo"."location"
```

After executing this process, we see something like this:

![image](https://user-images.githubusercontent.com/63752476/159876827-8a3263b2-05af-4639-8622-74a5229ee002.png)

I created some processes for my needs in this project, but I think it's no need to explain them, they are similar to the one above.

### Make a data exploration.

In this phase i understood, that dataset that i choosed isn't good. I saw that in 2010-2013 there are so many records that they amount prevents me from do a lot of stuff, for example time series forcasting. 

![image](https://user-images.githubusercontent.com/63752476/159879203-3169d3aa-50b7-423e-b352-255443b03144.png)

As you can see, it's not normal and I think that it can't be in real life. 
<br/>Another example:

![image](https://user-images.githubusercontent.com/63752476/159880679-cb0c7548-691c-418a-a87d-9949fc321503.png)

So i tried to avoid cases like these.
Now I can show you processes from the second folder with did data exploration.

I used 4 similar processes for data exploration, so I show you only one of them. 

![image](https://user-images.githubusercontent.com/63752476/160248537-7f19411a-2d3e-470d-9184-28d854d6aaf3.png)

<br/>First tile in this process is data process that I put above. Next tile it's an attribute seleciton, where I selected this attributes:

![image](https://user-images.githubusercontent.com/63752476/160249098-dfd3a159-09ea-45e5-8449-5b455746f17f.png)

Then I needed to select main attribute(in this case "state"), cause I choosed random forest algorithm for data exploration. 
<br/>Next tile is Random Forest algorithm settings.
Now I can show you results:

![image](https://user-images.githubusercontent.com/63752476/160249392-8014f3bd-2286-4e09-b1ce-b1d36c54a123.png)

From the visualization we can say that the most important is weather_type.
<br/>We also can see one of 50 trees:

![image](https://user-images.githubusercontent.com/63752476/160249459-6b333d7f-c45e-4244-8851-605be6285a3d.png)

You can see entire data exploration process in Data_exploration.pdf.












