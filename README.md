# Data-warehousing-project
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
- Visualize user questions from phase 1, perform analysis of these questions.
- Make some conclusions.

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

### Visualize user questions from phase 1, perform analysis of these questions.






