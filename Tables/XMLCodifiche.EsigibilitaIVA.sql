CREATE TABLE [XMLCodifiche].[EsigibilitaIVA]
(
[IDEsigibilitaIVA] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EsigibilitaIVA] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[EsigibilitaIVA] ADD CONSTRAINT [PK_XMLCodifiche_EsigibilitaIVA] PRIMARY KEY CLUSTERED  ([IDEsigibilitaIVA]) ON [PRIMARY]
GO
