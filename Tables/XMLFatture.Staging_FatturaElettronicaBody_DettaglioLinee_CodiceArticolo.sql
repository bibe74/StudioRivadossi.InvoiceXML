CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo]
(
[PKStaging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo]),
[PKStaging_FatturaElettronicaBody_DettaglioLinee] [bigint] NOT NULL,
[CodiceArticolo_CodiceTipo] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceArticolo_CodiceValore] [nvarchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_CodiceArticolo_PKStaging_FatturaElettronicaBody_DettaglioLinee] FOREIGN KEY ([PKStaging_FatturaElettronicaBody_DettaglioLinee]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee] ([PKStaging_FatturaElettronicaBody_DettaglioLinee])
GO
