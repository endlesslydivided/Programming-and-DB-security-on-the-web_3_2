use TRANS;
go

EXEC sp_configure 'clr enabled',1;
go
reconfigure;

--drop assembly Lab3_Assembly; drop procedure GetRouteNumber; drop type dbo.Route;

go
create assembly Lab3_Assembly from 'D:\ALEX\STUDY\6SEM_3COURSE\Программирование и безопасность баз данных web-приложений\Готовые лабораторные\Lab 3\CLR Prodcedures Project\CLR Prodcedures Project\bin\Release\CLR_Prodcedures_Project.dll';

go
create procedure GetRouteNumber @StartDate datetime, @EndDate datetime
as
external name Lab3_Assembly.StoredProcedures.ProcedureDateTime;

go
EXEC dbo.GetRouteNumber @StartDate='01/01/2018',@EndDate='01/01/2020';

go
create type dbo.Route
external name Lab3_Assembly.RouteType;