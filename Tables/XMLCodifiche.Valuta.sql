CREATE TABLE [XMLCodifiche].[Valuta]
(
[IDValuta] [char] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Valuta] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[Valuta] ADD CONSTRAINT [PK_XMLCodifiche_Valuta] PRIMARY KEY CLUSTERED  ([IDValuta]) ON [PRIMARY]
GO
