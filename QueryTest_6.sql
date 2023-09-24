Declare @EndTime datetime 
Declare @StartTime datetime 
Declare @TestName as VARCHAR(255)=('Query Test 6')
Select @StartTime=GETDATE()


select
	sum(l_extendedprice * l_discount) as revenue
from
	TPCSOURCE.lineitem
where
	l_shipdate >= CAST('1994-01-01' as datetime)
	and l_shipdate < DATEADD(YYYY,1,'1994-01-01')
	and l_discount between .06 - 0.01 and .06 + 0.01
	and l_quantity < 24;

Select @EndTime=GETDATE()

Insert into [TPCSOURCE.PERFORMANCE] 
	([Query_Test],
	[Test_Duration], 
	[Start_Time],
	[End_Time])
	Select
	(select @TestName),
	(select DATEDIFF(MILLISECOND,@StartTime,@EndTime)),
	(select @StartTime),
	(select @EndTime)
	;
	
