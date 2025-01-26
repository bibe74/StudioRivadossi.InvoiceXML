SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLFatture].[usp_ImportaFattura] (
	@codiceNumerico BIGINT = NULL,
	@codiceAlfanumerico NVARCHAR(40) = NULL,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@PKLanding_Fattura BIGINT OUTPUT
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

	IF (@PKEsitoEvento < 0)
	BEGIN

		BEGIN TRANSACTION;

		SET @PKLanding_Fattura = NEXT VALUE FOR XMLFatture.seq_Landing_Fattura;

		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = N'Recupero chiave per inserimento fattura',
									@LivelloLog = 0; -- 0: trace

		BEGIN TRY

			UPDATE XMLFatture.Landing_Fattura
			SET IsUltimaRevisione = CAST(0 AS BIT)
			WHERE ChiaveGestionale_CodiceNumerico = COALESCE(@codiceNumerico, -101)
				OR ChiaveGestionale_CodiceAlfanumerico = COALESCE(@codiceAlfanumerico, N'???');

			INSERT INTO XMLFatture.Landing_Fattura
			(
				PKLanding_Fattura,
				ChiaveGestionale_CodiceNumerico,
				ChiaveGestionale_CodiceAlfanumerico,
				IsUltimaRevisione
			)
			SELECT
				@PKLanding_Fattura AS PKLanding_Fattura,
				COALESCE(@codiceNumerico, 0) AS ChiaveGestionale_CodiceNumerico,
				COALESCE(@codiceAlfanumerico, N'') AS ChiaveGestionale_CodiceAlfanumerico,
				CAST(1 AS BIT) AS IsUltimaRevisione;

			COMMIT TRANSACTION;

			SET @PKEsitoEvento = 0; -- 0: Nessun errore
			SET @Messaggio = REPLACE('Inserimento fattura (#%PKLanding_Fattura%) completato', N'%PKLanding_Fattura%', CONVERT(NVARCHAR(10), @PKLanding_Fattura));
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = @Messaggio,
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 2; -- 2: info

		END TRY
		BEGIN CATCH

			IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;

			SET @PKLanding_Fattura = -1;

			SET @PKEsitoEvento = 103; -- 103: Eccezione in fase di inserimento XMLFatture.Landing_Fattura
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = N'Errore in inserimento fattura',
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 0; -- 0: trace

		END CATCH;

	END;

END;
GO
