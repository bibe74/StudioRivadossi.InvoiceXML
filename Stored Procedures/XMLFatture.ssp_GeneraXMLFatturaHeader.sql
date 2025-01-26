SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLFatture.ssp_GeneraXMLFatturaHeader
 * @description Generazione file XML fattura convalidata - Header (procedura di sistema)

 * @input_param @FatturaElettronicaHeader
 * @input_param @PKEvento

 * @output_param @PKEsitoEvento
 * @output_param @XMLOutput
*/

CREATE   PROCEDURE [XMLFatture].[ssp_GeneraXMLFatturaHeader] (
	@PKFatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@XMLOutput XML OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @sp_name sysname = OBJECT_NAME(@@PROCID);
	DECLARE @Messaggio NVARCHAR(500);

	SET @XMLOutput = (
		SELECT
			FEH.DatiTrasmissione_IdTrasmittente_IdPaese AS [DatiTrasmissione/IdTrasmittente/IdPaese],
			FEH.DatiTrasmissione_IdTrasmittente_IdCodice AS [DatiTrasmissione/IdTrasmittente/IdCodice],
			FEH.DatiTrasmissione_ProgressivoInvio AS [DatiTrasmissione/ProgressivoInvio],
			FEH.DatiTrasmissione_FormatoTrasmissione AS [DatiTrasmissione/FormatoTrasmissione],
			FEH.DatiTrasmissione_CodiceDestinatario AS [DatiTrasmissione/CodiceDestinatario],

			--FEH.DatiTrasmissione_HasContattiTrasmittente AS [DatiTrasmissione/HasContattiTrasmittente],
			CASE WHEN (FEH.DatiTrasmissione_HasContattiTrasmittente = CAST(0 AS BIT) OR FEH.DatiTrasmissione_ContattiTrasmittente_Telefono = N'') THEN NULL ELSE FEH.DatiTrasmissione_ContattiTrasmittente_Telefono END AS [DatiTrasmissione/ContattiTrasmittente/Telefono],
			CASE WHEN (FEH.DatiTrasmissione_HasContattiTrasmittente = CAST(0 AS BIT) OR FEH.DatiTrasmissione_ContattiTrasmittente_Email = N'') THEN NULL ELSE FEH.DatiTrasmissione_ContattiTrasmittente_Email END AS [DatiTrasmissione/ContattiTrasmittente/Email],
			CASE WHEN FEH.DatiTrasmissione_PECDestinatario = N'' THEN NULL ELSE FEH.DatiTrasmissione_PECDestinatario END AS [DatiTrasmissione/PECDestinatario],

			FEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese AS [CedentePrestatore/DatiAnagrafici/IdFiscaleIVA/IdPaese],
			FEH.CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice AS [CedentePrestatore/DatiAnagrafici/IdFiscaleIVA/IdCodice],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_CodiceFiscale = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_CodiceFiscale END AS [CedentePrestatore/DatiAnagrafici/CodiceFiscale],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione END AS [CedentePrestatore/DatiAnagrafici/Anagrafica/Denominazione],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Nome = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Nome END AS [CedentePrestatore/DatiAnagrafici/Anagrafica/Nome],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome END AS [CedentePrestatore/DatiAnagrafici/Anagrafica/Cognome],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Titolo = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_Titolo END AS [CedentePrestatore/DatiAnagrafici/Anagrafica/Titolo],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_CodEORI = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_Anagrafica_CodEORI END AS [CedentePrestatore/DatiAnagrafici/Anagrafica/CodEORI],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_AlboProfessionale = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_AlboProfessionale END AS [CedentePrestatore/DatiAnagrafici/AlboProfessionale],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_ProvinciaAlbo = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_ProvinciaAlbo END AS [CedentePrestatore/DatiAnagrafici/ProvinciaAlbo],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_NumeroIscrizioneAlbo = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_NumeroIscrizioneAlbo END AS [CedentePrestatore/DatiAnagrafici/NumeroIscrizioneAlbo],
			CASE WHEN FEH.CedentePrestatore_DatiAnagrafici_DataIscrizioneAlbo = N'' THEN NULL ELSE FEH.CedentePrestatore_DatiAnagrafici_DataIscrizioneAlbo END AS [CedentePrestatore/DatiAnagrafici/DataIscrizioneAlbo],
			FEH.CedentePrestatore_DatiAnagrafici_RegimeFiscale AS [CedentePrestatore/DatiAnagrafici/RegimeFiscale],
			FEH.CedentePrestatore_Sede_Indirizzo AS [CedentePrestatore/Sede/Indirizzo],
			CASE WHEN FEH.CedentePrestatore_Sede_NumeroCivico = N'' THEN NULL ELSE FEH.CedentePrestatore_Sede_NumeroCivico END AS [CedentePrestatore/Sede/NumeroCivico],
			FEH.CedentePrestatore_Sede_CAP AS [CedentePrestatore/Sede/CAP],
			FEH.CedentePrestatore_Sede_Comune AS [CedentePrestatore/Sede/Comune],
			CASE WHEN FEH.CedentePrestatore_Sede_Provincia = N'' THEN NULL ELSE FEH.CedentePrestatore_Sede_Provincia END AS [CedentePrestatore/Sede/Provincia],
			FEH.CedentePrestatore_Sede_Nazione AS [CedentePrestatore/Sede/Nazione],
			--FEH.CedentePrestatore_HasStabileOrganizzazione AS [CedentePrestatore/HasStabileOrganizzazione],
			CASE WHEN (FEH.CedentePrestatore_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CedentePrestatore_StabileOrganizzazione_Indirizzo = N'') THEN NULL ELSE FEH.CedentePrestatore_StabileOrganizzazione_Indirizzo END AS [CedentePrestatore/StabileOrganizzazione/Indirizzo],
			CASE WHEN (FEH.CedentePrestatore_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CedentePrestatore_StabileOrganizzazione_NumeroCivico = N'') THEN NULL ELSE FEH.CedentePrestatore_StabileOrganizzazione_NumeroCivico END AS [CedentePrestatore/StabileOrganizzazione/NumeroCivico],
			CASE WHEN (FEH.CedentePrestatore_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CedentePrestatore_StabileOrganizzazione_CAP = N'') THEN NULL ELSE FEH.CedentePrestatore_StabileOrganizzazione_CAP END AS [CedentePrestatore/StabileOrganizzazione/CAP],
			CASE WHEN (FEH.CedentePrestatore_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CedentePrestatore_StabileOrganizzazione_Comune = N'') THEN NULL ELSE FEH.CedentePrestatore_StabileOrganizzazione_Comune END AS [CedentePrestatore/StabileOrganizzazione/Comune],
			CASE WHEN (FEH.CedentePrestatore_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CedentePrestatore_StabileOrganizzazione_Provincia = N'') THEN NULL ELSE FEH.CedentePrestatore_StabileOrganizzazione_Provincia END AS [CedentePrestatore/StabileOrganizzazione/Provincia],
			CASE WHEN (FEH.CedentePrestatore_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CedentePrestatore_StabileOrganizzazione_Nazione = N'') THEN NULL ELSE FEH.CedentePrestatore_StabileOrganizzazione_Nazione END AS [CedentePrestatore/StabileOrganizzazione/Nazione],
			--FEH.CedentePrestatore_HasIscrizioneREA AS [CedentePrestatore/HasIscrizioneREA],
			CASE WHEN (FEH.CedentePrestatore_HasIscrizioneREA = CAST(0 AS BIT) OR FEH.CedentePrestatore_IscrizioneREA_Ufficio = N'') THEN NULL ELSE FEH.CedentePrestatore_IscrizioneREA_Ufficio END AS [CedentePrestatore/IscrizioneREA/Ufficio],
			CASE WHEN (FEH.CedentePrestatore_HasIscrizioneREA = CAST(0 AS BIT) OR FEH.CedentePrestatore_IscrizioneREA_NumeroREA = N'') THEN NULL ELSE FEH.CedentePrestatore_IscrizioneREA_NumeroREA END AS [CedentePrestatore/IscrizioneREA/NumeroREA],
			CASE WHEN (FEH.CedentePrestatore_HasIscrizioneREA = CAST(0 AS BIT) OR FEH.CedentePrestatore_IscrizioneREA_CapitaleSociale = N'') THEN NULL ELSE FEH.CedentePrestatore_IscrizioneREA_CapitaleSociale END AS [CedentePrestatore/IscrizioneREA/CapitaleSociale],
			CASE WHEN (FEH.CedentePrestatore_HasIscrizioneREA = CAST(0 AS BIT) OR FEH.CedentePrestatore_IscrizioneREA_SocioUnico = N'') THEN NULL ELSE FEH.CedentePrestatore_IscrizioneREA_SocioUnico END AS [CedentePrestatore/IscrizioneREA/SocioUnico],
			CASE WHEN (FEH.CedentePrestatore_HasIscrizioneREA = CAST(0 AS BIT) OR FEH.CedentePrestatore_IscrizioneREA_StatoLiquidazione = N'') THEN NULL ELSE FEH.CedentePrestatore_IscrizioneREA_StatoLiquidazione END AS [CedentePrestatore/IscrizioneREA/StatoLiquidazione],
			--FEH.CedentePrestatore_HasContatti AS [CedentePrestatore/HasContatti],
			CASE WHEN (FEH.CedentePrestatore_HasContatti = CAST(0 AS BIT) OR FEH.CedentePrestatore_Contatti_Telefono = N'') THEN NULL ELSE FEH.CedentePrestatore_Contatti_Telefono END AS [CedentePrestatore/Contatti/Telefono],
			CASE WHEN (FEH.CedentePrestatore_HasContatti = CAST(0 AS BIT) OR FEH.CedentePrestatore_Contatti_Fax = N'') THEN NULL ELSE FEH.CedentePrestatore_Contatti_Fax END AS [CedentePrestatore/Contatti/Fax],
			CASE WHEN (FEH.CedentePrestatore_HasContatti = CAST(0 AS BIT) OR FEH.CedentePrestatore_Contatti_Email = N'') THEN NULL ELSE FEH.CedentePrestatore_Contatti_Email END AS [CedentePrestatore/Contatti/Email],
			CASE WHEN FEH.CedentePrestatore_RiferimentoAmministrazione = N'' THEN NULL ELSE FEH.CedentePrestatore_RiferimentoAmministrazione END AS [CedentePrestatore/RiferimentoAmministrazione],

			--FEH.HasRappresentanteFiscale AS [HasRappresentanteFiscale],
			CASE WHEN (FEH.HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese = N'') THEN NULL ELSE FEH.RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese END AS [RappresentanteFiscale/DatiAnagrafici/IdFiscaleIVA/IdPaese],
			CASE WHEN (FEH.HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice = N'') THEN NULL ELSE FEH.RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice END AS [RappresentanteFiscale/DatiAnagrafici/IdFiscaleIVA/IdCodice],
			CASE WHEN (FEH.HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.RappresentanteFiscale_DatiAnagrafici_CodiceFiscale = N'') THEN NULL ELSE FEH.RappresentanteFiscale_DatiAnagrafici_CodiceFiscale END AS [RappresentanteFiscale/DatiAnagrafici/CodiceFiscale],
			CASE WHEN (FEH.HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione = N'') THEN NULL ELSE FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione END AS [RappresentanteFiscale/DatiAnagrafici/Anagrafica/Denominazione],
			CASE WHEN (FEH.HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome = N'') THEN NULL ELSE FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome END AS [RappresentanteFiscale/DatiAnagrafici/Anagrafica/Nome],
			CASE WHEN (FEH.HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome = N'') THEN NULL ELSE FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome END AS [RappresentanteFiscale/DatiAnagrafici/Anagrafica/Cognome],
			CASE WHEN (FEH.HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Titolo = N'') THEN NULL ELSE FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_Titolo END AS [RappresentanteFiscale/DatiAnagrafici/Anagrafica/Titolo],
			CASE WHEN (FEH.HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_CodEORI = N'') THEN NULL ELSE FEH.RappresentanteFiscale_DatiAnagrafici_Anagrafica_CodEORI END AS [RappresentanteFiscale/DatiAnagrafici/Anagrafica/CodEORI],

			--FEH.CessionarioCommittente_DatiAnagrafici_HasIdFiscaleIVA AS [CessionarioCommittente/DatiAnagrafici/HasIdFiscaleIVA],
			CASE WHEN (FEH.CessionarioCommittente_DatiAnagrafici_HasIdFiscaleIVA = CAST(0 AS BIT) OR FEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese = N'') THEN NULL ELSE FEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese END AS [CessionarioCommittente/DatiAnagrafici/IdFiscaleIVA/IdPaese],
			CASE WHEN (FEH.CessionarioCommittente_DatiAnagrafici_HasIdFiscaleIVA = CAST(0 AS BIT) OR FEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice = N'') THEN NULL ELSE FEH.CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice END AS [CessionarioCommittente/DatiAnagrafici/IdFiscaleIVA/IdCodice],
			CASE WHEN FEH.CessionarioCommittente_DatiAnagrafici_CodiceFiscale = N'' THEN NULL ELSE FEH.CessionarioCommittente_DatiAnagrafici_CodiceFiscale END AS [CessionarioCommittente/DatiAnagrafici/CodiceFiscale],
			CASE WHEN FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione = N'' THEN NULL ELSE FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione END AS [CessionarioCommittente/DatiAnagrafici/Anagrafica/Denominazione],
			CASE WHEN FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome = N'' THEN NULL ELSE FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome END AS [CessionarioCommittente/DatiAnagrafici/Anagrafica/Nome],
			CASE WHEN FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome = N'' THEN NULL ELSE FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome END AS [CessionarioCommittente/DatiAnagrafici/Anagrafica/Cognome],
			CASE WHEN FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Titolo = N'' THEN NULL ELSE FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_Titolo END AS [CessionarioCommittente/DatiAnagrafici/Anagrafica/Titolo],
			CASE WHEN FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_CodEORI = N'' THEN NULL ELSE FEH.CessionarioCommittente_DatiAnagrafici_Anagrafica_CodEORI END AS [CessionarioCommittente/DatiAnagrafici/Anagrafica/CodEORI],
			FEH.CessionarioCommittente_Sede_Indirizzo AS [CessionarioCommittente/Sede/Indirizzo],
			CASE WHEN FEH.CessionarioCommittente_Sede_NumeroCivico = N'' THEN NULL ELSE FEH.CessionarioCommittente_Sede_NumeroCivico END AS [CessionarioCommittente/Sede/NumeroCivico],
			FEH.CessionarioCommittente_Sede_CAP AS [CessionarioCommittente/Sede/CAP],
			FEH.CessionarioCommittente_Sede_Comune AS [CessionarioCommittente/Sede/Comune],
			CASE WHEN FEH.CessionarioCommittente_Sede_Provincia = N'' THEN NULL ELSE FEH.CessionarioCommittente_Sede_Provincia END AS [CessionarioCommittente/Sede/Provincia],
			FEH.CessionarioCommittente_Sede_Nazione AS [CessionarioCommittente/Sede/Nazione],
			--FEH.CessionarioCommittente_HasStabileOrganizzazione AS [CessionarioCommittente/HasStabileOrganizzazione],
			CASE WHEN (FEH.CessionarioCommittente_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CessionarioCommittente_StabileOrganizzazione_Indirizzo = N'') THEN NULL ELSE FEH.CessionarioCommittente_StabileOrganizzazione_Indirizzo END AS [CessionarioCommittente/StabileOrganizzazione/Indirizzo],
			CASE WHEN (FEH.CessionarioCommittente_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CessionarioCommittente_StabileOrganizzazione_NumeroCivico = N'') THEN NULL ELSE FEH.CessionarioCommittente_StabileOrganizzazione_NumeroCivico END AS [CessionarioCommittente/StabileOrganizzazione/NumeroCivico],
			CASE WHEN (FEH.CessionarioCommittente_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CessionarioCommittente_StabileOrganizzazione_CAP = N'') THEN NULL ELSE FEH.CessionarioCommittente_StabileOrganizzazione_CAP END AS [CessionarioCommittente/StabileOrganizzazione/CAP],
			CASE WHEN (FEH.CessionarioCommittente_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CessionarioCommittente_StabileOrganizzazione_Comune = N'') THEN NULL ELSE FEH.CessionarioCommittente_StabileOrganizzazione_Comune END AS [CessionarioCommittente/StabileOrganizzazione/Comune],
			CASE WHEN (FEH.CessionarioCommittente_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CessionarioCommittente_StabileOrganizzazione_Provincia = N'') THEN NULL ELSE FEH.CessionarioCommittente_StabileOrganizzazione_Provincia END AS [CessionarioCommittente/StabileOrganizzazione/Provincia],
			CASE WHEN (FEH.CessionarioCommittente_HasStabileOrganizzazione = CAST(0 AS BIT) OR FEH.CessionarioCommittente_StabileOrganizzazione_Nazione = N'') THEN NULL ELSE FEH.CessionarioCommittente_StabileOrganizzazione_Nazione END AS [CessionarioCommittente/StabileOrganizzazione/Nazione],
			--FEH.CessionarioCommittente_HasRappresentanteFiscale AS [CessionarioCommittente/HasRappresentanteFiscale],
			CASE WHEN (FEH.CessionarioCommittente_HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese = N'') THEN NULL ELSE FEH.CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese END AS [CessionarioCommittente/RappresentanteFiscale/IdFiscaleIVA/IdPaese],
			CASE WHEN (FEH.CessionarioCommittente_HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice = N'') THEN NULL ELSE FEH.CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice END AS [CessionarioCommittente/RappresentanteFiscale/IdFiscaleIVA/IdCodice],
			CASE WHEN (FEH.CessionarioCommittente_HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.CessionarioCommittente_RappresentanteFiscale_Denominazione = N'') THEN NULL ELSE FEH.CessionarioCommittente_RappresentanteFiscale_Denominazione END AS [CessionarioCommittente/RappresentanteFiscale/Denominazione],
			CASE WHEN (FEH.CessionarioCommittente_HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.CessionarioCommittente_RappresentanteFiscale_Nome = N'') THEN NULL ELSE FEH.CessionarioCommittente_RappresentanteFiscale_Nome END AS [CessionarioCommittente/RappresentanteFiscale/Nome],
			CASE WHEN (FEH.CessionarioCommittente_HasRappresentanteFiscale = CAST(0 AS BIT) OR FEH.CessionarioCommittente_RappresentanteFiscale_Cognome = N'') THEN NULL ELSE FEH.CessionarioCommittente_RappresentanteFiscale_Cognome END AS [CessionarioCommittente/RappresentanteFiscale/Cognome],

			--FEH.HasTerzoIntermediarioOSoggettoEmittente AS [HasTerzoIntermediarioOSoggettoEmittente],
			--FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_HasIdFiscaleIVA AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/HasIdFiscaleIVA],
			CASE WHEN (FEH.HasTerzoIntermediarioOSoggettoEmittente = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_HasIdFiscaleIVA = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese = N'') THEN NULL ELSE FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese END AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/IdFiscaleIVA/IdPaese],
			CASE WHEN (FEH.HasTerzoIntermediarioOSoggettoEmittente = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_HasIdFiscaleIVA = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice = N'') THEN NULL ELSE FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice END AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/IdFiscaleIVA/IdCodice],
			CASE WHEN (FEH.HasTerzoIntermediarioOSoggettoEmittente = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale = N'') THEN NULL ELSE FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale END AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/CodiceFiscale],
			CASE WHEN (FEH.HasTerzoIntermediarioOSoggettoEmittente = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione = N'') THEN NULL ELSE FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione END AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/Anagrafica/Denominazione],
			CASE WHEN (FEH.HasTerzoIntermediarioOSoggettoEmittente = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome = N'') THEN NULL ELSE FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome END AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/Anagrafica/Nome],
			CASE WHEN (FEH.HasTerzoIntermediarioOSoggettoEmittente = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome = N'') THEN NULL ELSE FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome END AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/Anagrafica/Cognome],
			CASE WHEN (FEH.HasTerzoIntermediarioOSoggettoEmittente = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Titolo = N'') THEN NULL ELSE FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Titolo END AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/Anagrafica/Titolo],
			CASE WHEN (FEH.HasTerzoIntermediarioOSoggettoEmittente = CAST(0 AS BIT) OR FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_CodEORI = N'') THEN NULL ELSE FEH.TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_CodEORI END AS [TerzoIntermediarioOSoggettoEmittente/DatiAnagrafici/Anagrafica/CodEORI],

			CASE WHEN FEH.SoggettoEmittente = N'' THEN NULL ELSE FEH.SoggettoEmittente END AS [SoggettoEmittente]

		FROM XMLFatture.FatturaElettronicaHeader FEH
		WHERE FEH.PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader
		FOR XML PATH ('FatturaElettronicaHeader')
	);

END;
GO
