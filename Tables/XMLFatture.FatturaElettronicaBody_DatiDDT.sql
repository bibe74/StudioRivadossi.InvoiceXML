CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DatiDDT]
(
[PKFatturaElettronicaBody_DatiDDT] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiDDT] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DatiDDT]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[NumeroDDT] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataDDT] [date] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiDDT] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DatiDDT] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DatiDDT]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiDDT] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiDDT_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
