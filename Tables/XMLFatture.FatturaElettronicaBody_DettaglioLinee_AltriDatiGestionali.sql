CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali]
(
[PKFatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali]),
[PKFatturaElettronicaBody_DettaglioLinee] [bigint] NOT NULL,
[AltriDatiGestionali_TipoDato] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AltriDatiGestionali_RiferimentoTesto] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AltriDatiGestionali_RiferimentoNumero] [decimal] (20, 5) NULL,
[AltriDatiGestionali_RiferimentoData] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_AltriDatiGestionali_PKFatturaElettronicaBody_DettaglioLinee] FOREIGN KEY ([PKFatturaElettronicaBody_DettaglioLinee]) REFERENCES [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ([PKFatturaElettronicaBody_DettaglioLinee])
GO
