use TRANS;

--1
SELECT Id,CustomerName,OrderDate,ServiceId FROM [Order] 
SELECT Id,CustomerName,OrderDate,ServiceId FROM [Order] where OrderDate between '01/01/2018' and '01/05/2018';
SELECT count(*) [Объём заказов]  FROM [Order] where OrderDate between '01/01/2018' and '01/05/2018';
---------------------------------------

begin
	DECLARE @t table (a float);
	DECLARE @dateOne date = '01/01/2018';
	DECLARE @dateTwo date = '01/05/2018';
	DECLARE @counts1 float;
	DECLARE @counts2 float;
	DECLARE @max float;
	DECLARE @datafromrange float;
	declare @countMax float;
	SELECT @datafromrange =  COUNT(*) from [Order] Where [Order].OrderDate BETWEEN @dateOne AND @dateTwo;
	SELECT @counts1  = COUNT(*) from [Order];
	SELECT @countMax = T.K from ( SELECT TOP(1)  COUNT(ServiceId)  as K  from [Order] Where [Order].OrderDate BETWEEN @dateOne AND @dateTwo  group by ServiceId order by K desc) as T;

	insert into @t (a) select @counts1 union all select @counts2

	DECLARE @middle float =  100 *(@datafromrange/@counts1);
	SELECT @max = MAX(a) from @t;
	DECLARE @maxdata float = 100 *(@countMax/@datafromrange);

	print(' ');
	print('Общий объём услуг в промежуток между '+ CAST(@dateOne as varchar) +' и ' +CAST(@dateTwo as varchar) + ': '+ CAST(@datafromrange as varchar))
	print ('Сравнение общего объёма услуг с объёмом услуг за промежуток между '+ CAST(@dateOne as varchar) +' и ' +CAST(@dateTwo as varchar) + ': '+ CAST(@middle as varchar) + '%')
	print('Сравнение максиамального объёма услуг и  всего объёма услуг за промежуток между '+ CAST(@dateOne as varchar) +' и ' +CAST(@dateTwo as varchar) + ': '+ CAST(@maxdata as varchar) + '%')
end;

--3
SELECT * , ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY CustomerName) AS rownum FROM [Order];

--4. 

begin transaction
SELECT * , ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY CustomerName) AS rownum FROM [Order];

	delete x from 
	(
	  select *, rn=row_number() OVER(PARTITION BY CustomerName ORDER BY CustomerName) 
	  from [Order] 
	) x
	where rn > 1;

SELECT * , ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY CustomerName) AS rownum FROM [Order];
rollback;


--5
SELECT * FROM (Select CustomerName,[Service].RouteName, OrderDate,  ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY OrderDate desc) AS rownum from [Order] inner join [Service]  on [Order].ServiceId = [Service].Id) AS R
where rownum between 1 and 6;

--6
   
	begin
	   DROP TABLE if exists #ResultSet ;
	   Select CustomerName, ServiceId,
	   RANK() OVER (PARTITION BY CustomerName ORDER BY Count(ServiceId)) AS [RANK], Count(ServiceId) [Количество Заказов]
	   into #ResultSet
	   FROM [Order]
	   GROUP BY CustomerName, ServiceId ORDER BY CustomerName ,ServiceId;
	   select * from #ResultSet;
	   select CustomerName,ServiceId,[RANK],[Количество Заказов] from (
					select CustomerName,ServiceId, ROW_NUMBER() OVER(PARTITION BY CustomerName ORDER BY CustomerName DESC) rn,[RANK],[Количество Заказов]  from 
						(select CustomerName,ServiceId,MAX([RANK]) [RANK],[Количество Заказов] from #ResultSet group by CustomerName,ServiceId,[Количество Заказов] having MAX([RANK]) 
							in (select MAX([RANK]) from #ResultSet group by CustomerName)
						) as t
					 )AS RESULTSET
		WHERE rn <= 1

	end;

   