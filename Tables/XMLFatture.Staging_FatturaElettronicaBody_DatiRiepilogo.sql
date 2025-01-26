CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiRiepilogo]
(
[PKStaging_FatturaElettronicaBody_DatiRiepilogo] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DatiRiepilogo] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DatiRiepilogo]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[AliquotaIVA] [decimal] (5, 2) NULL,
[Natura] [varchar] (5) COLLATE Latin1_General_CI_AS NULL,
[SpeseAccessorie] [decimal] (14, 2) NULL,
[Arrotondamento] [decimal] (20, 2) NULL,
[ImponibileImporto] [decimal] (14, 2) NULL,
[Imposta] [decimal] (14, 2) NULL,
[EsigibilitaIVA] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RiferimentoNormativo] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiRiepilogo] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DatiRiepilogo] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DatiRiepilogo]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiRiepilogo] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DatiRiepilogo_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
