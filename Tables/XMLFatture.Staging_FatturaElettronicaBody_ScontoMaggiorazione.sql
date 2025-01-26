CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_ScontoMaggiorazione]
(
[PKStaging_FatturaElettronicaBody_ScontoMaggiorazione] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_ScontoMaggiorazione] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_ScontoMaggiorazione]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[Tipo] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Percentuale] [decimal] (5, 2) NULL,
[Importo] [decimal] (14, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_ScontoMaggiorazione] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_ScontoMaggiorazione] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_ScontoMaggiorazione]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_ScontoMaggiorazione] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_ScontoMaggiorazione_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
