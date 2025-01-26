CREATE TABLE [XMLAudit].[Evento]
(
[PKEvento] [bigint] NOT NULL IDENTITY(1, 1),
[ChiaveGestionale_CodiceNumerico] [bigint] NULL,
[ChiaveGestionale_CodiceAlfanumerico] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataOra] [datetime2] NOT NULL CONSTRAINT [DFT_XMLAudit_Evento_DataOra] DEFAULT (sysdatetime()),
[StoredProcedure] [sys].[sysname] NULL,
[PKEsitoEvento] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[Evento] ADD CONSTRAINT [PK_XMLAudit_Evento] PRIMARY KEY CLUSTERED  ([PKEvento]) ON [PRIMARY]
GO
