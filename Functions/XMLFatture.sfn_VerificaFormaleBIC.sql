SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [XMLFatture].[sfn_VerificaFormaleBIC] (
	@BIC VARCHAR(100)
)
RETURNS BIT
AS
BEGIN

	DECLARE @risultato BIT = 0;

    IF (@BIC IS NOT NULL)
    BEGIN
        IF (LEN(@BIC) IN (8, 11))
        BEGIN
            IF (SUBSTRING(@BIC, 1, 1) LIKE '[A-Z]')
                AND (SUBSTRING(@BIC, 2, 1) LIKE '[A-Z]')
                AND (SUBSTRING(@BIC, 3, 1) LIKE '[A-Z]')
                AND (SUBSTRING(@BIC, 4, 1) LIKE '[A-Z]')
                AND (SUBSTRING(@BIC, 5, 1) LIKE '[A-Z]')
                AND (SUBSTRING(@BIC, 6, 1) LIKE '[A-Z]')
                AND (SUBSTRING(@BIC, 7, 1) LIKE '[A-Z]' OR SUBSTRING(@BIC, 7, 1) LIKE '[2-9]')
                AND (SUBSTRING(@BIC, 8, 1) LIKE '[A-N]' OR SUBSTRING(@BIC, 8, 1) LIKE '[P-Z]' OR SUBSTRING(@BIC, 8, 1) LIKE '[0-9]')
            BEGIN
                IF (LEN(@BIC) = 8)
                BEGIN
                    SET @risultato = 1;
                END;

                IF (LEN(@BIC) = 11)
                BEGIN
                    IF (SUBSTRING(@BIC, 9, 1) LIKE '[A-Z]' OR SUBSTRING(@BIC, 9, 1) LIKE '[0-9]')
                        AND (SUBSTRING(@BIC, 10, 1) LIKE '[A-Z]' OR SUBSTRING(@BIC, 10, 1) LIKE '[0-9]')
                        AND (SUBSTRING(@BIC, 11, 1) LIKE '[A-Z]' OR SUBSTRING(@BIC, 11, 1) LIKE '[0-9]')
                    BEGIN
                        SET @risultato = 1;
                    END;
                END;
            END;
        END;
    END;

	RETURN @risultato;

END;
GO
