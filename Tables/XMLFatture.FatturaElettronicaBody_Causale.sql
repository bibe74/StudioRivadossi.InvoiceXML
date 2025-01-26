CREATE TABLE [XMLFatture].[FatturaElettronicaBody_Causale]
(
[PKFatturaElettronicaBody_Causale] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_Causale] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_Causale]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[DatiGenerali_Causale] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_PKFatturaElettronicaBody_Causale_DatiGenerali_Causale] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_Causale] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_Causale] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_Causale]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_Causale] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_Causale_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
