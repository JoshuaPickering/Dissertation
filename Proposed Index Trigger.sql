USE [TCP-H]
GO

/****** Object:  Trigger [dbo].[TrgIndex]    Script Date: 24/09/2023 10:10:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TrgIndex]
ON [dbo].[TPCSOURCE.PERFORMANCE]
FOR INSERT 
AS

Truncate table [dbo].[TPCSOURCE.INDEX]

INSERT INTO [dbo].[TPCSOURCE.INDEX]
           ([Database]
           ,[Table_Name]
           ,[Index_Improvement]
           ,[Index]
           ,[Index_Equality_Columns]
           ,[Index_InEqualityColumns]
           ,[Indexed_Columns]
           ,[Avg_TotalUserCost]
           ,[Avg_UserImpact]
           ,[Date])
   SELECT
    db.[name] AS [Database],
    OBJECT_NAME(Mi_Index_Details.[object_id], db.[database_id]) AS [Table_Name],
    Round((Mi_Group_Stats.avg_total_user_cost / 1000) + Mi_Group_Stats.avg_user_impact,0) * ( Mi_Group_Stats.user_seeks + Mi_Group_Stats.user_scans ) AS [Index_Improvement],
    'CREATE INDEX [IX_' + OBJECT_NAME(Mi_Index_Details.[object_id], db.[database_id]) + '_' + REPLACE(REPLACE(REPLACE(ISNULL(Mi_Index_Details.[equality_columns], ''), ', ', '_'), '[', ''), ']', '') + 
		CASE 
			WHEN Mi_Index_Details.[equality_columns] IS NOT NULL AND Mi_Index_Details.[inequality_columns] IS NOT NULL 
				THEN '_'
					ELSE '' 
					END + 
	REPLACE(REPLACE(REPLACE(ISNULL(Mi_Index_Details.[inequality_columns], ''), ', ', '_'), '[', ''), ']', '') + '_' + LEFT(CAST(NEWID() AS [NVARCHAR](64)), 5) + ']' + ' ON ' + Mi_Index_Details.[statement] + ' (' + ISNULL(Mi_Index_Details.[equality_columns], '') + 
		CASE 
			WHEN Mi_Index_Details.[equality_columns] IS NOT NULL AND Mi_Index_Details.[inequality_columns] IS NOT NULL 
				THEN ',' 
					ELSE '' 
						END + ISNULL(Mi_Index_Details.[inequality_columns], '') + ')' + ISNULL(' INCLUDE (' + Mi_Index_Details.[included_columns] + ')', '') 
	AS [Index],
    Mi_Index_Details.[equality_columns] AS [Index_Equality_Columns],
    Mi_Index_Details.[inequality_columns] AS [Index_InEqualityColumns],
    Mi_Index_Details.[included_columns] AS [Indexed_Columns],
    Mi_Group_Stats.[avg_total_user_cost] AS [Avg_TotalUserCost],
    Mi_Group_Stats.[avg_user_impact] AS [Avg_UserImpact],
    CAST(CURRENT_TIMESTAMP AS [SMALLDATETIME]) AS [Date]
FROM
    [sys].[dm_db_missing_index_group_stats] Mi_Group_Stats WITH ( NOLOCK )
    JOIN [sys].[dm_db_missing_index_groups] Mi_Index_Groups WITH ( NOLOCK ) ON Mi_Group_Stats.[group_handle] = Mi_Index_Groups.[index_group_handle]
    JOIN [sys].[dm_db_missing_index_details] Mi_Index_Details WITH ( NOLOCK ) ON Mi_Index_Groups.[index_handle] = Mi_Index_Details.[index_handle]
    JOIN [sys].[databases] db WITH ( NOLOCK ) ON db.[database_id] = Mi_Index_Details.[database_id]
WHERE
    db.[database_id] = DB_ID()
ORDER BY
    [Index_Improvement] DESC;


GO

ALTER TABLE [dbo].[TPCSOURCE.PERFORMANCE] ENABLE TRIGGER [TrgIndex]
GO


