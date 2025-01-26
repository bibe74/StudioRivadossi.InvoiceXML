CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_CodiceArticolo]
(
[PKFatturaElettronicaBody_DettaglioLinee_CodiceArticolo] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo]),
[PKFatturaElettronicaBody_DettaglioLinee] [bigint] NOT NULL,
[CodiceArticolo_CodiceTipo] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CodiceArticolo_CodiceValore] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DettaglioLinee_CodiceArticolo]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo_PKFatturaElettronicaBody_DettaglioLinee] FOREIGN KEY ([PKFatturaElettronicaBody_DettaglioLinee]) REFERENCES [XMLFatture].[FatturaElettronicaBody_DettaglioLinee] ([PKFatturaElettronicaBody_DettaglioLinee])
GO
