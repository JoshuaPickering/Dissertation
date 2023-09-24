USE [TCP-H]
GO

/****** Object:  Table [dbo].[TPCSOURCE.PERFORMANCE]    Script Date: 24/09/2023 10:15:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TPCSOURCE.PERFORMANCE](
	[Query_Test] [varchar](max) NULL,
	[Test_Duration] [int] NULL,
	[Start_Time] [datetime] NULL,
	[End_Time] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

