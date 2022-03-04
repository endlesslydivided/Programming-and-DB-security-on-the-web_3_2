use master;

CREATE DATABASE TRANS;
use TRANS;
DROP DATABASE TRANS;

go
SELECT * FROM information_schema.TABLES;
SELECT * FROM information_schema.COLUMNS;
SELECT 'EXECUTE ' + ROUTINE_NAME + ';' FROM information_schema.ROUTINES;

CREATE TABLE ServiceType
(
Id int constraint PK_SERVICE_TYPE primary key (Id) identity(1,1),
ServiceName varchar(50) NOT NULL UNIQUE,
UnitType varchar(15) NOT NULL CHECK (UnitType = 'Человек' or UnitType = 'Килограмм' or UnitType = 'Литр')
)

CREATE TABLE City
(
Id int constraint PK_CITY primary key(Id) identity(1,1),
CityName varchar(100) NOT NULL UNIQUE
)

CREATE TABLE Route
(
Id int constraint PK_ROUTE primary key(Id) identity(1,1),
RouteName varchar(100) NOT NULL UNIQUE,
Distance decimal(5,1) NOT NULL,
DeparturePoint varchar(100) NOT NULL constraint FK_CITYD_ROUTE foreign key (DeparturePoint) references City(CityName) ON DELETE CASCADE ON UPDATE CASCADE,
ArrivalPoint varchar(100) NOT NULL constraint FK_CITYA_ROUTE foreign key (ArrivalPoint) references City(CityName)
)

CREATE TABLE Customer
(
Id int  constraint PK_CUSTOMER primary key(Id) identity(1,1),
CustomerName varchar(300) UNIQUE NOT NULL
)

CREATE TABLE Service
(
Id int constraint PK_SERVICE primary key(Id) identity(1,1),
ServiceType varchar(50) NOT NULL constraint FK_SERVICE_SERVICETYPE foreign key (ServiceType) references ServiceType(ServiceName) ON DELETE CASCADE ON UPDATE CASCADE,
RouteName varchar(100) NOT NULL constraint FK_SERVICE_ROUTE foreign key (RouteName) references Route(RouteName) ON DELETE CASCADE ON UPDATE CASCADE,
CostPerUnit money NOT NULL DEFAULT '0'
)

CREATE TABLE [Order]
(
Id int constraint PK_Order primary key(Id) identity(1,1),
CustomerName varchar(300) NOT NULL constraint FK_ORDER_CUSTOMER foreign key (CustomerName) references Customer(CustomerName) ON DELETE CASCADE ON UPDATE CASCADE,
ServiceId int NOT NULL constraint FK_ORDER_SERVICE foreign key (ServiceId) references Service(Id) ON DELETE CASCADE ON UPDATE CASCADE,
UnitsAmount decimal(6,1) NOT NULL DEFAULT '0',
OrderDate datetime NOT NULL,
OrderExec datetime NOT NULL
)

