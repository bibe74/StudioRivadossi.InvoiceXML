CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DatiCassaPrevidenziale]
(
[PKFatturaElettronicaBody_DatiCassaPrevidenziale] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DatiCassaPrevidenziale]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[TipoCassa] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale_TipoCassa] DEFAULT (''),
[AlCassa] [decimal] (5, 2) NOT NULL,
[ImportoContributoCassa] [decimal] (14, 2) NOT NULL,
[ImponibileCassa] [decimal] (14, 2) NULL,
[AliquotaIVA] [decimal] (5, 2) NOT NULL,
[Ritenuta] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale_Ritenuta] DEFAULT (''),
[Natura] [varchar] (5) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale_Natura] DEFAULT (''),
[RiferimentoAmministrazione] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiCassaPrevidenziale] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DatiCassaPrevidenziale]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiCassaPrevidenziale] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale_Natura] FOREIGN KEY ([Natura]) REFERENCES [XMLCodifiche].[Natura] ([IDNatura])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiCassaPrevidenziale] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiCassaPrevidenziale] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale_Ritenuta] FOREIGN KEY ([Ritenuta]) REFERENCES [XMLCodifiche].[RispostaSI] ([IDRispostaSI])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiCassaPrevidenziale] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiCassaPrevidenziale_TipoCassa] FOREIGN KEY ([TipoCassa]) REFERENCES [XMLCodifiche].[TipoCassa] ([IDTipoCassa])
GO
