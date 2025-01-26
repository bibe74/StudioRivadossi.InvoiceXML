CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiSAL]
(
[PKStaging_FatturaElettronicaBody_DatiSAL] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DatiSAL] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DatiSAL]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[RiferimentoFase] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiSAL] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DatiSAL] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DatiSAL]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiSAL] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DatiSAL_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
