SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLAudit.ssp_LeggiLogEvento
 * @description Lettura log evento (procedura di sistema)

 * @param_input @PKEvento
 * @param_input @LivelloLog

*/

CREATE   PROCEDURE [XMLAudit].[ssp_LeggiLogEvento] (
	@PKEvento BIGINT,
	@LivelloLog TINYINT = NULL
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT @LivelloLog = COALESCE(@LivelloLog, 2); -- 2: info

	SELECT
		ER.PKEvento_Riga,
		ER.PKEvento,
		ER.DataOra,
		ER.Messaggio,
		ER.LivelloLog

	FROM XMLAudit.Evento E
	INNER JOIN XMLAudit.Evento_Riga ER ON ER.PKEvento = E.PKEvento
	WHERE E.PKEvento = @PKEvento
		AND ER.LivelloLog >= @LivelloLog
	ORDER BY ER.PKEvento_Riga;

END;
GO
