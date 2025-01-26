CREATE TABLE [XMLCodifiche].[CodiceErroreEvento]
(
[PKEsitoEvento] [smallint] NOT NULL,
[CodiceErroreEvento] [smallint] NOT NULL,
[DescrizioneErroreEvento] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[CodiceErroreEvento] ADD CONSTRAINT [PK_XMLCodifiche_CodiceErroreEvento] PRIMARY KEY CLUSTERED  ([PKEsitoEvento]) ON [PRIMARY]
GO
