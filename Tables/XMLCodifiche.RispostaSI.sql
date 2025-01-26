CREATE TABLE [XMLCodifiche].[RispostaSI]
(
[IDRispostaSI] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RispostaSI] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[RispostaSI] ADD CONSTRAINT [PK_XMLCodifiche_RispostaSI] PRIMARY KEY CLUSTERED  ([IDRispostaSI]) ON [PRIMARY]
GO
