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

create table weather
(
    weather_id   tinyint not null
        constraint test_weather_pk
            primary key nonclustered,
    weather_type varchar(15)
)
go

create unique index test_weather_weather_id_uindex
    on weather (weather_id)
go

create table pedestrian
(
    pedestrian_id varchar not null
        constraint pedestrian_pk
            primary key nonclustered,
    is_pedestrian bit
)
go

create unique index pedestrian_pedestrian_id_uindex
    on pedestrian (pedestrian_id)
go

create table location
(
    lat_long  varchar(100) not null
        primary key,
    latitude  float,
    longitude float,
    state     varchar(4)
)
go

create table date_time
(
    date_time_id varchar(20) not null
        primary key,
    year         int,
    month        tinyint,
    day_of_week  tinyint,
    day_of_month tinyint,
    hour         float
)
go

create table intersection
(
    intersection_id varchar not null
        constraint intersection_pk
            primary key nonclustered,
    isIntersection  bit
)
go

create unique index intersection_intersection_id_uindex
    on intersection (intersection_id)
go

create table crash
(
    crash_id        varchar(25) not null,
    lat_long        varchar(100)
        constraint ll_fk
            references location
            on delete cascade,
    date_time_id    varchar(20)
        constraint date_time_id
            references date_time
            on delete cascade,
    pedestrian_id   varchar
        constraint p_fk
            references pedestrian,
    weather_id      tinyint     not null
        constraint w_fk
            references weather
            on delete cascade,
    severity_id     tinyint
        constraint s_fk
            references severity,
    intersection_id varchar     not null
        constraint intersection_fk
            references intersection
)
go

