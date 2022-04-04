go
use TRANS
go

--				Task 1
create table Report (
id INTEGER primary key identity(1,1),
xml_column XML
);

--				Task 2
go
create procedure generateXML
as
declare @x XML
set @x = (Select row_number() OVER (ORDER BY final.Заказчик ) as id , final.Заказчик [Customer], final.[Название маршрута] [Route], final.[Количество поездок] [RouteCount],GETDATE() [Date] 
from (SELECT A.CustomerName 'Заказчик', B.RouteName 'Название маршрута', COUNT(A.RouteName) 'Количество поездок' FROM (
	(SELECT CustomerName, ServiceType, UnitsAmount, RouteName from [Order] inner join Service on ServiceId = Service.Id) as A right outer join 
	(SELECT RouteName from Route) as B on A.RouteName = B.RouteName)
	Group By A.CustomerName , B.RouteName) as final where Заказчик is not null
FOR XML AUTO);
SELECT @x;

go
execute generateXML;

--				Task 3
go
create procedure InsertInReport
as
DECLARE  @s XML  
SET @s = (Select row_number() OVER (ORDER BY final.Заказчик ) as id , final.Заказчик [Customer], final.[Название маршрута] [Route], final.[Количество поездок] [RouteCount],GETDATE() [Date] 
from (SELECT A.CustomerName 'Заказчик', B.RouteName 'Название маршрута', COUNT(A.RouteName) 'Количество поездок' FROM (
	(SELECT CustomerName, ServiceType, UnitsAmount, RouteName from [Order] inner join Service on ServiceId = Service.Id) as A right outer join 
	(SELECT RouteName from Route) as B on A.RouteName = B.RouteName)
	Group By A.CustomerName , B.RouteName) as final where Заказчик is not null
FOR XML RAW);
insert into Report values(@s);

go
execute InsertInReport
select * from Report;

--				Task 4

create primary xml index XMLIndex on Report(xml_column)
create xml index XMLIndex_sec on Report(xml_column)
using xml index XMLIndex for path

--				Task 5
go
create or alter procedure SelectData @query nvarchar(max)
as
execute('select xml_column.query(''' + @query + ''') as[xml_column] from Report for xml auto, type')

go
execute SelectData '/row';
execute SelectData 'row[@id = "5"]';
execute SelectData '/row[3]';
execute SelectData '/*';
