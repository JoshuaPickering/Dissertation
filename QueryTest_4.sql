Declare @EndTime datetime 
Declare @StartTime datetime 
Declare @TestName as VARCHAR(255)=('Query Test 4')
Select @StartTime=GETDATE()

select
	o_orderpriority,
	count(*) as order_count
from
	TPCSOURCE.orders
where
	o_orderdate >= CAST('1996-01-07' as datetime)
	and o_orderdate < DATEADD(mm,3,'1996-01-07')
	and exists (
		select
			*
		from
			TPCSOURCE.lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
order by
	o_orderpriority;

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
	
