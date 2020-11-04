CREATE DATABASE ApuestasF1
GO
USE ApuestasF1
GO

---------------TABLAS----------------

CREATE TABLE Usuarios (
    ID SMALLINT NOT NULL CONSTRAINT PK_Usuarios PRIMARY KEY
    ,Nombre VARCHAR(30) NOT NULL
    ,Saldo SMALLMONEY NOT NULL
    ,Email VARCHAR(50) NOT NULL CONSTRAINT CK_Email CHECK (Email LIKE '%_@__%.__%')
    ,Contrasenha VARCHAR(30) NOT NULL
)

CREATE TABLE Transacciones (
    ID SMALLINT NOT NULL CONSTRAINT PK_Transacciones PRIMARY KEY
    ,IDUsuario SMALLINT NOT NULL CONSTRAINT FK_Transacciones FOREIGN KEY REFERENCES Usuarios(ID) ON DELETE CASCADE ON UPDATE CASCADE
    ,Fecha DATETIME NOT NULL
    ,Importe SMALLMONEY NOT NULL
    ,Concepto VARCHAR(100) NULL
)

CREATE TABLE Pilotos(
    Numero TINYINT NOT NULL CONSTRAINT PK_Pilotos PRIMARY KEY
    ,Nombre VARCHAR(30) NOT NULL
    ,Apellido VARCHAR(50) NOT NULL
    ,Siglas CHAR(3) NOT NULL
    ,Escuder�a CHAR(3) NOT NULL
)

CREATE TABLE Carreras (
    C�digo SMALLINT NOT NULL CONSTRAINT PK_Carreras PRIMARY KEY 
	,Circuito VARCHAR(20) NOT NULL
	,[Fecha y Hora Fin] DATETIME NOT NULL
	,[N� vueltas] TINYINT NOT NULL
)

CREATE TABLE PilotoCarreras(
	 [Numero Piloto] TINYINT NOT NULL CONSTRAINT FK_C�digoPiloto FOREIGN KEY REFERENCES Pilotos(Numero) ON DELETE CASCADE ON UPDATE CASCADE
	,[C�digo Carrera] SMALLINT NOT NULL CONSTRAINT FK_C�digoCarrera FOREIGN KEY REFERENCES Carreras(C�digo) ON DELETE CASCADE ON UPDATE CASCADE
	,PRIMARY KEY ([Numero Piloto], [C�digo Carrera])
	,Posici�n TINYINT NULL
	,[Vuelta r�pida] TIME NULL
)

CREATE TABLE Apuestas (
	[ID Apuesta] INT NOT NULL CONSTRAINT PK_Apuestas PRIMARY KEY
	,[ID Usuario] SMALLINT NOT NULL CONSTRAINT FK_ApuestasUsuarios FOREIGN KEY REFERENCES Usuarios(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
	,[C�digo Carrera] SMALLINT NOT NULL CONSTRAINT FK_ApuestasCarreras FOREIGN KEY REFERENCES Carreras(C�digo) ON DELETE NO ACTION ON UPDATE NO ACTION
	,[C�digo Piloto1] TINYINT NOT NULL CONSTRAINT FK_ApuestasPilotos1 FOREIGN KEY REFERENCES Pilotos(Numero) ON DELETE NO ACTION ON UPDATE NO ACTION
	,[C�digo Piloto2] TINYINT NULL CONSTRAINT FK_ApuestasPilotos2 FOREIGN KEY REFERENCES Pilotos(Numero) ON DELETE NO ACTION ON UPDATE NO ACTION
	,[C�digo Piloto3] TINYINT NULL CONSTRAINT FK_ApuestasPilotos3 FOREIGN KEY REFERENCES Pilotos(Numero) ON DELETE NO ACTION ON UPDATE NO ACTION
	,Tipo TINYINT  NOT NULL CONSTRAINT CK_Tipo CHECK (Tipo BETWEEN 1 AND 3)
	,Momento SMALLDATETIME NOT NULL
	,Importe SMALLMONEY NOT NULL
	,Cuota DECIMAL(4,2) NOT NULL
)

GO


----------------------------------------PROCEDIMIENTOS Y FUNCIONES--------------------------------------

--PROCEDIMIENTOS DE INSERCI�N DE DATOS

--Nombre: InscribirUsuario
--Descripci�n: Inscribe un usuario en nuestra BBDD
--Entrada: Nombre, email y contrase�a
--Salida: Un nuevo usuario

CREATE OR ALTER PROCEDURE InscribirUsuario 
	@Id SMALLINT,
	@Nombre VARCHAR(30),
	@email VARCHAR(50),
	@Contrase�a VARCHAR(30)
AS BEGIN
	BEGIN TRANSACTION
		SELECT @Id = MAX(ID) FROM Usuarios
		SET @Id = @Id + 1
		INSERT INTO Usuarios VALUES (@Id, @Nombre, 0, @email, @Contrase�a)
	COMMIT
END

GO

--Nombre: InscribirPiloto
--Descripci�n: Inscribe un piloto en nuestra BBDD
--Entrada: Numero, Nombre, Apellido, Siglas y Escuuderia
--Salida: Un nuevo piloto

CREATE OR ALTER PROCEDURE InscribirPiloto
	@Numero TINYINT,
	@Nombre VARCHAR(30),
	@Apellido VARCHAR(50),
	@Siglas CHAR(3),
	@Escuderia CHAR(3)
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Pilotos VALUES (@Numero, @Nombre, @Apellido, @Siglas, @Escuderia)
	COMMIT
END
GO

--Nombre: A�adirCarrera
--Descripci�n: A�ade una carrera a nuestra BBDD
--Entradas: C�digo de carrera, Nombre del circuito, fecha y hora en la que se realiza y n�mero de vueltas
--Salida: Una nueva carrera

CREATE OR ALTER PROCEDURE A�adirCarrera
	@Codigo SMALLINT,
	@Circuito VARCHAR(20),
	@FechaHora DATETIME,
	@Vueltas TINYINT
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Carreras VALUES (@Codigo, @Circuito, @FechaHora, @Vueltas)
	COMMIT
END

GO

--Nombre: GenerarTransaccion
--Descripci�n: A�ade una transacci�n a nuestra BBDD
--Entradas: ID, IdUsuario, Importe, Concepto
--Salida: Una nueva transacci�n

CREATE OR ALTER PROCEDURE GenerarTransaccion
	@IDUsuario SMALLINT,
	@Momento DATETIME,
	@Importe SMALLMONEY,
	@Concepto VARCHAR(100)
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Transacciones VALUES (@IDUsuario, @Momento, @Importe, @Concepto)
	COMMIT
END

GO

--FUNCION DE ASIGNACI�N DE LA CUOTA

--Nombre: AsignarCuota
--Descripci�n: Asigna una cuota de apuesta en funci�n de las apuestas ya realizadas y los paramentros de entrada
--Entradas: circuito, piloto/pilotos por los que se apuesta, tipo de apuesta, momento
--Salida: Un valor del tipo DECIMAL(4,2) que indica lo segura o arriesgada que es la apuesta y por lo tanto su beneficio en caso de ser acertada

--Vista auxiliar para obtener un valor Random
CREATE OR ALTER VIEW F1_ValorRandom 
AS 
SELECT RAND() AS Valor 
GO

CREATE OR ALTER FUNCTION AsignarCuota (
	@CodigoCarrera SMALLINT, 
	@CodigoPiloto1 TINYINT, 
	@CodigoPiloto2 TINYINT,
	@CodigoPiloto3 TINYINT,
	@TipoApuesta TINYINT,
	@Momento SMALLDATETIME) 
RETURNS DECIMAL(4,2) AS
BEGIN
	DECLARE @Cuota DECIMAL (4,2)

	--SET @CUOTA = RAND()			--Da error ya que no se puede llamar a una funcion no determinada desde una funcion creada, la solucion es crear una vista  
	SET @CUOTA = (SELECT Valor FROM F1_ValorRandom) 

	RETURN @Cuota
END

GO

--RESTO DE PROCEDIMIENTOS

--Nombre: ModificarSaldo
--Descripci�n: modifica el saldo de un usuario dado
--Entradas: Usuario, importe, concepto
--Salida: Modificaci�n correspondiente del saldo del usuario dado y genera la transacci�n adecuada

CREATE OR ALTER PROCEDURE ModificarSaldo
	@Usuario SMALLINT,
	@Importe SMALLMONEY,
	@Concepto VARCHAR (100)
AS BEGIN
	BEGIN TRANSACTION
		DECLARE @Saldo SMALLMONEY
		DECLARE @Momento DATETIME

		SELECT @Saldo = Saldo FROM Usuarios
			WHERE @Usuario=ID
		SET @Saldo = @Saldo + @Importe

		UPDATE Usuarios 
		SET Saldo=@Saldo
		WHERE @Usuario=ID

		SET @Momento = CURRENT_TIMESTAMP

		EXECUTE GenerarTransaccion @Usuario, @Momento, @Importe, @Concepto

	COMMIT
END

GO

--Nombre: GrabarApuestas
--Descripci�n: Graba una apuesta en la base de datos
--Entradas: tipo de apuesta, piloto/pilotos por los que se apuesta, circuito, importe
--Salida: Inserci�n de datos en la tabla apuestas y 
--			reducci�n de saldo correspondiente en la tabla jugadores.

CREATE OR ALTER PROCEDURE GrabarApuestas 
	@IdUsuario SMALLINT,
	@IdCarrera SMALLINT,
	@TipoApuesta TINYINT,
	@Piloto1 TINYINT,
	@Piloto2 TINYINT NULL,
	@Piloto3 TINYINT NULL,
	@Importe SMALLMONEY
AS BEGIN	
	BEGIN TRANSACTION
		DECLARE @IdApuesta INT
		DECLARE @Momento SMALLDATETIME
	
		SELECT @IdApuesta = MAX ([ID Apuesta]) FROM Apuestas
		SET @IdApuesta = @IdApuesta + 1
		SET @Momento = CURRENT_TIMESTAMP

		INSERT INTO Apuestas VALUES (	@IdApuesta, 
										@IdUsuario, 
										@IdCarrera, 
										@Piloto1, @Piloto2, @Piloto3, 
										@TipoApuesta, 
										@Momento, 
										@Importe, 
										dbo.AsignarCuota(@IdCarrera, @Piloto1, @Piloto2, @Piloto3, @TipoApuesta, @Momento))

		SET @Importe=-@Importe --La funci�n ModificarSaldo suma el importe al saldo, cuando se graba una apuesta queremos disminuir
		
		EXECUTE ModificarSaldo @IdUsuario,@Importe, 'Deducci�n por apuesta realizada'

	COMMIT
END
GO