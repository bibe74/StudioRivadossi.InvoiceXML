CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DatiRiepilogo]
(
[PKFatturaElettronicaBody_DatiRiepilogo] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiRiepilogo] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DatiRiepilogo]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[AliquotaIVA] [decimal] (5, 2) NOT NULL,
[Natura] [varchar] (5) COLLATE Latin1_General_CI_AS NOT NULL,
[SpeseAccessorie] [decimal] (14, 2) NULL,
[Arrotondamento] [decimal] (20, 2) NULL,
[ImponibileImporto] [decimal] (14, 2) NOT NULL,
[Imposta] [decimal] (14, 2) NOT NULL,
[EsigibilitaIVA] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RiferimentoNormativo] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiRiepilogo] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DatiRiepilogo] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DatiRiepilogo]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiRiepilogo] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiRiepilogo_EsigibilitaIVA] FOREIGN KEY ([EsigibilitaIVA]) REFERENCES [XMLCodifiche].[EsigibilitaIVA] ([IDEsigibilitaIVA])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiRiepilogo] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiRiepilogo_Natura] FOREIGN KEY ([Natura]) REFERENCES [XMLCodifiche].[Natura] ([IDNatura])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiRiepilogo] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiRiepilogo_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
