SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLAudit.ssp_ScriviLogValidazione
 * @description Scrittura riga di log Validazione (procedura di sistema)

 * @param_input @PKValidazione
 * @param_input @campo
 * @param_input @valoreTesto
 * @param_input @valoreIntero
 * @param_input @valoreDecimale
 * @param_input @valoreData
 * @param_input @Messaggio
 * @param_input @LivelloLog

*/

CREATE   PROCEDURE [XMLAudit].[ssp_ScriviLogValidazione] (
	@PKValidazione BIGINT,
	@campo NVARCHAR(100),
	@valoreTesto NVARCHAR(100) = NULL,
	@valoreIntero INT = NULL,
	@valoreDecimale DECIMAL(28, 12) = NULL,
	@valoreData DATETIME2 = NULL,
	@Messaggio NVARCHAR(500),
	@LivelloLog TINYINT = NULL
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT @LivelloLog = COALESCE(@LivelloLog, 0); -- 0: trace

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
	    @campo,  -- Campo - nvarchar(100)
	    @valoreTesto,  -- ValoreTesto - nvarchar(100)
	    @valoreIntero,    -- ValoreIntero - int
	    @valoreDecimale, -- ValoreDecimale - decimal(28, 12)
		@valoreData, -- ValoreData - datetime2
	    @Messaggio,   -- Messaggio - nvarchar(100)
		@LivelloLog		-- LivelloLog - tinyint
	);

END;
GO
