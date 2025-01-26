CREATE TABLE [XMLCodifiche].[SoggettoEmittente]
(
[IDSoggettoEmittente] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SoggettoEmittente] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[SoggettoEmittente] ADD CONSTRAINT [PK_XMLCodifiche_SoggettoEmittente] PRIMARY KEY CLUSTERED  ([IDSoggettoEmittente]) ON [PRIMARY]
GO
