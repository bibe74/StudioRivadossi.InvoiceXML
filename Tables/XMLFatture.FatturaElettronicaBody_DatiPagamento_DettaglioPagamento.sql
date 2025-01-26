CREATE TABLE [XMLFatture].[FatturaElettronicaBody_DatiPagamento_DettaglioPagamento]
(
[PKFatturaElettronicaBody_DatiPagamento_DettaglioPagamento] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiPagamento_DettaglioPagamento] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody_DatiPagamento_DettaglioPagamento]),
[PKFatturaElettronicaBody_DatiPagamento] [bigint] NOT NULL,
[Beneficiario] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModalitaPagamento] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DataRiferimentoTerminiPagamento] [date] NULL,
[GiorniTerminiPagamento] [int] NULL,
[DataScadenzaPagamento] [date] NULL,
[ImportoPagamento] [decimal] (14, 2) NOT NULL,
[CodUfficioPostale] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CognomeQuietanzante] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NomeQuietanzante] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CFQuietanzante] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TitoloQuietanzante] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IstitutoFinanziario] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IBAN] [nvarchar] (34) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ABI] [int] NULL,
[CAB] [int] NULL,
[BIC] [nvarchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ScontoPagamentoAnticipato] [decimal] (14, 2) NULL,
[DataLimitePagamentoAnticipato] [date] NULL,
[PenalitaPagamentiRitardati] [decimal] (14, 2) NULL,
[DataDecorrenzaPenale] [date] NULL,
[CodicePagamento] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiPagamento_DettaglioPagamento] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody_DatiPagamento_DettaglioPagamento] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody_DatiPagamento_DettaglioPagamento]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiPagamento_DettaglioPagamento] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioPagamento_ModalitaPagamento] FOREIGN KEY ([ModalitaPagamento]) REFERENCES [XMLCodifiche].[ModalitaPagamento] ([IDModalitaPagamento])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody_DatiPagamento_DettaglioPagamento] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_DettaglioPagamento_PKFatturaElettronicaBody_DatiPagamento] FOREIGN KEY ([PKFatturaElettronicaBody_DatiPagamento]) REFERENCES [XMLFatture].[FatturaElettronicaBody_DatiPagamento] ([PKFatturaElettronicaBody_DatiPagamento])
GO
