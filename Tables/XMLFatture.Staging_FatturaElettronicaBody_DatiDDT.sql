CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiDDT]
(
[PKStaging_FatturaElettronicaBody_DatiDDT] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DatiDDT] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DatiDDT]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[NumeroDDT] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataDDT] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiDDT] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DatiDDT] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DatiDDT]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiDDT] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DatiDDT_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
