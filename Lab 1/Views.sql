USE TRANS;

CREATE VIEW OrdersWithServices as
	SELECT [Order].Id,CustomerName,ServiceType,RouteName,UnitsAmount,CostPerUnit,
	(CAST (UnitsAmount * CostPerUnit AS VARCHAR) + ' $') 'TotalAmount', OrderDate,OrderExec FROM [ORDER] INNER JOIN SERVICE ON [ORDER].SERVICEID = SERVICE.ID;

CREATE VIEW NumberRouteOrders as
	SELECT B.RouteName, COUNT(A.RouteName) 'Количество поездок' FROM (
	(SELECT RouteName from [Order] inner join Service on ServiceId = Service.Id) as A right outer join 
	(SELECT RouteName from Route) as B on A.RouteName = B.RouteName)
	Group By B.RouteName;

CREATE VIEW CityRoutesDeparture as
	SELECT CityName, COUNT(Route.RouteName) 'Количество путей из этого города' from City left outer join Route  on Route.DeparturePoint = CityName group by CityName;