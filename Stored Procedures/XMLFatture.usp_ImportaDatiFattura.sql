SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLFatture.usp_ImportaDatiFattura
 * @description Importazione dati fattura da gestionale

 * @input_param @codiceNumerico
 * @input_param @codiceAlfanumerico
 * @input_param @PKLanding_Fattura
 
 * @output_param @PKEvento
 * @output_param @PKEsitoEvento
 * @output_param @PKStaging_FatturaElettronicaHeader
*/

CREATE   PROCEDURE [XMLFatture].[usp_ImportaDatiFattura] (
	@codiceNumerico BIGINT = NULL,
	@codiceAlfanumerico NVARCHAR(40) = NULL,
	@PKLanding_Fattura BIGINT,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@PKStaging_FatturaElettronicaHeader BIGINT OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @sp_name sysname = OBJECT_NAME(@@PROCID);
	DECLARE @Messaggio NVARCHAR(500);

	EXEC XMLFatture.ssp_VerificaParametriFattura @sp_name = @sp_name,
	                                             @codiceNumerico = @codiceNumerico,
	                                             @codiceAlfanumerico = @codiceAlfanumerico,
	                                             @PKEvento = @PKEvento OUTPUT,
	                                             @PKEsitoEvento = @PKEsitoEvento OUTPUT;

	SELECT @PKEsitoEvento AS PKEsitoEvento;

	IF (@PKEsitoEvento < 0)
	BEGIN

		BEGIN TRANSACTION;

		SELECT @PKStaging_FatturaElettronicaHeader = NEXT VALUE FOR XMLFatture.seq_Staging_FatturaElettronicaHeader;

		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = N'Recupero chiave per inserimento dati fattura',
									@LivelloLog = 0; -- 0: trace

		BEGIN TRY

			INSERT INTO XMLFatture.Staging_FatturaElettronicaHeader
			(
				PKStaging_FatturaElettronicaHeader,
				PKLanding_Fattura
			)
			SELECT
				@PKStaging_FatturaElettronicaHeader,
				F.PKLanding_Fattura

			FROM XMLFatture.Landing_Fattura F
			WHERE F.PKLanding_Fattura = @PKLanding_Fattura
			AND (
				F.ChiaveGestionale_CodiceNumerico = @codiceNumerico
				OR F.ChiaveGestionale_CodiceAlfanumerico = @codiceAlfanumerico
			);

			COMMIT TRANSACTION;

			SET @PKEsitoEvento = 0; -- 0: Nessun errore
			SET @Messaggio = REPLACE('Inserimento record per dati fattura (#%PKStaging_FatturaElettronicaHeader%) completato', N'%PKStaging_FatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKStaging_FatturaElettronicaHeader));
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = @Messaggio,
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 2; -- 2: info

		END TRY
		BEGIN CATCH

			IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;

			SET @PKLanding_Fattura = -1;

			SET @PKEsitoEvento = 203; -- 203: Eccezione in fase di inserimento XMLFatture.Staging_FatturaElettronicaHeader
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = N'Errore in inserimento record per dati fattura',
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 0; -- 0: trace

		END CATCH

	END;

END;
GO
