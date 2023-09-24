USE [TCP-H]
GO

/****** Object:  Table [dbo].[TPCSOURCE.INDEX]    Script Date: 24/09/2023 10:16:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TPCSOURCE.INDEX](
	[Database] [varchar](max) NULL,
	[Table_Name] [varchar](max) NULL,
	[Index_Improvement] [float] NULL,
	[Index] [varchar](max) NULL,
	[Index_Equality_Columns] [varchar](max) NULL,
	[Index_InEqualityColumns] [varchar](max) NULL,
	[Indexed_Columns] [varchar](max) NULL,
	[Avg_TotalUserCost] [float] NULL,
	[Avg_UserImpact] [float] NULL,
	[Date] [smalldatetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

