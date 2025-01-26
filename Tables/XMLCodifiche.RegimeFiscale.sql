CREATE TABLE [XMLCodifiche].[RegimeFiscale]
(
[IDRegimeFiscale] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RegimeFiscale] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[RegimeFiscale] ADD CONSTRAINT [PK_XMLCodifiche_RegimeFiscale] PRIMARY KEY CLUSTERED  ([IDRegimeFiscale]) ON [PRIMARY]
GO
