CREATE TABLE [XMLAudit].[Evento_Riga]
(
[PKEvento_Riga] [bigint] NOT NULL IDENTITY(1, 1),
[PKEvento] [bigint] NOT NULL,
[DataOra] [datetime2] NOT NULL CONSTRAINT [DFT_XMLAudit_Evento_Riga_DataOra] DEFAULT (sysdatetime()),
[Messaggio] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LivelloLog] [tinyint] NOT NULL CONSTRAINT [DFT_XMLAudit_Evento_Riga_LivelloLog] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[Evento_Riga] ADD CONSTRAINT [PK_XMLAudit_Evento_Riga] PRIMARY KEY CLUSTERED  ([PKEvento_Riga]) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[Evento_Riga] ADD CONSTRAINT [FK_XMLAudit_Evento_Riga_PKEvento] FOREIGN KEY ([PKEvento]) REFERENCES [XMLAudit].[Evento] ([PKEvento])
GO
