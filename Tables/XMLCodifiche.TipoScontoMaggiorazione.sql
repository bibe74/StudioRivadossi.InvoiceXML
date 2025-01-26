CREATE TABLE [XMLCodifiche].[TipoScontoMaggiorazione]
(
[IDTipoScontoMaggiorazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TipoScontoMaggiorazione] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[TipoScontoMaggiorazione] ADD CONSTRAINT [PK_XMLCodifiche_TipoScontoMaggiorazione] PRIMARY KEY CLUSTERED  ([IDTipoScontoMaggiorazione]) ON [PRIMARY]
GO
