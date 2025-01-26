SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLFatture].[ssp_EsportaFattura] (
	@PKStaging_FatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@PKFatturaElettronicaHeader BIGINT OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @sp_name sysname = OBJECT_NAME(@@PROCID);
	DECLARE @Messaggio NVARCHAR(500);

	--BEGIN TRANSACTION;

	SET @PKFatturaElettronicaHeader = NEXT VALUE FOR XMLFatture.seq_FatturaElettronicaHeader;

	EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
								@Messaggio = N'Recupero chiave per esportazione fattura',
								@LivelloLog = 0; -- 0: trace

	BEGIN TRY

		PRINT REPLACE(REPLACE('@PKStaging_FatturaElettronicaHeader #%PKStaging_FatturaElettronicaHeader% > @PKFatturaElettronicaHeader #%PKFatturaElettronicaHeader%', '%PKStaging_FatturaElettronicaHeader%', CONVERT(NVARCHAR(20), @PKStaging_FatturaElettronicaHeader)), '%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(20), @PKFatturaElettronicaHeader));

		EXEC XMLFatture.ssp_EsportaFatturaHeader @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader,
		                                         @PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader,
		                                         @PKEvento = @PKEvento,
		                                         @PKEsitoEvento = @PKEsitoEvento OUTPUT;

		IF (@PKEsitoEvento < 0)
		BEGIN

			EXEC XMLFatture.ssp_EsportaFatturaBody @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader,
			                                       @PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader,
			                                       @PKEvento = @PKEvento,
			                                       @PKEsitoEvento = @PKEsitoEvento OUTPUT;

			SET @PKEsitoEvento = 0;
			SET @Messaggio = REPLACE('Esportazione righe fattura #%PKFatturaElettronicaHeader% completata', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader));
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = @Messaggio,
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 2; -- 2: info
		END;

	END TRY
	BEGIN CATCH

		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;

		SET @PKStaging_FatturaElettronicaHeader = -1;

		SET @PKEsitoEvento = 350; -- 350: Errore generico in fase di esportazione fattura
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = N'Errore generico in fase di esportazione fattura',
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 4; -- 4: error

	END CATCH;

END;
GO
