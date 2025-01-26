CREATE TABLE [XMLCodifiche].[Natura]
(
[IDNatura] [varchar] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[Natura] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsObsoleta] [bit] NOT NULL CONSTRAINT [DFT_XMLCodifiche_Natura_IsObsoleta] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[Natura] ADD CONSTRAINT [PK_XMLCodifiche_Natura] PRIMARY KEY CLUSTERED  ([IDNatura]) ON [PRIMARY]
GO
