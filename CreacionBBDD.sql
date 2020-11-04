USE master
DROP DATABASE ApuestasF1
CREATE DATABASE ApuestasF1
GO
USE ApuestasF1
GO

CREATE TABLE Usuarios (
    ID SMALLINT IDENTITY (1,1) NOT NULL CONSTRAINT PK_Usuarios PRIMARY KEY
    ,Nombre VARCHAR(30) NOT NULL
    ,Saldo SMALLMONEY NOT NULL CONSTRAINT CK_Saldo CHECK (Saldo >= 0)
    ,Email VARCHAR(50) NOT NULL CONSTRAINT CK_Email CHECK (Email LIKE '%_@__%.__%') CONSTRAINT UQ_Email UNIQUE (Email)
    ,Contraseña VARCHAR(30) NOT NULL
)

CREATE TABLE Transacciones (
    ID INT IDENTITY (1,1) NOT NULL CONSTRAINT PK_Transacciones PRIMARY KEY --> Cambio a INT, se van a generar bastantes
    ,IDUsuario SMALLINT NOT NULL CONSTRAINT FK_Transacciones FOREIGN KEY REFERENCES Usuarios(ID) ON DELETE CASCADE ON UPDATE CASCADE
    ,Fecha DATETIME NOT NULL
    ,Importe SMALLMONEY NOT NULL
    ,Concepto VARCHAR(100) NULL
)

CREATE TABLE Pilotos(
	ID INT IDENTITY (1,1) NOT NULL CONSTRAINT PK_Pilotos PRIMARY KEY
    ,Numero TINYINT NOT NULL CONSTRAINT CK_Numero CHECK (Numero BETWEEN 1 AND 99)
    ,Nombre VARCHAR(30) NOT NULL
    ,Apellido VARCHAR(50) NOT NULL
    ,Siglas CHAR(3) NOT NULL
    ,Escuderia CHAR(3) NOT NULL
)

CREATE TABLE Carreras (
    Codigo SMALLINT IDENTITY (1,1) NOT NULL CONSTRAINT PK_Carreras PRIMARY KEY 
	,Circuito VARCHAR(20) NOT NULL
	,[Fecha y Hora Inicio] DATETIME NOT NULL
	,[Fecha y Hora Fin] DATETIME
	,[Num vueltas] TINYINT NOT NULL
)

CREATE TABLE PilotosCarreras(
	 [ID Piloto] INT NOT NULL CONSTRAINT FK_CodigoPiloto FOREIGN KEY REFERENCES Pilotos(ID) ON DELETE CASCADE ON UPDATE CASCADE
	,[Codigo Carrera] SMALLINT NOT NULL CONSTRAINT FK_CodigoCarrera FOREIGN KEY REFERENCES Carreras(Codigo) ON DELETE CASCADE ON UPDATE CASCADE
	,PRIMARY KEY ([ID Piloto], [Codigo Carrera])
	,Posicion TINYINT NULL CONSTRAINT CK_Posicion CHECK (Posicion BETWEEN 1 AND 24)
	,[Vuelta rapida] TIME NULL
)

CREATE TABLE Apuestas (
	[ID Apuesta] INT IDENTITY (1,1) NOT NULL CONSTRAINT PK_Apuestas PRIMARY KEY
	,[ID Usuario] SMALLINT NOT NULL CONSTRAINT FK_ApuestasUsuarios FOREIGN KEY REFERENCES Usuarios(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
	,[Codigo Carrera] SMALLINT NOT NULL CONSTRAINT FK_ApuestasCarreras FOREIGN KEY REFERENCES Carreras(Codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
	,[ID Piloto1] INT NOT NULL CONSTRAINT FK_ApuestasPilotos1 FOREIGN KEY REFERENCES Pilotos(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
	,[ID Piloto2] INT NULL CONSTRAINT FK_ApuestasPilotos2 FOREIGN KEY REFERENCES Pilotos(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
	,[ID Piloto3] INT NULL CONSTRAINT FK_ApuestasPilotos3 FOREIGN KEY REFERENCES Pilotos(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
	,Tipo TINYINT  NOT NULL CONSTRAINT CK_Tipo CHECK (Tipo BETWEEN 1 AND 3) --	-1. Posicion de un piloto 
																			--	-2. Piloto que hace la vuelta rapida
																			--	-3. Podium (primeros tres pilotos sin orden)

	,Momento SMALLDATETIME NOT NULL
	,Importe SMALLMONEY NOT NULL
	,Cuota DECIMAL(4,2) NOT NULL CONSTRAINT CK_Cuota CHECK (Cuota > 1)
)

GO


