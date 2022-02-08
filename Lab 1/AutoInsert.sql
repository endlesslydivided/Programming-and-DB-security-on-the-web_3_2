Use TRANS;

go
Create Procedure AI_ORDERS AS
Begin
DECLARE 
		@CustomerName varchar(300),
		@ServiceId int,
		@UnitsAmount int,
		@OrderDate datetime,
		@OrderExec datetime,
		@number int;
SET @number = 1;
While @number <= 10000
	BEGIN
	SET @CustomerName = (
	SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (SELECT CustomerName from Customer) AS T1(c1) ORDER BY ABS(CHECKSUM(NEWID())) ) AS T2 FOR XML PATH('')
	);
	SET @ServiceId = (
	SELECT c1 AS [text()] FROM (SELECT TOP (1) c1 FROM (SELECT Id from Service) AS T1(c1) ORDER BY ABS(CHECKSUM(NEWID())) ) AS T2 FOR XML PATH('')
	);
	SET @OrderDate = (SELECT DATEADD(SECOND,FLOOR(rand()*60),DATEADD(MINUTE,FLOOR(rand()*60),DATEADD(HOUR, FLOOR(rand()*24),DATEADD(DAY, FLOOR(rand()*500), '20180101')))));
	SET @OrderExec =  (SELECT DATEADD(MINUTE,FLOOR(rand()*60),DATEADD(HOUR, FLOOR(rand()*24),DATEADD(DAY, FLOOR(rand()*500), @OrderDate))));
	SET @UnitsAmount =  (SELECT FLOOR(RAND()*(100-30)+30));


	Insert into [Order](CustomerName,ServiceId,UnitsAmount,OrderDate,OrderExec)
		values(@CustomerName,
		@ServiceId,
		@UnitsAmount,
		@OrderDate,
		@OrderExec);
	SET @number = @number + 1;
	END;
End;

EXECUTE AI_ORDERS;


