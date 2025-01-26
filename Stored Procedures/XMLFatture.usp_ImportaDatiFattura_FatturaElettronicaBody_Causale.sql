SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLFatture].[usp_ImportaDatiFattura_FatturaElettronicaBody_Causale] (
	@codiceNumerico BIGINT = NULL,
	@codiceAlfanumerico NVARCHAR(40) = NULL,
	@PKStaging_FatturaElettronicaHeader BIGINT,
    @DatiGenerali_Causale NVARCHAR(200) = NULL,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT
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

		BEGIN TRY

            DECLARE @PKStaging_FatturaElettronicaBody BIGINT;

            SELECT @PKStaging_FatturaElettronicaBody = MAX(SFEB.PKStaging_FatturaElettronicaBody)
            FROM XMLFatture.Staging_FatturaElettronicaBody SFEB
            WHERE SFEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

            IF (
                @PKStaging_FatturaElettronicaBody IS NOT NULL
                AND (
                    @DatiGenerali_Causale IS NOT NULL
                )
            )
            BEGIN

                INSERT INTO XMLFatture.Staging_FatturaElettronicaBody_Causale
                (
                    --PKStaging_FatturaElettronicaBody_Causale,
                    PKStaging_FatturaElettronicaBody,
                    DatiGenerali_Causale
                )
                VALUES (
                    @PKStaging_FatturaElettronicaBody,
                    @DatiGenerali_Causale
                );
           

            END;

			COMMIT TRANSACTION;

			SET @PKEsitoEvento = 0; -- 0: Nessun errore
			SET @Messaggio = REPLACE('Inserimento dati Causale per fattura (#%PKStaging_FatturaElettronicaHeader%) completato', N'%PKStaging_FatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKStaging_FatturaElettronicaHeader));
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = @Messaggio,
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 2; -- 2: info

		END TRY
		BEGIN CATCH

			IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;

			SET @PKEsitoEvento = 212; -- 212: Eccezione in fase di inserimento XMLFatture.Staging_FatturaElettronicaBody*
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = N'Errore in inserimento dati Causale per fattura',
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 4; -- 4: error

		END CATCH

	END;

END;
GO
