CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DatiSAL]
(
[PKFatturaElettronicaBody_DatiSAL] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiSAL] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DatiSAL]),
[PKFatturaElettronicaBody] [bigint] NOT NULL,
[RiferimentoFase] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiSAL] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DatiSAL] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DatiSAL]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiSAL] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DatiSAL_PKFatturaElettronicaBody] FOREIGN KEY ([PKFatturaElettronicaBody]) REFERENCES [XMLFatture].[FatturaElettronicaBody] ([PKFatturaElettronicaBody])
GO
