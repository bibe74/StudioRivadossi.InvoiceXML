CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea]
(
[PKFatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea]),
[PKFatturaElettronicaBody_DocumentoEsterno] [bigint] NOT NULL,
[RiferimentoNumeroLinea] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea_PKFatturaElettronicaBody_DocumentoEsterno] FOREIGN KEY ([PKFatturaElettronicaBody_DocumentoEsterno]) REFERENCES [XMLFatture].[FatturaElettronicaBody_DocumentoEsterno] ([PKFatturaElettronicaBody_DocumentoEsterno])
GO
