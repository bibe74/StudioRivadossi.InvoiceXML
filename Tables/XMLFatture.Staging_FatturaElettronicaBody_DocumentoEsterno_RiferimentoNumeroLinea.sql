CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea]
(
[PKStaging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea]),
[PKStaging_FatturaElettronicaBody_DocumentoEsterno] [bigint] NOT NULL,
[RiferimentoNumeroLinea] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DocumentoEsterno_RiferimentoNumeroLinea_DocumentoEsterno] FOREIGN KEY ([PKStaging_FatturaElettronicaBody_DocumentoEsterno]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody_DocumentoEsterno] ([PKStaging_FatturaElettronicaBody_DocumentoEsterno])
GO
