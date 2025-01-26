CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiCassaPrevidenziale]
(
[PKStaging_FatturaElettronicaBody_DatiCassaPrevidenziale] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaBody_DatiCassaPrevidenziale] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaBody_DatiCassaPrevidenziale]),
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[TipoCassa] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AlCassa] [decimal] (5, 2) NULL,
[ImportoContributoCassa] [decimal] (14, 2) NULL,
[ImponibileCassa] [decimal] (14, 2) NULL,
[AliquotaIVA] [decimal] (5, 2) NULL,
[Ritenuta] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Natura] [varchar] (5) COLLATE Latin1_General_CI_AS NULL,
[RiferimentoAmministrazione] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiCassaPrevidenziale] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaBody_DatiCassaPrevidenziale] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaBody_DatiCassaPrevidenziale]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaBody_DatiCassaPrevidenziale] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaBody_DatiCassaPrevidenziale_PKStaging_FatturaElettronicaBody] FOREIGN KEY ([PKStaging_FatturaElettronicaBody]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaBody] ([PKStaging_FatturaElettronicaBody])
GO
