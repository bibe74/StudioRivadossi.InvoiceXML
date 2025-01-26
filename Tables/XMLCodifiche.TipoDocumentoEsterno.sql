CREATE TABLE [XMLCodifiche].[TipoDocumentoEsterno]
(
[IDTipoDocumentoEsterno] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TipoDocumentoEsterno] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[TipoDocumentoEsterno] ADD CONSTRAINT [PK_XMLCodifiche_TipoDocumentoEsterno] PRIMARY KEY CLUSTERED  ([IDTipoDocumentoEsterno]) ON [PRIMARY]
GO
