CREATE DATABASE ILagunaNetaSystem
GO

USE [ILagunaNetaSystem]
GO
/****** Object:  StoredProcedure [dbo].[CiudadGetByIdEstado]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CiudadGetByIdEstado] 
	@IdEstado INT
AS 
    SELECT 
	 IdCiudad,
	 Nombre,
	 IdEstado
	 	 
 FROM Ciudad
 WHERE IdEstado = @IdEstado
GO
/****** Object:  StoredProcedure [dbo].[ClienteAdd]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClienteAdd]
@Nombre VARCHAR (100),
@ApellidoPaterno VARCHAR (100),
@ApellidoMaterno VARCHAR (100),
@FechaNacimiento VARCHAR (50),
@Telefono VARCHAR (50),
@Celular VARCHAR (50),
@Email VARCHAR (254),
@Calle VARCHAR (100),
@NumeroExterior VARCHAR (50),
@NumeroInterior VARCHAR (50),
@IdColonia INT
AS

INSERT INTO Cliente (Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Telefono, Celular, Email)
VALUES (@Nombre, @ApellidoPaterno, @ApellidoMaterno, CONVERT(VARCHAR(50),@FechaNacimiento,105), @Telefono, @Celular, @Email)


INSERT INTO Domicilio(Calle, NumeroExterior, NumeroInterior, IdColonia, IdCliente)
VALUES (@Calle, @NumeroExterior, @NumeroInterior, @IdColonia, @@IDENTITY)
GO
/****** Object:  StoredProcedure [dbo].[ClienteDelete]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClienteDelete]
@IdCliente INT
AS

DELETE FROM Domicilio
WHERE IdCliente = @IdCliente
GO
/****** Object:  StoredProcedure [dbo].[ClienteGetAll]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClienteGetAll]
AS
	SELECT 
	Cliente.IdCliente,
	Cliente.Nombre,
	Cliente.ApellidoPaterno,
	Cliente.ApellidoMaterno,
	Cliente.FechaNacimiento,
	Cliente.Telefono,
	Cliente.Celular,
	Cliente.Email,
	Domicilio.IdDomicilio,
	Domicilio.Calle,
	Domicilio.NumeroExterior,
	Domicilio.NumeroInterior,
	Colonia.IdColonia,
	Colonia.Nombre AS NombreColonia,
	Colonia.CodigoPostal,
	Municipio.IdMunicipio,
	Municipio.Nombre AS NombreMunicipio,	
	Ciudad.IdCiudad,
	Ciudad.Nombre AS NombreCiudad,
	Estado.IdEstado,
	Estado.Nombre AS NombreEstado

	FROM Cliente
	INNER JOIN Domicilio ON Domicilio.IdCliente = Cliente.IdCliente
	INNER JOIN Colonia ON Domicilio.IdColonia = Colonia.IdColonia
	INNER JOIN Municipio ON Colonia.IdMunicipio = Municipio.IdMunicipio
	INNER JOIN Ciudad ON Municipio.IdCiudad = Ciudad.IdCiudad
	INNER JOIN Estado ON Ciudad.IdEstado = Estado.IdEstado
GO
/****** Object:  StoredProcedure [dbo].[ClienteGetAllBusqueda]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClienteGetAllBusqueda]
@Nombre VARCHAR (100),
@ApellidoPaterno VARCHAR (100),
@ApellidoMaterno VARCHAR (100),
@FechaNacimiento VARCHAR (50)
AS
IF(@Nombre='' AND @ApellidoPaterno='' AND @ApellidoMaterno='' AND @FechaNacimiento ='')
BEGIN
	SELECT 
	Cliente.IdCliente,
	Cliente.Nombre,
	Cliente.ApellidoPaterno,
	Cliente.ApellidoMaterno,
	Cliente.FechaNacimiento,
	Cliente.Telefono,
	Cliente.Celular,
	Cliente.Email,
	Domicilio.IdDomicilio,
	Domicilio.Calle,
	Domicilio.NumeroExterior,
	Domicilio.NumeroInterior,
	Colonia.IdColonia,
	Colonia.Nombre AS NombreColonia,
	Colonia.CodigoPostal,
	Municipio.IdMunicipio,
	Municipio.Nombre AS NombreMunicipio,	
	Ciudad.IdCiudad,
	Ciudad.Nombre AS NombreCiudad,
	Estado.IdEstado,
	Estado.Nombre AS NombreEstado

FROM Cliente
	INNER JOIN Domicilio ON Domicilio.IdCliente = Cliente.IdCliente
	INNER JOIN Colonia ON Domicilio.IdColonia = Colonia.IdColonia
	INNER JOIN Municipio ON Colonia.IdMunicipio = Municipio.IdMunicipio
	INNER JOIN Ciudad ON Municipio.IdCiudad = Ciudad.IdCiudad
	INNER JOIN Estado ON Ciudad.IdEstado = Estado.IdEstado

END	
ELSE
	
BEGIN
	SELECT 
	Cliente.IdCliente,
	Cliente.Nombre,
	Cliente.ApellidoPaterno,
	Cliente.ApellidoMaterno,
	Cliente.FechaNacimiento,
	Cliente.Telefono,
	Cliente.Celular,
	Cliente.Email,
	Domicilio.IdDomicilio,
	Domicilio.Calle,
	Domicilio.NumeroExterior,
	Domicilio.NumeroInterior,
	Colonia.IdColonia,
	Colonia.Nombre AS NombreColonia,
	Colonia.CodigoPostal,
	Municipio.IdMunicipio,
	Municipio.Nombre AS NombreMunicipio,	
	Ciudad.IdCiudad,
	Ciudad.Nombre AS NombreCiudad,
	Estado.IdEstado,
	Estado.Nombre AS NombreEstado

FROM Cliente
	INNER JOIN Domicilio ON Domicilio.IdCliente = Cliente.IdCliente
	INNER JOIN Colonia ON Domicilio.IdColonia = Colonia.IdColonia
	INNER JOIN Municipio ON Colonia.IdMunicipio = Municipio.IdMunicipio
	INNER JOIN Ciudad ON Municipio.IdCiudad = Ciudad.IdCiudad
	INNER JOIN Estado ON Ciudad.IdEstado = Estado.IdEstado

	WHERE Cliente.Nombre LIKE '%' +@Nombre+ '%'
	AND Cliente.ApellidoPaterno LIKE '%' +@ApellidoPaterno+ '%'
	AND Cliente.ApellidoMaterno LIKE '%' +@ApellidoMaterno+ '%'
	AND Cliente.FechaNacimiento LIKE '%' +@FechaNacimiento+ '%'
END
GO
/****** Object:  StoredProcedure [dbo].[ClienteGetById]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClienteGetById]
@IdCliente INT
AS	
SELECT 
	Cliente.IdCliente,
	Cliente.Nombre,
	Cliente.ApellidoPaterno,
	Cliente.ApellidoMaterno,
	Cliente.FechaNacimiento,
	Cliente.Telefono,
	Cliente.Celular,
	Cliente.Email,
	Domicilio.IdDomicilio,
	Domicilio.Calle,
	Domicilio.NumeroExterior,
	Domicilio.NumeroInterior,
	Colonia.IdColonia,
	Colonia.Nombre AS NombreColonia,
	Colonia.CodigoPostal,
	Municipio.IdMunicipio,
	Municipio.Nombre AS NombreMunicipio,	
	Ciudad.IdCiudad,
	Ciudad.Nombre AS NombreCiudad,
	Estado.IdEstado,
	Estado.Nombre AS NombreEstado

	FROM Cliente
	INNER JOIN Domicilio ON Domicilio.IdCliente = Cliente.IdCliente
	INNER JOIN Colonia ON Domicilio.IdColonia = Colonia.IdColonia
	INNER JOIN Municipio ON Colonia.IdMunicipio = Municipio.IdMunicipio
	INNER JOIN Ciudad ON Municipio.IdCiudad = Ciudad.IdCiudad
	INNER JOIN Estado ON Ciudad.IdEstado = Estado.IdEstado

		WHERE Cliente.IdCliente = @IdCliente
GO
/****** Object:  StoredProcedure [dbo].[ClienteUpdate]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ClienteUpdate]
@IdCliente INT,
@Nombre VARCHAR (100),
@ApellidoPaterno VARCHAR (100),
@ApellidoMaterno VARCHAR (100),
@FechaNacimiento VARCHAR (50),
@Telefono VARCHAR (50),
@Celular VARCHAR (50),
@Email VARCHAR (254),
@IdDomicilio INT,
@Calle VARCHAR (100),
@NumeroExterior VARCHAR (50),
@NumeroInterior VARCHAR (50),
@IdColonia INT
AS

	UPDATE Cliente
	SET [Nombre] = @Nombre,
		[ApellidoPaterno] = @ApellidoPaterno ,
		[ApellidoMaterno] = @ApellidoMaterno,
		[FechaNacimiento] = @FechaNacimiento,
		[Telefono] = @Telefono,
		[Celular] = @Celular,
		[Email] = @Email

		WHERE IdCliente = @IdCliente

	UPDATE Domicilio
	SET	   [Calle] = @Calle ,
		   [NumeroExterior] = @NumeroExterior,
		   [NumeroInterior] = @NumeroInterior,	
		   [IdColonia] = @IdColonia

	WHERE IdDomicilio = @IdDomicilio

GO
/****** Object:  StoredProcedure [dbo].[ColoniaGetByIdMunicipio]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ColoniaGetByIdMunicipio] 

@IdMunicipio INT
AS
	SELECT

	IdColonia,
	Nombre,
	CodigoPostal,
	IdMunicipio

	
	FROM Colonia

	WHERE IdMunicipio = @IdMunicipio
GO
/****** Object:  StoredProcedure [dbo].[EstadoGetAll]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EstadoGetAll]
AS
	SELECT 
	IdEstado,
	Nombre

	FROM Estado
GO
/****** Object:  StoredProcedure [dbo].[MunicipioGetByIdCiudad]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MunicipioGetByIdCiudad] 
@IdCiudad INT
AS
	SELECT

	IdMunicipio	,
	Nombre,
	IdCiudad

	FROM Municipio

WHERE IdCiudad = @IdCiudad
GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ciudad](
	[IdCiudad] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[IdEstado] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[ApellidoPaterno] [varchar](100) NOT NULL,
	[ApellidoMaterno] [varchar](100) NULL,
	[FechaNacimiento] [varchar](50) NOT NULL,
	[Telefono] [varchar](50) NULL,
	[Celular] [varchar](50) NULL,
	[Email] [varchar](254) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Colonia]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Colonia](
	[IdColonia] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[CodigoPostal] [varchar](100) NULL,
	[IdMunicipio] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdColonia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Domicilio]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Domicilio](
	[IdDomicilio] [int] IDENTITY(1,1) NOT NULL,
	[Calle] [varchar](100) NULL,
	[NumeroExterior] [varchar](50) NULL,
	[NumeroInterior] [varchar](50) NULL,
	[IdColonia] [int] NULL,
	[IdCliente] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDomicilio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estado](
	[IdEstado] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Municipio]    Script Date: 10/6/2022 8:19:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Municipio](
	[IdMunicipio] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[IdCiudad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMunicipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Ciudad] ON 

INSERT [dbo].[Ciudad] ([IdCiudad], [Nombre], [IdEstado]) VALUES (1, N'CDMX', 1)
INSERT [dbo].[Ciudad] ([IdCiudad], [Nombre], [IdEstado]) VALUES (2, N'Toluca', 2)
SET IDENTITY_INSERT [dbo].[Ciudad] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([IdCliente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaNacimiento], [Telefono], [Celular], [Email]) VALUES (1, N'Isac', N'Laguna', N'Sanchez', N'03-04-1997', N'55-34-21-10', N'55-76-21-20', N'ILaguna@gmail.com')
INSERT [dbo].[Cliente] ([IdCliente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaNacimiento], [Telefono], [Celular], [Email]) VALUES (3, N'Isac', N'Laguna', N'Sanchez', N'03-04-1997', N'55-34-21-10', N'55-76-21-20', N'ILaguna1@gmail.com')
INSERT [dbo].[Cliente] ([IdCliente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaNacimiento], [Telefono], [Celular], [Email]) VALUES (4, N'Andrea', N'Gutierrez', N'Vladez', N'10-11-2012', N'55-78-45-10', N'55-42-34-19', N'AGuty@gmail.com')
INSERT [dbo].[Cliente] ([IdCliente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaNacimiento], [Telefono], [Celular], [Email]) VALUES (5, N'Karen', N'Castillo', N'Mendoza', N'20-05-2001', N'55-32-11-66', N'55-89-21-34', N'KCastillo@gmail.com')
INSERT [dbo].[Cliente] ([IdCliente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaNacimiento], [Telefono], [Celular], [Email]) VALUES (6, N'Prueba1', N'Prueba1', N'Prueba1', N'06/10/2022', N'5555555', N'5555555', N'Prueba1@gmail.com')
INSERT [dbo].[Cliente] ([IdCliente], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaNacimiento], [Telefono], [Celular], [Email]) VALUES (8, N'Prueba 12', N'Prueba 12', N'Prueba 12', N'06-10-2022', N'5555', N'55552', N'Prueba120@gmail.com')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
SET IDENTITY_INSERT [dbo].[Colonia] ON 

INSERT [dbo].[Colonia] ([IdColonia], [Nombre], [CodigoPostal], [IdMunicipio]) VALUES (1, N'Col. Guerrero', N'60300', 1)
INSERT [dbo].[Colonia] ([IdColonia], [Nombre], [CodigoPostal], [IdMunicipio]) VALUES (2, N'Col. Ciudad Azteca', N'55120', 2)
SET IDENTITY_INSERT [dbo].[Colonia] OFF
SET IDENTITY_INSERT [dbo].[Domicilio] ON 

INSERT [dbo].[Domicilio] ([IdDomicilio], [Calle], [NumeroExterior], [NumeroInterior], [IdColonia], [IdCliente]) VALUES (3, N'Cholultecas MZ.624', N'S/N', N'S/N', 1, 3)
INSERT [dbo].[Domicilio] ([IdDomicilio], [Calle], [NumeroExterior], [NumeroInterior], [IdColonia], [IdCliente]) VALUES (4, N'Andador No.1', N'S/N', N'S/N', 2, 4)
SET IDENTITY_INSERT [dbo].[Domicilio] OFF
SET IDENTITY_INSERT [dbo].[Estado] ON 

INSERT [dbo].[Estado] ([IdEstado], [Nombre]) VALUES (1, N'Ciudad de México')
INSERT [dbo].[Estado] ([IdEstado], [Nombre]) VALUES (2, N'Estado de México')
SET IDENTITY_INSERT [dbo].[Estado] OFF
SET IDENTITY_INSERT [dbo].[Municipio] ON 

INSERT [dbo].[Municipio] ([IdMunicipio], [Nombre], [IdCiudad]) VALUES (1, N'Cuahtémoc', 1)
INSERT [dbo].[Municipio] ([IdMunicipio], [Nombre], [IdCiudad]) VALUES (2, N'Ecatepec', 2)
SET IDENTITY_INSERT [dbo].[Municipio] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Cliente__A9D105342DFBB099]    Script Date: 10/6/2022 8:19:34 PM ******/
ALTER TABLE [dbo].[Cliente] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Ciudad]  WITH CHECK ADD FOREIGN KEY([IdEstado])
REFERENCES [dbo].[Estado] ([IdEstado])
GO
ALTER TABLE [dbo].[Colonia]  WITH CHECK ADD FOREIGN KEY([IdMunicipio])
REFERENCES [dbo].[Municipio] ([IdMunicipio])
GO
ALTER TABLE [dbo].[Domicilio]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[Domicilio]  WITH CHECK ADD FOREIGN KEY([IdColonia])
REFERENCES [dbo].[Colonia] ([IdColonia])
GO
ALTER TABLE [dbo].[Municipio]  WITH CHECK ADD FOREIGN KEY([IdCiudad])
REFERENCES [dbo].[Ciudad] ([IdCiudad])
GO
