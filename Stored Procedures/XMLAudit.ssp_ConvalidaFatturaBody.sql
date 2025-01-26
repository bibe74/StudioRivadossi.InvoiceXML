SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [XMLAudit].[ssp_ConvalidaFatturaBody] (
	@PKStaging_FatturaElettronicaHeader BIGINT,
	@PKValidazione BIGINT
)
AS
BEGIN

	SET NOCOUNT ON;

	/* declare variables */
	DECLARE @DatiGenerali_DatiGeneraliDocumento_TipoDocumento CHAR(4);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_Divisa CHAR(3);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_Data DATE;
	DECLARE @DatiGenerali_DatiGeneraliDocumento_Numero NVARCHAR(20);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta CHAR(4);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta DECIMAL(14,2);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta DECIMAL(5,2);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento CHAR(2);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale CHAR(2);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo DECIMAL(14,2);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento DECIMAL(14,2);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_Arrotondamento DECIMAL(14,2);
	DECLARE @DatiGenerali_DatiGeneraliDocumento_Art73 CHAR(2);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese CHAR(2);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdCodice NVARCHAR(28);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_CodiceFiscale NVARCHAR(16);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Denominazione NVARCHAR(80);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Nome NVARCHAR(60);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Cognome NVARCHAR(60);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Titolo NVARCHAR(10);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_CodEORI NVARCHAR(17);
	DECLARE @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_NumeroLicenzaGuida NVARCHAR(20);
	DECLARE @DatiGenerali_DatiTrasporto_MezzoTrasporto NVARCHAR(80);
	DECLARE @DatiGenerali_DatiTrasporto_CausaleTrasporto NVARCHAR(100);
	DECLARE @DatiGenerali_DatiTrasporto_NumeroColli INT;
	DECLARE @DatiGenerali_DatiTrasporto_Descrizione NVARCHAR(100);
	DECLARE @DatiGenerali_DatiTrasporto_UnitaMisuraPeso NVARCHAR(10);
	DECLARE @DatiGenerali_DatiTrasporto_PesoLordo DECIMAL(6,2);
	DECLARE @DatiGenerali_DatiTrasporto_PesoNetto DECIMAL(6,2);
	DECLARE @DatiGenerali_DatiTrasporto_DataOraRitiro DATETIME;
	DECLARE @DatiGenerali_DatiTrasporto_DataInizioTrasporto DATE;
	DECLARE @DatiGenerali_DatiTrasporto_TipoResa CHAR(3);
	DECLARE @DatiGenerali_DatiTrasporto_IndirizzoResa_Indirizzo NVARCHAR(60);
	DECLARE @DatiGenerali_DatiTrasporto_IndirizzoResa_NumeroCivico NVARCHAR(8);
	DECLARE @DatiGenerali_DatiTrasporto_IndirizzoResa_CAP CHAR(5);
	DECLARE @DatiGenerali_DatiTrasporto_IndirizzoResa_Comune NVARCHAR(60);
	DECLARE @DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia CHAR(2);
	DECLARE @DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione CHAR(2);
	DECLARE @DatiGenerali_DatiTrasporto_DataOraConsegna DATETIME;
	DECLARE @DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale NVARCHAR(20);
	DECLARE @DatiGenerali_FatturaPrincipale_DataFatturaPrincipale DATE;
	DECLARE @DatiVeicoli_Data DATE;
	DECLARE @DatiVeicoli_TotalePercorso NVARCHAR(15);

	DECLARE cursor_FEB CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        DatiGenerali_DatiGeneraliDocumento_TipoDocumento,
        DatiGenerali_DatiGeneraliDocumento_Divisa,
        DatiGenerali_DatiGeneraliDocumento_Data,
        DatiGenerali_DatiGeneraliDocumento_Numero,
        DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta,
        DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta,
        DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta,
        DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento,
        DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale,
        DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo,
        DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento,
        DatiGenerali_DatiGeneraliDocumento_Arrotondamento,
        DatiGenerali_DatiGeneraliDocumento_Art73,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdCodice,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_CodiceFiscale,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Denominazione,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Nome,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Cognome,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Titolo,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_CodEORI,
        DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_NumeroLicenzaGuida,
        DatiGenerali_DatiTrasporto_MezzoTrasporto,
        DatiGenerali_DatiTrasporto_CausaleTrasporto,
        DatiGenerali_DatiTrasporto_NumeroColli,
        DatiGenerali_DatiTrasporto_Descrizione,
        DatiGenerali_DatiTrasporto_UnitaMisuraPeso,
        DatiGenerali_DatiTrasporto_PesoLordo,
        DatiGenerali_DatiTrasporto_PesoNetto,
        DatiGenerali_DatiTrasporto_DataOraRitiro,
        DatiGenerali_DatiTrasporto_DataInizioTrasporto,
        DatiGenerali_DatiTrasporto_TipoResa,
        DatiGenerali_DatiTrasporto_IndirizzoResa_Indirizzo,
        DatiGenerali_DatiTrasporto_IndirizzoResa_NumeroCivico,
        DatiGenerali_DatiTrasporto_IndirizzoResa_CAP,
        DatiGenerali_DatiTrasporto_IndirizzoResa_Comune,
        DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia,
        DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione,
        DatiGenerali_DatiTrasporto_DataOraConsegna,
        DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale,
        DatiGenerali_FatturaPrincipale_DataFatturaPrincipale,
        DatiVeicoli_Data,
        DatiVeicoli_TotalePercorso
 
	FROM XMLFatture.Staging_FatturaElettronicaBody
	WHERE PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEB;
	
	FETCH NEXT FROM cursor_FEB INTO
		@DatiGenerali_DatiGeneraliDocumento_TipoDocumento
		, @DatiGenerali_DatiGeneraliDocumento_Divisa
		, @DatiGenerali_DatiGeneraliDocumento_Data
		, @DatiGenerali_DatiGeneraliDocumento_Numero
		, @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta
		, @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta
		, @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta
		, @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento
		, @DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale
		, @DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo
		, @DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento
		, @DatiGenerali_DatiGeneraliDocumento_Arrotondamento
		, @DatiGenerali_DatiGeneraliDocumento_Art73
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdCodice
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_CodiceFiscale
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Denominazione
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Nome
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Cognome
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Titolo
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_CodEORI
		, @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_NumeroLicenzaGuida
		, @DatiGenerali_DatiTrasporto_MezzoTrasporto
		, @DatiGenerali_DatiTrasporto_CausaleTrasporto
		, @DatiGenerali_DatiTrasporto_NumeroColli
		, @DatiGenerali_DatiTrasporto_Descrizione
		, @DatiGenerali_DatiTrasporto_UnitaMisuraPeso
		, @DatiGenerali_DatiTrasporto_PesoLordo
		, @DatiGenerali_DatiTrasporto_PesoNetto
		, @DatiGenerali_DatiTrasporto_DataOraRitiro
		, @DatiGenerali_DatiTrasporto_DataInizioTrasporto
		, @DatiGenerali_DatiTrasporto_TipoResa
		, @DatiGenerali_DatiTrasporto_IndirizzoResa_Indirizzo
		, @DatiGenerali_DatiTrasporto_IndirizzoResa_NumeroCivico
		, @DatiGenerali_DatiTrasporto_IndirizzoResa_CAP
		, @DatiGenerali_DatiTrasporto_IndirizzoResa_Comune
		, @DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia
		, @DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione
		, @DatiGenerali_DatiTrasporto_DataOraConsegna
		, @DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale
		, @DatiGenerali_FatturaPrincipale_DataFatturaPrincipale
		, @DatiVeicoli_Data
		, @DatiVeicoli_TotalePercorso;

	--WHILE @@FETCH_STATUS = 0
	--BEGIN
	    
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.1', @ValoreTesto = @DatiGenerali_DatiGeneraliDocumento_TipoDocumento;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.2', @ValoreTesto = @DatiGenerali_DatiGeneraliDocumento_Divisa;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.3', @TipoValore = 'E', @ValoreData = @DatiGenerali_DatiGeneraliDocumento_Data;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.4', @ValoreTesto = @DatiGenerali_DatiGeneraliDocumento_Numero;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.5.1', @ValoreTesto = @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.5.2', @TipoValore = 'D', @ValoreDecimale = @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.5.3', @TipoValore = 'D', @ValoreDecimale = @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.5.4', @ValoreTesto = @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.6.1', @ValoreTesto = @DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.6.2', @TipoValore = 'D', @ValoreDecimale = @DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.9', @TipoValore = 'D', @ValoreDecimale = @DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.10', @TipoValore = 'D', @ValoreDecimale = @DatiGenerali_DatiGeneraliDocumento_Arrotondamento, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.12', @ValoreTesto = @DatiGenerali_DatiGeneraliDocumento_Art73, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.1.1', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.1.2', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdCodice, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.2', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_CodiceFiscale, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.3.1', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Denominazione, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.3.2', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Nome, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.3.3', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Cognome, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.3.4', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Titolo, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.3.5', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_CodEORI, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.1.4', @ValoreTesto = @DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_NumeroLicenzaGuida, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.2', @ValoreTesto = @DatiGenerali_DatiTrasporto_MezzoTrasporto, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.3', @ValoreTesto = @DatiGenerali_DatiTrasporto_CausaleTrasporto, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.4', @TipoValore = 'I', @ValoreIntero = @DatiGenerali_DatiTrasporto_NumeroColli, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.5', @ValoreTesto = @DatiGenerali_DatiTrasporto_Descrizione, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.6', @ValoreTesto = @DatiGenerali_DatiTrasporto_UnitaMisuraPeso, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.7', @ValoreTesto = @DatiGenerali_DatiTrasporto_PesoLordo, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.8', @ValoreTesto = @DatiGenerali_DatiTrasporto_PesoNetto, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.9', @TipoValore = 'E', @ValoreData = @DatiGenerali_DatiTrasporto_DataOraRitiro, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.10', @TipoValore = 'E', @ValoreData = @DatiGenerali_DatiTrasporto_DataInizioTrasporto, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.11', @ValoreTesto = @DatiGenerali_DatiTrasporto_TipoResa, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.12.1', @ValoreTesto = @DatiGenerali_DatiTrasporto_IndirizzoResa_Indirizzo, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.12.2', @ValoreTesto = @DatiGenerali_DatiTrasporto_IndirizzoResa_NumeroCivico, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.12.3', @ValoreTesto = @DatiGenerali_DatiTrasporto_IndirizzoResa_CAP, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.12.4', @ValoreTesto = @DatiGenerali_DatiTrasporto_IndirizzoResa_Comune, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.12.5', @ValoreTesto = @DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.12.6', @ValoreTesto = @DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.9.13', @TipoValore = 'E', @ValoreData = @DatiGenerali_DatiTrasporto_DataOraConsegna, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.10.1', @ValoreTesto = @DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.10.2', @TipoValore = 'E', @ValoreData = @DatiGenerali_FatturaPrincipale_DataFatturaPrincipale, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.3.1', @ValoreTesto = @DatiVeicoli_Data, @IsObbligatorio = 0;
	EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.3.2', @ValoreTesto = @DatiVeicoli_TotalePercorso, @IsObbligatorio = 0;

	IF (@DatiGenerali_DatiGeneraliDocumento_Data > CAST(CURRENT_TIMESTAMP AS DATE))
	BEGIN

		EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
						                                  @IDCampo = N'2.1.1.3',
						                                  @CodiceErroreSDI = 403,
						                                  @valoreData = @DatiGenerali_DatiGeneraliDocumento_Data,
						                                  @LivelloLog = 4;

	END;

	IF (@DatiGenerali_DatiGeneraliDocumento_TipoDocumento IN ('TD04', 'TD16', 'TD17', 'TD18', 'TD19'))
	BEGIN

		DECLARE @DataPrimaFatturaCollegata DATE;

		SELECT
			@DataPrimaFatturaCollegata = MIN(FEBDDC.[Data])
		
		FROM XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno FEBDDC
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDDC.PKStaging_FatturaElettronicaBody
			AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
		WHERE FEBDDC.TipoDocumentoEsterno = N'FTCL';

		IF (@DatiGenerali_DatiGeneraliDocumento_Data < @DataPrimaFatturaCollegata)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
															  @IDCampo = N'2.1.1.3',
															  @CodiceErroreSDI = 418,
															  @valoreData = @DatiGenerali_DatiGeneraliDocumento_Data,
															  @LivelloLog = 4;
		END;

	END;

	IF (@DatiGenerali_DatiGeneraliDocumento_Numero NOT LIKE N'%[0-9]%')
	BEGIN

		EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
						                                  @IDCampo = N'2.1.1.4',
						                                  @CodiceErroreSDI = 425,
						                                  @valoreTesto = @DatiGenerali_DatiGeneraliDocumento_Numero,
						                                  @LivelloLog = 4;

	END;

	IF (
		@DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta = N''
		AND EXISTS(
			SELECT FEBDL.Ritenuta
			FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee FEBDL
			INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDL.PKStaging_FatturaElettronicaBody
				AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
			WHERE FEBDL.Ritenuta = 'SI'
		)
	)
	BEGIN

		EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
						                                  @IDCampo = N'2.1.1.5',
						                                  @CodiceErroreSDI = 411,
						                                  @valoreTesto = @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta,
						                                  @LivelloLog = 4;

	END;

	IF (
		@DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta = N''
		AND EXISTS(
			SELECT FEBDCP.Ritenuta
			FROM XMLFatture.Staging_FatturaElettronicaBody_DatiCassaPrevidenziale FEBDCP
			INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDCP.PKStaging_FatturaElettronicaBody
				AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
			WHERE FEBDCP.Ritenuta = 'SI'
		)
	)
	BEGIN

		EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
						                                  @IDCampo = N'2.1.1.5',
						                                  @CodiceErroreSDI = 415,
						                                  @valoreTesto = @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta,
						                                  @LivelloLog = 4;

	END;

    IF (@DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento <> N'')
    BEGIN

        DECLARE @IsCausalePagamentoObsoleta BIT;
	    SELECT @IsCausalePagamentoObsoleta = IsObsoleta FROM XMLCodifiche.CausalePagamento WHERE IDCausalePagamento = @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento;
        IF (@IsCausalePagamentoObsoleta = CAST(1 AS BIT))
        BEGIN

		    EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
															    @IDCampo = N'2.1.1.5.4',
															    @CodiceErroreSDI = 999,
															    @valoreTesto = @DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento,
															    @LivelloLog = 4;

        END;

    END;
    SELECT * FROM XMLCodifiche.CodiceErroreSDI WHERE CodiceErroreSDI = 448
	--    FETCH NEXT FROM cursor_FEH INTO @variable
	--END;

	/*** Causale: inizio ***/

	/* declare variables */
	DECLARE @DatiGenerali_Causale NVARCHAR(200);
	
	DECLARE cursor_FEBC CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBC.DatiGenerali_Causale
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_Causale FEBC
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBC.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEBC
	
	FETCH NEXT FROM cursor_FEBC INTO @DatiGenerali_Causale;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.11', @ValoreTesto = @DatiGenerali_Causale, @IsObbligatorio = 0;
	
	    FETCH NEXT FROM cursor_FEBC INTO @DatiGenerali_Causale;
	END
	
	CLOSE cursor_FEBC
	DEALLOCATE cursor_FEBC

	/*** Causale: fine ***/

	/*** DatiDDT: inizio ***/

	/* declare variables */
	DECLARE @NumeroDDT NVARCHAR(20);
	DECLARE @DataDDT DATE;
	
	DECLARE cursor_FEBDDDT CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBDDDT.NumeroDDT,
        FEBDDDT.DataDDT
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_DatiDDT FEBDDDT
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDDDT.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEBDDDT
	
	FETCH NEXT FROM cursor_FEBDDDT INTO @NumeroDDT, @DataDDT;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.8.1', @ValoreTesto = @NumeroDDT;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.8,2', @TipoValore = 'E', @ValoreData = @DataDDT;
	
		FETCH NEXT FROM cursor_FEBDDDT INTO @NumeroDDT, @DataDDT;
	END
	
	CLOSE cursor_FEBDDDT
	DEALLOCATE cursor_FEBDDDT

	/*** DatiDDT: fine ***/
	
	/*** DatiDDT_RiferimentoNumeroLinea: inizio ***/

	/* declare variables */
	DECLARE @RiferimentoNumeroLinea INT;
	
	DECLARE cursor_FEBDDDTNL CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBDDDTNL.RiferimentoNumeroLinea
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea FEBDDDTNL
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DatiDDT FEBDDDT ON FEBDDDT.PKStaging_FatturaElettronicaBody_DatiDDT = FEBDDDTNL.PKStaging_FatturaElettronicaBody_DatiDDT
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDDDT.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEBDDDTNL
	
	FETCH NEXT FROM cursor_FEBDDDTNL INTO @RiferimentoNumeroLinea;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.1.1.11', @TipoValore = 'I', @ValoreIntero = @RiferimentoNumeroLinea;
	
		FETCH NEXT FROM cursor_FEBDDDTNL INTO @RiferimentoNumeroLinea;
	END
	
	CLOSE cursor_FEBDDDTNL
	DEALLOCATE cursor_FEBDDDTNL

	/*** DatiDDT: fine ***/

	/*** DettaglioLinee: inizio ***/

	/* declare variables */
	DECLARE @NumeroLinea INT;
	DECLARE @TipoCessionePrestazione CHAR(2);
	DECLARE @Descrizione NVARCHAR(1000);
	DECLARE @Quantita DECIMAL(20, 5);
	DECLARE @UnitaMisura NVARCHAR(10);
	DECLARE @DataInizioPeriodo DATE;
	DECLARE @DataFinePeriodo DATE;
	DECLARE @PrezzoUnitario DECIMAL(20, 5);
	DECLARE @PrezzoTotale DECIMAL(20, 5);
	DECLARE @AliquotaIVA DECIMAL(5, 2);
	DECLARE @Ritenuta CHAR(2);
	DECLARE @Natura VARCHAR(5);
    DECLARE @IsNaturaObsoleta BIT;
	DECLARE @RiferimentoAmministrazione NVARCHAR(20);
	
	DECLARE cursor_FEBDL CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBDL.NumeroLinea,
        FEBDL.TipoCessionePrestazione,
        FEBDL.Descrizione,
        FEBDL.Quantita,
        FEBDL.UnitaMisura,
        FEBDL.DataInizioPeriodo,
        FEBDL.DataFinePeriodo,
        FEBDL.PrezzoUnitario,
        FEBDL.PrezzoTotale,
        FEBDL.AliquotaIVA,
        FEBDL.Ritenuta,
        FEBDL.Natura,
        FEBDL.RiferimentoAmministrazione
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee FEBDL
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDL.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEBDL
	
	FETCH NEXT FROM cursor_FEBDL INTO
		@NumeroLinea,
        @TipoCessionePrestazione,
        @Descrizione,
        @Quantita,
        @UnitaMisura,
        @DataInizioPeriodo,
        @DataFinePeriodo,
        @PrezzoUnitario,
        @PrezzoTotale,
        @AliquotaIVA,
        @Ritenuta,
        @Natura,
        @RiferimentoAmministrazione;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.1', @TipoValore = 'I', @ValoreIntero = @NumeroLinea, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.2', @ValoreTesto = @TipoCessionePrestazione, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.4', @ValoreTesto = @Descrizione, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.5', @TipoValore = 'D', @ValoreDecimale = @Quantita, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.6', @ValoreTesto = @UnitaMisura, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.7', @TipoValore = 'E', @ValoreData = @DataInizioPeriodo, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.8', @TipoValore = 'E', @ValoreData = @DataFinePeriodo, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.9', @TipoValore = 'D', @ValoreDecimale = @PrezzoUnitario, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.11', @TipoValore = 'D', @ValoreDecimale = @PrezzoTotale, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.12', @TipoValore = 'D', @ValoreDecimale = @AliquotaIVA, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.13', @ValoreTesto = @Ritenuta, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.14', @ValoreTesto = @Natura, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.15', @ValoreTesto = @RiferimentoAmministrazione, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		
		-- TODO: verifica calcolo prezzo totale (elenco controlli versione 1.2)

		IF (@AliquotaIVA > 0.0 AND @AliquotaIVA < 1.0)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.1.12',
																@CodiceErroreSDI = 424,
																@valoreDecimale = @AliquotaIVA,
																@LivelloLog = 4;

		END;

		-- 2.1.1.13 Ritenuta: duplicato di controllo 2.1.1.5

		IF (@Natura = '' AND @AliquotaIVA = 0.0)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.1.14',
																@CodiceErroreSDI = 400,
																@valoreTesto = @Natura,
																@LivelloLog = 4;

		END;

		IF (@Natura <> '' AND @AliquotaIVA <> 0.0)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.1.14',
																@CodiceErroreSDI = 401,
																@valoreTesto = @Natura,
																@LivelloLog = 4;

		END;

		SELECT @IsNaturaObsoleta = IsObsoleta FROM XMLCodifiche.Natura WHERE IDNatura = @Natura;
        IF (@IsNaturaObsoleta = CAST(1 AS BIT))
        BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.1.14',
																@CodiceErroreSDI = 448,
																@valoreTesto = @Natura,
																@LivelloLog = 4;

        END;

		FETCH NEXT FROM cursor_FEBDL INTO
			@NumeroLinea,
			@TipoCessionePrestazione,
			@Descrizione,
			@Quantita,
			@UnitaMisura,
			@DataInizioPeriodo,
			@DataFinePeriodo,
			@PrezzoUnitario,
			@PrezzoTotale,
			@AliquotaIVA,
			@Ritenuta,
			@Natura,
			@RiferimentoAmministrazione;
	END
	
	CLOSE cursor_FEBDL
	DEALLOCATE cursor_FEBDL

	/*** DettaglioLinee: fine ***/

	/*** DettaglioLinee_CodiceArticolo: inizio ***/

	/* declare variables */
    DECLARE @CodiceArticolo_CodiceTipo NVARCHAR(35);
    DECLARE @CodiceArticolo_CodiceValore NVARCHAR(35);
	
	DECLARE cursor_FEBDLCA CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBDLCA.CodiceArticolo_CodiceTipo,
        FEBDLCA.CodiceArticolo_CodiceValore
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo FEBDLCA
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee FEBDL ON FEBDL.PKStaging_FatturaElettronicaBody_DettaglioLinee = FEBDLCA.PKStaging_FatturaElettronicaBody_DettaglioLinee
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDL.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEBDLCA
	
	FETCH NEXT FROM cursor_FEBDLCA INTO @CodiceArticolo_CodiceTipo, @CodiceArticolo_CodiceValore;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.3.1', @ValoreTesto = @CodiceArticolo_CodiceTipo, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.3.2', @ValoreTesto = @CodiceArticolo_CodiceValore, @NumeroLinea = @NumeroLinea;
	
		FETCH NEXT FROM cursor_FEBDLCA INTO @CodiceArticolo_CodiceTipo, @CodiceArticolo_CodiceValore;
	END
	
	CLOSE cursor_FEBDLCA
	DEALLOCATE cursor_FEBDLCA

	/*** DettaglioLinee_CodiceArticolo: fine ***/

	/*** DettaglioLinee_ScontoMaggiorazione: inizio ***/

	/* declare variables */
    DECLARE @ScontoMaggiorazione_Tipo CHAR(2);
    DECLARE @ScontoMaggiorazione_Percentuale DECIMAL(5, 2);
    DECLARE @ScontoMaggiorazione_Importo DECIMAL(14, 2);
	
	DECLARE cursor_FEBDLSM CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBDLCA.ScontoMaggiorazione_Tipo,
        FEBDLCA.ScontoMaggiorazione_Percentuale,
        FEBDLCA.ScontoMaggiorazione_Importo
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione FEBDLCA
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee FEBDL ON FEBDL.PKStaging_FatturaElettronicaBody_DettaglioLinee = FEBDLCA.PKStaging_FatturaElettronicaBody_DettaglioLinee
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDL.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEBDLSM
	
	FETCH NEXT FROM cursor_FEBDLSM INTO @ScontoMaggiorazione_Tipo, @ScontoMaggiorazione_Percentuale, @ScontoMaggiorazione_Importo;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.10.1', @ValoreTesto = @ScontoMaggiorazione_Tipo, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.10.2', @TipoValore = 'D', @ValoreDecimale = @ScontoMaggiorazione_Percentuale, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.1.10.3', @TipoValore = 'D', @ValoreDecimale = @ScontoMaggiorazione_Importo, @IsObbligatorio = 0, @NumeroLinea = @NumeroLinea;

		IF (
			COALESCE(@ScontoMaggiorazione_Tipo, N'') <> N''
			AND COALESCE(@ScontoMaggiorazione_Percentuale, 0.0) = 0.0
			AND COALESCE(@ScontoMaggiorazione_Importo, 0.0) = 0.0
		)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.1.10.1',
																@CodiceErroreSDI = 438,
																@valoreTesto = @ScontoMaggiorazione_Tipo,
																@LivelloLog = 4;

		END;

		FETCH NEXT FROM cursor_FEBDLSM INTO @ScontoMaggiorazione_Tipo, @ScontoMaggiorazione_Percentuale, @ScontoMaggiorazione_Importo;
	END
	
	CLOSE cursor_FEBDLSM
	DEALLOCATE cursor_FEBDLSM

	/*** DettaglioLinee_ScontoMaggiorazione: fine ***/

	/*** DatiRiepilogo: inizio ***/

	DECLARE @AliquoteMancanti INT;

	WITH AliquoteIVA
	AS (
		SELECT DISTINCT
			FEBDL.AliquotaIVA

		FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee FEBDL
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDL.PKStaging_FatturaElettronicaBody
			AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader

		UNION

		SELECT DISTINCT
			FEBDCP.AliquotaIVA

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiCassaPrevidenziale FEBDCP
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDCP.PKStaging_FatturaElettronicaBody
			AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	)
	SELECT @AliquoteMancanti = COUNT(1)
	FROM AliquoteIVA AIVA
	LEFT JOIN (
		SELECT DISTINCT
			FEBDR.AliquotaIVA

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiRiepilogo FEBDR
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDR.PKStaging_FatturaElettronicaBody
			AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
	) DR ON DR.AliquotaIVA = AIVA.AliquotaIVA
	WHERE DR.AliquotaIVA IS NULL;

	IF (@AliquoteMancanti > 0)
	BEGIN

		EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
															@IDCampo = N'2.2.2',
															@CodiceErroreSDI = 419,
															@valoreDecimale = @AliquoteMancanti,
															@LivelloLog = 4;

	END;

	/* declare variables */
	--DECLARE @AliquotaIVA DECIMAL(5, 2);
	--DECLARE @Natura VARCHAR(5);
	DECLARE @SpeseAccessorie DECIMAL(14, 2);
	DECLARE @Arrotondamento DECIMAL(20, 2);
	DECLARE @ImponibileImporto DECIMAL(14, 2);
	DECLARE @Imposta DECIMAL(14, 2);
	DECLARE @EsigibilitaIVA CHAR(1);
	DECLARE @RiferimentoNormativo NVARCHAR(100);
	
	DECLARE cursor_FEBDR CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBDR.AliquotaIVA,
        FEBDR.Natura,
        FEBDR.SpeseAccessorie,
        FEBDR.Arrotondamento,
        FEBDR.ImponibileImporto,
        FEBDR.Imposta,
        FEBDR.EsigibilitaIVA,
        FEBDR.RiferimentoNormativo
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_DatiRiepilogo FEBDR
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDR.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
		AND FEBDR.ImponibileImporto > 0.0;
	
	OPEN cursor_FEBDR
	
	FETCH NEXT FROM cursor_FEBDR INTO
		@AliquotaIVA,
		@Natura,
		@SpeseAccessorie,
		@Arrotondamento,
		@ImponibileImporto,
		@Imposta,
		@EsigibilitaIVA,
		@RiferimentoNormativo;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.2.1', @TipoValore = 'D', @ValoreDecimale = @AliquotaIVA, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.2.2', @ValoreTesto = @Natura, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.2.3', @TipoValore = 'D', @ValoreDecimale = @SpeseAccessorie, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.2.4', @TipoValore = 'D', @ValoreDecimale = @Arrotondamento, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.2.5', @TipoValore = 'D', @ValoreDecimale = @ImponibileImporto;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.2.6', @TipoValore = 'D', @ValoreDecimale = @Imposta, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.2.7', @ValoreTesto = @EsigibilitaIVA, @IsObbligatorio = 1;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.2.2.8', @ValoreTesto = @RiferimentoNormativo, @IsObbligatorio = 0;

		IF (@AliquotaIVA > 0.0 AND @AliquotaIVA < 1.0)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.2.1',
																@CodiceErroreSDI = 424,
																@valoreDecimale = @AliquotaIVA,
																@LivelloLog = 4;

		END;

		IF (LEFT(@Natura, 2) = 'N6' AND @EsigibilitaIVA = 'S')
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.2.2',
																@CodiceErroreSDI = 420,
																@valoreTesto = @Natura,
																@LivelloLog = 4;

		END;

		IF (@Natura = '' AND @AliquotaIVA = 0.0)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.2.2',
																@CodiceErroreSDI = 429,
																@valoreTesto = @Natura,
																@LivelloLog = 4;

		END;

		IF (@Natura <> '' AND @AliquotaIVA <> 0.0)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.2.2',
																@CodiceErroreSDI = 430,
																@valoreTesto = @Natura,
																@LivelloLog = 4;

		END;

		SELECT @IsNaturaObsoleta = IsObsoleta FROM XMLCodifiche.Natura WHERE IDNatura = @Natura;
        IF (@IsNaturaObsoleta = CAST(1 AS BIT))
        BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'2.2.2.2',
																@CodiceErroreSDI = 448,
																@valoreTesto = @Natura,
																@LivelloLog = 4;

        END;

		FETCH NEXT FROM cursor_FEBDR INTO
			@AliquotaIVA,
			@Natura,
			@SpeseAccessorie,
			@Arrotondamento,
			@ImponibileImporto,
			@Imposta,
			@EsigibilitaIVA,
			@RiferimentoNormativo;
	END
	
	CLOSE cursor_FEBDR
	DEALLOCATE cursor_FEBDR

	/*** DatiRiepilogo: fine ***/

	/*** DatiPagamento: inizio ***/

	/* declare variables */
	DECLARE @CondizioniPagamento CHAR(4);
	
	DECLARE cursor_FEBDP CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBDP.CondizioniPagamento
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_DatiPagamento FEBDP
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDP.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEBDP
	
	FETCH NEXT FROM cursor_FEBDP INTO @CondizioniPagamento;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.1', @ValoreTesto = @CondizioniPagamento;
	
	    FETCH NEXT FROM cursor_FEBDP INTO @CondizioniPagamento;
	END
	
	CLOSE cursor_FEBDP
	DEALLOCATE cursor_FEBDP

	/*** DatiPagamento: fine ***/

	/*** DatiPagamento_DettaglioPagamento: inizio ***/

	/* declare variables */
	DECLARE @Beneficiario NVARCHAR(200);
	DECLARE @ModalitaPagamento CHAR(4);
	DECLARE @DataRiferimentoTerminiPagamento DATE;
	DECLARE @GiorniTerminiPagamento INT;
	DECLARE @DataScadenzaPagamento DATE;
	DECLARE @ImportoPagamento DECIMAL(14, 2);
	DECLARE @CodUfficioPostale NVARCHAR(20);
	DECLARE @CognomeQuietanzante NVARCHAR(60);
	DECLARE @NomeQuietanzante NVARCHAR(60);
	DECLARE @CFQuietanzante NVARCHAR(16);
	DECLARE @TitoloQuietanzante NVARCHAR(10);
	DECLARE @IstitutoFinanziario NVARCHAR(80);
	DECLARE @IBAN NVARCHAR(34);
	DECLARE @ABI INT;
	DECLARE @CAB INT;
	DECLARE @BIC NVARCHAR(11);
	DECLARE @ScontoPagamentoAnticipato DECIMAL(14, 2);
	DECLARE @DataLimitePagamentoAnticipato DATE;
	DECLARE @PenalitaPagamentiRitardati DECIMAL(14, 2);
	DECLARE @DataDecorrenzaPenale DATE;
	DECLARE @CodicePagamento NVARCHAR(60);
	
	DECLARE cursor_FEBDPDP CURSOR FAST_FORWARD READ_ONLY FOR
	SELECT
        FEBDPDP.Beneficiario,
        FEBDPDP.ModalitaPagamento,
        FEBDPDP.DataRiferimentoTerminiPagamento,
        FEBDPDP.GiorniTerminiPagamento,
        FEBDPDP.DataScadenzaPagamento,
        FEBDPDP.ImportoPagamento,
        FEBDPDP.CodUfficioPostale,
        FEBDPDP.CognomeQuietanzante,
        FEBDPDP.NomeQuietanzante,
        FEBDPDP.CFQuietanzante,
        FEBDPDP.TitoloQuietanzante,
        FEBDPDP.IstitutoFinanziario,
        FEBDPDP.IBAN,
        FEBDPDP.ABI,
        FEBDPDP.CAB,
        FEBDPDP.BIC,
        FEBDPDP.ScontoPagamentoAnticipato,
        FEBDPDP.DataLimitePagamentoAnticipato,
        FEBDPDP.PenalitaPagamentiRitardati,
        FEBDPDP.DataDecorrenzaPenale,
        FEBDPDP.CodicePagamento
	
	FROM XMLFatture.Staging_FatturaElettronicaBody_DatiPagamento_DettaglioPagamento FEBDPDP
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DatiPagamento FEBDP ON FEBDP.PKStaging_FatturaElettronicaBody_DatiPagamento = FEBDPDP.PKStaging_FatturaElettronicaBody_DatiPagamento
	INNER JOIN XMLFatture.Staging_FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = FEBDP.PKStaging_FatturaElettronicaBody
		AND FEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
	OPEN cursor_FEBDPDP
	
	FETCH NEXT FROM cursor_FEBDPDP INTO
		@Beneficiario,
		@ModalitaPagamento,
		@DataRiferimentoTerminiPagamento,
		@GiorniTerminiPagamento,
		@DataScadenzaPagamento,
		@ImportoPagamento,
		@CodUfficioPostale,
		@CognomeQuietanzante,
		@NomeQuietanzante,
		@CFQuietanzante,
		@TitoloQuietanzante,
		@IstitutoFinanziario,
		@IBAN,
		@ABI,
		@CAB,
		@BIC,
		@ScontoPagamentoAnticipato,
		@DataLimitePagamentoAnticipato,
		@PenalitaPagamentiRitardati,
		@DataDecorrenzaPenale,
		@CodicePagamento;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.1', @ValoreTesto = @Beneficiario, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.2', @ValoreTesto = @ModalitaPagamento, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.3', @TipoValore = 'E', @ValoreData = @DataRiferimentoTerminiPagamento, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.4', @TipoValore = 'I', @ValoreIntero = @GiorniTerminiPagamento, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.5', @TipoValore = 'E', @ValoreData = @DataScadenzaPagamento, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.6', @TipoValore = 'D', @ValoreDecimale = @ImportoPagamento;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.7', @ValoreTesto = @CodUfficioPostale, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.8', @ValoreTesto = @CognomeQuietanzante, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.9', @ValoreTesto = @NomeQuietanzante, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.10', @ValoreTesto = @CFQuietanzante, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.11', @ValoreTesto = @TitoloQuietanzante, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.12', @ValoreTesto = @IstitutoFinanziario, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.13', @ValoreTesto = @IBAN, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.14', @TipoValore = 'I', @ValoreIntero = @ABI, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.15', @TipoValore = 'I', @ValoreIntero = @CAB, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.16', @ValoreTesto = @BIC, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.17', @TipoValore = 'D', @ValoreDecimale = @ScontoPagamentoAnticipato, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.18', @TipoValore = 'E', @ValoreData = @DataLimitePagamentoAnticipato, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.19', @TipoValore = 'D', @ValoreDecimale = @PenalitaPagamentiRitardati, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.20', @TipoValore = 'E', @ValoreData = @DataDecorrenzaPenale, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'2.4.2.21', @ValoreTesto = @CodicePagamento, @IsObbligatorio = 0;

		FETCH NEXT FROM cursor_FEBDPDP INTO
			@Beneficiario,
			@ModalitaPagamento,
			@DataRiferimentoTerminiPagamento,
			@GiorniTerminiPagamento,
			@DataScadenzaPagamento,
			@ImportoPagamento,
			@CodUfficioPostale,
			@CognomeQuietanzante,
			@NomeQuietanzante,
			@CFQuietanzante,
			@TitoloQuietanzante,
			@IstitutoFinanziario,
			@IBAN,
			@ABI,
			@CAB,
			@BIC,
			@ScontoPagamentoAnticipato,
			@DataLimitePagamentoAnticipato,
			@PenalitaPagamentiRitardati,
			@DataDecorrenzaPenale,
			@CodicePagamento;
	END
	
	CLOSE cursor_FEBDPDP
	DEALLOCATE cursor_FEBDPDP

	/*** DatiPagamento_DettaglioPagamento: fine ***/

	CLOSE cursor_FEB;
	DEALLOCATE cursor_FEB;

END;
GO
