CREATE TABLE [XMLCodifiche].[TipoRitenuta]
(
[IDTipoRitenuta] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TipoRitenuta] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[TipoRitenuta] ADD CONSTRAINT [PK_XMLCodifiche_TipoRitenuta] PRIMARY KEY CLUSTERED  ([IDTipoRitenuta]) ON [PRIMARY]
GO
