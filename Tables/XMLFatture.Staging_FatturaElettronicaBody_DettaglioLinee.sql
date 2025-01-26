CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee]
(
[PKStaging_FatturaElettronicaBody_DettaglioLinee] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DettaglioLinee]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[NumeroLinea] [int] NULL,
[TipoCessionePrestazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Descrizione] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantita] [decimal] (20, 5) NULL,
[UnitaMisura] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataInizioPeriodo] [date] NULL,
[DataFinePeriodo] [date] NULL,
[PrezzoUnitario] [decimal] (20, 5) NULL,
[PrezzoTotale] [decimal] (20, 5) NULL,
[AliquotaIVA] [decimal] (5, 2) NULL,
[Ritenuta] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Natura] [varchar] (5) COLLATE Latin1_General_CI_AS NULL,
[RiferimentoAmministrazione] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DettaglioLinee]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_PKStaging_FatturaElettronicaBody_NumeroLinea] ON [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee] ([PKStaging_FatturaElettronicaBody], [NumeroLinea]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DettaglioLinee] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DettaglioLinee_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
