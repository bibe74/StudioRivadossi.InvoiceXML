CREATE TABLE [XMLCodifiche].[TipoCassa]
(
[IDTipoCassa] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TipoCassa] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[TipoCassa] ADD CONSTRAINT [PK_XMLCodifiche_TipoCassa] PRIMARY KEY CLUSTERED  ([IDTipoCassa]) ON [PRIMARY]
GO
