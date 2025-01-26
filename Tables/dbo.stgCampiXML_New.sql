CREATE TABLE [dbo].[stgCampiXML_New]
(
[NomeElementoRadice] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IndiceElemento] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeElemento] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeTabella] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeElementoFull] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TipoInfo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DescrizioneFunzionale] [nvarchar] (600) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FormatoEValoriAmmessi] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ObbligatorietaEOccorrenze] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Dimensione] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Origine] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TabellaOrigine] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampoOrigine] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ControlliExtraSchema] [nvarchar] (550) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceDescrizioneErrore] [nvarchar] (650) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
