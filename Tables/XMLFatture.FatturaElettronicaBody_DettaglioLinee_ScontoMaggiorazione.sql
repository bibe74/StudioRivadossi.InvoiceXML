CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione]
(
[PKFatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione]),
[PKFatturaElettronicaBody_DettaglioLinee] [bigint] NOT NULL,
[ScontoMaggiorazione_Tipo] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ScontoMaggiorazione_Percentuale] [decimal] (5, 2) NULL,
[ScontoMaggiorazione_Importo] [decimal] (14, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione_PKFatturaElettronicaBody_DettaglioLinee] FOREIGN KEY ([PKFatturaElettronicaBody_DettaglioLinee]) REFERENCES [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ([PKFatturaElettronicaBody_DettaglioLinee])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione_ScontoMaggiorazione_Tipo] FOREIGN KEY ([ScontoMaggiorazione_Tipo]) REFERENCES [XMLCodifiche].[TipoScontoMaggiorazione] ([IDTipoScontoMaggiorazione])
GO
