CREATE TABLE [XMLCodifiche].[SocioUnico]
(
[IDSocioUnico] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SocioUnico] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[SocioUnico] ADD CONSTRAINT [PK_XMLCodifiche_SocioUnico] PRIMARY KEY CLUSTERED  ([IDSocioUnico]) ON [PRIMARY]
GO
