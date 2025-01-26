SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [XMLFatture].[ssp_GeneraXMLFatturaBody] (
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
            FEB.DatiGenerali_DatiGeneraliDocumento_TipoDocumento AS [DatiGenerali/DatiGeneraliDocumento/TipoDocumento],
            FEB.DatiGenerali_DatiGeneraliDocumento_Divisa AS [DatiGenerali/DatiGeneraliDocumento/Divisa],
            FEB.DatiGenerali_DatiGeneraliDocumento_Data AS [DatiGenerali/DatiGeneraliDocumento/Data],
            FEB.DatiGenerali_DatiGeneraliDocumento_Numero AS [DatiGenerali/DatiGeneraliDocumento/Numero],

            --FEB.DatiGenerali_DatiGeneraliDocumento_HasDatiRitenuta,
            CASE WHEN (FEB.DatiGenerali_DatiGeneraliDocumento_HasDatiRitenuta = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta END AS [DatiGenerali/DatiGeneraliDocumento/DatiRitenuta/TipoRitenuta],
            CASE WHEN (FEB.DatiGenerali_DatiGeneraliDocumento_HasDatiRitenuta = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta END AS [DatiGenerali/DatiGeneraliDocumento/DatiRitenuta/ImportoRitenuta],
            CASE WHEN (FEB.DatiGenerali_DatiGeneraliDocumento_HasDatiRitenuta = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta END AS [DatiGenerali/DatiGeneraliDocumento/DatiRitenuta/AliquotaRitenuta],
            CASE WHEN (FEB.DatiGenerali_DatiGeneraliDocumento_HasDatiRitenuta = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento END AS [DatiGenerali/DatiGeneraliDocumento/DatiRitenuta/CausalePagamento],

            --FEB.DatiGenerali_DatiGeneraliDocumento_HasDatiBollo,
            CASE WHEN (FEB.DatiGenerali_DatiGeneraliDocumento_HasDatiBollo = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale END AS [DatiGenerali/DatiGeneraliDocumento/DatiBollo/BolloVirtuale],
            CASE WHEN (FEB.DatiGenerali_DatiGeneraliDocumento_HasDatiBollo = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo END AS [DatiGenerali/DatiGeneraliDocumento/DatiBollo/ImportoBollo],
			
			-- DatiCassaPrevidenziale
			(
				SELECT
                    DCP.TipoCassa,
                    DCP.AlCassa,
                    DCP.ImportoContributoCassa,
                    DCP.ImponibileCassa,
                    DCP.AliquotaIVA,
                    CASE WHEN (DCP.Ritenuta = '') THEN NULL ELSE DCP.Ritenuta END AS Ritenuta,
                    CASE WHEN (DCP.Natura = '') THEN NULL ELSE DCP.Natura END AS Natura,
                    DCP.RiferimentoAmministrazione

				FROM XMLFatture.FatturaElettronicaBody_DatiCassaPrevidenziale DCP
				WHERE DCP.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
				FOR XML PATH (''), TYPE
			) AS [DatiGenerali/DatiGeneraliDocumento/DatiCassaPrevidenziale],

			-- ScontoMaggiorazione
			(
				SELECT
                    DSM.Tipo,
                    DSM.Percentuale,
                    DSM.Importo

				FROM XMLFatture.FatturaElettronicaBody_ScontoMaggiorazione DSM
				WHERE DSM.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
				FOR XML PATH (''), TYPE
			) AS [DatiGenerali/DatiGeneraliDocumento/ScontoMaggiorazione],

            FEB.DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento AS [DatiGenerali/DatiGeneraliDocumento/ImportoTotaleDocumento],
            FEB.DatiGenerali_DatiGeneraliDocumento_Arrotondamento AS [DatiGenerali/DatiGeneraliDocumento/Arrotondamento],

			-- Causale
			(
				SELECT
					C.DatiGenerali_Causale AS [Causale]
			
				FROM XMLFatture.FatturaElettronicaBody_Causale C
				----INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKFatturaElettronicaBody = FEBC.PKFatturaElettronicaBody
				----	AND FEB.PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader
				WHERE C.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
				FOR XML PATH(''), TYPE
			) AS [DatiGenerali/DatiGeneraliDocumento],

            CASE WHEN (COALESCE(FEB.DatiGenerali_DatiGeneraliDocumento_Art73, '') = '') THEN NULL ELSE FEB.DatiGenerali_DatiGeneraliDocumento_Art73 END AS [DatiGenerali/DatiGeneraliDocumento/Art73],

			-- DocumentoEsterno
			(
				SELECT
					-- DocumentoEsterno_RiferimentoNumeroLinea
					(
						SELECT
                            DERNL.RiferimentoNumeroLinea

						FROM XMLFatture.FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea DERNL
						----INNER JOIN XMLFatture.FatturaElettronicaBody_DatiDDT DDDT ON DDDT.PKFatturaElettronicaBody_DatiDDT = DDDTRNL.PKFatturaElettronicaBody_DatiDDT
						----	AND DDDT.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
						WHERE DERNL.PKFatturaElettronicaBody_DocumentoEsterno = DEOACQ.PKFatturaElettronicaBody_DocumentoEsterno
                        ORDER BY DERNL.RiferimentoNumeroLinea
						FOR XML PATH (''), TYPE
					),
                    DEOACQ.IdDocumento,
					DEOACQ.Data,
					DEOACQ.CodiceCUP,
					DEOACQ.CodiceCIG

				FROM XMLFatture.FatturaElettronicaBody_DocumentoEsterno DEOACQ

				WHERE DEOACQ.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
					AND DEOACQ.TipoDocumentoEsterno = 'OACQ'
				FOR XML PATH ('DatiOrdineAcquisto'), TYPE
			) AS [DatiGenerali],

			--N'%TODO%' AS [DatiGenerali/DatiSAL],

			-- DatiDDT
			(
				SELECT
                    DDDT.NumeroDDT,
                    DDDT.DataDDT,

					-- DatiDDT_RiferimentoNumeroLinea
					(
						SELECT
                            DDDTRNL.RiferimentoNumeroLinea

						FROM XMLFatture.FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea DDDTRNL
						----INNER JOIN XMLFatture.FatturaElettronicaBody_DatiDDT DDDT ON DDDT.PKFatturaElettronicaBody_DatiDDT = DDDTRNL.PKFatturaElettronicaBody_DatiDDT
						----	AND DDDT.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
						WHERE DDDTRNL.PKFatturaElettronicaBody_DatiDDT = DDDT.PKFatturaElettronicaBody_DatiDDT
                        ORDER BY DDDTRNL.RiferimentoNumeroLinea
						FOR XML PATH (''), TYPE
					)

				FROM XMLFatture.FatturaElettronicaBody_DatiDDT DDDT
				----INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKFatturaElettronicaBody = DDDT.PKFatturaElettronicaBody
				----	AND FEB.PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader
				WHERE DDDT.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
				FOR XML PATH ('DatiDDT'), TYPE
			) AS [DatiGenerali],

            --FEB.DatiGenerali_HasDatiTrasporto,
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/IdFiscaleIVA/IdPaese],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdCodice END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/IdFiscaleIVA/IdCodice],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_CodiceFiscale, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_CodiceFiscale END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/CodiceFiscale],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Denominazione, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Denominazione END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/Anagrafica/Denominazione],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Nome, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Nome END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/Anagrafica/Nome],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Cognome, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Cognome END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/Anagrafica/Cognome],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Titolo, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Titolo END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/Anagrafica/Titolo],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_CodEORI, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_CodEORI END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/Anagrafica/CodEORI],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_NumeroLicenzaGuida, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_NumeroLicenzaGuida END AS [DatiGenerali/DatiTrasporto/DatiAnagraficiVettore/NumeroLicenzaGuida],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_MezzoTrasporto, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_MezzoTrasporto END AS [DatiGenerali/DatiTrasporto/MezzoTrasporto],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_CausaleTrasporto, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_CausaleTrasporto END AS [DatiGenerali/DatiTrasporto/CausaleTrasporto],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_NumeroColli, 0) = 0) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_NumeroColli END AS [DatiGenerali/DatiTrasporto/NumeroColli],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_Descrizione, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_Descrizione END AS [DatiGenerali/DatiTrasporto/Descrizione],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_UnitaMisuraPeso, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_UnitaMisuraPeso END AS [DatiGenerali/DatiTrasporto/UnitaMisuraPeso],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_PesoLordo, 0.0) = 0.0) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_PesoLordo END AS [DatiGenerali/DatiTrasporto/PesoLordo],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_PesoNetto, 0.0) = 0.0) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_PesoNetto END AS [DatiGenerali/DatiTrasporto/PesoNetto],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DataOraRitiro END AS [DatiGenerali/DatiTrasporto/DataOraRitiro],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DataInizioTrasporto END AS [DatiGenerali/DatiTrasporto/DataInizioTrasporto],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR COALESCE (FEB.DatiGenerali_DatiTrasporto_TipoResa, N'') = N'') THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_TipoResa END AS [DatiGenerali/DatiTrasporto/TipoResa],
            --FEB.DatiGenerali_DatiTrasporto_HasIndirizzoResa,
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR FEB.DatiGenerali_DatiTrasporto_HasIndirizzoResa = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_IndirizzoResa_Indirizzo END AS [DatiGenerali/DatiTrasporto/IndirizzoResa/Indirizzo],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR FEB.DatiGenerali_DatiTrasporto_HasIndirizzoResa = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_IndirizzoResa_NumeroCivico END AS [DatiGenerali/DatiTrasporto/IndirizzoResa/NumeroCivico],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR FEB.DatiGenerali_DatiTrasporto_HasIndirizzoResa = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_IndirizzoResa_CAP END AS [DatiGenerali/DatiTrasporto/IndirizzoResa/CAP],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR FEB.DatiGenerali_DatiTrasporto_HasIndirizzoResa = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_IndirizzoResa_Comune END AS [DatiGenerali/DatiTrasporto/IndirizzoResa/Comune],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR FEB.DatiGenerali_DatiTrasporto_HasIndirizzoResa = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia END AS [DatiGenerali/DatiTrasporto/IndirizzoResa/Provincia],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT) OR FEB.DatiGenerali_DatiTrasporto_HasIndirizzoResa = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione END AS [DatiGenerali/DatiTrasporto/IndirizzoResa/Nazione],
            CASE WHEN (FEB.DatiGenerali_HasDatiTrasporto = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_DatiTrasporto_DataOraConsegna END AS [DatiGenerali/DatiTrasporto/DataOraConsegna],

            --FEB.DatiGenerali_HasFatturaPrincipale,
            CASE WHEN (FEB.DatiGenerali_HasFatturaPrincipale = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale END AS [DatiGenerali/FatturaPrincipale/NumeroFatturaPrincipale],
            CASE WHEN (FEB.DatiGenerali_HasFatturaPrincipale = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiGenerali_FatturaPrincipale_DataFatturaPrincipale END AS [DatiGenerali/FatturaPrincipale/DataFatturaPrincipale],

			(
				SELECT
				-- DettaglioLinee
				(
					SELECT
						DL.NumeroLinea,
						CASE WHEN (DL.TipoCessionePrestazione = '') THEN NULL ELSE DL.TipoCessionePrestazione END AS TipoCessionePrestazione,

						-- DettaglioLinee_CodiceArticolo
						(
							SELECT
								CA.CodiceArticolo_CodiceTipo AS [CodiceTipo],
								CA.CodiceArticolo_CodiceValore AS [CodiceValore]

							FROM XMLFatture.FatturaElettronicaBody_DettaglioLinee_CodiceArticolo CA
							WHERE CA.PKFatturaElettronicaBody_DettaglioLinee = DL.PKFatturaElettronicaBody_DettaglioLinee
							FOR XML PATH('CodiceArticolo'), TYPE
						),

						DL.Descrizione,
						DL.Quantita,
						CASE WHEN COALESCE(DL.UnitaMisura, N'') = N'' THEN NULL ELSE DL.UnitaMisura END AS UnitaMisura,
						DL.DataInizioPeriodo,
						DL.DataFinePeriodo,
						DL.PrezzoUnitario,

						-- DettaglioLinee_ScontoMaggiorazione
						(
							SELECT
								SM.ScontoMaggiorazione_Tipo AS [Tipo],
								SM.ScontoMaggiorazione_Percentuale AS [Percentuale],
								SM.ScontoMaggiorazione_Importo AS [Importo]

							FROM XMLFatture.FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione SM
							WHERE SM.PKFatturaElettronicaBody_DettaglioLinee = DL.PKFatturaElettronicaBody_DettaglioLinee
							FOR XML PATH('ScontoMaggiorazione'), TYPE
						),

						DL.PrezzoTotale,
						DL.AliquotaIVA,
						CASE WHEN DL.Ritenuta = '' THEN NULL ELSE DL.Ritenuta END AS Ritenuta,
						CASE WHEN DL.Natura = '' THEN NULL ELSE DL.Natura END AS Natura,
						DL.RiferimentoAmministrazione,

						-- DettaglioLinee_AltriDatiGestionali
						(
							SELECT
								SM.AltriDatiGestionali_TipoDato AS [TipoDato],
								SM.AltriDatiGestionali_RiferimentoTesto AS [RiferimentoTesto],
								SM.AltriDatiGestionali_RiferimentoNumero AS [RiferimentoNumero],
								SM.AltriDatiGestionali_RiferimentoData AS [RiferimentoData]

							FROM XMLFatture.FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali SM
							WHERE SM.PKFatturaElettronicaBody_DettaglioLinee = DL.PKFatturaElettronicaBody_DettaglioLinee
							FOR XML PATH('AltriDatiGestionali'), TYPE
						)

					FROM XMLFatture.FatturaElettronicaBody_DettaglioLinee DL
					WHERE DL.PKFatturaElettronicaBody = FEB2.PKFatturaElettronicaBody
					FOR XML PATH ('DettaglioLinee'), TYPE
				),

				-- DatiRiepilogo
				(
					SELECT
                        DR.AliquotaIVA,
                        CASE WHEN DR.Natura = '' THEN NULL ELSE DR.Natura END AS Natura,
                        DR.SpeseAccessorie,
                        DR.Arrotondamento,
                        DR.ImponibileImporto,
                        DR.Imposta,
                        DR.EsigibilitaIVA,
                        DR.RiferimentoNormativo

					FROM XMLFatture.FatturaElettronicaBody_DatiRiepilogo DR
					WHERE DR.PKFatturaElettronicaBody = FEB2.PKFatturaElettronicaBody
					FOR XML PATH ('DatiRiepilogo'), TYPE
				)

				FROM XMLFatture.FatturaElettronicaBody FEB2
				WHERE FEB2.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
				FOR XML PATH (''), TYPE
			) AS [DatiBeniServizi],

            --FEB.DatiGenerali_HasDatiVeicoli,
			CASE WHEN (FEB.DatiGenerali_HasDatiVeicoli = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiVeicoli_Data END AS [DatiVeicoli/Data],
            CASE WHEN (FEB.DatiGenerali_HasDatiVeicoli = CAST(0 AS BIT)) THEN NULL ELSE FEB.DatiVeicoli_TotalePercorso END AS [DatiVeicoli/TotalePercorso],

			-- DatiPagamento
			(
				SELECT
                    DP.CondizioniPagamento,

					-- DatiPagamento_DettaglioPagamento
					(
						SELECT
                            DPDP.Beneficiario,
                            DPDP.ModalitaPagamento,
                            DPDP.DataRiferimentoTerminiPagamento,
                            DPDP.GiorniTerminiPagamento,
                            DPDP.DataScadenzaPagamento,
                            DPDP.ImportoPagamento,
                            DPDP.CodUfficioPostale,
                            DPDP.CognomeQuietanzante,
                            DPDP.NomeQuietanzante,
                            DPDP.CFQuietanzante,
                            DPDP.TitoloQuietanzante,
                            DPDP.IstitutoFinanziario,
                            CASE WHEN COALESCE(DPDP.IBAN, N'') = N'' THEN NULL ELSE DPDP.IBAN END AS IBAN,
                            CASE WHEN COALESCE(DPDP.ABI, 0) > 0 THEN RIGHT('00000' + CONVERT(NVARCHAR(5), DPDP.ABI), 5) ELSE NULL END AS ABI,
                            CASE WHEN COALESCE(DPDP.CAB, 0) > 0 THEN RIGHT('00000' + CONVERT(NVARCHAR(5), DPDP.CAB), 5) ELSE NULL END AS CAB,
                            CASE WHEN COALESCE(DPDP.BIC, N'') = N'' THEN NULL ELSE DPDP.BIC END AS BIC,
                            DPDP.ScontoPagamentoAnticipato,
                            DPDP.DataLimitePagamentoAnticipato,
                            DPDP.PenalitaPagamentiRitardati,
                            DPDP.DataDecorrenzaPenale,
                            DPDP.CodicePagamento

						FROM XMLFatture.FatturaElettronicaBody_DatiPagamento_DettaglioPagamento DPDP
						WHERE DPDP.PKFatturaElettronicaBody_DatiPagamento = DP.PKFatturaElettronicaBody_DatiPagamento
						FOR XML PATH ('DettaglioPagamento'), TYPE
					)

				FROM XMLFatture.FatturaElettronicaBody_DatiPagamento DP
				WHERE DP.PKFatturaElettronicaBody = FEB.PKFatturaElettronicaBody
				FOR XML PATH (''), TYPE
			) AS [DatiPagamento],

			N'%ALLEGATI%' AS [Allegati]

		FROM XMLFatture.FatturaElettronicaHeader FEH
		INNER JOIN XMLFatture.FatturaElettronicaBody FEB ON FEB.PKFatturaElettronicaHeader = FEH.PKFatturaElettronicaHeader                                                                                                                                                                                                                    --AND CONVERT(INT, CURRENT_TIMESTAMP) < 43464
		WHERE FEH.PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader
		FOR XML PATH ('FatturaElettronicaBody')
	);

END;
GO
