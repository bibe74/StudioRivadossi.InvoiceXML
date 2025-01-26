CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea]
(
[PKStaging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea]),
[PKStaging_FatturaElettronicaBody_DatiDDT] [bigint] NOT NULL,
[RiferimentoNumeroLinea] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea_PKStaging_FatturaElettronicaBody_DatiDDT] FOREIGN KEY ([PKStaging_FatturaElettronicaBody_DatiDDT]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody_DatiDDT] ([PKStaging_FatturaElettronicaBody_DatiDDT])
GO
