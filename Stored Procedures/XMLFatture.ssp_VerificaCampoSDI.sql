SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [XMLFatture].[ssp_VerificaCampoSDI] (
	@PKValidazione BIGINT,
	@IDCampo NVARCHAR(20),
	@TipoValore CHAR(1) = 'T', -- T: Testo, I: Intero, D: Decimale, E: Data
	@ValoreTesto NVARCHAR(100) = NULL,
	@ValoreIntero INT = NULL,
	@ValoreDecimale DECIMAL(28, 12) = NULL,
	@ValoreData DATE = NULL,
	@IsObbligatorio BIT = 1,
	@IDNazione CHAR(2) = NULL,
	@NumeroLinea INT = NULL
)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @NomeElemento NVARCHAR(100);
	DECLARE @NomeElementoFull NVARCHAR(255);
	DECLARE @DescrizioneCampo NVARCHAR(100);
	DECLARE @PKEvento BIGINT;
	DECLARE @Messaggio NVARCHAR(500);

	SELECT @NomeElemento = NomeElemento,
		@NomeElementoFull = NomeElementoFull
	FROM XMLCodifiche.CampiXML
	WHERE IndiceElemento = @IDCampo;

	SELECT @PKEvento = V.PKEvento
	FROM XMLAudit.Validazione V
	WHERE V.PKValidazione = @PKValidazione;

	--SET @DescrizioneCampo = REPLACE(REPLACE(N'%NOME_ELEMENTO% (%INDICE_ELEMENTO%)', N'%NOME_ELEMENTO%', COALESCE(@NomeElemento, N'')), N'%INDICE_ELEMENTO%', @IDCampo);
	SET @DescrizioneCampo = REPLACE(REPLACE(REPLACE(N'%NOME_ELEMENTO_FULL% (%INDICE_ELEMENTO%%RIGA_ELEMENTO%)', N'%NOME_ELEMENTO_FULL%', COALESCE(@NomeElementoFull, N'')), N'%INDICE_ELEMENTO%', @IDCampo), N'%RIGA_ELEMENTO%', COALESCE(N' riga ' + CONVERT(NVARCHAR(10), @NumeroLinea), N''));

	IF (@TipoValore IS NULL)
	BEGIN

		SET @TipoValore = CASE
			WHEN @ValoreTesto IS NOT NULL THEN 'T'
			WHEN @ValoreIntero IS NOT NULL THEN 'I'
			WHEN @ValoreDecimale IS NOT NULL THEN 'D'
			WHEN @ValoreData IS NOT NULL THEN 'E'
			ELSE '?'
		END;

		IF (@TipoValore = '?')
		BEGIN

			SET @Messaggio = @DescrizioneCampo + REPLACE('Parametro @TipoValore %TIPO_VALORE% non valido', '%TIPO_VALORE%', @TipoValore)

			EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,      -- bigint
			                                  @Messaggio = @Messaggio,   -- nvarchar(500)
			                                  @PKEsitoEvento = 307, -- 307: Errore in fase di validazione campo SDI: parametro @TipoValore non valido
			                                  @LivelloLog = 4     -- tinyint

		END;

	END;

	IF (@IsObbligatorio = 1)
	BEGIN

		IF (
			(@TipoValore = 'T' AND COALESCE(@ValoreTesto, N'') = N'')
			OR (@TipoValore = N'I' AND COALESCE(@ValoreIntero, 0) = 0)
			OR (@TipoValore = N'D' AND COALESCE(@ValoreDecimale, 0.0) = 0.0)
			OR (@TipoValore = N'E' AND COALESCE(@ValoreData, CAST('19000101' AS DATE)) = CAST('19000101' AS DATE))
		)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				ValoreIntero,
				ValoreDecimale,
				ValoreData,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,    -- PKValidazione_Riga - bigint
				@PKValidazione,    -- PKValidazione - bigint
				@DescrizioneCampo,  -- Campo - nvarchar(100)
				@ValoreTesto,  -- ValoreTesto - nvarchar(100)
				@ValoreIntero,    -- ValoreIntero - int
				@ValoreDecimale, -- ValoreDecimale - decimal(28, 12)
				@ValoreData, -- ValoreData - date
				N'Campo obbligatorio non valorizzato',  -- Messaggio - nvarchar(100)
				4     -- LivelloLog - tinyint
			);

		END;

	END;

	-- Verifica Nazione (lookup XMLCodifiche.Nazione)
	IF (
		(@IDCampo = N'1.1.1.1')
		OR (@IDCampo = N'1.2.1.1.1')
		OR (@IDCampo = N'1.2.2.6')
		OR (@IDCampo = N'1.2.3.6')
		OR (@IDCampo = N'1.3.1.1.1' AND COALESCE(@ValoreTesto, N'') <> N'')
		OR (@IDCampo = N'1.4.1.1.1' AND COALESCE(@ValoreTesto, N'') <> N'')
		OR (@IDCampo = N'1.4.2.6')
		OR (@IDCampo = N'1.4.3.6')
		OR (@IDCampo = N'1.4.4.1.1' AND COALESCE(@ValoreTesto, N'') <> N'')
		OR (@IDCampo = N'1.5.1.1.1' AND COALESCE(@ValoreTesto, N'') <> N'')
	)
	BEGIN

		DECLARE @Nazione NVARCHAR(255);
		SELECT @Nazione = Nazione FROM XMLCodifiche.Nazione WHERE IDNazione = @ValoreTesto;

		IF (@Nazione IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @Nazione),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Nazione non trovata (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;
	END;

	-- Verifica Provincia (lookup XMLCodifiche.Provincia)
	IF (
		COALESCE(@IDNazione, '') = 'IT'
		AND (
			(@IDCampo = N'1.2.2.5')
			OR (@IDCampo = N'1.2.3.5')
			OR (@IDCampo = N'1.4.2.5')
			OR (@IDCampo = N'1.4.3.5')
		)
	)
	BEGIN

		DECLARE @Provincia NVARCHAR(255);
		SELECT @Provincia = Provincia FROM XMLCodifiche.Provincia WHERE IDProvincia = COALESCE(@ValoreTesto, '??'); -- Se la nazione è IT, la provincia deve essere valorizzata

		IF (@Provincia IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @Provincia),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Provincia non trovata (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;
	END;

	-- Verifica formale partita IVA
	IF (
		@IDNazione = 'IT'
		AND (
			(@IDCampo = N'1.2.1.1.2' AND COALESCE(@ValoreTesto, N'') <> N'')
			OR (@IDCampo = N'1.4.1.1.2' AND COALESCE(@ValoreTesto, N'') <> N'')
		)
	)
	BEGIN

		DECLARE @IsPartitaIVAFormalmenteValida BIT;
		SELECT @IsPartitaIVAFormalmenteValida = XMLFatture.sfn_VerificaFormalePartitaIVA(@ValoreTesto);

		IF (@IsPartitaIVAFormalmenteValida = 1)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				N'Partita IVA formalmente valida',
				2
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Verifica formale partita IVA non superata (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica formale codice fiscale
	IF (
		@IDNazione = 'IT'
		AND (
			(@IDCampo = N'1.1.1.2')
			OR (@IDCampo = N'1.2.1.2' AND COALESCE(@ValoreTesto, N'') <> N'')
			OR (@IDCampo = N'1.4.1.2' AND COALESCE(@ValoreTesto, N'') <> N'')
		)
	)
	BEGIN

		DECLARE @IsCodiceFiscaleFormalmenteValido BIT;

		IF (@IDCampo IN (N'1.1.1.2', N'1.2.1.2', N'1.4.1.2'))
		BEGIN
			-- Verifica formale codice fiscale o partita IVA (per i soli campi che possono contenere anche una partita IVA)
			SELECT @IsCodiceFiscaleFormalmenteValido = XMLFatture.sfn_VerificaFormaleCodiceFiscale(@ValoreTesto, 1);
		END;
		ELSE
		BEGIN
			SELECT @IsCodiceFiscaleFormalmenteValido = XMLFatture.sfn_VerificaFormaleCodiceFiscale(@ValoreTesto, 0);
		END;

		IF (@IsCodiceFiscaleFormalmenteValido = 1)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				N'Codice fiscale formalmente valido',
				2
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Verifica formale codice fiscale non superata (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

    -- Verifica formale BIC
	IF (@IDCampo = N'2.4.2.16' AND COALESCE(@ValoreTesto, N'') <> N'')
	BEGIN

		DECLARE @IsBICFormalmenteValido BIT;

		-- Verifica formale BIC
		SELECT @IsBICFormalmenteValido = XMLFatture.sfn_VerificaFormaleBIC(@ValoreTesto);

		IF (@IsBICFormalmenteValido = 1)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				N'BIC formalmente valido',
				2
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Verifica formale BIC non superata (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica formato trasmissione
	IF (
		(@IDCampo = N'1.1.3' AND COALESCE(@ValoreTesto, N'') <> N'')
	)
	BEGIN

		IF (@ValoreTesto IN (N'FPA12', N'FPR12'))
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'FormatoTrasmissione: valore ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				0
			);

		END;
		ELSE
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
			                                                  @IDCampo = N'1.1.3',
			                                                  @CodiceErroreSDI = 428,
			                                                  @valoreTesto = @ValoreTesto,
			                                                  @LivelloLog = 4;
			
		END;

	END;

	-- Verifica codice destinatario (lunghezza)
	IF (
		@IDCampo = N'1.1.4' AND LEN(COALESCE(@ValoreTesto, N'')) NOT IN (6, 7)
	)
	BEGIN

		EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
			                                                @IDCampo = N'1.1.4',
			                                                @CodiceErroreSDI = 311,
			                                                @valoreTesto = @ValoreTesto,
			                                                @LivelloLog = 4;
	END;

	-- Verifica tipo documento (lookup XMLCodifiche.TipoDocumento)
	IF (
		(@IDCampo = N'2.1.1.1')
	)
	BEGIN

		DECLARE @TipoDocumento NVARCHAR(255);
		SELECT @TipoDocumento = TipoDocumento FROM XMLCodifiche.TipoDocumento WHERE IDTipoDocumento = @ValoreTesto;

		IF (@TipoDocumento IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @TipoDocumento),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'TipoDocumento non trovato (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;
	END;

	-- Verifica divisa (lookup XMLCodifiche.Valuta)
	IF (
		(@IDCampo = N'2.1.1.2')
	)
	BEGIN

		DECLARE @Valuta NVARCHAR(255);
		SELECT @Valuta = Valuta FROM XMLCodifiche.Valuta WHERE IDValuta = @ValoreTesto;

		IF (@Valuta IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @Valuta),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Divisa non trovato (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica tipo ritenuta
	IF (
		(@IDCampo = N'2.1.1.5.1' AND @ValoreTesto <> N'')
	)
	BEGIN

		IF (@ValoreTesto IN (N'RT01', N'RT02'))
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'TipoRitenuta: valore ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'TipoRitenuta: valore non ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica causale pagamento
	IF (
		(@IDCampo = N'2.1.1.5.4' AND @ValoreTesto <> N'')
	)
	BEGIN

		DECLARE @CausalePagamento NVARCHAR(512);
		SELECT @CausalePagamento = CausalePagamento FROM XMLCodifiche.CausalePagamento WHERE IDCausalePagamento = @ValoreTesto;

		IF (@CausalePagamento IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				LEFT(REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @CausalePagamento), 100),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				LEFT(REPLACE(N'CausalePagamento non trovata (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', COALESCE(@ValoreTesto, N'')), 100),
				4
			);

		END;
	END;

	-- Verifica bollo virtuale
	IF (
		(@IDCampo = N'2.1.1.6.1' AND @ValoreTesto <> N'')
	)
	BEGIN

		DECLARE @BolloVirtuale NVARCHAR(255);
		SELECT @BolloVirtuale = RispostaSI FROM XMLCodifiche.RispostaSI WHERE IDRispostaSI = @ValoreTesto;

		IF (@BolloVirtuale IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				LEFT(REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @BolloVirtuale), 100),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				LEFT(REPLACE(N'BolloVirtuale non trovato (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', COALESCE(@ValoreTesto, N'')), 100),
				4
			);

		END;
	END;

	-- Verifica tipo cessione/prestazione
	IF (
		(@IDCampo = N'2.2.1.2' AND @ValoreTesto <> N'')
	)
	BEGIN

		IF (@ValoreTesto IN (N'SC', N'PR', N'AB', N'AC'))
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'TipoCessionePrestazione: valore ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'TipoCessionePrestazione: valore non ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica tipo sconto/maggiorazione
	IF (
		(@IDCampo = N'2.2.1.10.1' AND @ValoreTesto <> N'')
	)
	BEGIN

		IF (@ValoreTesto IN (N'SC', N'MG'))
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'TipoScontoMaggiorazione: valore ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'TipoScontoMaggiorazione: valore non ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica "risposta" (lookup XMLCodifiche.RispostaSI)
	IF (
		(@IDCampo = N'2.2.1.13' AND @ValoreTesto <> N'')
	)
	BEGIN

		DECLARE @RispostaSI NVARCHAR(255);
		SELECT @RispostaSI = RispostaSI FROM XMLCodifiche.RispostaSI WHERE IDRispostaSI = @ValoreTesto;

		IF (@RispostaSI IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @RispostaSI),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Divisa non trovato (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica natura (lookup XMLCodifiche.Natura)
	IF (
		(@IDCampo = N'2.2.1.14' AND @ValoreTesto <> N'')
	)
	BEGIN

		DECLARE @Natura NVARCHAR(255);
		SELECT @Natura = Natura FROM XMLCodifiche.Natura WHERE IDNatura = @ValoreTesto;

		IF (@Natura IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @Natura),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Divisa non trovato (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica esigilibità IVA
	IF (
		(@IDCampo = N'2.2.2.7')
	)
	BEGIN

		IF (@ValoreTesto IN (N'I', N'D', N'S'))
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'EsigibilitaIVA: valore ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'EsigibilitaIVA: valore non ammesso (%VALORE_TESTO%)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

	-- Verifica modalità pagamento (lookup XMLCodifiche.ModalitaPagamento)
	IF (
		(@IDCampo = N'2.4.2.2' AND @ValoreTesto <> N'')
	)
	BEGIN

		DECLARE @ModalitaPagamento NVARCHAR(255);
		SELECT @ModalitaPagamento = ModalitaPagamento FROM XMLCodifiche.ModalitaPagamento WHERE IDModalitaPagamento = @ValoreTesto;

		IF (@ModalitaPagamento IS NOT NULL)
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES
			(   --0,
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(REPLACE(N'Lookup completata (%VALORE_TESTO% > %VALORE_LOOKUP%)', N'%VALORE_TESTO%', @ValoreTesto), N'%VALORE_LOOKUP%', @ModalitaPagamento),
				0
			);

		END;
		ELSE
		BEGIN

			INSERT INTO XMLAudit.Validazione_Riga
			(
				--PKValidazione_Riga,
				PKValidazione,
				Campo,
				ValoreTesto,
				Messaggio,
				LivelloLog
			)
			VALUES (
				@PKValidazione,
				@DescrizioneCampo,
				@ValoreTesto,
				REPLACE(N'Divisa non trovato (%VALORE_TESTO% > ???)', N'%VALORE_TESTO%', @ValoreTesto),
				4
			);

		END;

	END;

END;
GO
