USE ApuestasF1
GO

--PROCEDIMIENTOS DE INSERCI�N DE DATOS

--Nombre: InscribirUsuario
--Descripci�n: Inscribe un usuario en nuestra BBDD
--Entrada: Nombre, email y contrase�a
--Salida: Un nuevo usuario

CREATE OR ALTER PROCEDURE InscribirUsuario
	@Nombre VARCHAR(30),
	@email VARCHAR(50),
	@Contrase�a VARCHAR(30)
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Usuarios VALUES (@Nombre, 0, @email, @Contrase�a)
	COMMIT
END

GO

--Nombre: InsertarPiloto
--Descripci�n: Inscribe un piloto en nuestra BBDD
--Entrada: Numero, Nombre, Apellido, Siglas y Escuuderia
--Salida: Un nuevo piloto

CREATE OR ALTER PROCEDURE InsertarPiloto
	@Numero TINYINT,
	@Nombre VARCHAR(30),
	@Apellido VARCHAR(50),
	@Siglas CHAR(3),
	@Escuderia VARCHAR(20)
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
	@Circuito VARCHAR(20),
	@FechaHoraInicio DATETIME,
	@Vueltas TINYINT
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Carreras (Circuito, [Fecha y Hora Inicio],[Num vueltas]) VALUES (@Circuito, @FechaHoraInicio, @Vueltas)
	COMMIT
END

GO

--Nombre: InsertarPilotoCarrera
--Descripci�n: Inscribe a un piloto en una carrera insertandolo en la tabla pilotoscarreras
--Entrada: IdPiloto, Codigo de Carrera
--Salida: Piloto inscrito en una carrera

CREATE OR ALTER PROCEDURE InscribirPilotoCarrera
    @IDPiloto SMALLINT,
    @CodigoCarrera SMALLINT
AS BEGIN
    BEGIN TRAN
        INSERT INTO PilotosCarreras ([ID Piloto], [Codigo Carrera]) VALUES (@IDPiloto, @CodigoCarrera)
    COMMIT
END
GO

--Nombre: GenerarTransaccion
--Descripci�n: A�ade una transacci�n a nuestra BBDD
--Entradas: ID, IdUsuario, Importe, Concepto
--Salida: Una nueva transacci�n

CREATE OR ALTER PROCEDURE GenerarTransaccion
	@IDUsuario INT,
	@Momento DATETIME,
	@Importe SMALLMONEY,
	@Concepto VARCHAR(100)
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Transacciones VALUES (@IDUsuario, @Momento, @Importe, @Concepto)
	COMMIT
END

GO

--FUNCIONES ESCALARES

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
	@IdPiloto1 SMALLINT,
	@IdPiloto2 SMALLINT = NULL,
	@IdPiloto3 SMALLINT = NULL,
	@TipoApuesta TINYINT,
	@Momento SMALLDATETIME)
RETURNS DECIMAL(4,2) AS
BEGIN
	DECLARE @Cuota DECIMAL (4,2)

	--SET @CUOTA = RAND()			--Da error ya que no se puede llamar a una funcion no determinada desde una funcion creada, la solucion es crear una vista
	SET @CUOTA = (SELECT Valor FROM F1_ValorRandom)

	RETURN @Cuota*20
END

GO

--Nombre: CalcularPremio
--Descripci�n: Devuelve el dinero que se gana con esa apuesta
--Entradas: Dinero apostado y cuota
--Salida: Cantidad de dinero ganada

CREATE OR ALTER FUNCTION CalcularPremio(
    @DineroApostado SMALLMONEY,
    @Cuota DECIMAL(4,2)
) RETURNS SMALLMONEY 
AS BEGIN
    RETURN @DineroApostado*@Cuota
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
	@Momento DATETIME,
	@Concepto VARCHAR (100)
AS BEGIN
	BEGIN TRANSACTION
		DECLARE @Saldo SMALLMONEY

		SELECT @Saldo = Saldo FROM Usuarios
			WHERE @Usuario=ID
		SET @Saldo = @Saldo + @Importe

		UPDATE Usuarios
		SET Saldo=@Saldo
		WHERE @Usuario=ID

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
	@Piloto2 TINYINT = NULL,
	@Piloto3 TINYINT = NULL,
	@Importe SMALLMONEY
AS BEGIN
	BEGIN TRANSACTION
		DECLARE @Momento SMALLDATETIME

		SET @Momento = CURRENT_TIMESTAMP

		INSERT INTO Apuestas VALUES (	@IdUsuario,
										@IdCarrera,
										@Piloto1, @Piloto2, @Piloto3,
										@TipoApuesta,
										@Momento,
										@Importe,
										dbo.AsignarCuota(@IdCarrera, @Piloto1, @Piloto2, @Piloto3, @TipoApuesta, @Momento))

		SET @Importe=-@Importe --La funci�n ModificarSaldo suma el importe al saldo, cuando se graba una apuesta queremos disminuir

		EXECUTE ModificarSaldo @IdUsuario,@Importe, @Momento, 'Deducci�n por apuesta realizada'

	COMMIT
END
GO


CREATE OR ALTER PROCEDURE IngresarRetirarDinero
	@IdUsuario SMALLINT,
	@Importe SMALLMONEY
AS BEGIN 
		DECLARE @Momento SMALLDATETIME
	BEGIN TRANSACTION

		SET @Momento = CURRENT_TIMESTAMP
		
		ELSE

		EXECUTE ModificarSaldo @IdUsuario,@Importe, @Momento, 'Ingreso'
		IF(@Importe > 0)
		EXECUTE ModificarSaldo @IdUsuario,@Importe, @Momento, 'RetiradaEfectivo'

	COMMIT
GO
END

