Declare @EndTime datetime 
Declare @StartTime datetime 
Declare @TestName as VARCHAR(255)=('Query Test 5')
Select @StartTime=GETDATE()

select
	n_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue
from
	TPCSOURCE.customer,
	TPCSOURCE.orders,
	TPCSOURCE.lineitem,
	TPCSOURCE.supplier,
	TPCSOURCE.nation,
	TPCSOURCE.region
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and l_suppkey = s_suppkey
	and c_nationkey = s_nationkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'ASIA'
	and o_orderdate >= CAST('1994-01-01' as datetime)
	and o_orderdate < DATEADD(YYYY,1,'1994-01-01')
group by
	n_name
order by
	revenue desc;


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
	