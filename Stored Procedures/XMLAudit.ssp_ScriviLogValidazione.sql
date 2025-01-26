SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLAudit].[ssp_ScriviLogValidazione] (
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
