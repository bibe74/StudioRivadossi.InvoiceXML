SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLFatture].[ssp_VerificaParametriFattura] (
	@sp_name sysname,
	@codiceNumerico BIGINT = NULL,
	@codiceAlfanumerico NVARCHAR(40) = NULL,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Messaggio NVARCHAR(500);

	IF (@PKEvento IS NULL)
	BEGIN

		EXEC XMLAudit.ssp_GeneraEvento @chiaveGestionale_CodiceNumerico = @codiceNumerico,
										@chiaveGestionale_CodiceAlfanumerico = @codiceAlfanumerico,
										@storedProcedure = @sp_name,
										@PKEvento = @PKEvento OUTPUT;

		SET @PKEsitoEvento = -1;
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = N'Impostazione EsitoEvento di default (-1)',
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 0; -- 0: trace

	END;
	
	IF (@PKEsitoEvento IS NULL)
	BEGIN

		SET @PKEsitoEvento = -1;

	END;

	IF (@codiceNumerico IS NULL AND @codiceAlfanumerico IS NULL)
	BEGIN
		SET @PKEsitoEvento = 902; -- 902: Valorizzare almeno uno dei parametri @codiceNumerico e @codiceAlfanumerico
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = N'Parametri non validi',
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 4; -- 4: error
	END
	ELSE
	BEGIN

		IF (
			@sp_name = N'usp_ImportaFattura'
			OR @sp_name = N'usp_ImportaDatiFattura'
			OR @sp_name = N'usp_ConvalidaFattura'
		)
		BEGIN
		
			IF EXISTS(
				SELECT FEH.PKFatturaElettronicaHeader
				FROM XMLFatture.FatturaElettronicaHeader FEH
				INNER JOIN XMLFatture.Landing_Fattura LF ON LF.PKLanding_Fattura = FEH.PKLanding_Fattura
					AND (
						@codiceNumerico IS NULL
						OR LF.ChiaveGestionale_CodiceNumerico = @codiceNumerico
					)
					AND (
						@codiceAlfanumerico IS NULL
						OR LF.ChiaveGestionale_CodiceAlfanumerico = @codiceAlfanumerico
					)
				WHERE FEH.IsValidataDaSDI = CAST(1 AS BIT)
			)
			BEGIN

				SET @PKEsitoEvento = 903; -- 903: Fattura %CODICEFATTURA% già convalidata
				SELECT
					@Messaggio = REPLACE(E.Descrizione, N'%CODICEFATTURA%', COALESCE(@codiceAlfanumerico, N'#' + CONVERT(NVARCHAR(20), @codiceNumerico)))
			
				FROM XMLAudit.EsitoEvento E
				WHERE E.PKEsitoEvento = @PKEsitoEvento;

				EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
											@Messaggio = @Messaggio,
											@PKEsitoEvento = @PKEsitoEvento,
											@LivelloLog = 4; -- 4: error

			END;

		END;

	END;

END;
GO
