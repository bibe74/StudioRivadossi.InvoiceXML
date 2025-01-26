SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [XMLFatture].[usp_GeneraXMLFattura] (
	@codiceNumerico BIGINT = NULL,
	@codiceAlfanumerico NVARCHAR(40) = NULL,
	@PKFatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT OUTPUT,
	@PKEsitoEvento SMALLINT OUTPUT,
	@XMLOutput XML OUTPUT
)
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @sp_name sysname = OBJECT_NAME(@@PROCID);
	DECLARE @Messaggio NVARCHAR(500);
	DECLARE @XMLOutputHeader XML;
	DECLARE @XMLOutputBody XML;

	EXEC XMLFatture.ssp_VerificaParametriFattura @sp_name = @sp_name,
	                                             @codiceNumerico = @codiceNumerico,
	                                             @codiceAlfanumerico = @codiceAlfanumerico,
	                                             @PKEvento = @PKEvento OUTPUT,
	                                             @PKEsitoEvento = @PKEsitoEvento OUTPUT;

	IF (@PKEsitoEvento < 0)
	BEGIN

		EXEC XMLFatture.ssp_GeneraXMLFatturaHeader @PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader,
		                                           @PKEvento = @PKEvento,
		                                           @PKEsitoEvento = @PKEsitoEvento OUTPUT,
		                                           @XMLOutput = @XMLOutputHeader OUTPUT;
		
		IF (@PKEsitoEvento < 0)
		BEGIN

			EXEC XMLFatture.ssp_GeneraXMLFatturaBody @PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader,
												     @PKEvento = @PKEvento,
												     @PKEsitoEvento = @PKEsitoEvento OUTPUT,
												     @XMLOutput = @XMLOutputBody OUTPUT;
		
			SELECT @XMLOutputBody;

			IF (@PKEsitoEvento < 0)
			BEGIN

                DECLARE @FormatoTrasmissione CHAR(5);

                SELECT @FormatoTrasmissione = DatiTrasmissione_FormatoTrasmissione
                FROM XMLFatture.FatturaElettronicaHeader
                WHERE PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader;

				-- Versione "cruda" (non formalmente corretta)
				SET @XMLOutput = (SELECT @XMLOutputHeader, @XMLOutputBody FOR XML PATH ('FatturaElettronica'));

				-- Versione con namespaces
				WITH XMLNAMESPACES ('http://www.w3.org/2000/09/xmldsig#' AS ds, 'http://ivaservizi.agenziaentrate.gov.it/docs/xsd/fatture/v1.2' AS p, 'http://www.w3.org/2001/XMLSchema-instance' AS xsi)
				SELECT @XMLOutput = (SELECT @FormatoTrasmissione AS '@versione', @XMLOutputHeader, @XMLOutputBody FOR XML PATH ('p:FatturaElettronica'));

				-- Versione con namespaces e foglio di stile XSL
				SET @XMLOutput.modify('
    insert <?xml-stylesheet type="text/xsl" href="(File per visualizzazione fattura elettronica 1.2.1 - NON inviare).xsl"?>
    before /*[1]
')

				UPDATE XMLFatture.FatturaElettronicaHeader
				SET IsEsportata = CAST(1 AS BIT),
					DataOraUltimaEsportazione = CURRENT_TIMESTAMP,
					XMLOutput = @XMLOutput

				WHERE PKFatturaElettronicaHeader = @PKFatturaElettronicaHeader;

				SET @Messaggio = REPLACE('Aggiornamento data ultima esportazione fattura (#%PKFatturaElettronicaHeader%) completata', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader));
				EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
											@Messaggio = @Messaggio,
											@PKEsitoEvento = @PKEsitoEvento,
											@LivelloLog = 2; -- 2: info

				SET @PKEsitoEvento = 0; -- 0: Nessun errore
				SET @Messaggio = REPLACE('Generazione XML fattura (#%PKFatturaElettronicaHeader%) completata', N'%PKFatturaElettronicaHeader%', CONVERT(NVARCHAR(10), @PKFatturaElettronicaHeader));
				EXEC XMLAudit.ssp_ScriviLogEvento @PKEvento = @PKEvento,
											@Messaggio = @Messaggio,
											@PKEsitoEvento = @PKEsitoEvento,
											@LivelloLog = 2; -- 2: info

			END;

		END;

	END;

END;
GO
GO
GO
