CREATE TABLE [XMLFatture].[FatturaElettronicaBody]
(
[PKFatturaElettronicaBody] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaBody]),
[PKFatturaElettronicaHeader] [bigint] NOT NULL,
[PKStaging_FatturaElettronicaBody] [bigint] NOT NULL,
[DatiGenerali_DatiGeneraliDocumento_TipoDocumento] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiGeneraliDocumento_TipoDocumento] DEFAULT (''),
[DatiGenerali_DatiGeneraliDocumento_Divisa] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiGeneraliDocumento_Divisa] DEFAULT (''),
[DatiGenerali_DatiGeneraliDocumento_Data] [date] NOT NULL,
[DatiGenerali_DatiGeneraliDocumento_Numero] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DatiGenerali_DatiGeneraliDocumento_HasDatiRitenuta] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_2115_DatiRitenuta] DEFAULT ((0)),
[DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta] DEFAULT (''),
[DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_ImportoRitenuta] [decimal] (14, 2) NULL,
[DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_AliquotaRitenuta] [decimal] (5, 2) NULL,
[DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento] DEFAULT (''),
[DatiGenerali_DatiGeneraliDocumento_HasDatiBollo] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_2116_DatiBollo] DEFAULT ((0)),
[DatiGenerali_DatiGeneraliDocumento_DatiBollo_BolloVirtuale] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiGeneraliDocumento_DatiBollo_ImportoBollo] [decimal] (14, 2) NULL,
[DatiGenerali_DatiGeneraliDocumento_ImportoTotaleDocumento] [decimal] (14, 2) NULL,
[DatiGenerali_DatiGeneraliDocumento_Arrotondamento] [decimal] (14, 2) NULL,
[DatiGenerali_DatiGeneraliDocumento_Art73] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiGeneraliDocumento_Art73] DEFAULT (''),
[DatiGenerali_HasDatiTrasporto] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_219_DatiTrasporto] DEFAULT ((0)),
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese] DEFAULT (''),
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_CodiceFiscale] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_Titolo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_Anagrafica_CodEORI] [nvarchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_NumeroLicenzaGuida] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_MezzoTrasporto] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_CausaleTrasporto] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_NumeroColli] [int] NULL,
[DatiGenerali_DatiTrasporto_Descrizione] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_UnitaMisuraPeso] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_PesoLordo] [decimal] (6, 2) NULL,
[DatiGenerali_DatiTrasporto_PesoNetto] [decimal] (6, 2) NULL,
[DatiGenerali_DatiTrasporto_DataOraRitiro] [datetime] NULL,
[DatiGenerali_DatiTrasporto_DataInizioTrasporto] [date] NULL,
[DatiGenerali_DatiTrasporto_TipoResa] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiTrasporto_TipoResa] DEFAULT (''),
[DatiGenerali_DatiTrasporto_HasIndirizzoResa] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_21912_IndirizzoResa] DEFAULT ((0)),
[DatiGenerali_DatiTrasporto_IndirizzoResa_Indirizzo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_IndirizzoResa_NumeroCivico] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_IndirizzoResa_CAP] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_IndirizzoResa_Comune] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia] DEFAULT (''),
[DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione] DEFAULT (''),
[DatiGenerali_DatiTrasporto_DataOraConsegna] [datetime] NULL,
[DatiGenerali_HasFatturaPrincipale] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_2110_FatturaPrincipale] DEFAULT ((0)),
[DatiGenerali_FatturaPrincipale_NumeroFatturaPrincipale] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiGenerali_FatturaPrincipale_DataFatturaPrincipale] [date] NULL,
[DatiGenerali_HasDatiVeicoli] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaBody_23_DatiVeicoli] DEFAULT ((0)),
[DatiVeicoli_Data] [date] NULL,
[DatiVeicoli_TotalePercorso] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaBody] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaBody]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronica_21912_Nazione] FOREIGN KEY ([DatiGenerali_DatiTrasporto_IndirizzoResa_Nazione]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_21_Art73] FOREIGN KEY ([DatiGenerali_DatiGeneraliDocumento_Art73]) REFERENCES [XMLCodifiche].[RispostaSI] ([IDRispostaSI])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_211_Divisa] FOREIGN KEY ([DatiGenerali_DatiGeneraliDocumento_Divisa]) REFERENCES [XMLCodifiche].[Valuta] ([IDValuta])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_211_TipoDocumento] FOREIGN KEY ([DatiGenerali_DatiGeneraliDocumento_TipoDocumento]) REFERENCES [XMLCodifiche].[TipoDocumento] ([IDTipoDocumento])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_2115_CausalePagamento] FOREIGN KEY ([DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_CausalePagamento]) REFERENCES [XMLCodifiche].[CausalePagamento] ([IDCausalePagamento])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_2115_TipoRitenuta] FOREIGN KEY ([DatiGenerali_DatiGeneraliDocumento_DatiRitenuta_TipoRitenuta]) REFERENCES [XMLCodifiche].[TipoRitenuta] ([IDTipoRitenuta])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_219_TipoResa] FOREIGN KEY ([DatiGenerali_DatiTrasporto_TipoResa]) REFERENCES [XMLCodifiche].[TipoResa] ([IDTipoResa])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_21911_IdPaese] FOREIGN KEY ([DatiGenerali_DatiTrasporto_DatiAnagraficiVettore_IdFiscaleIVA_IdPaese]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_21912_Provincia] FOREIGN KEY ([DatiGenerali_DatiTrasporto_IndirizzoResa_Provincia]) REFERENCES [XMLCodifiche].[Provincia] ([IDProvincia])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaBody] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaBody_PKFatturaElettronicaHeader] FOREIGN KEY ([PKFatturaElettronicaHeader]) REFERENCES [XMLFatture].[FatturaElettronicaHeader] ([PKFatturaElettronicaHeader])
GO
