CREATE TABLE [dbo].[stgCodiceErroreEvento]
(
[PKEsitoEvento] [int] NOT NULL,
[CodiceErrore] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DescrizioneErrore] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
