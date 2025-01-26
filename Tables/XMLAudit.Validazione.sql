CREATE TABLE [XMLAudit].[Validazione]
(
[PKValidazione] [bigint] NOT NULL CONSTRAINT [DFT_XMLAudit_Validazione_PKValidazione] DEFAULT (NEXT VALUE FOR [XMLAudit].[seq_Validazione]),
[PKStaging_FatturaElettronicaHeader] [bigint] NOT NULL,
[DataOraValidazione] [datetime2] NOT NULL CONSTRAINT [DFT_XMLAudit_Validazione_DataOraValidazione] DEFAULT (sysdatetime()),
[PKEvento] [bigint] NOT NULL,
[PKStato] [tinyint] NOT NULL CONSTRAINT [DFT_XMLAudit_Validazione_PKStato] DEFAULT ((1)),
[IsValida] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_IsValida] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[Validazione] ADD CONSTRAINT [PK_XMLAudit_Validazione] PRIMARY KEY CLUSTERED  ([PKValidazione]) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[Validazione] ADD CONSTRAINT [FK_XMLAudit_Validazione_PKEvento] FOREIGN KEY ([PKEvento]) REFERENCES [XMLAudit].[Evento] ([PKEvento])
GO
