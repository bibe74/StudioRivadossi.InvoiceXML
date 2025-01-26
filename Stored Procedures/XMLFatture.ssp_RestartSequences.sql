SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLFatture].[ssp_RestartSequences]
AS
BEGIN

/* declare variables */
DECLARE @sequenceName sysname;
DECLARE @maxValue INT = 0;
DECLARE @sqlStatement NVARCHAR(4000);

DECLARE curSequence CURSOR FAST_FORWARD READ_ONLY FOR SELECT name FROM sys.sequences WHERE name NOT LIKE N'seq_Validazione%';

OPEN curSequence;

FETCH NEXT FROM curSequence INTO @sequenceName;

WHILE @@FETCH_STATUS = 0
BEGIN
    
    SET @sqlStatement = REPLACE(N'SELECT @maxValue = MAX(PK%TABLE_NAME%) FROM XMLFatture.%TABLE_NAME%;', N'%TABLE_NAME%', REPLACE(@sequenceName, N'seq_', N''));
    EXEC sp_executesql @stmt = @sqlStatement,
        @params = N'@maxValue INT OUTPUT',
        @maxValue = @maxValue OUTPUT;
    PRINT 'ALTER SEQUENCE XMLFatture.' + @sequenceName + ' RESTART WITH ' + CONVERT(NVARCHAR(10), @maxValue) + ';';

    FETCH NEXT FROM curSequence INTO @sequenceName;
END;

CLOSE curSequence;
DEALLOCATE curSequence;

END;
GO
