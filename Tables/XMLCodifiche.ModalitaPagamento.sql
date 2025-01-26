CREATE TABLE [XMLCodifiche].[ModalitaPagamento]
(
[IDModalitaPagamento] [char] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModalitaPagamento] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLCodifiche].[ModalitaPagamento] ADD CONSTRAINT [PK_XMLCodifiche_ModalitaPagamento] PRIMARY KEY CLUSTERED  ([IDModalitaPagamento]) ON [PRIMARY]
GO
