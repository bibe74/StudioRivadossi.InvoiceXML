SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [XMLAudit].[ssp_GeneraEvento] (
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
