CREATE TABLE [XMLFatture].[FatturaElettronicaHeader]
(
[PKFatturaElettronicaHeader] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_FatturaElettronicaHeader]),
[PKLanding_Fattura] [bigint] NOT NULL,
[PKStaging_FatturaElettronicaHeader] [bigint] NOT NULL,
[DataOraInserimento] [datetime2] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_DataOraInserimento] DEFAULT (getdate()),
[IsEsportata] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_IsEsportata] DEFAULT ((0)),
[DataOraUltimaEsportazione] [datetime2] NULL,
[IsValidataDaSDI] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_IsValidataDaSDI] DEFAULT ((0)),
[DatiTrasmissione_IdTrasmittente_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_DatiTrasmissione_IdTrasmittente_IdPaese] DEFAULT (''),
[DatiTrasmissione_IdTrasmittente_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DatiTrasmissione_ProgressivoInvio] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DatiTrasmissione_FormatoTrasmissione] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_DatiTrasmissione_FormatoTrasmissione] DEFAULT (''),
[DatiTrasmissione_CodiceDestinatario] [nvarchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DatiTrasmissione_HasContattiTrasmittente] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_115_HasContattiTrasmittente] DEFAULT ((0)),
[DatiTrasmissione_ContattiTrasmittente_Telefono] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_ContattiTrasmittente_Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_PECDestinatario] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese] DEFAULT (''),
[CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CedentePrestatore_DatiAnagrafici_CodiceFiscale] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_Titolo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_CodEORI] [nvarchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_AlboProfessionale] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_ProvinciaAlbo] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_DatiAnagrafici_ProvinciaAlbo] DEFAULT (''),
[CedentePrestatore_DatiAnagrafici_NumeroIscrizioneAlbo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_DataIscrizioneAlbo] [date] NULL,
[CedentePrestatore_DatiAnagrafici_RegimeFiscale] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_CedentePrestatore_DatiAnagrafici_RegimeFiscale] DEFAULT (''),
[CedentePrestatore_Sede_Indirizzo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CedentePrestatore_Sede_NumeroCivico] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Sede_CAP] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CedentePrestatore_Sede_Comune] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Sede_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_Sede_Provincia] DEFAULT (''),
[CedentePrestatore_Sede_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_Sede_Nazione] DEFAULT (''),
[CedentePrestatore_HasStabileOrganizzazione] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_123_HasStabileOrganizzazione] DEFAULT ((0)),
[CedentePrestatore_StabileOrganizzazione_Indirizzo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_NumeroCivico] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_CAP] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_Comune] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_StabileOrganizzazione_Provincia] DEFAULT (''),
[CedentePrestatore_StabileOrganizzazione_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_StabileOrganizzazione_Nazione] DEFAULT (''),
[CedentePrestatore_HasIscrizioneREA] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_124_HasIscrizioneREA] DEFAULT ((0)),
[CedentePrestatore_IscrizioneREA_Ufficio] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_IscrizioneREA_Ufficio] DEFAULT (''),
[CedentePrestatore_IscrizioneREA_NumeroREA] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_IscrizioneREA_CapitaleSociale] [decimal] (14, 2) NULL,
[CedentePrestatore_IscrizioneREA_SocioUnico] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_CedentePrestatore_IscrizioneREA_SocioUnico] DEFAULT (''),
[CedentePrestatore_IscrizioneREA_StatoLiquidazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_CedentePrestatore_IscrizioneREA_StatoLiquidazione] DEFAULT (''),
[CedentePrestatore_HasContatti] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_125_HasContatti] DEFAULT ((0)),
[CedentePrestatore_Contatti_Telefono] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Contatti_Fax] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Contatti_Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_RiferimentoAmministrazione] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HasRappresentanteFiscale] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_13_HasRappresentanteFiscale] DEFAULT ((0)),
[RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese] DEFAULT (''),
[RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_CodiceFiscale] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_Titolo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_CodEORI] [nvarchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_DatiAnagrafici_HasIdFiscaleIVA] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_1411_HasIdFiscaleIVA] DEFAULT ((0)),
[CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese] DEFAULT (''),
[CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_DatiAnagrafici_CodiceFiscale] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_DatiAnagrafici_Anagrafica_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_DatiAnagrafici_Anagrafica_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_DatiAnagrafici_Anagrafica_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_DatiAnagrafici_Anagrafica_Titolo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_DatiAnagrafici_Anagrafica_CodEORI] [nvarchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_Sede_Indirizzo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_Sede_NumeroCivico] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_Sede_CAP] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_Sede_Comune] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_Sede_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CessionarioCommittente_Sede_Provincia] DEFAULT (''),
[CessionarioCommittente_Sede_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CessionarioCommittente_Sede_Nazione] DEFAULT (''),
[CessionarioCommittente_HasStabileOrganizzazione] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_143_HasStabileOrganizzazione] DEFAULT ((0)),
[CessionarioCommittente_StabileOrganizzazione_Indirizzo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_NumeroCivico] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_CAP] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_Comune] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CessionarioCommittente_StabileOrganizzazione_Provincia] DEFAULT (''),
[CessionarioCommittente_StabileOrganizzazione_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CessionarioCommittente_StabileOrganizzazione_Nazione] DEFAULT (''),
[CessionarioCommittente_HasRappresentanteFiscale] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_144_HasRappresentanteFiscale] DEFAULT ((0)),
[CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese] DEFAULT (''),
[CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_RappresentanteFiscale_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_RappresentanteFiscale_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_RappresentanteFiscale_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HasTerzoIntermediarioOSoggettoEmittente] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_15_HasTerzoIntermediarioOSoggettoEmittente] DEFAULT ((0)),
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_HasIdFiscaleIVA] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_1511_HasIdFiscaleIVA] DEFAULT ((0)),
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese] DEFAULT (''),
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Titolo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_CodEORI] [nvarchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SoggettoEmittente] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DFT_XMLFatture_FatturaElettronicaHeader_CedentePrestatore_SoggettoEmittente] DEFAULT (''),
[XMLOutput] [xml] NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [PK_XMLFatture_FatturaElettronicaHeader] PRIMARY KEY CLUSTERED  ([PKFatturaElettronicaHeader]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_1_SoggettoEmittente] FOREIGN KEY ([SoggettoEmittente]) REFERENCES [XMLCodifiche].[SoggettoEmittente] ([IDSoggettoEmittente])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_11_FormatoTrasmissione] FOREIGN KEY ([DatiTrasmissione_FormatoTrasmissione]) REFERENCES [XMLCodifiche].[FormatoTrasmissione] ([IDFormatoTrasmissione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_111_IdPaese] FOREIGN KEY ([DatiTrasmissione_IdTrasmittente_IdPaese]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_121_ProvinciaAlbo] FOREIGN KEY ([CedentePrestatore_DatiAnagrafici_ProvinciaAlbo]) REFERENCES [XMLCodifiche].[Provincia] ([IDProvincia])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_1211_IdPaese] FOREIGN KEY ([CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_122_Nazione] FOREIGN KEY ([CedentePrestatore_Sede_Nazione]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_122_Provincia] FOREIGN KEY ([CedentePrestatore_Sede_Provincia]) REFERENCES [XMLCodifiche].[Provincia] ([IDProvincia])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_123_Nazione] FOREIGN KEY ([CedentePrestatore_StabileOrganizzazione_Nazione]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_123_Provincia] FOREIGN KEY ([CedentePrestatore_StabileOrganizzazione_Provincia]) REFERENCES [XMLCodifiche].[Provincia] ([IDProvincia])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_124_SocioUnico] FOREIGN KEY ([CedentePrestatore_IscrizioneREA_SocioUnico]) REFERENCES [XMLCodifiche].[SocioUnico] ([IDSocioUnico])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_124_StatoLiquidazione] FOREIGN KEY ([CedentePrestatore_IscrizioneREA_StatoLiquidazione]) REFERENCES [XMLCodifiche].[StatoLiquidazione] ([IDStatoLiquidazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_124_Ufficio] FOREIGN KEY ([CedentePrestatore_IscrizioneREA_Ufficio]) REFERENCES [XMLCodifiche].[Provincia] ([IDProvincia])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_1311_IdPaese] FOREIGN KEY ([RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_1411_IdPaese] FOREIGN KEY ([CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_142_Nazione] FOREIGN KEY ([CessionarioCommittente_Sede_Nazione]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_142_Provincia] FOREIGN KEY ([CessionarioCommittente_Sede_Provincia]) REFERENCES [XMLCodifiche].[Provincia] ([IDProvincia])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_143_Nazione] FOREIGN KEY ([CessionarioCommittente_StabileOrganizzazione_Nazione]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_143_Provincia] FOREIGN KEY ([CessionarioCommittente_StabileOrganizzazione_Provincia]) REFERENCES [XMLCodifiche].[Provincia] ([IDProvincia])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_1441_IdPaese] FOREIGN KEY ([CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_1511_IdPaese] FOREIGN KEY ([TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese]) REFERENCES [XMLCodifiche].[Nazione] ([IDNazione])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_PKLanding_Fattura] FOREIGN KEY ([PKLanding_Fattura]) REFERENCES [XMLFatture].[Landing_Fattura] ([PKLanding_Fattura])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_PKStaging_FatturaElettronicaHeader] FOREIGN KEY ([PKStaging_FatturaElettronicaHeader]) REFERENCES [XMLFatture].[Staging_FatturaElettronicaHeader] ([PKStaging_FatturaElettronicaHeader])
GO
ALTER TABLE [XMLFatture].[FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_FatturaElettronicaHeader_RegimeFiscale] FOREIGN KEY ([CedentePrestatore_DatiAnagrafici_RegimeFiscale]) REFERENCES [XMLCodifiche].[RegimeFiscale] ([IDRegimeFiscale])
GO
