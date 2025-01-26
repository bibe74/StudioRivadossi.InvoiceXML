CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali]
(
[PKStaging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali]),
[PKStaging_FatturaElettronicaBody_DettaglioLinee] [bigint] NOT NULL,
[AltriDatiGestionali_TipoDato] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AltriDatiGestionali_RiferimentoTesto] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AltriDatiGestionali_RiferimentoNumero] [decimal] (20, 5) NULL,
[AltriDatiGestionali_RiferimentoData] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali_PKStaging_FatturaElettronicaBody_DettaglioLinee] FOREIGN KEY ([PKStaging_FatturaElettronicaBody_DettaglioLinee]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee] ([PKStaging_FatturaElettronicaBody_DettaglioLinee])
GO
