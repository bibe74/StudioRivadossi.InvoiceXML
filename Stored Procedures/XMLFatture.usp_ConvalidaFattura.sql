SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLFatture].[usp_ConvalidaFattura] (
	@codiceNumerico BIGINT = NULL,
	@codiceAlfanumerico NVARCHAR(40) = NULL,
	@PKStaging_FatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@IsValida BIT OUTPUT,
	@PKValidazione BIGINT OUTPUT,
	@PKFatturaElettronicaHeader BIGINT OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @sp_name sysname = OBJECT_NAME(@@PROCID);
	DECLARE @Messaggio NVARCHAR(500);
	DECLARE @isUltimaRevisione_check BIT;
	DECLARE @PKStaging_FatturaElettronicaHeader_check BIGINT;

	EXEC XMLFatture.ssp_VerificaParametriFattura @sp_name = @sp_name,
	                                             @codiceNumerico = @codiceNumerico,
	                                             @codiceAlfanumerico = @codiceAlfanumerico,
	                                             @PKEvento = @PKEvento OUTPUT,
	                                             @PKEsitoEvento = @PKEsitoEvento OUTPUT;

	IF (@PKEsitoEvento < 0)
	BEGIN

		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = N'Verifica parametri fattura: OK',
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 0; -- 0: trace

		SELECT TOP 1
			@isUltimaRevisione_check = LF.IsUltimaRevisione

		FROM XMLFatture.Landing_Fattura LF
		WHERE (
			@codiceNumerico IS NULL
			OR LF.ChiaveGestionale_CodiceNumerico = @codiceNumerico
		)
		AND (
			@codiceAlfanumerico IS NULL
			OR LF.ChiaveGestionale_CodiceAlfanumerico = @codiceAlfanumerico
		)
		ORDER BY LF.PKLanding_Fattura DESC;

		IF (@isUltimaRevisione_check IS NULL)
		BEGIN

			SET @PKEsitoEvento = 304; -- 304: Fattura %CODICEFATTURA% non ancora trasmessa
			SELECT
				@Messaggio = REPLACE(E.Descrizione, N'%CODICEFATTURA%', COALESCE(@codiceAlfanumerico, N'#' + CONVERT(NVARCHAR(20), @codiceNumerico)))
			
			FROM XMLAudit.EsitoEvento E
			WHERE E.PKEsitoEvento = @PKEsitoEvento;

			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = @Messaggio,
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 4; -- 4: error

		END
		ELSE
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
										@Messaggio = N'Verifica esistenza ultima revisione: OK',
										@PKEsitoEvento = @PKEsitoEvento,
										@LivelloLog = 0; -- 0: trace

			SELECT TOP 1
				@PKStaging_FatturaElettronicaHeader_check = SFEH.PKStaging_FatturaElettronicaHeader

			FROM XMLFatture.Landing_Fattura LF
			INNER JOIN XMLFatture.Staging_FatturaElettronicaHeader SFEH ON SFEH.PKLanding_Fattura = LF.PKLanding_Fattura
			WHERE (
				@codiceNumerico IS NULL
				OR LF.ChiaveGestionale_CodiceNumerico = @codiceNumerico
			)
			AND (
				@codiceAlfanumerico IS NULL
				OR LF.ChiaveGestionale_CodiceAlfanumerico = @codiceAlfanumerico
			)
			AND LF.IsUltimaRevisione = CAST(1 AS BIT)
			ORDER BY LF.PKLanding_Fattura DESC;

			IF (@PKStaging_FatturaElettronicaHeader_check IS NULL)
			BEGIN

				SET @PKEsitoEvento = 305; -- 305: Revisione mancante per la fattura %CODICEFATTURA%
				SELECT
					@Messaggio = REPLACE(E.Descrizione, N'%CODICEFATTURA%', COALESCE(@codiceAlfanumerico, N'#' + CONVERT(NVARCHAR(20), @codiceNumerico)))
			
				FROM XMLAudit.EsitoEvento E
				WHERE E.PKEsitoEvento = @PKEsitoEvento;

				EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
											@Messaggio = @Messaggio,
											@PKEsitoEvento = @PKEsitoEvento,
											@LivelloLog = 4; -- 4: error

			END
			ELSE
			BEGIN

				IF (@PKStaging_FatturaElettronicaHeader_check <> @PKStaging_FatturaElettronicaHeader)
				BEGIN

					SET @PKEsitoEvento = 306; -- 306: Revisione #%PKStaging_FatturaElettronicaHeader% errata per la fattura %CODICEFATTURA%
					SELECT
						@Messaggio = REPLACE(REPLACE(E.Descrizione, N'%CODICEFATTURA%', COALESCE(@codiceAlfanumerico, N'#' + CONVERT(NVARCHAR(20), @codiceNumerico))), N'%PKStaging_FatturaElettronicaHeader%', @PKStaging_FatturaElettronicaHeader)
			
					FROM XMLAudit.EsitoEvento E
					WHERE E.PKEsitoEvento = @PKEsitoEvento;

					EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
												@Messaggio = @Messaggio,
												@PKEsitoEvento = @PKEsitoEvento,
												@LivelloLog = 4; -- 4: error

				END
				ELSE
				BEGIN

					EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
												@Messaggio = N'Verifica validità ultima revisione: OK',
												@PKEsitoEvento = @PKEsitoEvento,
												@LivelloLog = 0; -- 0: trace

					EXEC XMLAudit.ssp_GeneraValidazione @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader,
					                                      @PKEvento = @PKEvento,
					                                      @PKValidazione = @PKValidazione OUTPUT;

					EXEC XMLAudit.ssp_ConvalidaFatturaHeader @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader,
						@PKValidazione = @PKValidazione;

					EXEC XMLAudit.ssp_ConvalidaFatturaBody @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader,
						@PKValidazione = @PKValidazione;

					----INSERT INTO XMLAudit.Validazione_Riga
					----(
					----	--PKValidazione_Riga,
					----	PKValidazione,
					----	Campo,
					----	Messaggio,
					----	LivelloLog
					----)
					----VALUES
					----(
					----	@PKValidazione,
					----	N'<togliere>',
					----	N'segnaposto per non verifica validazione',
					----	4
					----);

					DECLARE @MaxLivelloLog TINYINT;
					SELECT @MaxLivelloLog = MAX(LivelloLog) FROM XMLAudit.Validazione_Riga WHERE PKValidazione = @PKValidazione;

					SET @IsValida = CASE WHEN @MaxLivelloLog < 4 THEN 1 ELSE 0 END;

					IF (@IsValida = CAST(1 AS BIT))
					BEGIN

						UPDATE XMLAudit.Validazione SET PKStato = 2, IsValida = @IsValida WHERE PKValidazione = @PKValidazione;
						EXEC XMLAudit.ssp_ScriviLogValidazione @PKValidazione = @PKValidazione,
						                                       @campo = N'',
						                                       @Messaggio = N'Validazione completata con successo',
						                                       @LivelloLog = 2;

						EXEC XMLFatture.ssp_EsportaFattura @PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader,
						                                   @PKEvento = @PKEvento,
						                                   @PKEsitoEvento = @PKEsitoEvento OUTPUT,
						                                   @PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader OUTPUT;

						EXEC XMLAudit.ssp_ScriviLogValidazione @PKValidazione = @PKValidazione,
						                                       @campo = N'',
						                                       @Messaggio = N'Esportazione fattura completata con successo',
						                                       @LivelloLog = 2;

					END;
					ELSE
					BEGIN

						EXEC XMLAudit.ssp_ScriviLogValidazione @PKValidazione = @PKValidazione,
						                                       @campo = N'',
						                                       @Messaggio = N'Validazione completata con errori (verificare log validazione)',
						                                       @LivelloLog = 4;

					END;

					UPDATE XMLFatture.Staging_FatturaElettronicaHeader SET IsValida = @IsValida, DataOraUltimaValidazione = CURRENT_TIMESTAMP WHERE PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
					EXEC XMLAudit.ssp_ScriviLogValidazione @PKValidazione = @PKValidazione,
						                                    @campo = N'',
						                                    @Messaggio = N'Aggiornamento validità fattura completato con successo',
						                                    @LivelloLog = 2;

				END;

			END;

		END;

	END;

END;
GO
