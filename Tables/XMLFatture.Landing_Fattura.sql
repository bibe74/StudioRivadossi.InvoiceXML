CREATE TABLE [XMLFatture].[Landing_Fattura]
(
[PKLanding_Fattura] [bigint] NOT NULL CONSTRAINT [DFT_XMLFatture_Landing_Fattura_PKLanding_Fattura] DEFAULT (NEXT VALUE FOR [XMLFatture].[seq_Landing_Fattura]),
[ChiaveGestionale_CodiceNumerico] [bigint] NOT NULL,
[ChiaveGestionale_CodiceAlfanumerico] [nvarchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsUltimaRevisione] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [XMLFatture].[Landing_Fattura] ADD CONSTRAINT [PK_XMLFatture_Landing_Fattura] PRIMARY KEY CLUSTERED  ([PKLanding_Fattura]) ON [PRIMARY]
GO
