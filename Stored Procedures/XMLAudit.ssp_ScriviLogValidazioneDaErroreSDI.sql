SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLAudit].[ssp_ScriviLogValidazioneDaErroreSDI] (
	@PKValidazione BIGINT,
	@IDCampo NVARCHAR(20),
	@CodiceErroreSDI SMALLINT,
	--@campo NVARCHAR(100),
	@valoreTesto NVARCHAR(100) = NULL,
	@valoreIntero INT = NULL,
	@valoreDecimale DECIMAL(28, 12) = NULL,
	@valoreData DATETIME2 = NULL,
	@LivelloLog TINYINT = NULL
)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @NomeElemento NVARCHAR(100);
	DECLARE @DescrizioneCampo NVARCHAR(500);
	DECLARE @Messaggio NVARCHAR(100);

	SELECT @NomeElemento = NomeElemento
	FROM XMLCodifiche.CampiXML
	WHERE IndiceElemento = @IDCampo;

	SET @DescrizioneCampo = REPLACE(REPLACE(N'%NOME_ELEMENTO% (%INDICE_ELEMENTO%)', N'%NOME_ELEMENTO%', COALESCE(@NomeElemento, N'')), N'%INDICE_ELEMENTO%', @IDCampo);

	SELECT
		@Messaggio = DescrizioneErroreSDI
	FROM XMLCodifiche.CodiceErroreSDI
	WHERE IDCampo = @IDCampo
		AND CodiceErroreSDI = @CodiceErroreSDI;

	SELECT @Messaggio = COALESCE(@Messaggio, REPLACE(REPLACE(N'Errore generico: CodiceErroreSDI %CODICE_ERRORE_SDI% non definito per %DESCRIZIONE_CAMPO%', N'%DESCRIZIONE_CAMPO%', @DescrizioneCampo), N'%CODICE_ERRORE_SDI%', CONVERT(NVARCHAR(10), @CodiceErroreSDI)));

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
	VALUES (
		@PKValidazione,
		@DescrizioneCampo,
		@valoreTesto,
		@valoreIntero,
		@valoreDecimale,
		@valoreData,
		@Messaggio,
		@LivelloLog
	);

END;
GO
