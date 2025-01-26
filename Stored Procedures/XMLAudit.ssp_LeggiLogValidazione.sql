SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLAudit.ssp_LeggiLogValidazione
 * @description Lettura log Validazione (procedura di sistema)

 * @param_input @PKValidazione
 * @param_input @LivelloLog

*/

CREATE   PROCEDURE [XMLAudit].[ssp_LeggiLogValidazione] (
	@PKValidazione BIGINT,
	@LivelloLog TINYINT = NULL
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT @LivelloLog = COALESCE(@LivelloLog, 2); -- 2: info

	SELECT
		VR.PKValidazione_Riga,
		VR.PKValidazione,
		VR.Campo,
		VR.ValoreTesto,
		VR.ValoreIntero,
		VR.ValoreDecimale,
		VR.ValoreData,
		VR.Messaggio,
		VR.LivelloLog

	FROM XMLAudit.Validazione V
	INNER JOIN XMLAudit.Validazione_Riga VR ON VR.PKValidazione = V.PKValidazione
	WHERE V.PKValidazione = @PKValidazione
		AND VR.LivelloLog >= @LivelloLog
	ORDER BY VR.PKValidazione_Riga;

END;
GO
