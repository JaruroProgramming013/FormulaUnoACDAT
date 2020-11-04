USE ApuestasF1
GO

--PROCEDIMIENTOS DE INSERCIÓN DE DATOS

--Nombre: InscribirUsuario
--Descripción: Inscribe un usuario en nuestra BBDD
--Entrada: Nombre, email y contraseña
--Salida: Un nuevo usuario

CREATE OR ALTER PROCEDURE InscribirUsuario
	@Nombre VARCHAR(30),
	@email VARCHAR(50),
	@Contraseña VARCHAR(30)
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Usuarios VALUES (@Nombre, 0, @email, @Contraseña)
	COMMIT
END

GO

--Nombre: InscribirPiloto
--Descripción: Inscribe un piloto en nuestra BBDD
--Entrada: Numero, Nombre, Apellido, Siglas y Escuuderia
--Salida: Un nuevo piloto

CREATE OR ALTER PROCEDURE InsertarPiloto
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

--Nombre: AñadirCarrera
--Descripción: Añade una carrera a nuestra BBDD
--Entradas: Código de carrera, Nombre del circuito, fecha y hora en la que se realiza y número de vueltas
--Salida: Una nueva carrera

CREATE OR ALTER PROCEDURE AñadirCarrera
	@Circuito VARCHAR(20),
	@FechaHoraFin DATETIME,
	@Vueltas TINYINT
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Carreras VALUES (@Circuito, @FechaHoraFin, @Vueltas)
	COMMIT
END

GO

--Nombre: GenerarTransaccion
--Descripción: Añade una transacción a nuestra BBDD
--Entradas: ID, IdUsuario, Importe, Concepto
--Salida: Una nueva transacción

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

--FUNCION DE ASIGNACIÓN DE LA CUOTA

--Nombre: AsignarCuota
--Descripción: Asigna una cuota de apuesta en función de las apuestas ya realizadas y los paramentros de entrada
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
--Descripción: modifica el saldo de un usuario dado
--Entradas: Usuario, importe, concepto
--Salida: Modificación correspondiente del saldo del usuario dado y genera la transacción adecuada

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
--Descripción: Graba una apuesta en la base de datos
--Entradas: tipo de apuesta, piloto/pilotos por los que se apuesta, circuito, importe
--Salida: Inserción de datos en la tabla apuestas y
--			reducción de saldo correspondiente en la tabla jugadores.

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

		SET @Importe=-@Importe --La función ModificarSaldo suma el importe al saldo, cuando se graba una apuesta queremos disminuir

		EXECUTE ModificarSaldo @IdUsuario,@Importe, @Momento, 'Deducción por apuesta realizada'

	COMMIT
END
GO
CREATE OR ALTER PROCEDURE InsertarPilotoCarrera
    @IDPiloto TINYINT,
    @CodigoCarrera TINYINT
AS BEGIN
    BEGIN TRAN
        INSERT INTO PilotoCarreras ([Numero Piloto], [Codigo Carrera]) VALUES (@IDPiloto, @CodigoCarrera)
    COMMIT
END
GO
CREATE OR ALTER FUNCTION calcularPremio(
    @DineroApostado SMALLMONEY,
    @Cuota DECIMAL(4,2)
) RETURNS SMALLMONEY AS BEGIN
    RETURN @DineroApostado*@Cuota
end
