SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLAudit].[ssp_GeneraValidazione] (
	@PKStaging_FatturaElettronicaHeader BIGINT,
	@PKEvento BIGINT,
	@PKValidazione BIGINT OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	SET @PKValidazione = NEXT VALUE FOR XMLAudit.seq_Validazione;

	INSERT INTO XMLAudit.Validazione
	(
	    PKValidazione,
	    PKStaging_FatturaElettronicaHeader,
	    DataOraValidazione,
	    PKEvento,
	    PKStato,
	    IsValida
	)
	VALUES
	(   @PKValidazione,             -- PKValidazione - bigint
	    @PKStaging_FatturaElettronicaHeader,             -- PKStaging_FatturaElettronicaHeader - bigint
	    SYSDATETIME(), -- DataOraValidazione - datetime2(7)
	    @PKEvento,             -- PKEvento - bigint
		1,             -- PKStato - tinyint
	    0           -- IsValida - bit
	);

END;
GO
