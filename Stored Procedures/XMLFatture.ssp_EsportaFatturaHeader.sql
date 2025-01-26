SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLFatture.ssp_EsportaFatturaHeader
 * @description Esportazione fattura da tabelle di staging a tabelle "ufficiali" - Testata fattura

 * @input_param @PKStaging_FatturaElettronicaHeader
 * @input_param @PKFatturaElettronicaHeader
 * @input_param @PKEvento

 * @output_param @PKEsitoEvento
*/

CREATE   PROCEDURE [XMLFatture].[ssp_EsportaFatturaHeader] (
	@PKStaging_FatturaElettronicaHeader BIGINT,
	@PKFatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT,
	@PKEsitoEvento SMALLINT OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @sp_name sysname = OBJECT_NAME(@@PROCID);
	DECLARE @Messaggio NVARCHAR(500);

	--BEGIN TRANSACTION; -- L'unica transazione è gestita nella procedura XMLFatture.ssp_EsportaFattura

	BEGIN TRY

		INSERT INTO XMLFatture.FatturaElettronicaHeader
		(
			PKFatturaElettronicaHeader,
			PKLanding_Fattura,
			PKStaging_FatturaElettronicaHeader,
			DatiTrasmissione_IdTrasmittente_IdPaese,
			DatiTrasmissione_IdTrasmittente_IdCodice,
			DatiTrasmissione_ProgressivoInvio,
			DatiTrasmissione_FormatoTrasmissione,
			DatiTrasmissione_CodiceDestinatario,
			DatiTrasmissione_HasContattiTrasmittente,
			DatiTrasmissione_ContattiTrasmittente_Telefono,
			DatiTrasmissione_ContattiTrasmittente_Email,
			DatiTrasmissione_PECDestinatario,
			CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese,
			CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice,
			CedentePrestatore_DatiAnagrafici_CodiceFiscale,
			CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione,
			CedentePrestatore_DatiAnagrafici_Anagrafica_Nome,
			CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome,
			CedentePrestatore_DatiAnagrafici_Anagrafica_Titolo,
			CedentePrestatore_DatiAnagrafici_Anagrafica_CodEORI,
			CedentePrestatore_DatiAnagrafici_AlboProfessionale,
			CedentePrestatore_DatiAnagrafici_ProvinciaAlbo,
			CedentePrestatore_DatiAnagrafici_NumeroIscrizioneAlbo,
			CedentePrestatore_DatiAnagrafici_DataIscrizioneAlbo,
			CedentePrestatore_DatiAnagrafici_RegimeFiscale,
			CedentePrestatore_Sede_Indirizzo,
			CedentePrestatore_Sede_NumeroCivico,
			CedentePrestatore_Sede_CAP,
			CedentePrestatore_Sede_Comune,
			CedentePrestatore_Sede_Provincia,
			CedentePrestatore_Sede_Nazione,
			CedentePrestatore_HasStabileOrganizzazione,
			CedentePrestatore_StabileOrganizzazione_Indirizzo,
			CedentePrestatore_StabileOrganizzazione_NumeroCivico,
			CedentePrestatore_StabileOrganizzazione_CAP,
			CedentePrestatore_StabileOrganizzazione_Comune,
			CedentePrestatore_StabileOrganizzazione_Provincia,
			CedentePrestatore_StabileOrganizzazione_Nazione,
			CedentePrestatore_HasIscrizioneREA,
			CedentePrestatore_IscrizioneREA_Ufficio,
			CedentePrestatore_IscrizioneREA_NumeroREA,
			CedentePrestatore_IscrizioneREA_CapitaleSociale,
			CedentePrestatore_IscrizioneREA_SocioUnico,
			CedentePrestatore_IscrizioneREA_StatoLiquidazione,
			CedentePrestatore_HasContatti,
			CedentePrestatore_Contatti_Telefono,
			CedentePrestatore_Contatti_Fax,
			CedentePrestatore_Contatti_Email,
			CedentePrestatore_RiferimentoAmministrazione,
			HasRappresentanteFiscale,
			RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese,
			RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice,
			RappresentanteFiscale_DatiAnagrafici_CodiceFiscale,
			RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione,
			RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome,
			RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome,
			RappresentanteFiscale_DatiAnagrafici_Anagrafica_Titolo,
			RappresentanteFiscale_DatiAnagrafici_Anagrafica_CodEORI,
			CessionarioCommittente_DatiAnagrafici_HasIdFiscaleIVA,
			CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese,
			CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice,
			CessionarioCommittente_DatiAnagrafici_CodiceFiscale,
			CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione,
			CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome,
			CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome,
			CessionarioCommittente_DatiAnagrafici_Anagrafica_Titolo,
			CessionarioCommittente_DatiAnagrafici_Anagrafica_CodEORI,
			CessionarioCommittente_Sede_Indirizzo,
			CessionarioCommittente_Sede_NumeroCivico,
			CessionarioCommittente_Sede_CAP,
			CessionarioCommittente_Sede_Comune,
			CessionarioCommittente_Sede_Provincia,
			CessionarioCommittente_Sede_Nazione,
			CessionarioCommittente_HasStabileOrganizzazione,
			CessionarioCommittente_StabileOrganizzazione_Indirizzo,
			CessionarioCommittente_StabileOrganizzazione_NumeroCivico,
			CessionarioCommittente_StabileOrganizzazione_CAP,
			CessionarioCommittente_StabileOrganizzazione_Comune,
			CessionarioCommittente_StabileOrganizzazione_Provincia,
			CessionarioCommittente_StabileOrganizzazione_Nazione,
			CessionarioCommittente_HasRappresentanteFiscale,
			CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese,
			CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice,
			CessionarioCommittente_RappresentanteFiscale_Denominazione,
			CessionarioCommittente_RappresentanteFiscale_Nome,
			CessionarioCommittente_RappresentanteFiscale_Cognome,
			HasTerzoIntermediarioOSoggettoEmittente,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_HasIdFiscaleIVA,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Titolo,
			TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_CodEORI,
			SoggettoEmittente
		)
		SELECT
			@PKFatturaElettronicaHeader,
			SFEH.PKLanding_Fattura,
			SFEH.PKStaging_FatturaElettronicaHeader,
			SFEH.DatiTrasmissione_IdTrasmittente_IdPaese,
			SFEH.DatiTrasmissione_IdTrasmittente_IdCodice,
			SFEH.DatiTrasmissione_ProgressivoInvio,
			SFEH.DatiTrasmissione_FormatoTrasmissione,
			SFEH.DatiTrasmissione_CodiceDestinatario,
			CASE
				WHEN COALESCE(SFEH.DatiTrasmissione_ContattiTrasmittente_Telefono, N'') = N''
					AND COALESCE(SFEH.DatiTrasmissione_ContattiTrasmittente_Email, N'') = N''
				THEN 0
				ELSE 1
			END AS DatiTrasmissione_HasContattiTrasmittente,
			COALESCE(SFEH.DatiTrasmissione_ContattiTrasmittente_Telefono, N'') AS DatiTrasmissione_ContattiTrasmittente_Telefono,
			COALESCE(SFEH.DatiTrasmissione_ContattiTrasmittente_Email, N'') AS DatiTrasmissione_ContattiTrasmittente_Email,
			COALESCE(SFEH.DatiTrasmissione_PECDestinatario, N'') AS DatiTrasmissione_PECDestinatario,
			SFEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese,
			SFEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_CodiceFiscale, N'') AS CedentePrestatore_DatiAnagrafici_CodiceFiscale,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione, N'') AS CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Nome, N'') AS CedentePrestatore_DatiAnagrafici_Anagrafica_Nome,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome, N'') AS CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Titolo, N'') AS CedentePrestatore_DatiAnagrafici_Anagrafica_Titolo,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_Anagrafica_CodEORI, N'') AS CedentePrestatore_DatiAnagrafici_Anagrafica_CodEORI,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_AlboProfessionale, N'') AS CedentePrestatore_DatiAnagrafici_AlboProfessionale,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_ProvinciaAlbo, N'') AS CedentePrestatore_DatiAnagrafici_ProvinciaAlbo,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_NumeroIscrizioneAlbo, N'') AS CedentePrestatore_DatiAnagrafici_NumeroIscrizioneAlbo,
			COALESCE(SFEH.CedentePrestatore_DatiAnagrafici_DataIscrizioneAlbo, NULL) AS CedentePrestatore_DatiAnagrafici_DataIscrizioneAlbo,
			SFEH.CedentePrestatore_DatiAnagrafici_RegimeFiscale,
			SFEH.CedentePrestatore_Sede_Indirizzo,
			COALESCE(SFEH.CedentePrestatore_Sede_NumeroCivico, N'') AS CedentePrestatore_Sede_NumeroCivico,
			SFEH.CedentePrestatore_Sede_CAP,
			SFEH.CedentePrestatore_Sede_Comune,
			COALESCE(SFEH.CedentePrestatore_Sede_Provincia, N'') AS CedentePrestatore_Sede_Provincia,
			SFEH.CedentePrestatore_Sede_Nazione,
			CASE
				WHEN COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_Indirizzo, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_NumeroCivico, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_CAP, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_Comune, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_Provincia, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_Nazione, N'') = N''
				THEN 0
				ELSE 1
			END AS CedentePrestatore_HasStabileOrganizzazione,
			COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_Indirizzo, N'') AS CedentePrestatore_StabileOrganizzazione_Indirizzo,
			COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_NumeroCivico, N'') AS CedentePrestatore_StabileOrganizzazione_NumeroCivico,
			COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_CAP, N'') AS CedentePrestatore_StabileOrganizzazione_CAP,
			COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_Comune, N'') AS CedentePrestatore_StabileOrganizzazione_Comune,
			COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_Provincia, N'') AS CedentePrestatore_StabileOrganizzazione_Provincia,
			COALESCE(SFEH.CedentePrestatore_StabileOrganizzazione_Nazione, N'') AS CedentePrestatore_StabileOrganizzazione_Nazione,
			CASE
				WHEN COALESCE(SFEH.CedentePrestatore_IscrizioneREA_Ufficio, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_IscrizioneREA_NumeroREA, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_IscrizioneREA_CapitaleSociale, 0.0) = 0.0
					AND COALESCE(SFEH.CedentePrestatore_IscrizioneREA_SocioUnico, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_IscrizioneREA_StatoLiquidazione, N'') = N''
				THEN 0
				ELSE 1
			END AS CedentePrestatore_HasIscrizioneREA,
			COALESCE(SFEH.CedentePrestatore_IscrizioneREA_Ufficio, N'') AS CedentePrestatore_IscrizioneREA_Ufficio,
			COALESCE(SFEH.CedentePrestatore_IscrizioneREA_NumeroREA, N'') AS CedentePrestatore_IscrizioneREA_NumeroREA,
			COALESCE(SFEH.CedentePrestatore_IscrizioneREA_CapitaleSociale, 0.0) AS CedentePrestatore_IscrizioneREA_CapitaleSociale,
			COALESCE(SFEH.CedentePrestatore_IscrizioneREA_SocioUnico, N'') AS CedentePrestatore_IscrizioneREA_SocioUnico,
			COALESCE(SFEH.CedentePrestatore_IscrizioneREA_StatoLiquidazione, N'') AS CedentePrestatore_IscrizioneREA_StatoLiquidazione,
			CASE
				WHEN COALESCE(SFEH.CedentePrestatore_Contatti_Telefono, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_Contatti_Fax, N'') = N''
					AND COALESCE(SFEH.CedentePrestatore_Contatti_Email, N'') = N''
				THEN 0
				ELSE 1
			END AS CedentePrestatore_HasContatti,
			COALESCE(SFEH.CedentePrestatore_Contatti_Telefono, N'') AS CedentePrestatore_Contatti_Telefono,
			COALESCE(SFEH.CedentePrestatore_Contatti_Fax, N'') AS CedentePrestatore_Contatti_Fax,
			COALESCE(SFEH.CedentePrestatore_Contatti_Email, N'') AS CedentePrestatore_Contatti_Email,
			COALESCE(SFEH.CedentePrestatore_RiferimentoAmministrazione, N'') AS CedentePrestatore_RiferimentoAmministrazione,
			CASE
				WHEN COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese, N'') = N''
					AND COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice, N'') = N''
				THEN 0
				ELSE 1
			END AS HasRappresentanteFiscale,
			COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese, N'') AS RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese,
			COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice, N'') AS RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice,
			COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_CodiceFiscale, N'') AS RappresentanteFiscale_DatiAnagrafici_CodiceFiscale,
			COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione, N'') AS RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione,
			COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome, N'') AS RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome,
			COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome, N'') AS RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome,
			COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Titolo, N'') AS RappresentanteFiscale_DatiAnagrafici_Anagrafica_Titolo,
			COALESCE(SFEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_CodEORI, N'') AS RappresentanteFiscale_DatiAnagrafici_Anagrafica_CodEORI,
			CASE
				WHEN COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese, N'') = N''
					AND COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice, N'') = N''
				THEN 0
				ELSE 1
			END AS CessionarioCommittente_DatiAnagrafici_HasIdFiscaleIVA,
			COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese, N'') AS CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese,
			COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice, N'') AS CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice,
			COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_CodiceFiscale, N'') AS CessionarioCommittente_DatiAnagrafici_CodiceFiscale,
			COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione, N'') AS CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione,
			COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome, N'') AS CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome,
			COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome, N'') AS CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome,
			COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Titolo, N'') AS CessionarioCommittente_DatiAnagrafici_Anagrafica_Titolo,
			COALESCE(SFEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_CodEORI, N'') AS CessionarioCommittente_DatiAnagrafici_Anagrafica_CodEORI,
			SFEH.CessionarioCommittente_Sede_Indirizzo,
			COALESCE(SFEH.CessionarioCommittente_Sede_NumeroCivico, N'') AS CessionarioCommittente_Sede_NumeroCivico,
			SFEH.CessionarioCommittente_Sede_CAP,
			SFEH.CessionarioCommittente_Sede_Comune,
			COALESCE(SFEH.CessionarioCommittente_Sede_Provincia, N'') AS CessionarioCommittente_Sede_Provincia,
			SFEH.CessionarioCommittente_Sede_Nazione,
			CASE
				WHEN COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_Indirizzo, N'') = N''
					AND COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_NumeroCivico, N'') = N''
					AND COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_CAP, N'') = N''
					AND COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_Comune, N'') = N''
					AND COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_Provincia, N'') = N''
					AND COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_Nazione, N'') = N''
				THEN 0
				ELSE 1
			END AS CessionarioCommittente_HasStabileOrganizzazione,
			COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_Indirizzo, N'') AS CessionarioCommittente_StabileOrganizzazione_Indirizzo,
			COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_NumeroCivico, N'') AS CessionarioCommittente_StabileOrganizzazione_NumeroCivico,
			COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_CAP, N'') AS CessionarioCommittente_StabileOrganizzazione_CAP,
			COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_Comune, N'') AS CessionarioCommittente_StabileOrganizzazione_Comune,
			COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_Provincia, N'') AS CessionarioCommittente_StabileOrganizzazione_Provincia,
			COALESCE(SFEH.CessionarioCommittente_StabileOrganizzazione_Nazione, N'') AS CessionarioCommittente_StabileOrganizzazione_Nazione,
			CASE
				WHEN COALESCE(SFEH.CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese, N'') = N''
					AND COALESCE(SFEH.CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice, N'') = N''
				THEN 0
				ELSE 1
			END AS HasRappresentanteFiscale,
			COALESCE(SFEH.CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese, N'') AS CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese,
			COALESCE(SFEH.CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice, N'') AS CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice,
			COALESCE(SFEH.CessionarioCommittente_RappresentanteFiscale_Denominazione, N'') AS CessionarioCommittente_RappresentanteFiscale_Denominazione,
			COALESCE(SFEH.CessionarioCommittente_RappresentanteFiscale_Nome, N'') AS CessionarioCommittente_RappresentanteFiscale_Nome,
			COALESCE(SFEH.CessionarioCommittente_RappresentanteFiscale_Cognome, N'') AS CessionarioCommittente_RappresentanteFiscale_Cognome,
			CASE
				WHEN COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese, N'') = N''
					AND COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice, N'') = N''
				THEN 0
				ELSE 1
			END AS HasTerzoIntermediarioOSoggettoEmittente,
			CASE
				WHEN COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese, N'') = N''
					AND COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice, N'') = N''
				THEN 0
				ELSE 1
			END AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_HasIdFiscaleIVA,
			COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese, N'') AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese,
			COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice, N'') AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice,
			COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale, N'') AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale,
			COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione, N'') AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione,
			COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome, N'') AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome,
			COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome, N'') AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome,
			COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Titolo, N'') AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Titolo,
			COALESCE(SFEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_CodEORI, N'') AS TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_CodEORI,
			COALESCE(SFEH.SoggettoEmittente, N'') AS SoggettoEmittente
	
		FROM XMLFatture.Staging_FatturaElettronicaHeader SFEH
		WHERE SFEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE('Inserimento XMLFatture.FatturaElettronicaHeader (#%PKFatturaElettronicaHeader%) completato', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		UPDATE XMLFatture.Staging_FatturaElettronicaHeader SET IsValida = CAST(1 AS BIT) WHERE PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE('Aggiornamento validità XMLFatture.Staging_FatturaElettronicaHeader (#%PKStaging_FatturaElettronicaHeader%) completato', N'%PKStaging_FatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKStaging_FatturaElettronicaHeader));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		--COMMIT TRANSACTION;

	END TRY
	BEGIN CATCH

		--IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION; -- L'unica transazione è gestita nella procedura XMLFatture.ssp_EsportaFattura

		SET @PKStaging_FatturaElettronicaHeader = -1;

		SET @PKEsitoEvento = 311; -- 311: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaHeader
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = N'Errore in esportazione testata fattura',
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 0; -- 0: trace

	END CATCH;

END;
GO
