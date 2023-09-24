Declare @EndTime datetime 
Declare @StartTime datetime 
Declare @TestName as VARCHAR(255)=('Query Test 10')
Select @StartTime=GETDATE()


select
	c_custkey,
	c_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue,
	c_acctbal,
	n_name,
	c_address,
	c_phone,
	c_comment
from
	TPCSOURCE.customer,
	TPCSOURCE.orders,
	TPCSOURCE.lineitem,
	TPCSOURCE.nation
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate >= CAST('1993-10-01' as datetime)
	and o_orderdate < DATEADD(mm,3,'1993-10-01')
	and l_returnflag = 'R'
	and c_nationkey = n_nationkey
group by
	c_custkey,
	c_name,
	c_acctbal,
	c_phone,
	n_name,
	c_address,
	c_comment
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
	
