CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione]
(
[PKStaging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione]),
[PKStaging_FatturaElettronicaBody_DettaglioLinee] [bigint] NOT NULL,
[ScontoMaggiorazione_Tipo] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ScontoMaggiorazione_Percentuale] [decimal] (5, 2) NULL,
[ScontoMaggiorazione_Importo] [decimal] (14, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_ScontoMaggiorazione_PKStaging_FatturaElettronicaBody_DettaglioLinee] FOREIGN KEY ([PKStaging_FatturaElettronicaBody_DettaglioLinee]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee] ([PKStaging_FatturaElettronicaBody_DettaglioLinee])
GO
