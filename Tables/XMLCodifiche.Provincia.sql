CREATE TABLE [XMLCodifiche].[Provincia]
(
[IDProvincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Provincia] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[Provincia] ADD CONSTRAINT [PK_XMLCodifiche_Provincia] PRIMARY KEY CLUSTERED  ([IDProvincia]) ON [PRIMARY]
GO
