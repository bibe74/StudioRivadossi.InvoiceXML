SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLAudit.usp_LeggiLogValidazione
 * @description Lettura log Validazione

 * @param_input @chiaveGestionale_CodiceNumerico
 * @param_input @chiaveGestionale_CodiceAlfanumerico
 * @param_input @PKValidazione
 * @param_input @LivelloLog

*/

CREATE   PROCEDURE [XMLAudit].[usp_LeggiLogValidazione] (
	@chiaveGestionale_CodiceNumerico BIGINT = NULL,
	@chiaveGestionale_CodiceAlfanumerico NVARCHAR(40) = NULL,
	@PKValidazione BIGINT,
	@LivelloLog TINYINT = NULL
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT @LivelloLog = COALESCE(@LivelloLog, 2); -- 2: info

	IF NOT (@chiaveGestionale_CodiceNumerico IS NULL AND @chiaveGestionale_CodiceAlfanumerico IS NULL)
	BEGIN

		SELECT
			ER.PKValidazione_Riga,
			ER.PKValidazione,
			ER.Campo,
			ER.ValoreTesto,
			ER.ValoreIntero,
			ER.ValoreDecimale,
			ER.Messaggio,
			ER.LivelloLog

		FROM XMLAudit.Validazione E
		INNER JOIN XMLFatture.Staging_FatturaElettronicaHeader SFEH ON SFEH.PKStaging_FatturaElettronicaHeader = E.PKStaging_FatturaElettronicaHeader
		INNER JOIN XMLFatture.Landing_Fattura LF ON LF.PKLanding_Fattura = SFEH.PKLanding_Fattura
			AND (
				@chiaveGestionale_CodiceNumerico IS NULL
				OR LF.ChiaveGestionale_CodiceNumerico = @chiaveGestionale_CodiceNumerico
			)
			AND (
				@chiaveGestionale_CodiceAlfanumerico IS NULL
				OR LF.ChiaveGestionale_CodiceAlfanumerico = @chiaveGestionale_CodiceAlfanumerico
			)
		INNER JOIN XMLAudit.Validazione_Riga ER ON ER.PKValidazione = E.PKValidazione
		WHERE E.PKValidazione = @PKValidazione
		ORDER BY ER.PKValidazione_Riga;

	END;

END;
GO
