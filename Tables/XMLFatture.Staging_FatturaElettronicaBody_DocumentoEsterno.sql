CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DocumentoEsterno]
(
[PKStaging_FatturaElettronicaBody_DocumentoEsterno] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DocumentoEsterno] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DocumentoEsterno]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[TipoDocumentoEsterno] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IdDocumento] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Data] [date] NULL,
[NumItem] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceCommessaConvenzione] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceCUP] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceCIG] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DocumentoEsterno] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DocumentoEsterno] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DocumentoEsterno]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DocumentoEsterno] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DocumentoEsterno_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
