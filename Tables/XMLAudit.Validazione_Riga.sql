CREATE TABLE [XMLAudit].[Validazione_Riga]
(
[PKValidazione_Riga] [bigint] NOT NULL CONSTRAINT [DFT_XMLAudit_Validazione_Riga_PKValidazione_Riga] DEFAULT (NEXT VALUE FOR [XMLAudit].[seq_Validazione_Riga]),
[PKValidazione] [bigint] NOT NULL,
[Campo] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ValoreTesto] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ValoreIntero] [int] NULL,
[ValoreDecimale] [decimal] (28, 12) NULL,
[ValoreData] [datetime2] NULL,
[Messaggio] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LivelloLog] [tinyint] NOT NULL CONSTRAINT [DFT_XMLAudit_Validazione_Riga_LivelloLog] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[Validazione_Riga] ADD CONSTRAINT [PK_XMLAudit_Validazione_Riga] PRIMARY KEY CLUSTERED ([PKValidazione_Riga]) ON [PRIMARY]
GO
ALTER TABLE [XMLAudit].[Validazione_Riga] ADD CONSTRAINT [FK_XMLAudit_Validazione_Riga_PKValidazione] FOREIGN KEY ([PKValidazione]) REFERENCES [XMLAudit].[Validazione] ([PKValidazione])
GO
