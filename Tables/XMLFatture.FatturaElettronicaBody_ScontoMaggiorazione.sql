CREATE TABLE [XMLFatture].[FatturaElettronicaBody_ScontoMaggiorazione]
(
[PKFatturaElettronicaBody_ScontoMaggiorazione] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_ScontoMaggiorazione] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_ScontoMaggiorazione]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[Tipo] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_ScontoMaggiorazione_Tipo] DEFAULT (''),
[Percentuale] [decimal] (5, 2) NULL,
[Importo] [decimal] (14, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_ScontoMaggiorazione] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_ScontoMaggiorazione] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_ScontoMaggiorazione]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_ScontoMaggiorazione] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_] FOREIGN KEY ([Tipo]) REFERENCES [XMLCodifiche].[TipoScontoMaggiorazione] ([IDTipoScontoMaggiorazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_ScontoMaggiorazione] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_ScontoMaggiorazione_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
