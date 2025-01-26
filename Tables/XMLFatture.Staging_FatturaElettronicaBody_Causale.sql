CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_Causale]
(
[PKStaging_FatturaElettronicaBody_Causale] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_Causale] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_Causale]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[DatiGenerali_Causale] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_Causale] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_Causale] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_Causale]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_Causale] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_Causale_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
