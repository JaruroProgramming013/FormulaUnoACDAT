USE ApuestasF1
GO

--PROCEDIMIENTOS DE INSERCION DE DATOS

--Nombre: InscribirUsuario
--Descripcion: Inscribe un usuario en nuestra BBDD
--Entrada: Nombre, email y contrasenha
--Salida: Un nuevo usuario

CREATE OR ALTER PROCEDURE InscribirUsuario
	@Nombre VARCHAR(30),
	@email VARCHAR(50),
	@Contrasenha VARCHAR(30)
AS BEGIN
	BEGIN TRANSACTION
		INSERT INTO Usuarios VALUES (@Nombre, 0, @email, @Contrasenha)
	COMMIT
END

GO

--Nombre: InsertarPiloto
--Descripcion: Inscribe un piloto en nuestra BBDD
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

--Nombre: AnhadirCarrera
--Descripcion: Anhade una carrera a nuestra BBDD
--Entradas: Codigo de carrera, Nombre del circuito, fecha y hora en la que se realiza y numero de vueltas
--Salida: Una nueva carrera

CREATE OR ALTER PROCEDURE AnhadirCarrera
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
--Descripcion: Inscribe a un piloto en una carrera insertandolo en la tabla pilotoscarreras
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
--Descripcion: Anhade una transaccion a nuestra BBDD
--Entradas: ID, IdUsuario, Importe, Concepto
--Salida: Una nueva transaccion

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
--Descripcion: Asigna una cuota de apuesta en funcion de las apuestas ya realizadas y los paramentros de entrada
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
--Descripcion: Devuelve el dinero que se gana con esa apuesta
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
--Descripcion: modifica el saldo de un usuario dado
--Entradas: Usuario, importe, concepto
--Salida: Modificacion correspondiente del saldo del usuario dado y genera la transaccion adecuada

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
--Descripcion: Graba una apuesta en la base de datos
--Entradas: tipo de apuesta, piloto/pilotos por los que se apuesta, circuito, importe
--Salida: Insercion de datos en la tabla apuestas y
--			reduccion de saldo correspondiente en la tabla jugadores.

CREATE OR ALTER PROCEDURE GrabarApuestas
	@IdUsuario SMALLINT,
	@IdCarrera SMALLINT,
	@TipoApuesta TINYINT,
	@Piloto1 TINYINT,
	@Piloto2 TINYINT = NULL,
	@Piloto3 TINYINT = NULL,
	@Posicion TINYINT = NULL,
	@Importe SMALLMONEY
AS BEGIN
	BEGIN TRANSACTION
		DECLARE @Momento SMALLDATETIME

		SET @Momento = CURRENT_TIMESTAMP

		INSERT INTO Apuestas VALUES (	@IdUsuario,
										@IdCarrera,
										@Piloto1, @Piloto2, @Piloto3,
										@Posicion,
										@TipoApuesta,
										@Momento,
										@Importe,
										dbo.AsignarCuota(@IdCarrera, @Piloto1, @Piloto2, @Piloto3, @TipoApuesta, @Momento))

		SET @Importe=-@Importe --La funcion ModificarSaldo suma el importe al saldo, cuando se graba una apuesta queremos disminuir

		EXECUTE ModificarSaldo @IdUsuario,@Importe, @Momento, 'Deduccion por apuesta realizada'

	COMMIT
END
GO

--Nombre: IngresarRetirarDinero
--Descripción: Modoifica el saldo del usuario y genera una transacción con su correspondiente concepto de retirada o ingreso
--Entrada: Id del usuario e importe (positivo si es un ingreso o negativo si es retirada)
--Salida: Cambios en el saldo del usuario y una nueva transaccion

CREATE OR ALTER PROCEDURE IngresarRetirarDinero
	@IdUsuario SMALLINT,
	@Importe SMALLMONEY
AS BEGIN 
	BEGIN TRANSACTION

		DECLARE @Momento SMALLDATETIME

		SET @Momento = CURRENT_TIMESTAMP
		
		IF(@Importe > 0)
			EXECUTE ModificarSaldo @IdUsuario,@Importe, @Momento, 'Ingreso'
		ELSE
			EXECUTE ModificarSaldo @IdUsuario,@Importe, @Momento, 'Retirada efectivo'
		
	COMMIT
END
GO

--Nombre: GanaciasApuesta
--Descripcion: genera una tabla con las ganancias que generan a cada usuario las apuestas para un caso concreto
--Entrada: Codico de carrera, Id del piloto 1, Id del piloto 2, Id del piloto 3, tipo de apuesta
--Salida: Tabla Con las ganacias por cada apuesta de un usuario
CREATE OR ALTER FUNCTION GanaciasApuesta (
		@CodigoCarrera SMALLINT,  
		@IdPiloto1 SMALLINT, 
		@IdPiloto2 SMALLINT, 
		@IdPiloto3 SMALLINT,
		@Posicion TINYINT,
		@TipoApuesta TINYINT) 
RETURNS TABLE AS
RETURN(	SELECT [ID Usuario], dbo.CalcularPremio(Importe,Cuota) AS [Ganancia] FROM Apuestas
		WHERE	[Codigo Carrera]=@CodigoCarrera AND
				[ID Piloto1]=@IdPiloto1 AND
				ISNULL([ID Piloto2],0)=ISNULL(@IdPiloto2,0) AND
				ISNULL([ID Piloto3],0)=ISNULL(@IdPiloto3,0) AND
				ISNULL(Posicion,0)=ISNULL(@Posicion,0) AND
				Tipo=@TipoApuesta
	)
GO

SELECT * FROM Apuestas
	DECLARE @TotalApostado SMALLMONEY
	DECLARE @CodigoCarrera SMALLINT
	DECLARE @IdPiloto1 SMALLINT
	DECLARE @IdPiloto2 SMALLINT
	DECLARE @IdPiloto3 SMALLINT
	DECLARE @Posicion TINYINT
	DECLARE @Tipo SMALLINT

	SET @CodigoCarrera = 1
	SET @IdPiloto1 = 1
	SET @IdPiloto2 = NULL
	SET @IdPiloto3 = NULL
	SET @Posicion = 3
	SET @Tipo = 1

SELECT * FROM dbo.GanaciasApuesta(@CodigoCarrera, @IdPiloto1, @IdPiloto2, @IdPiloto3, @Posicion, @Tipo)


GO
--Nombre: FinalizarCarrera
--Descripcion: Comprueba todas las apuestas de una carrera y actualiza los saldos de las apuestas ganadas
--Entrada: Codigo Carrera
--Salida: Saldos actualizados

CREATE OR ALTER PROCEDURE introducirDatosFinCarrera(
	@IdPiloto SMALLINT
	,@CodigoCarrera SMALLINT
	,@Posicion TINYINT
	,@Tiempo TIME
	)
	
	AS BEGIN
		BEGIN TRANSACTION
			INSERT INTO PilotosCarreras VALUES (
												@IdPiloto,
												@CodigoCarrera,
												@Posicion,
												@Tiempo
											)
		COMMIT
	END




	GO