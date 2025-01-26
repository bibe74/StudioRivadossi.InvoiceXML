CREATE TABLE [XMLAudit].[EsitoEvento]
(
[PKEsitoEvento] [smallint] NOT NULL,
[Codice] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Descrizione] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[EsitoEvento] ADD CONSTRAINT [PK_XMLAudit_EsitoEvento] PRIMARY KEY CLUSTERED  ([PKEsitoEvento]) ON [PRIMARY]
GO
