CREATE TABLE [XMLAudit].[TipoEvento]
(
[PKTipoEvento] [smallint] NOT NULL,
[Codice] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Descrizione] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[TipoEvento] ADD CONSTRAINT [PK_XMLAudit_TipoEvento] PRIMARY KEY CLUSTERED  ([PKTipoEvento]) ON [PRIMARY]
GO
