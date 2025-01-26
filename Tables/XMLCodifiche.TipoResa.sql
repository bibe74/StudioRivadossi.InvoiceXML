CREATE TABLE [XMLCodifiche].[TipoResa]
(
[IDTipoResa] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TipoResa] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[TipoResa] ADD CONSTRAINT [PK_XMLCodifiche_TipoResa] PRIMARY KEY CLUSTERED  ([IDTipoResa]) ON [PRIMARY]
GO
