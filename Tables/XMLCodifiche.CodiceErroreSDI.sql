CREATE TABLE [XMLCodifiche].[CodiceErroreSDI]
(
[IDCampo] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodiceErroreSDI] [smallint] NOT NULL,
[DescrizioneErroreSDI] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[CodiceErroreSDI] ADD CONSTRAINT [PK_XMLCodifiche_CodiceErroreSDI] PRIMARY KEY CLUSTERED  ([IDCampo], [CodiceErroreSDI]) ON [PRIMARY]
GO
