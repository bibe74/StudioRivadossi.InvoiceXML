CREATE TABLE [XMLCodifiche].[Nazione]
(
[IDNazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Nazione] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[Nazione] ADD CONSTRAINT [PK_XMLCodifiche_Nazione] PRIMARY KEY CLUSTERED  ([IDNazione]) ON [PRIMARY]
GO
