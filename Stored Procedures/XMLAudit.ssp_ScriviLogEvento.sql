SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLAudit].[ssp_ScriviLogEvento] (
	@PKEvento BIGINT,
	@Messaggio NVARCHAR(500),
	@PKEsitoEvento SMALLINT = NULL,
	@LivelloLog TINYINT = NULL
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT @LivelloLog = COALESCE(@LivelloLog, 0); -- 0: trace

	INSERT INTO XMLAudit.Evento_Riga
	(
	    PKEvento,
	    DataOra,
	    Messaggio,
		LivelloLog
	)
	VALUES
	(   @PKEvento,
	    SYSDATETIME(),
	    @Messaggio,
		@LivelloLog
	);

	IF (@PKEsitoEvento IS NOT NULL)
	BEGIN

		UPDATE XMLAudit.Evento
		SET PKEsitoEvento = @PKEsitoEvento
		WHERE PKEvento = @PKEvento;

	END;

END;
GO
