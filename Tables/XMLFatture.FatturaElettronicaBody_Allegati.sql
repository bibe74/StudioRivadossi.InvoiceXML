CREATE TABLE [XMLFatture].[FatturaElettronicaBody_Allegati]
(
[PKFatturaElettronicaBody_Allegati] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_Allegati] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_Allegati]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[NomeAttachment] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AlgoritmoCompressione] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormatoAttachment] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DescrizioneAttachment] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Attachment] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_Allegati] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_Allegati] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_Allegati]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_Allegati] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_Allegati_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
