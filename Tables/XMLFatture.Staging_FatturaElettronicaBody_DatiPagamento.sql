CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiPagamento]
(
[PKStaging_FatturaElettronicaBody_DatiPagamento] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DatiPagamento] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DatiPagamento]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[CondizioniPagamento] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DatiPagamento_CondizioniPagamento] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiPagamento] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DatiPagamento] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DatiPagamento]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiPagamento] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DatiPagamento_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
