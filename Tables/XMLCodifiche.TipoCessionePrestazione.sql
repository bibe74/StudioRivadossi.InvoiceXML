CREATE TABLE [XMLCodifiche].[TipoCessionePrestazione]
(
[IDTipoCessionePrestazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TipoCessionePrestazione] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[TipoCessionePrestazione] ADD CONSTRAINT [PK_XMLCodifiche_TipoCessionePrestazione] PRIMARY KEY CLUSTERED  ([IDTipoCessionePrestazione]) ON [PRIMARY]
GO
