CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DatiPagamento]
(
[PKFatturaElettronicaBody_DatiPagamento] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiPagamento] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DatiPagamento]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[CondizioniPagamento] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiPagamento_CondizioniPagamento] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiPagamento] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DatiPagamento] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DatiPagamento]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiPagamento] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiPagamento_CondizioniPagamento] FOREIGN KEY ([CondizioniPagamento]) REFERENCES [XMLCodifiche].[CondizioniPagamento] ([IDCondizioniPagamento])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiPagamento] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiPagamento_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
