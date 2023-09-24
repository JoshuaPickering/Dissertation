USE TPCH
GO

BULK INSERT tpcsource.part FROM 'C:\Users\joshu\Documents\TCP-H 100GB\part.tbl' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|')
BULK INSERT tpcsource.customer FROM 'C:\Users\joshu\Documents\TCP-H 100GB\customer.tbl' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|')
BULK INSERT tpcsource.orders FROM 'C:\Users\joshu\Documents\TCP-H 100GB\orders.tbl' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|')
BULK INSERT tpcsource.partsupp FROM 'C:\Users\joshu\Documents\TCP-H 100GB\partsupp.tbl' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|')
BULK INSERT tpcsource.supplier FROM 'C:\Users\joshu\Documents\TCP-H 100GB\supplier.tbl' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|')
BULK INSERT tpcsource.lineitem FROM 'C:\Users\joshu\Documents\TCP-H 100GB\lineitem.tbl' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|')
BULK INSERT tpcsource.nation FROM 'C:\Users\joshu\Documents\TCP-H 100GB\nation.tbl' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|')
BULK INSERT tpcsource.region FROM 'C:\Users\joshu\Documents\TCP-H 100GB\region.tbl' WITH (TABLOCK, DATAFILETYPE='char', CODEPAGE='raw', FIELDTERMINATOR = '|')