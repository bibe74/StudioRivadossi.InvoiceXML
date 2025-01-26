CREATE TABLE [dbo].[Versioni]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Tipo] [char] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Data] [datetime] NULL,
[Major] [int] NULL,
[Minor] [int] NULL,
[Build] [int] NULL,
[Revision] [int] NULL,
[Bin] [varbinary] (max) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Versioni] ADD CONSTRAINT [PK_Versioni] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
