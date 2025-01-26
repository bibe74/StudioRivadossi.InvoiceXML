CREATE TABLE [XMLCodifiche].[TipoDocumento]
(
[IDTipoDocumento] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TipoDocumento] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[TipoDocumento] ADD CONSTRAINT [PK_XMLCodifiche_TipoDocumento] PRIMARY KEY CLUSTERED  ([IDTipoDocumento]) ON [PRIMARY]
GO
