CREATE TABLE [XMLCodifiche].[FormatoTrasmissione]
(
[IDFormatoTrasmissione] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FormatoTrasmissione] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[FormatoTrasmissione] ADD CONSTRAINT [PK_XMLCodifiche_FormatoTrasmissione] PRIMARY KEY CLUSTERED  ([IDFormatoTrasmissione]) ON [PRIMARY]
GO
