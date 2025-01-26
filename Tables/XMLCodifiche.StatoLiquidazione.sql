CREATE TABLE [XMLCodifiche].[StatoLiquidazione]
(
[IDStatoLiquidazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StatoLiquidazione] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[StatoLiquidazione] ADD CONSTRAINT [PK_XMLCodifiche_StatoLiquidazione] PRIMARY KEY CLUSTERED  ([IDStatoLiquidazione]) ON [PRIMARY]
GO
