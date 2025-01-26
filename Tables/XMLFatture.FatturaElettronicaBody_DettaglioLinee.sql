CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee]
(
[PKFatturaElettronicaBody_DettaglioLinee] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DettaglioLinee] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DettaglioLinee]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[NumeroLinea] [int] NOT NULL,
[TipoCessionePrestazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Descrizione] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Quantita] [decimal] (20, 5) NULL,
[UnitaMisura] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataInizioPeriodo] [date] NULL,
[DataFinePeriodo] [date] NULL,
[PrezzoUnitario] [decimal] (20, 5) NOT NULL,
[PrezzoTotale] [decimal] (20, 5) NOT NULL,
[AliquotaIVA] [decimal] (5, 2) NOT NULL,
[Ritenuta] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Natura] [varchar] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[RiferimentoAmministrazione] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DettaglioLinee] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DettaglioLinee]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_XMLFatture_FatturaElettronicaBody_DettaglioLinee_PKFatturaElettronicaBody_NumeroLinea] ON [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ([PKFatturaElettronicaBody], [NumeroLinea]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_Natura] FOREIGN KEY ([Natura]) REFERENCES [XMLCodifiche].[Natura] ([IDNatura])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_Ritenuta] FOREIGN KEY ([Ritenuta]) REFERENCES [XMLCodifiche].[RispostaSI] ([IDRispostaSI])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_TipoCessionePrestazione] FOREIGN KEY ([TipoCessionePrestazione]) REFERENCES [XMLCodifiche].[TipoCessionePrestazione] ([IDTipoCessionePrestazione])
GO
