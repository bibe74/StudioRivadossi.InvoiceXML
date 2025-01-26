SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [XMLFatture].[sfn_VerificaFormaleCodiceFiscale] (
	@CodiceFiscale VARCHAR(16),
	@CheckPartitaIVA BIT = 0
)
RETURNS BIT
AS
BEGIN

	DECLARE @risultato BIT = 0;

	IF LEN(@CodiceFiscale) = 16
	BEGIN
		IF @CodiceFiscale LIKE '[A-Z][A-Z][A-Z][A-Z][A-Z][A-Z][0-9][0-9][A-Z][0-9][0-9][A-Z][0-9][0-9][0-9][A-Z]'
		BEGIN
			SET @risultato = 1;
		END;
	END;

	IF (@CheckPartitaIVA = CAST(1 AS BIT) AND LEN(@CodiceFiscale) = 11)
	BEGIN
		SELECT @risultato = XMLFatture.sfn_VerificaFormalePartitaIVA(@CodiceFiscale);
	END;

	RETURN @risultato;

END;
GO
