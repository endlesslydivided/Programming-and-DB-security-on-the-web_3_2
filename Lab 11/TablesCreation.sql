
CREATE TABLE ServiceType
(
Id INTEGER PRIMARY KEY AUTOINCREMENT ,
ServiceName TEXT NOT NULL UNIQUE,
UnitType TEXT NOT NULL CHECK (UnitType = 'Человек' or UnitType = 'Килограмм' or UnitType = 'Литр')
);

CREATE TABLE City
(
Id INTEGER PRIMARY KEY AUTOINCREMENT ,
CityName TEXT NOT NULL UNIQUE
);

CREATE TABLE Route
(
Id INTEGER PRIMARY KEY AUTOINCREMENT ,
RouteName TEXT NOT NULL UNIQUE,
Distance REAL NOT NULL,
DeparturePoint TEXT NOT NULL,
ArrivalPoint TEXT NOT NULL,
foreign key (DeparturePoint) references City(CityName) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (ArrivalPoint) references City(CityName)
);

CREATE TABLE Customer
(
Id INTEGER PRIMARY KEY AUTOINCREMENT ,
CustomerName TEXT UNIQUE NOT NULL
);

CREATE TABLE Service
(
Id INTEGER PRIMARY KEY AUTOINCREMENT ,
ServiceType TEXT NOT NULL,
RouteName TEXT NOT NULL,
CostPerUnit INTEGER NOT NULL DEFAULT '0',
foreign key (ServiceType) references ServiceType(ServiceName) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (RouteName) references Route(RouteName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE [Order]
(
Id INTEGER PRIMARY KEY AUTOINCREMENT ,
CustomerName TEXT NOT NULL,
ServiceId INTEGER NOT NULL,
UnitsAmount REAL NOT NULL DEFAULT '0',
OrderDate TEXT NOT NULL,
OrderExec TEXT NOT NULL,
foreign key (CustomerName) references Customer(CustomerName) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (ServiceId) references Service(Id) ON DELETE CASCADE ON UPDATE CASCADE
)

