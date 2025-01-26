CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea]
(
[PKFatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea]),
[PKFatturaElettronicaBody_DatiDDT] [bigint] NOT NULL,
[RiferimentoNumeroLinea] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiDDT_RiferimentoNumeroLinea_PKFatturaElettronicaBody_DatiDDT] FOREIGN KEY ([PKFatturaElettronicaBody_DatiDDT]) REFERENCES [XMLFatture].[FatturaElettronicaBody_DatiDDT] ([PKFatturaElettronicaBody_DatiDDT])
GO
