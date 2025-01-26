CREATE TABLE [XMLCodifiche].[CampiXML]
(
[NomeElementoRadice] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IndiceElemento] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeElemento] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NomeElementoFull] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TipoInfo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsElementoXML] [bit] NULL,
[FormatoElemento] [sys].[sysname] NULL,
[FormatoEstesoElemento] [sys].[sysname] NULL,
[DescrizioneFunzionale] [nvarchar] (600) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FormatoEValoriAmmessi] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ObbligatorietaEOccorrenze] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsObbligatorio] [bit] NULL,
[HasOccorrenzeMultiple] [bit] NULL,
[Dimensione] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ControlliExtraSchema] [nvarchar] (550) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CodiceDescrizioneErrore] [nvarchar] (650) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[CampiXML] ADD CONSTRAINT [PK_XMLCodifiche_CampiXML] PRIMARY KEY CLUSTERED  ([NomeElementoRadice], [IndiceElemento]) ON [PRIMARY]
GO
