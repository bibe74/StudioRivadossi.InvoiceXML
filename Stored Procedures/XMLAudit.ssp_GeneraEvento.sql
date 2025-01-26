SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/**
 * @stored_procedure XMLAudit.ssp_GeneraEvento
 * @description Generazione nuovo evento (procedura di sistema)

 * @param_input @chiaveGestionale_CodiceNumerico
 * @param_input @chiaveGestionale_CodiceAlfanumerico
 * @param_input @storedProcedure

 * @param_output @PKEvento

*/

CREATE   PROCEDURE [XMLAudit].[ssp_GeneraEvento] (
	@chiaveGestionale_CodiceNumerico BIGINT = NULL,
	@chiaveGestionale_CodiceAlfanumerico NVARCHAR(40) = NULL,
	@storedProcedure sysname = NULL,
	@PKEvento BIGINT OUTPUT
)
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO XMLAudit.Evento
	(
	    ChiaveGestionale_CodiceNumerico,
	    ChiaveGestionale_CodiceAlfanumerico,
	    DataOra,
	    StoredProcedure,
	    PKEsitoEvento
	)
	VALUES
	(   @chiaveGestionale_CodiceNumerico,             -- ChiaveGestionale_CodiceNumerico - bigint
	    @chiaveGestionale_CodiceAlfanumerico,           -- ChiaveGestionale_CodiceAlfanumerico - nvarchar(40)
	    SYSDATETIME(), -- DataOra - datetime2(7)
	    @storedProcedure,          -- StoredProcedure - sysname
	    -1              -- PKEsitoEvento - smallint
	);

	SELECT @PKEvento = SCOPE_IDENTITY();

END;
GO
