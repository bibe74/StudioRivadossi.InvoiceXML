CREATE TABLE [XMLAudit].[LivelloLog]
(
[PKLivelloLog] [smallint] NOT NULL,
[Codice] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Descrizione] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[LivelloLog] ADD CONSTRAINT [PK_XMLAudit_LivelloLog] PRIMARY KEY CLUSTERED  ([PKLivelloLog]) ON [PRIMARY]
GO
