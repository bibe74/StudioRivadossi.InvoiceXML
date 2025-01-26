SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLFatture].[usp_ImportaDatiFattura_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] (
	@codiceNumerico BIGINT = NULL,
	@codiceAlfanumerico NVARCHAR(40) = NULL,
	@PKStaging_FatturaElettronicaHeader BIGINT,
    @SDI_NumeroLinea INT,
    @AltriDatiGestionali_TipoDato NVARCHAR(10) = NULL,
    @AltriDatiGestionali_RiferimentoTesto NVARCHAR(60) = NULL,
    @AltriDatiGestionali_RiferimentoNumero DECIMAL(20, 5) = NULL,
    @AltriDatiGestionali_RiferimentoData DATE = NULL,
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

            DECLARE @PKStaging_FatturaElettronicaBody_DettaglioLinee BIGINT;

            SELECT @PKStaging_FatturaElettronicaBody_DettaglioLinee = MAX(SFEBDL.PKStaging_FatturaElettronicaBody_DettaglioLinee)
            FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee SFEBDL
            INNER JOIN XMLFatture.Staging_FatturaElettronicaBody SFEB ON SFEB.PKStaging_FatturaElettronicaBody = SFEBDL.PKStaging_FatturaElettronicaBody
                AND SFEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
            WHERE SFEBDL.NumeroLinea = @SDI_NumeroLinea;

            IF (
                @PKStaging_FatturaElettronicaBody_DettaglioLinee IS NOT NULL
                AND (
                    @AltriDatiGestionali_TipoDato IS NOT NULL
                )
            )
            BEGIN

                INSERT INTO XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali
                (
                    --PKStaging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali,
                    PKStaging_FatturaElettronicaBody_DettaglioLinee,
                    AltriDatiGestionali_TipoDato,
                    AltriDatiGestionali_RiferimentoTesto,
                    AltriDatiGestionali_RiferimentoNumero,
                    AltriDatiGestionali_RiferimentoData
                )
                VALUES (
                    @PKStaging_FatturaElettronicaBody_DettaglioLinee,
                    @AltriDatiGestionali_TipoDato,
                    @AltriDatiGestionali_RiferimentoTesto,
                    @AltriDatiGestionali_RiferimentoNumero,
                    @AltriDatiGestionali_RiferimentoData
                );

            END;

			COMMIT TRANSACTION;

			SET @PKEsitoEvento = 0; -- 0: Nessun errore
			SET @Messaggio = REPLACE(REPLACE('Inserimento AltriDatiGestionali per riga fattura (#%PKStaging_FatturaElettronicaHeader%/%SDI_NumeroLinea%) completato', N'%PKStaging_FatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKStaging_FatturaElettronicaHeader)), N'%SDI_NumeroLinea%', CONVERT(NVARCHAR(10), @SDI_NumeroLinea));
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = @Messaggio,
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 2; -- 2: info

		END TRY
		BEGIN CATCH

			IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;

			SET @PKEsitoEvento = 212; -- 212: Eccezione in fase di inserimento XMLFatture.Staging_FatturaElettronicaBody*
			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = N'Errore in inserimento AltriDatiGestionali per riga fattura',
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 4; -- 4: error

		END CATCH

	END;

END;
GO
