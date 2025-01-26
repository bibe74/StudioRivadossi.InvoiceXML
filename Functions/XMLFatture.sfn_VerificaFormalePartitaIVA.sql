SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/**
 * @function XMLFatture.sfn_VerificaFormalePartitaIVA
 * @description Verifica formale partita IVA (funzione di sistema)

 * @param @PartitaIVA

 * @returns BIT
*/

CREATE   FUNCTION [XMLFatture].[sfn_VerificaFormalePartitaIVA] (
	@PartitaIVA VARCHAR(16)
)
RETURNS BIT
AS
BEGIN

	DECLARE @risultato BIT = 0;

	IF LEN(@PartitaIVA) = 11
	BEGIN
		DECLARE @index INT = 1;
		DECLARE @char CHAR(1);
		DECLARE @s INT;
		DECLARE @s1 INT;
		DECLARE @dispari BIT;
		DECLARE @r INT;
		DECLARE @c INT;

		SET @risultato = 1;
		SET @s = 0;
		SET @dispari = 1;

		WHILE (@index <= 11) AND (@risultato = 1)
		BEGIN
			SET @char = SUBSTRING(@PartitaIVA, @index, 1);
			IF (@char = '.') OR (ISNUMERIC(@char) = 0)
			BEGIN
				SET @risultato = 0;
			END;
			ELSE
			BEGIN
				IF @index = 11
				BEGIN
					SET @r = @s % 10;
					IF @r = 0
					BEGIN
						SET @c = 0;
					END;
					ELSE
					BEGIN
						SET @c = 10 - @r;
					END;
		
					IF @c <> CAST(@char AS INT)
					BEGIN
						SET @risultato = 0;
					END;
				END;
				ELSE
				BEGIN
					IF @dispari = 1
					BEGIN
						SET @s = @s + CAST(@char AS INT);
						SET @dispari = 0;
					END;
					ELSE
					BEGIN
						SET @s1 = CAST(@char AS INT) * 2 ;
						IF @s1 > 9
						BEGIN
							SET @s1 = @s1 - 9;
						END;
						SET @s = @s + @s1;
						SET @dispari = 1;
					END;
				END;
			END;
			SET @index = @index + 1;
		END;
	END;

	RETURN @risultato;

END;
GO
