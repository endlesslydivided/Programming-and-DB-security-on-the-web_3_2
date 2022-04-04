CREATE VIEW NumberRouteOrders AS
    SELECT B.RouteName "Название маршрута",
           COUNT(A.RouteName) "Количество поездок"
      FROM (
               (
                   SELECT RouteName
                     FROM [Order]
                          INNER JOIN
                          Service ON ServiceId = Service.Id
               )
               AS A
               INNER JOIN
               (
                   SELECT RouteName
                     FROM Route
               )
               AS B ON A.RouteName = B.RouteName
           )
     GROUP BY B.RouteName;

