Declare @EndTime datetime 
Declare @StartTime datetime 
Declare @TestName as VARCHAR(255)=('Query Test 3')
Select @StartTime=GETDATE()

select
	l_orderkey,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	o_orderdate,
	o_shippriority
from
	tpcsource.customer,
	tpcsource.orders,
	tpcsource.lineitem
where
	c_mktsegment = 'BUILDING'
	and c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate < CAST('1995-03-12' as datetime)
	and l_shipdate > CAST('1995-03-12' as datetime) 
group by
	l_orderkey,
	o_orderdate,
	o_shippriority
order by
	revenue desc,
	o_orderdate;

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
	

