SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [XMLFatture].[ssp_EsportaFatturaBody] (
	@PKStaging_FatturaElettronicaHeader BIGINT,
	@PKFatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT,
	@PKEsitoEvento BIGINT OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @sp_name sysname = OBJECT_NAME(@@PROCID);
	DECLARE @NomeTabella sysname;
	DECLARE @Messaggio NVARCHAR(500);

	--BEGIN TRANSACTION;

	BEGIN TRY

		/* FatturaElettronicaBody: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody';
		INSERT INTO XMLFatture.FatturaElettronicaBody
		(
			--PKFatturaElettronicaBody,
			PKFatturaElettronicaHeader,
			PKStaging_FatturaElettronicaBody,
			DatiGenerali_DatiGeneraliDocumento_TipoDocumento,
			DatiGenerali_DatiGeneraliDocumento_Divisa,
			DatiGenerali_DatiGeneraliDocumento_Data,
			DatiGenerali_DatiGeneraliDocumento_Numero,
			DatiGenerali_DatiGeneraliDocumento_HasDatiRitenuta,
			DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta,
			DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta,
			DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta,
			DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento,
			DatiGenerali_DatiGeneraliDocumento_HasDatiBollo,
			DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale,
			DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo,
			DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento,
			DatiGenerali_DatiGeneraliDocumento_Arrotondamento,
			DatiGenerali_DatiGeneraliDocumento_Art73,
			DatiGenerali_HasDatiTrasporto,
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
			DatiGenerali_DatiTrasporto_HasIndirizzoResa,
			DatiGenerali_DatiTrasporto_IndirizzoResa_Indirizzo,
			DatiGenerali_DatiTrasporto_IndirizzoResa_NumeroCivico,
			DatiGenerali_DatiTrasporto_IndirizzoResa_CAP,
			DatiGenerali_DatiTrasporto_IndirizzoResa_Comune,
			DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia,
			DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione,
			DatiGenerali_DatiTrasporto_DataOraConsegna,
			DatiGenerali_HasFatturaPrincipale,
			DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale,
			DatiGenerali_FatturaPrincipale_DataFatturaPrincipale,
			DatiGenerali_HasDatiVeicoli,
			DatiVeicoli_Data,
			DatiVeicoli_TotalePercorso
		)
		SELECT
			@PKFatturaElettronicaHeader,
			SFEB.PKStaging_FatturaElettronicaBody,
			SFEB.DatiGenerali_DatiGeneraliDocumento_TipoDocumento,
			SFEB.DatiGenerali_DatiGeneraliDocumento_Divisa,
			SFEB.DatiGenerali_DatiGeneraliDocumento_Data,
			SFEB.DatiGenerali_DatiGeneraliDocumento_Numero,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta, 0.0) > 0.0 THEN 1 ELSE 0 END AS DatiGenerali_DatiGeneraliDocumento_HasDatiRitenuta,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta, 0.0) > 0.0 THEN SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta ELSE '' END AS DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta, 0.0) > 0.0 THEN SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta ELSE NULL END AS DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta, 0.0) > 0.0 THEN SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta ELSE NULL END AS DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta, 0.0) > 0.0 THEN SFEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento ELSE '' END AS DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo, 0.0) > 0.0 THEN 1 ELSE 0 END AS DatiGenerali_DatiGeneraliDocumento_HasDatiBollo,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo, 0.0) > 0.0 THEN SFEB.DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale ELSE NULL END AS DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo, 0.0) > 0.0 THEN SFEB.DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo ELSE NULL END AS DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento, 0.0) > 0.0 THEN SFEB.DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento ELSE NULL END AS DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_Arrotondamento, 0.0) > 0.0 THEN SFEB.DatiGenerali_DatiGeneraliDocumento_Arrotondamento ELSE NULL END AS DatiGenerali_DatiGeneraliDocumento_Arrotondamento,
			CASE WHEN COALESCE(SFEB.DatiGenerali_DatiGeneraliDocumento_Art73, '') <> '' THEN SFEB.DatiGenerali_DatiGeneraliDocumento_Art73 ELSE '' END AS DatiGenerali_DatiGeneraliDocumento_Art73,
			0 AS DatiGenerali_HasDatiTrasporto,
			'' AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese,
			NULL AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdCodice,
			NULL AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_CodiceFiscale,
			NULL AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Denominazione,
			NULL AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Nome,
			NULL AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Cognome,
			NULL AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Titolo,
			NULL AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_CodEORI,
			NULL AS DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_NumeroLicenzaGuida,
			NULL AS DatiGenerali_DatiTrasporto_MezzoTrasporto,
			NULL AS DatiGenerali_DatiTrasporto_CausaleTrasporto,
			NULL AS DatiGenerali_DatiTrasporto_NumeroColli,
			NULL AS DatiGenerali_DatiTrasporto_Descrizione,
			NULL AS DatiGenerali_DatiTrasporto_UnitaMisuraPeso,
			NULL AS DatiGenerali_DatiTrasporto_PesoLordo,
			NULL AS DatiGenerali_DatiTrasporto_PesoNetto,
			NULL AS DatiGenerali_DatiTrasporto_DataOraRitiro,
			NULL AS DatiGenerali_DatiTrasporto_DataInizioTrasporto,
			'' AS DatiGenerali_DatiTrasporto_TipoResa,
			0 AS DatiGenerali_DatiTrasporto_HasIndirizzoResa,
			NULL AS DatiGenerali_DatiTrasporto_IndirizzoResa_Indirizzo,
			NULL AS DatiGenerali_DatiTrasporto_IndirizzoResa_NumeroCivico,
			NULL AS DatiGenerali_DatiTrasporto_IndirizzoResa_CAP,
			NULL AS DatiGenerali_DatiTrasporto_IndirizzoResa_Comune,
			'' AS DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia,
			'' AS DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione,
			NULL AS DatiGenerali_DatiTrasporto_DataOraConsegna,
			CASE WHEN COALESCE(SFEB.DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale, N'') = N'' THEN 0 ELSE 1 END AS DatiGenerali_HasFatturaPrincipale,
			CASE WHEN COALESCE(SFEB.DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale, N'') = N'' THEN SFEB.DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale ELSE NULL END AS DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale,
			CASE WHEN COALESCE(SFEB.DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale, N'') = N'' THEN SFEB.DatiGenerali_FatturaPrincipale_DataFatturaPrincipale ELSE NULL END AS DatiGenerali_FatturaPrincipale_DataFatturaPrincipale,
			0 AS HasDatiVeicoli,
			NULL AS DatiVeicoli_Data,
			NULL AS DatiVeicoli_TotalePercorso

		FROM XMLFatture.Staging_FatturaElettronicaBody SFEB
		WHERE SFEB.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody: Fine */

		/* FatturaElettronicaBody_DatiCassaPrevidenziale : Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DatiCassaPrevidenziale';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DatiCassaPrevidenziale
		(
		    --PKFatturaElettronicaBody_DatiCassaPrevidenziale,
		    PKFatturaElettronicaBody,
		    TipoCassa,
		    AlCassa,
		    ImportoContributoCassa,
		    ImponibileCassa,
		    AliquotaIVA,
		    Ritenuta,
		    Natura,
		    RiferimentoAmministrazione
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBDCP.TipoCassa,
            SFEBDCP.AlCassa,
            SFEBDCP.ImportoContributoCassa,
            SFEBDCP.ImponibileCassa,
            SFEBDCP.AliquotaIVA,
            SFEBDCP.Ritenuta,
            SFEBDCP.Natura,
            SFEBDCP.RiferimentoAmministrazione 

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiCassaPrevidenziale SFEBDCP
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDCP.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DatiCassaPrevidenziale : Fine */

		/* FatturaElettronicaBody_ScontoMaggiorazione: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_ScontoMaggiorazione';

		INSERT INTO XMLFatture.FatturaElettronicaBody_ScontoMaggiorazione
		(
		    --PKFatturaElettronicaBody_ScontoMaggiorazione,
		    PKFatturaElettronicaBody,
		    Tipo,
		    Percentuale,
		    Importo
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBSM.Tipo,
            SFEBSM.Percentuale,
            SFEBSM.Importo

		FROM XMLFatture.Staging_FatturaElettronicaBody_ScontoMaggiorazione SFEBSM
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBSM.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_ScontoMaggiorazione: Fine */

		/* FatturaElettronicaBody_Causale: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_Causale';

		INSERT INTO XMLFatture.FatturaElettronicaBody_Causale
		(
		    --PKFatturaElettronicaBody_Causale,
		    PKFatturaElettronicaBody,
		    DatiGenerali_Causale
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBC.DatiGenerali_Causale

		FROM XMLFatture.Staging_FatturaElettronicaBody_Causale SFEBC
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBC.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_Causale: Fine */

		/* FatturaElettronicaBody_DocumentoEsterno: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DocumentoEsterno';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DocumentoEsterno
		(
		    --PKFatturaElettronicaBody_DocumentoEsterno,
		    PKFatturaElettronicaBody,
		    TipoDocumentoEsterno,
		    IdDocumento,
		    Data,
		    NumItem,
		    CodiceCommessaConvenzione,
		    CodiceCUP,
		    CodiceCIG
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBDE.TipoDocumentoEsterno,
            SFEBDE.IdDocumento,
            SFEBDE.Data,
            SFEBDE.NumItem,
            SFEBDE.CodiceCommessaConvenzione,
            SFEBDE.CodiceCUP,
            SFEBDE.CodiceCIG

		FROM XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno SFEBDE
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDE.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DocumentoEsterno: Fine */

		/* FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea';

        INSERT INTO XMLFatture.FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea
        (
            --PKFatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea,
            PKFatturaElettronicaBody_DocumentoEsterno,
            RiferimentoNumeroLinea
        )
        SELECT
            FEBDE.PKFatturaElettronicaBody_DocumentoEsterno,
            SFEBDERNL.RiferimentoNumeroLinea

		FROM XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea SFEBDERNL
        INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DocumentoEsterno SFEBDE ON SFEBDE.PKStaging_FatturaElettronicaBody_DocumentoEsterno = SFEBDERNL.PKStaging_FatturaElettronicaBody_DocumentoEsterno
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDE.PKStaging_FatturaElettronicaBody
        INNER JOIN XMLFatture.FatturaElettronicaBody_DocumentoEsterno FEBDE ON FEBDE.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
            AND FEBDE.IdDocumento = SFEBDE.IdDocumento
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
        ORDER BY SFEBDE.PKStaging_FatturaElettronicaBody_DocumentoEsterno,
            SFEBDERNL.RiferimentoNumeroLinea;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea: Fine */

		/* FatturaElettronicaBody_DatiSAL: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DatiSAL';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DatiSAL
		(
		    --PKFatturaElettronicaBody_DatiSAL,
		    PKFatturaElettronicaBody,
		    RiferimentoFase
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBDS.RiferimentoFase

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiSAL SFEBDS
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDS.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DatiSAL: Fine */

		/* FatturaElettronicaBody_DatiDDT: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DatiDDT';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DatiDDT
		(
		    --PKFatturaElettronicaBody_DatiDDT,
		    PKFatturaElettronicaBody,
		    NumeroDDT,
		    DataDDT
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBDDT.NumeroDDT,
            SFEBDDT.DataDDT

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiDDT SFEBDDT
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDDT.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DatiDDT: Fine */

		/* FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea
		(
		    --PKFatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea,
		    PKFatturaElettronicaBody_DatiDDT,
		    RiferimentoNumeroLinea
		)
		SELECT
			FEBDDT.PKFatturaElettronicaBody_DatiDDT,
            SFEBDDTRNL.RiferimentoNumeroLinea

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea SFEBDDTRNL
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DatiDDT SFEBDDDT ON SFEBDDDT.PKStaging_FatturaElettronicaBody_DatiDDT = SFEBDDTRNL.PKStaging_FatturaElettronicaBody_DatiDDT
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody SFEB ON SFEB.PKStaging_FatturaElettronicaBody = SFEBDDDT.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEB.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
		INNER JOIN XMLFatture.FatturaElettronicaBody_DatiDDT FEBDDT ON FEBDDT.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody AND FEBDDT.DataDDT = SFEBDDDT.DataDDT AND FEBDDT.NumeroDDT = SFEBDDDT.NumeroDDT;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea: Fine */

		/* FatturaElettronicaBody_DettaglioLinee: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DettaglioLinee';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DettaglioLinee
		(
		    --PKFatturaElettronicaBody_DettaglioLinee,
		    PKFatturaElettronicaBody,
		    NumeroLinea,
		    TipoCessionePrestazione,
		    Descrizione,
		    Quantita,
		    UnitaMisura,
		    DataInizioPeriodo,
		    DataFinePeriodo,
		    PrezzoUnitario,
		    PrezzoTotale,
		    AliquotaIVA,
		    Ritenuta,
		    Natura,
		    RiferimentoAmministrazione
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBDL.NumeroLinea,
            SFEBDL.TipoCessionePrestazione,
            SFEBDL.Descrizione,
            SFEBDL.Quantita,
            SFEBDL.UnitaMisura,
            SFEBDL.DataInizioPeriodo,
            SFEBDL.DataFinePeriodo,
            SFEBDL.PrezzoUnitario,
            SFEBDL.PrezzoTotale,
            SFEBDL.AliquotaIVA,
            SFEBDL.Ritenuta,
            SFEBDL.Natura,
            SFEBDL.RiferimentoAmministrazione

		FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee SFEBDL
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDL.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DettaglioLinee: Fine */

		/* FatturaElettronicaBody_DettaglioLinee_CodiceArticolo: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DettaglioLinee_CodiceArticolo';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DettaglioLinee_CodiceArticolo
		(
		    --PKFatturaElettronicaBody_DettaglioLinee_CodiceArticolo,
		    PKFatturaElettronicaBody_DettaglioLinee,
		    CodiceArticolo_CodiceTipo,
		    CodiceArticolo_CodiceValore
		)
		SELECT
			FEBDL.PKFatturaElettronicaBody_DettaglioLinee,
            SFEBDLCA.CodiceArticolo_CodiceTipo,
            SFEBDLCA.CodiceArticolo_CodiceValore

		FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo SFEBDLCA
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee SFEBDL ON SFEBDL.PKStaging_FatturaElettronicaBody_DettaglioLinee = SFEBDLCA.PKStaging_FatturaElettronicaBody_DettaglioLinee
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody SFEB ON SFEB.PKStaging_FatturaElettronicaBody = SFEBDL.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEB.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
		INNER JOIN XMLFatture.FatturaElettronicaBody_DettaglioLinee FEBDL ON FEBDL.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody AND FEBDL.NumeroLinea = SFEBDL.NumeroLinea;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DettaglioLinee_CodiceArticolo: Fine */

		/* FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione
		(
		    --PKFatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione,
		    PKFatturaElettronicaBody_DettaglioLinee,
		    ScontoMaggiorazione_Tipo,
		    ScontoMaggiorazione_Percentuale,
		    ScontoMaggiorazione_Importo
		)
		SELECT
			FEBDL.PKFatturaElettronicaBody_DettaglioLinee,
            SFEBDLSM.ScontoMaggiorazione_Tipo,
            SFEBDLSM.ScontoMaggiorazione_Percentuale,
            SFEBDLSM.ScontoMaggiorazione_Importo

		FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione SFEBDLSM
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee SFEBDL ON SFEBDL.PKStaging_FatturaElettronicaBody_DettaglioLinee = SFEBDLSM.PKStaging_FatturaElettronicaBody_DettaglioLinee
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody SFEB ON SFEB.PKStaging_FatturaElettronicaBody = SFEBDL.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEB.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
		INNER JOIN XMLFatture.FatturaElettronicaBody_DettaglioLinee FEBDL ON FEBDL.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody AND FEBDL.NumeroLinea = SFEBDL.NumeroLinea;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione: Fine */

		/* FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali
		(
		    --PKFatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali,
		    PKFatturaElettronicaBody_DettaglioLinee,
		    AltriDatiGestionali_TipoDato,
		    AltriDatiGestionali_RiferimentoTesto,
		    AltriDatiGestionali_RiferimentoNumero,
		    AltriDatiGestionali_RiferimentoData
		)
		SELECT
			FEBDL.PKFatturaElettronicaBody_DettaglioLinee,
            SFEBDLADG.AltriDatiGestionali_TipoDato,
            SFEBDLADG.AltriDatiGestionali_RiferimentoTesto,
            SFEBDLADG.AltriDatiGestionali_RiferimentoNumero,
            SFEBDLADG.AltriDatiGestionali_RiferimentoData

		FROM XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali SFEBDLADG
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DettaglioLinee SFEBDL ON SFEBDL.PKStaging_FatturaElettronicaBody_DettaglioLinee = SFEBDLADG.PKStaging_FatturaElettronicaBody_DettaglioLinee
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody SFEB ON SFEB.PKStaging_FatturaElettronicaBody = SFEBDL.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEB.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
		INNER JOIN XMLFatture.FatturaElettronicaBody_DettaglioLinee FEBDL ON FEBDL.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody AND FEBDL.NumeroLinea = SFEBDL.NumeroLinea;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali: Fine */

		/* FatturaElettronicaBody_DatiRiepilogo: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DatiRiepilogo';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DatiRiepilogo
		(
		    --PKFatturaElettronicaBody_DatiRiepilogo,
		    PKFatturaElettronicaBody,
		    AliquotaIVA,
		    Natura,
		    SpeseAccessorie,
		    Arrotondamento,
		    ImponibileImporto,
		    Imposta,
		    EsigibilitaIVA,
		    RiferimentoNormativo
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBDR.AliquotaIVA,
            COALESCE(SFEBDR.Natura, '') AS Natura,
            SFEBDR.SpeseAccessorie,
            SFEBDR.Arrotondamento,
            SFEBDR.ImponibileImporto,
            SFEBDR.Imposta,
            SFEBDR.EsigibilitaIVA,
            SFEBDR.RiferimentoNormativo

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiRiepilogo SFEBDR
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDR.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DatiRiepilogo: Fine */

		/* FatturaElettronicaBody_DatiPagamento: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DatiPagamento';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DatiPagamento
		(
		    --PKFatturaElettronicaBody_DatiPagamento,
		    PKFatturaElettronicaBody,
		    CondizioniPagamento
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBDP.CondizioniPagamento

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiPagamento SFEBDP
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDP.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DatiPagamento: Fine */

		/* FatturaElettronicaBody_DatiPagamento_DettaglioPagamento: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_DatiPagamento_DettaglioPagamento';

		INSERT INTO XMLFatture.FatturaElettronicaBody_DatiPagamento_DettaglioPagamento
		(
		    --PKFatturaElettronicaBody_DatiPagamento_DettaglioPagamento,
		    PKFatturaElettronicaBody_DatiPagamento,
		    Beneficiario,
		    ModalitaPagamento,
		    DataRiferimentoTerminiPagamento,
		    GiorniTerminiPagamento,
		    DataScadenzaPagamento,
		    ImportoPagamento,
		    CodUfficioPostale,
		    CognomeQuietanzante,
		    NomeQuietanzante,
		    CFQuietanzante,
		    TitoloQuietanzante,
		    IstitutoFinanziario,
		    IBAN,
		    ABI,
		    CAB,
		    BIC,
		    ScontoPagamentoAnticipato,
		    DataLimitePagamentoAnticipato,
		    PenalitaPagamentiRitardati,
		    DataDecorrenzaPenale,
		    CodicePagamento
		)
		SELECT
			FEBDP.PKFatturaElettronicaBody_DatiPagamento,
            SFEBDPDP.Beneficiario,
            SFEBDPDP.ModalitaPagamento,
            SFEBDPDP.DataRiferimentoTerminiPagamento,
            SFEBDPDP.GiorniTerminiPagamento,
            SFEBDPDP.DataScadenzaPagamento,
            SFEBDPDP.ImportoPagamento,
            SFEBDPDP.CodUfficioPostale,
            SFEBDPDP.CognomeQuietanzante,
            SFEBDPDP.NomeQuietanzante,
            SFEBDPDP.CFQuietanzante,
            SFEBDPDP.TitoloQuietanzante,
            SFEBDPDP.IstitutoFinanziario,
            SFEBDPDP.IBAN,
            SFEBDPDP.ABI,
            SFEBDPDP.CAB,
            SFEBDPDP.BIC,
            SFEBDPDP.ScontoPagamentoAnticipato,
            SFEBDPDP.DataLimitePagamentoAnticipato,
            SFEBDPDP.PenalitaPagamentiRitardati,
            SFEBDPDP.DataDecorrenzaPenale,
            SFEBDPDP.CodicePagamento

		FROM XMLFatture.Staging_FatturaElettronicaBody_DatiPagamento_DettaglioPagamento SFEBDPDP
		INNER JOIN XMLFatture.Staging_FatturaElettronicaBody_DatiPagamento SFEBDP ON SFEBDP.PKStaging_FatturaElettronicaBody_DatiPagamento = SFEBDPDP.PKStaging_FatturaElettronicaBody_DatiPagamento
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBDP.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader
		INNER JOIN XMLFatture.FatturaElettronicaBody_DatiPagamento FEBDP ON FEBDP.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody AND FEBDP.CondizioniPagamento = SFEBDP.CondizioniPagamento;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_DatiPagamento_DettaglioPagamento: Fine */

		/* FatturaElettronicaBody_Allegati: Inizio */
		SET @NomeTabella = N'FatturaElettronicaBody_Allegati';

		INSERT INTO XMLFatture.FatturaElettronicaBody_Allegati
		(
		    --PKFatturaElettronicaBody_Allegati,
		    PKFatturaElettronicaBody,
		    NomeAttachment,
		    AlgoritmoCompressione,
		    FormatoAttachment,
		    DescrizioneAttachment,
		    Attachment
		)
		SELECT
			FEB.PKFatturaElettronicaBody,
            SFEBA.NomeAttachment,
            SFEBA.AlgoritmoCompressione,
            SFEBA.FormatoAttachment,
            SFEBA.DescrizioneAttachment,
            SFEBA.Attachment

		FROM XMLFatture.Staging_FatturaElettronicaBody_Allegati SFEBA
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKStaging_FatturaElettronicaBody = SFEBA.PKStaging_FatturaElettronicaBody
		INNER JOIN XMLFatture.FatturaElettronicaHeader FEH ON FEH.PKFatturaElettronicaHeader = FEB.PKFatturaElettronicaHeader
			AND FEH.PKStaging_FatturaElettronicaHeader = @PKStaging_FatturaElettronicaHeader;

		SET @Messaggio = REPLACE(REPLACE(REPLACE('Inserimento XMLFatture.%NOME_TABELLA% (#%PKFatturaElettronicaHeader%) completato (%ROWCOUNT% righe)', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader)), N'%NOME_TABELLA%', @NomeTabella), N'%ROWCOUNT%', CONVERT(NVARCHAR(10), @@ROWCOUNT));
		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 2; -- 2: info

		/* FatturaElettronicaBody_Allegati: Fine */

		--COMMIT TRANSACTION;

	END TRY
	BEGIN CATCH

		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;

		SET @PKStaging_FatturaElettronicaHeader = -1;

		SET @Messaggio = REPLACE(N'Errore in esportazione fattura (tabella %NOME_TABELLA%)', N'%NOME_TABELLA%', @NomeTabella);

		SET @PKEsitoEvento = CASE @NomeTabella
			WHEN N'FatturaElettronicaBody' THEN 313 -- 313: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody
			WHEN N'FatturaElettronicaBody_DatiCassaPrevidenziale' THEN 314 -- 314: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DatiCassaPrevidenziale
			WHEN N'FatturaElettronicaBody_ScontoMaggiorazione' THEN 315 -- 315: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_ScontoMaggiorazione
			WHEN N'FatturaElettronicaBody_DocumentoEsterno' THEN 317 -- 317: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DocumentoEsterno
			WHEN N'FatturaElettronicaBody_Causale' THEN 316 -- 316: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_Causale
			WHEN N'FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea' THEN 318 -- 318: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea
			WHEN N'FatturaElettronicaBody_DocumentoEsterno*' THEN 319 -- 319: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DocumentoEsterno*
			WHEN N'FatturaElettronicaBody_DatiSAL' THEN 320 -- 320: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DatiSAL
			WHEN N'FatturaElettronicaBody_DatiDDT' THEN 321 -- 321: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DatiDDT
			WHEN N'FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea' THEN 322 -- 322: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea
			WHEN N'FatturaElettronicaBody_DettaglioLinee' THEN 323 -- 323: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DettaglioLinee
			WHEN N'FatturaElettronicaBody_DettaglioLinee_CodiceArticolo' THEN 324 -- 324: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DettaglioLinee_CodiceArticolo
			WHEN N'FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione' THEN 325 -- 325: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione
			WHEN N'FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali' THEN 326 -- 326: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali
			WHEN N'FatturaElettronicaBody_DatiRiepilogo' THEN 327 -- 327: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DatiRiepilogo
			WHEN N'FatturaElettronicaBody_DatiPagamento' THEN 328 -- 328: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DatiPagamento
			WHEN N'FatturaElettronicaBody_DatiPagamento_DettaglioPagamento' THEN 329 -- 329: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_DatiPagamento_DettaglioPagamento
			WHEN N'FatturaElettronicaBody_Allegati' THEN 330 -- 330: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody_Allegati
			ELSE 312 -- 312: Eccezione in fase di inserimento XMLFatture.FatturaElettronicaBody*
		END;

		EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
									@Messaggio = @Messaggio,
									@PKEsitoEvento = @PKEsitoEvento,
									@LivelloLog = 0; -- 0: trace

	END CATCH;

END;
GO
