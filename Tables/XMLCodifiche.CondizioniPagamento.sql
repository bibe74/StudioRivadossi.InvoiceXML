CREATE TABLE [XMLCodifiche].[CondizioniPagamento]
(
[IDCondizioniPagamento] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CondizioniPagamento] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[CondizioniPagamento] ADD CONSTRAINT [PK_XMLCodifiche_CondizioniPagamento] PRIMARY KEY CLUSTERED  ([IDCondizioniPagamento]) ON [PRIMARY]
GO
