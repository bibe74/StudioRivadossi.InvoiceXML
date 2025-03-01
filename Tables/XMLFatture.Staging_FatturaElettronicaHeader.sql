CREATE TABLE [XMLFatture].[Staging_FatturaElettronicaHeader]
(
[PKStaging_FatturaElettronicaHeader] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaHeader] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Staging_FatturaElettronicaHeader]),
[PKLanding_Fattura] [bigint] NOT NULL,
[DataOraInserimento] [datetime2] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaHeader_DataOraInserimento] DEFAULT (getdate()),
[IsValida] [bit] NOT NULL CONSTRAINT [DFT_XMLFatture_Staging_FatturaElettronicaHeader_IsValida] DEFAULT ((0)),
[DataOraUltimaValidazione] [datetime2] NULL,
[DatiTrasmissione_IdTrasmittente_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_IdTrasmittente_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_ProgressivoInvio] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_FormatoTrasmissione] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_CodiceDestinatario] [nvarchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_ContattiTrasmittente_Telefono] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_ContattiTrasmittente_Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatiTrasmissione_PECDestinatario] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_CodiceFiscale] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_Titolo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_Anagrafica_CodEORI] [nvarchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_AlboProfessionale] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_ProvinciaAlbo] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_NumeroIscrizioneAlbo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_DatiAnagrafici_DataIscrizioneAlbo] [date] NULL,
[CedentePrestatore_DatiAnagrafici_RegimeFiscale] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Sede_Indirizzo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Sede_NumeroCivico] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Sede_CAP] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Sede_Comune] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Sede_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Sede_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_Indirizzo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_NumeroCivico] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_CAP] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_Comune] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_StabileOrganizzazione_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_IscrizioneREA_Ufficio] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_IscrizioneREA_NumeroREA] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_IscrizioneREA_CapitaleSociale] [decimal] (14, 2) NULL,
[CedentePrestatore_IscrizioneREA_SocioUnico] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_IscrizioneREA_StatoLiquidazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Contatti_Telefono] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Contatti_Fax] [nvarchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_Contatti_Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CedentePrestatore_RiferimentoAmministrazione] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_CodiceFiscale] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_Titolo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RappresentanteFiscale_DatiAnagrafici_Anagrafica_CodEORI] [nvarchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_DatiAnagrafici_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[CessionarioCommittente_Sede_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_Sede_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_Indirizzo] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_NumeroCivico] [nvarchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_CAP] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_Comune] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_Provincia] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_StabileOrganizzazione_Nazione] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_RappresentanteFiscale_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_RappresentanteFiscale_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_RappresentanteFiscale_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CessionarioCommittente_RappresentanteFiscale_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdPaese] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_IdFiscaleIVA_IdCodice] [nvarchar] (28) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_CodiceFiscale] [nvarchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Denominazione] [nvarchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Nome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Cognome] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_Titolo] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TerzoIntermediarioOSoggettoEmittente_DatiAnagrafici_Anagrafica_CodEORI] [nvarchar] (17) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SoggettoEmittente] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaHeader] ADD CONSTRAINT [PK_XMLFatture_Staging_FatturaElettronicaHeader] PRIMARY KEY CLUSTERED  ([PKStaging_FatturaElettronicaHeader]) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Staging_FatturaElettronicaHeader] ADD CONSTRAINT [FK_XMLFatture_Staging_FatturaElettronicaHeader_PKLanding_Fattura] FOREIGN KEY ([PKLanding_Fattura]) REFERENCES [XMLFatture].[Landing_Fattura] ([PKLanding_Fattura])
GO
