CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DocumentoEsterno]
(
[PKFatturaElettronicaBody_DocumentoEsterno] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DocumentoEsterno] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DocumentoEsterno]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[TipoDocumentoEsterno] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IdDocumento] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Data] [date] NULL,
[NumItem] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceCommessaConvenzione] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceCUP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceCIG] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DocumentoEsterno] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DocumentoEsterno] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DocumentoEsterno]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DocumentoEsterno] ADD CONSTRAINT [FK_PKFatturaElettronicaBody_DocumentoEsterno_TipoDocumentoEsterno] FOREIGN KEY ([TipoDocumentoEsterno]) REFERENCES [XMLCodifiche].[TipoDocumentoEsterno] ([IDTipoDocumentoEsterno])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DocumentoEsterno] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DocumentoEsterno_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
