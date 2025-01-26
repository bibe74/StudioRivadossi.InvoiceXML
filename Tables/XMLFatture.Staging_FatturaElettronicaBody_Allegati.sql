CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_Allegati]
(
[PKStaging_FatturaElettronicaBody_Allegati] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_Allegati] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_Allegati]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[NomeAttachment] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AlgoritmoCompressione] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormatoAttachment] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DescrizioneAttachment] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Attachment] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_Allegati] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_Allegati] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_Allegati]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_Allegati] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_Allegati_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
