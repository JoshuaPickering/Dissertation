create schema TPCSOURCE;
GO

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TPCSOURCE.ORDERS') and o.name = 'FK_CUSTOMER')
alter table TPCSOURCE.ORDERS
   drop constraint FK_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TPCSOURCE.PARTSUPP') and o.name = 'FK_PART')
alter table TPCSOURCE.PARTSUPP
   drop constraint FK_PART
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TPCSOURCE.SUPPLIER') and o.name = 'FK_SUPPLIER_NATION')
alter table TPCSOURCE.SUPPLIER
   drop constraint FK_SUPPLIER_NATION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TPCSOURCE.CUSTOMER')
            and   type = 'U')
   drop table TPCSOURCE.CUSTOMER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TPCSOURCE.LINEITEM')
            and   type = 'U')
   drop table TPCSOURCE.LINEITEM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TPCSOURCE.NATION')
            and   type = 'U')
   drop table TPCSOURCE.NATION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TPCSOURCE.ORDERS')
            and   type = 'U')
   drop table TPCSOURCE.ORDERS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TPCSOURCE.PART')
            and   type = 'U')
   drop table TPCSOURCE.PART
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TPCSOURCE.PARTSUPP')
            and   type = 'U')
   drop table TPCSOURCE.PARTSUPP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TPCSOURCE.REGION')
            and   type = 'U')
   drop table TPCSOURCE.REGION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TPCSOURCE.SUPPLIER')
            and   type = 'U')
   drop table TPCSOURCE.SUPPLIER
go

drop schema TPCSOURCE
go

create schema TPCSOURCE
go

create table TPCSOURCE.REGION (
   R_REGIONKEY          decimal(11)          not null,
   R_NAME               char(25)             null,
   R_COMMENT            varchar(152)         null,
   constraint PK_REGION primary key (R_REGIONKEY)
)
go

create table TPCSOURCE.NATION (
   N_NATIONKEY          decimal(11)          not null,
   N_NAME               char(25)             null,
   N_REGIONKEY          decimal(11)          null,
   N_COMMENT            varchar(152)         null,
   constraint PK_NATION primary key (N_NATIONKEY),
   constraint FK_REGION foreign key (N_REGIONKEY)
      references TPCSOURCE.REGION (R_REGIONKEY)
)
go

create table TPCSOURCE.CUSTOMER (
   C_CUSTKEY            decimal(11)          not null,
   C_NAME               varchar(25)          null,
   C_ADDRESS            varchar(40)          null,
   C_NATIONKEY          decimal(11)          null,
   C_PHONE              char(15)             null,
   C_ACCTBAL            decimal(12,2)        null,
   C_MKTSEGMENT         char(10)             null,
   C_COMMENT            varchar(117)         null,
   constraint PK_CUSTOMER primary key (C_CUSTKEY),
   constraint FK_CUSTOMER_NATION foreign key (C_NATIONKEY)
      references TPCSOURCE.NATION (N_NATIONKEY)
)
go

create table TPCSOURCE.ORDERS (
   O_ORDERKEY           decimal(11)          not null,
   O_CUSTKEY            decimal(11)          null,
   O_ORDERSTATUS        char(1)              null,
   O_TOTALPRICE         decimal(12,2)        null,
   O_ORDERDATE          datetime             null,
   O_ORDERPRIORITY      char(15)             null,
   O_CLERK              char(15)             null,
   O_SHIPPRIORITY       decimal(10)          null,
   O_COMMENT            varchar(79)          null,
   constraint PK_ORDERS primary key (O_ORDERKEY),
   constraint FK_CUSTOMER foreign key (O_CUSTKEY)
      references TPCSOURCE.CUSTOMER (C_CUSTKEY)
)
go

create table TPCSOURCE.PART (
   P_PARTKEY            decimal(11)          not null,
   P_NAME               varchar(55)          null,
   P_MFGR               char(25)             null,
   P_BRAND              char(10)             null,
   P_TYPE               varchar(25)          null,
   P_SIZE               decimal(10)          null,
   P_CONTAINER          char(10)             null,
   P_RETAILPRICE        decimal(12,2)        null,
   P_COMMENT            varchar(23)          null,
   constraint PK_PART primary key (P_PARTKEY)
)
go

create table TPCSOURCE.SUPPLIER (
   S_SUPPKEY            decimal(11)          not null,
   S_NAME               char(25)             null,
   S_ADDRESS            varchar(40)          null,
   S_NATIONKEY          decimal(11)          null,
   S_PHONE              char(15)             null,
   S_ACCTBAL            decimal(12,2)        null,
   S_COMMENT            varchar(101)         null,
   constraint PK_SUPPLIER primary key (S_SUPPKEY),
   constraint FK_SUPPLIER_NATION foreign key (S_NATIONKEY)
      references TPCSOURCE.NATION (N_NATIONKEY)
)
go

create table TPCSOURCE.PARTSUPP (
   PS_PARTKEY           decimal(11)          not null,
   PS_SUPPKEY           decimal(11)          not null,
   PS_AVAILQTY          decimal(10)          null,
   PS_SUPPLYCOST        decimal(12,2)        null,
   PS_COMMENT           varchar(199)         null,
   constraint PK_PARTSUPP primary key (PS_PARTKEY, PS_SUPPKEY),
   constraint FK_PART foreign key (PS_PARTKEY)
      references TPCSOURCE.PART (P_PARTKEY),
   constraint FK_SUPP foreign key (PS_SUPPKEY)
      references TPCSOURCE.SUPPLIER (S_SUPPKEY)
)
go

create table TPCSOURCE.LINEITEM (
   L_ORDERKEY           decimal(11)          not null,
   L_PARTKEY            decimal(11)          null,
   L_SUPPKEY            decimal(11)          null,
   L_LINENUMBER         decimal(10)          not null,
   L_QUANTITY           decimal(12,2)        null,
   L_EXTENDEDPRICE      decimal(12,2)        null,
   L_DISCOUNT           decimal(12,2)        null,
   L_TAX                decimal(12,2)        null,
   L_RETURNFLAG         char(1)              null,
   L_LINESTATUS         char(1)              null,
   L_SHIPDATE           datetime             null,
   L_COMMITDATE         datetime             null,
   L_RECEIPTDATE        datetime             null,
   L_SHIPINSTRUCT       char(25)             null,
   L_SHIPMODE           char(10)             null,
   L_COMMENT            varchar(44)          null,
   constraint PK_LINEITEM primary key (L_ORDERKEY, L_LINENUMBER),
   constraint FK_ORDER foreign key (L_ORDERKEY)
      references TPCSOURCE.ORDERS (O_ORDERKEY),
   constraint FK_PARTSUPP foreign key (L_PARTKEY, L_SUPPKEY)
      references TPCSOURCE.PARTSUPP (PS_PARTKEY, PS_SUPPKEY)
)
go
