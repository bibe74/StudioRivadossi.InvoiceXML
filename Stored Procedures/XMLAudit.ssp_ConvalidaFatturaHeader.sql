SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [XMLAudit].[ssp_ConvalidaFatturaHeader] (
	@PKStaging_FatturaElettronicaHeader BIGINT,
	@PKValidazione BIGINT
)
AS
BEGIN

	SET NOCOUNT ON;

	/* declare variables */
	DECLARE @DatiTrasmissione_IdTrasmittente_IdPaese CHAR(2);
	DECLARE @DatiTrasmissione_IdTrasmittente_IdCodice NVARCHAR(28);
	DECLARE @DatiTrasmissione_ProgressivoInvio NVARCHAR(10);
	DECLARE @DatiTrasmissione_FormatoTrasmissione CHAR(5);
	DECLARE @DatiTrasmissione_CodiceDestinatario NVARCHAR(7);
	DECLARE @DatiTrasmissione_PECDestinatario NVARCHAR(256);
	DECLARE @CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese CHAR(2);
	DECLARE @CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice NVARCHAR(28);
	DECLARE @CedentePrestatore_DatiAnagrafici_CodiceFiscale NVARCHAR(16);
	DECLARE @CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione NVARCHAR(80);
	DECLARE @CedentePrestatore_DatiAnagrafici_Anagrafica_Nome NVARCHAR(60);	
	DECLARE @CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome NVARCHAR(60);	
	DECLARE @CedentePrestatore_DatiAnagrafici_RegimeFiscale CHAR(4);
	DECLARE @CedentePrestatore_Sede_Indirizzo NVARCHAR(60);	
	DECLARE @CedentePrestatore_Sede_NumeroCivico NVARCHAR(8);	
	DECLARE @CedentePrestatore_Sede_CAP CHAR(5);	
	DECLARE @CedentePrestatore_Sede_Comune NVARCHAR(60);	
	DECLARE @CedentePrestatore_Sede_Provincia CHAR(2);
	DECLARE @CedentePrestatore_Sede_Nazione CHAR(2);
	DECLARE @RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese CHAR(2);
	DECLARE @RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice NVARCHAR(28);
	DECLARE @RappresentanteFiscale_DatiAnagrafici_CodiceFiscale NVARCHAR(16);
	DECLARE @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione NVARCHAR(80);	
	DECLARE @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome NVARCHAR(60);	
	DECLARE @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome NVARCHAR(60);	
	DECLARE @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese CHAR(2);
	DECLARE @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice NVARCHAR(28);
	DECLARE @CessionarioCommittente_DatiAnagrafici_CodiceFiscale NVARCHAR(16);
	DECLARE @CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione NVARCHAR(80);	
	DECLARE @CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome NVARCHAR(60);	
	DECLARE @CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome NVARCHAR(60);	
	DECLARE @CessionarioCommittente_Sede_Indirizzo NVARCHAR(60);	
	DECLARE @CessionarioCommittente_Sede_NumeroCivico NVARCHAR(8);	
	DECLARE @CessionarioCommittente_Sede_CAP CHAR(5);	
	DECLARE @CessionarioCommittente_Sede_Comune NVARCHAR(60);
	DECLARE @CessionarioCommittente_Sede_Provincia CHAR(2);
	DECLARE @CessionarioCommittente_Sede_Nazione CHAR(2);
	DECLARE @CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese CHAR(2);
	DECLARE @CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice NVARCHAR(28);
	DECLARE @CessionarioCommittente_RappresentanteFiscale_Denominazione NVARCHAR(80);
	DECLARE @CessionarioCommittente_RappresentanteFiscale_Nome NVARCHAR(60);	
	DECLARE @CessionarioCommittente_RappresentanteFiscale_Cognome NVARCHAR(60);	
	DECLARE @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese CHAR(2);
	DECLARE @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice NVARCHAR(28);
	DECLARE @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale NVARCHAR(16);
	DECLARE @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione NVARCHAR(80);
	DECLARE @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome NVARCHAR(60);	
	DECLARE @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome NVARCHAR(60);	
	DECLARE @SoggettoEmittente CHAR(2);

	BEGIN TRY

		DECLARE cursor_FEH CURSOR FAST_FORWARD READ_ONLY FOR
		SELECT
			DatiTrasmissione_IdTrasmittente_IdPaese
			, DatiTrasmissione_IdTrasmittente_IdCodice
			, DatiTrasmissione_ProgressivoInvio
			, DatiTrasmissione_FormatoTrasmissione
			, DatiTrasmissione_CodiceDestinatario
			, DatiTrasmissione_PECDestinatario
			, CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese
			, CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice
			, CedentePrestatore_DatiAnagrafici_CodiceFiscale
			, CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione
			, CedentePrestatore_DatiAnagrafici_Anagrafica_Nome
			, CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome
			, CedentePrestatore_DatiAnagrafici_RegimeFiscale
			, CedentePrestatore_Sede_Indirizzo
			, CedentePrestatore_Sede_NumeroCivico
			, CedentePrestatore_Sede_CAP
			, CedentePrestatore_Sede_Comune
			, CedentePrestatore_Sede_Provincia
			, CedentePrestatore_Sede_Nazione
			, RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese
			, RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice
			, RappresentanteFiscale_DatiAnagrafici_CodiceFiscale
			, RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione
			, RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome
			, RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome
			, CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese
			, CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice
			, CessionarioCommittente_DatiAnagrafici_CodiceFiscale
			, CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione
			, CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome
			, CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome
			, CessionarioCommittente_Sede_Indirizzo
			, CessionarioCommittente_Sede_NumeroCivico
			, CessionarioCommittente_Sede_CAP
			, CessionarioCommittente_Sede_Comune
			, CessionarioCommittente_Sede_Provincia
			, CessionarioCommittente_Sede_Nazione
			, CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese
			, CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice
			, CessionarioCommittente_RappresentanteFiscale_Denominazione
			, CessionarioCommittente_RappresentanteFiscale_Nome
			, CessionarioCommittente_RappresentanteFiscale_Cognome
			, TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese
			, TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice
			, TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale
			, TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione
			, TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome
			, TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome
			, SoggettoEmittente
 
		FROM XMLFatture.Staging_FatturaElettronicaHeader
		WHERE PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;
	
		OPEN cursor_FEH;
	
		FETCH NEXT FROM cursor_FEH INTO
			@DatiTrasmissione_IdTrasmittente_IdPaese
			, @DatiTrasmissione_IdTrasmittente_IdCodice
			, @DatiTrasmissione_ProgressivoInvio
			, @DatiTrasmissione_FormatoTrasmissione
			, @DatiTrasmissione_CodiceDestinatario
			, @DatiTrasmissione_PECDestinatario
			, @CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese
			, @CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice
			, @CedentePrestatore_DatiAnagrafici_CodiceFiscale
			, @CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione
			, @CedentePrestatore_DatiAnagrafici_Anagrafica_Nome
			, @CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome
			, @CedentePrestatore_DatiAnagrafici_RegimeFiscale
			, @CedentePrestatore_Sede_Indirizzo
			, @CedentePrestatore_Sede_NumeroCivico
			, @CedentePrestatore_Sede_CAP
			, @CedentePrestatore_Sede_Comune
			, @CedentePrestatore_Sede_Provincia
			, @CedentePrestatore_Sede_Nazione
			, @RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese
			, @RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice
			, @RappresentanteFiscale_DatiAnagrafici_CodiceFiscale
			, @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione
			, @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome
			, @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome
			, @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese
			, @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice
			, @CessionarioCommittente_DatiAnagrafici_CodiceFiscale
			, @CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione
			, @CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome
			, @CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome
			, @CessionarioCommittente_Sede_Indirizzo
			, @CessionarioCommittente_Sede_NumeroCivico
			, @CessionarioCommittente_Sede_CAP
			, @CessionarioCommittente_Sede_Comune
			, @CessionarioCommittente_Sede_Provincia
			, @CessionarioCommittente_Sede_Nazione
			, @CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese
			, @CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice
			, @CessionarioCommittente_RappresentanteFiscale_Denominazione
			, @CessionarioCommittente_RappresentanteFiscale_Nome
			, @CessionarioCommittente_RappresentanteFiscale_Cognome
			, @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese
			, @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice
			, @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale
			, @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione
			, @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome
			, @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome
			, @SoggettoEmittente;

		--WHILE @@FETCH_STATUS = 0
		--BEGIN
	    
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.1.1.1', @ValoreTesto = @DatiTrasmissione_IdTrasmittente_IdPaese;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.1.1.2', @ValoreTesto = @DatiTrasmissione_IdTrasmittente_IdCodice, @IDNazione = @DatiTrasmissione_IdTrasmittente_IdPaese;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.1.2', @ValoreTesto = @DatiTrasmissione_ProgressivoInvio;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.1.3', @ValoreTesto = @DatiTrasmissione_FormatoTrasmissione;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.1.4', @ValoreTesto = @DatiTrasmissione_CodiceDestinatario, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.1.6', @ValoreTesto = @DatiTrasmissione_PECDestinatario, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.1.1.1', @ValoreTesto = @CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.1.1.2', @ValoreTesto = @CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice, @IDNazione = @CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.1.2', @ValoreTesto = @CedentePrestatore_DatiAnagrafici_CodiceFiscale, @IsObbligatorio = 0, @IDNazione = @CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.1.3.1', @ValoreTesto = @CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.1.3.2', @ValoreTesto = @CedentePrestatore_DatiAnagrafici_Anagrafica_Nome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.1.3.3', @ValoreTesto = @CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.1.8', @ValoreTesto = @CedentePrestatore_DatiAnagrafici_RegimeFiscale;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.2.1', @ValoreTesto = @CedentePrestatore_Sede_Indirizzo;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.2.2', @ValoreTesto = @CedentePrestatore_Sede_NumeroCivico, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.2.3', @ValoreTesto = @CedentePrestatore_Sede_CAP;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.2.4', @ValoreTesto = @CedentePrestatore_Sede_Comune;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.2.5', @ValoreTesto = @CedentePrestatore_Sede_Provincia, @IsObbligatorio = 0, @IDNazione = @CedentePrestatore_Sede_Nazione;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.2.2.6', @ValoreTesto = @CedentePrestatore_Sede_Nazione;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.3.1.1.1', @ValoreTesto = @RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.3.1.1.2', @ValoreTesto = @RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.3.1.2', @ValoreTesto = @RappresentanteFiscale_DatiAnagrafici_CodiceFiscale, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.3.1.3.1', @ValoreTesto = @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.3.1.3.2', @ValoreTesto = @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.3.1.3.3', @ValoreTesto = @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.1.1.1', @ValoreTesto = @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.1.1.2', @ValoreTesto = @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice, @IsObbligatorio = 0, @IDNazione = @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.1.2', @ValoreTesto = @CessionarioCommittente_DatiAnagrafici_CodiceFiscale, @IsObbligatorio = 0, @IDNazione = @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.1.3.1', @ValoreTesto = @CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.1.3.2', @ValoreTesto = @CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.1.3.3', @ValoreTesto = @CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.2.1', @ValoreTesto = @CessionarioCommittente_Sede_Indirizzo;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.2.2', @ValoreTesto = @CessionarioCommittente_Sede_NumeroCivico, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.2.3', @ValoreTesto = @CessionarioCommittente_Sede_CAP;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.2.4', @ValoreTesto = @CessionarioCommittente_Sede_Comune;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.2.5', @ValoreTesto = @CessionarioCommittente_Sede_Provincia, @IsObbligatorio = 0, @IDNazione = @CessionarioCommittente_Sede_Nazione;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.2.6', @ValoreTesto = @CessionarioCommittente_Sede_Nazione;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.4.1.1', @ValoreTesto = @CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.4.1.2', @ValoreTesto = @CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.4.2', @ValoreTesto = @CessionarioCommittente_RappresentanteFiscale_Denominazione, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.4.3', @ValoreTesto = @CessionarioCommittente_RappresentanteFiscale_Nome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.4.4.4', @ValoreTesto = @CessionarioCommittente_RappresentanteFiscale_Cognome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.5.1.1.1', @ValoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.5.1.1.2', @ValoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.5.1.2', @ValoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.5.1.3.1', @ValoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.5.1.3.2', @ValoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.5.1.3.3', @ValoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome, @IsObbligatorio = 0;
		EXEC XMLFatture.ssp_VerificaCampoSDI @PKValidazione = @PKValidazione, @IDCampo = N'1.6', @ValoreTesto = @SoggettoEmittente, @IsObbligatorio = 0;

		IF (
			(@DatiTrasmissione_FormatoTrasmissione = 'FPA12' AND LEN(@DatiTrasmissione_CodiceDestinatario) <> 6)
			OR (@DatiTrasmissione_FormatoTrasmissione = 'FPR12' AND LEN(@DatiTrasmissione_CodiceDestinatario) <> 7)
		)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'1.1.3',
																@CodiceErroreSDI = 427,
																@valoreTesto = @DatiTrasmissione_FormatoTrasmissione,
																@LivelloLog = 4;

		END;

		IF (
			(@DatiTrasmissione_FormatoTrasmissione = 'FPA12' AND LEN(@DatiTrasmissione_CodiceDestinatario) <> 6)
			OR (@DatiTrasmissione_FormatoTrasmissione = 'FPR12' AND LEN(@DatiTrasmissione_CodiceDestinatario) <> 7)
		)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'1.1.4',
																@CodiceErroreSDI = 427,
																@valoreTesto = @DatiTrasmissione_CodiceDestinatario,
																@LivelloLog = 4;

		END;

		IF (
			/* Specifica Versione 1.2.1 - 1.1.6 <PECDestinatario> non valorizzato a fronte di 1.1.4 <CodiceDestinatario> con valore 0000000
            (@DatiTrasmissione_FormatoTrasmissione = 'FPR12' AND @DatiTrasmissione_CodiceDestinatario = N'0000000' AND COALESCE(@DatiTrasmissione_PECDestinatario, N'') = N'')
			OR (@DatiTrasmissione_FormatoTrasmissione = 'FPR12' AND @DatiTrasmissione_CodiceDestinatario <> N'0000000' AND COALESCE(@DatiTrasmissione_PECDestinatario, N'') <> N'') 
            
            In realtà lo SDI accetta fatture con CodiceDestinatario 0000000 e PEC non valorizzata (OK per i privati senza codice destinatario nè PEC) */
			(@DatiTrasmissione_FormatoTrasmissione = 'FPR12' AND @DatiTrasmissione_CodiceDestinatario <> N'0000000' AND COALESCE(@DatiTrasmissione_PECDestinatario, N'') <> N'')
		)
		BEGIN

			EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																@IDCampo = N'1.1.6',
																@CodiceErroreSDI = 426,
																@valoreTesto = @DatiTrasmissione_PECDestinatario,
																@LivelloLog = 4;

		END;


		----IF (
		----	COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N''
		----	OR COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome, N'') <> N''
		----	OR COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Nome, N'') <> N''
		----)
		----BEGIN

			IF (
				(COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND (COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Nome, N'') = N'' OR COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome, N'') = N''))
				OR (COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND (COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Nome, N'') <> N'' OR COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome, N'') <> N''))
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.2.1.3.1',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome, N'') = N'')
				OR (COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.2.1.3.2',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Nome, N'') = N'')
				OR (COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND COALESCE(@CedentePrestatore_DatiAnagrafici_Anagrafica_Nome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.2.1.3.3',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CedentePrestatore_DatiAnagrafici_Anagrafica_Nome,
																	@LivelloLog = 4;

			END;

		----END;

		IF (
			COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N''
			OR COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome, N'') <> N''
			OR COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome, N'') <> N''
		)
		BEGIN

			IF (
				(COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND (COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome, N'') = N'' OR COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome, N'') = N''))
				OR (COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND (COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome, N'') <> N'' OR COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome, N'') <> N''))
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.3.1.3.1',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome, N'') = N'')
				OR (COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.3.1.3.2',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome, N'') = N'')
				OR (COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND COALESCE(@RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.3.1.3.3',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome,
																	@LivelloLog = 4;

			END;

		END;

		IF (
			COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N''
			OR COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome, N'') <> N''
			OR COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome, N'') <> N''
		)
		BEGIN

			IF (COALESCE(@CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice, N'') = N'' AND COALESCE(@CessionarioCommittente_DatiAnagrafici_CodiceFiscale, N'') = N'')
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.4.1.1',
																	@CodiceErroreSDI = 417,
																	@valoreTesto = @CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice,
																	@LivelloLog = 4;

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.4.1.2',
																	@CodiceErroreSDI = 417,
																	@valoreTesto = @CessionarioCommittente_DatiAnagrafici_CodiceFiscale,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND (COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome, N'') = N'' OR COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome, N'') = N''))
				OR (COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND (COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome, N'') <> N'' OR COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome, N'') <> N''))
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.4.1.3.1',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome, N'') = N'')
				OR (COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.4.1.3.2',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome, N'') = N'')
				OR (COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND COALESCE(@CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.4.1.3.3',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome,
																	@LivelloLog = 4;

			END;

		END;

		IF (
			COALESCE(@CessionarioCommittente_RappresentanteFiscale_Denominazione, N'') <> N''
			OR COALESCE(@CessionarioCommittente_RappresentanteFiscale_Cognome, N'') <> N''
			OR COALESCE(@CessionarioCommittente_RappresentanteFiscale_Nome, N'') <> N''
		)
		BEGIN

			IF (
				(COALESCE(@CessionarioCommittente_RappresentanteFiscale_Denominazione, N'') = N'' AND (COALESCE(@CessionarioCommittente_RappresentanteFiscale_Nome, N'') = N'' OR COALESCE(@CessionarioCommittente_RappresentanteFiscale_Cognome, N'') = N''))
				OR (COALESCE(@CessionarioCommittente_RappresentanteFiscale_Denominazione, N'') <> N'' AND (COALESCE(@CessionarioCommittente_RappresentanteFiscale_Nome, N'') <> N'' OR COALESCE(@CessionarioCommittente_RappresentanteFiscale_Cognome, N'') <> N''))
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.4.4.3',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CessionarioCommittente_RappresentanteFiscale_Denominazione,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@CessionarioCommittente_RappresentanteFiscale_Denominazione, N'') = N'' AND COALESCE(@CessionarioCommittente_RappresentanteFiscale_Cognome, N'') = N'')
				OR (COALESCE(@CessionarioCommittente_RappresentanteFiscale_Denominazione, N'') <> N'' AND COALESCE(@CessionarioCommittente_RappresentanteFiscale_Cognome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.4.4.3',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CessionarioCommittente_RappresentanteFiscale_Cognome,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@CessionarioCommittente_RappresentanteFiscale_Denominazione, N'') = N'' AND COALESCE(@CessionarioCommittente_RappresentanteFiscale_Nome, N'') = N'')
				OR (COALESCE(@CessionarioCommittente_RappresentanteFiscale_Denominazione, N'') <> N'' AND COALESCE(@CessionarioCommittente_RappresentanteFiscale_Nome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.4.4.4',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @CessionarioCommittente_RappresentanteFiscale_Nome,
																	@LivelloLog = 4;

			END;

		END;

		IF (
			COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N''
			OR COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome, N'') <> N''
			OR COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome, N'') <> N''
		)
		BEGIN

			IF (
				(COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND (COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome, N'') = N'' OR COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome, N'') = N''))
				OR (COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND (COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome, N'') <> N'' OR COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome, N'') <> N''))
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.5.1.3.1',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome, N'') = N'')
				OR (COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.5.1.3.2',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome,
																	@LivelloLog = 4;

			END;

			IF (
				(COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, N'') = N'' AND COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome, N'') = N'')
				OR (COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, N'') <> N'' AND COALESCE(@TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome, N'') <> N'')
			)
			BEGIN

				EXEC XMLAudit.ssp_ScriviLogValidazioneDaErroreSDI @PKValidazione = @PKValidazione,
																	@IDCampo = N'1.5.1.3.3',
																	@CodiceErroreSDI = 200,
																	@valoreTesto = @TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome,
																	@LivelloLog = 4;

			END;

		END;

		--    FETCH NEXT FROM cursor_FEH INTO @variable
		--END
	
		CLOSE cursor_FEH;
		DEALLOCATE cursor_FEH;

	END TRY
	BEGIN CATCH

	END CATCH

END;
GO
