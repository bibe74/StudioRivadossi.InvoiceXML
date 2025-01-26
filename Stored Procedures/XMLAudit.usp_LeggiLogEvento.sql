SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLAudit.usp_LeggiLogEvento
 * @description Lettura log evento

 * @param_input @PKEvento
 * @param_input @LivelloLog

*/

CREATE   PROCEDURE [XMLAudit].[usp_LeggiLogEvento] (
	@chiaveGestionale_CodiceNumerico BIGINT = NULL,
	@chiaveGestionale_CodiceAlfanumerico NVARCHAR(40) = NULL,
	@PKEvento BIGINT,
	@LivelloLog TINYINT = NULL
)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT @LivelloLog = COALESCE(@LivelloLog, 2); -- 2: info

	IF NOT (@chiaveGestionale_CodiceNumerico IS NULL AND @chiaveGestionale_CodiceAlfanumerico IS NULL)
	BEGIN

		SELECT
			ER.PKEvento_Riga,
			ER.PKEvento,
			ER.DataOra,
			ER.Messaggio,
			ER.LivelloLog

		FROM XMLAudit.Evento E
		INNER JOIN XMLAudit.Evento_Riga ER ON ER.PKEvento = E.PKEvento
		WHERE E.PKEvento = @PKEvento
			AND (
				@chiaveGestionale_CodiceNumerico IS NULL
				OR E.ChiaveGestionale_CodiceNumerico = @chiaveGestionale_CodiceNumerico
			)
			AND (
				@chiaveGestionale_CodiceAlfanumerico IS NULL
				OR E.ChiaveGestionale_CodiceAlfanumerico = @chiaveGestionale_CodiceAlfanumerico
			)
			AND ER.LivelloLog >= @LivelloLog
		ORDER BY ER.PKEvento_Riga;

	END;

END;
GO
