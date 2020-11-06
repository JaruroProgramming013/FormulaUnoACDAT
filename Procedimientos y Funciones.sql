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

--Nombre: introducirDatosFinCarrera
--Descripcion:Introduce la posicion y la vuelta rapida de un piloto en una carrera
--Entradas: id poiloto, codigo de la carrera, posicion del piloto y su vuelta rapida
--Salidas: modificaciones en las tablas

CREATE OR ALTER PROCEDURE introducirDatosFinCarrera( 
	@IdPiloto SMALLINT 
	,@CodigoCarrera SMALLINT 
	,@VueltaRapida TIME 
	,@Posicion TINYINT 
	) 
	 
	AS BEGIN 
		BEGIN TRANSACTION 
			
			DECLARE @Momento SMALLDATETIME = CURRENT_TIMESTAMP
			
			--Actualiza Posicion y vuelta rápida
			UPDATE PilotosCarreras 
			SET Posicion = @Posicion,
				[Vuelta rapida] = @VueltaRapida
			WHERE	[ID Piloto]= @IdPiloto AND
					[Codigo Carrera]=@CodigoCarrera

			--Actualiza la hora de fin de carrera
			UPDATE Carreras
			SET [Fecha y Hora Fin] = @Momento
			WHERE @CodigoCarrera=Codigo

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

	RETURN @Cuota*20+1
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
	@CodigoCarrera SMALLINT,
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
										@CodigoCarrera,
										@Piloto1, @Piloto2, @Piloto3,
										@Posicion,
										@TipoApuesta,
										@Momento,
										@Importe,
										dbo.AsignarCuota(@CodigoCarrera, @Piloto1, @Piloto2, @Piloto3, @TipoApuesta, @Momento))

		SET @Importe=-@Importe --La funcion ModificarSaldo suma el importe al saldo, cuando se graba una apuesta queremos disminuir

		EXECUTE ModificarSaldo @IdUsuario,@Importe, @Momento, 'Deduccion por apuesta realizada'

	COMMIT
END

GO

--Nombre: ApuestaTipo1
--Descripciom: toma los parametros de entrada para realizar una apuesta de tipo uno (Acertar la posicion de un piloto) y llama al metodo 
--				grabar apuesta
--Entrada: ID usuaraio, codigo de carrera, id del piloto, posicion del piloto e importe
--Salida: cambios en las tablas apuesta, usuario y transaccion

CREATE OR ALTER PROCEDURE ApuestaTipo1 
	@IdUsuario SMALLINT,
	@CodigoCarrera SMALLINT,
	@Piloto1 TINYINT,
	@Posicion TINYINT,
	@Importe SMALLMONEY
AS BEGIN
	BEGIN TRANSACTION
		EXECUTE GrabarApuestas @IdUsuario, @CodigoCarrera , 1, @Piloto1, null, null, @Posicion, @Importe
	COMMIT
END

GO

--Nombre: ApuestaTipo2
--Descripciom: toma los parametros de entrada para realizar una apuesta de tipo dos (Acertar piloto que va a tener la vuelta más rápida 
--				de la carrera) y llama al metodo grabar apuesta
--Entrada: ID usuaraio, codigo de carrera, id del piloto e importe
--Salida: cambios en las tablas apuesta, usuario y transaccion

CREATE OR ALTER PROCEDURE ApuestaTipo2
	@IdUsuario SMALLINT,
	@CodigoCarrera SMALLINT,
	@Piloto1 TINYINT,
	@Importe SMALLMONEY
AS BEGIN
	BEGIN TRANSACTION
		EXECUTE GrabarApuestas @IdUsuario, @CodigoCarrera , 2, @Piloto1, null, null, null, @Importe
	COMMIT
END

GO

--Nombre: ApuestaTipo3
--Descripciom: toma los parametros de entrada para realizar una apuesta de tipo tres (Acertar los tres primeros pilotos de una carrera) 
--				y llama al metodo grabar apuesta
--Entrada: ID usuaraio, codigo de carrera, id de los piloto tres pilotos e importe
--Salida: cambios en las tablas apuesta, usuario y transaccion

CREATE OR ALTER PROCEDURE ApuestaTipo3
	@IdUsuario SMALLINT,
	@CodigoCarrera SMALLINT,
	@Piloto1 TINYINT,
	@Piloto2 TINYINT,
	@Piloto3 TINYINT,
	@Importe SMALLMONEY
AS BEGIN
	BEGIN TRANSACTION
		EXECUTE GrabarApuestas @IdUsuario, @CodigoCarrera , 3, @Piloto1, @Piloto2, @Piloto3, null, @Importe
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

--Nombre: DeterminarGanador
--Descripcion: Devuelve el resultado de una apuesta con ID especificado, 0 si no es ganador y 1 si es ganador.
--Entradas: idApuesta, int
--Salida: ganador, bit que indica 0 si no es ganador y 1 si es ganador.
CREATE OR ALTER PROCEDURE DeterminarGanador @idApuesta INT,
@ganador BIT OUTPUT
AS
BEGIN
    SET @ganador = 0
    DECLARE @tipo tinyint = (SELECT Tipo FROM Apuestas WHERE [ID Apuesta] = @idApuesta)
    DECLARE @carrera INT = (SELECT [Codigo Carrera] FROM Apuestas AS A WHERE A.[ID Apuesta] = @idApuesta)
	IF (@tipo = 1) -- Posicion de Piloto
        BEGIN
            IF EXISTS
            (
                SELECT * FROM Apuestas AS A
                INNER JOIN PilotosCarreras AS PC
                    ON A.[Codigo Carrera] = PC.[Codigo Carrera]
                           AND A.[ID Piloto1] = PC.[ID Piloto]
                WHERE A.[ID Apuesta] = @idApuesta
                  AND A.Posicion = PC.Posicion
            )
            BEGIN
                SET @ganador = 1
            END
        END
    ELSE IF (@tipo = 2) -- Vuelta rapida
        BEGIN
            IF EXISTS
            (
                SELECT MasRapido.Tiempo, A.[ID Piloto1]
                FROM Apuestas AS A
                INNER JOIN PilotosCarreras AS PC
                        ON A.[Codigo Carrera] = PC.[Codigo Carrera]
                            AND A.[ID Piloto1] = PC.[ID Piloto]
                INNER JOIN
                    (
                        SELECT MIN(PC.[Vuelta rapida]) AS Tiempo
                        FROM Apuestas AS A
                        INNER JOIN PilotosCarreras AS PC 
							ON A.[ID Piloto1] = PC.[ID Piloto]
                        WHERE PC.[Codigo Carrera] = @carrera
                    ) AS MasRapido ON PC.[Vuelta rapida] = MasRapido.Tiempo
                WHERE A.[ID Apuesta] = @idApuesta
            )
            BEGIN
                SET @ganador = 1
            END
        END
    ELSE IF (@tipo = 3) -- Podio
        BEGIN
            IF EXISTS
            (
                SELECT * FROM Apuestas AS A
                INNER JOIN Carreras AS C
                    ON A.[Codigo Carrera] = C.Codigo
                INNER JOIN PilotosCarreras AS PC1
                    ON C.Codigo = PC1.[Codigo Carrera]
                       AND A.[ID Piloto1] = PC1.[ID Piloto]
                INNER JOIN PilotosCarreras AS PC2
                    ON C.Codigo = PC2.[Codigo Carrera]
                       AND A.[ID Piloto2] = PC2.[ID Piloto]
                INNER JOIN PilotosCarreras AS PC3
                    ON C.Codigo = PC3.[Codigo Carrera]
                       AND A.[ID Piloto3] = PC3.[ID Piloto]
                WHERE A.[ID Apuesta] = @idApuesta
                  AND PC1.Posicion BETWEEN 1 AND 3
                  AND PC2.Posicion BETWEEN 1 AND 3
                  AND PC3.Posicion BETWEEN 1 AND 3
            )
            BEGIN
                SET @ganador = 1
            END
        END
	RETURN @ganador
END
GO

--Nombre: FinalizarCarrera
--Descripcion: Comprueba todas las apuestas de una carrera y actualiza los saldos de las apuestas ganadas
--Entrada: Codigo Carrera
--Salida: Saldos actualizados

CREATE OR ALTER PROCEDURE FinalizarCarrera 
	@CodigoCarrera SMALLINT
AS BEGIN
	BEGIN TRANSACTION
		
		DECLARE @IDApuesta SMALLINT --Variables en las que se va a almacenar el ID de las apuestas
		DECLARE @IDUsuario SMALLINT
		DECLARE @Importe SMALLMONEY
		DECLARE @Cuota DECIMAL(4,2)
		DECLARE @Momento SMALLDATETIME = CURRENT_TIMESTAMP
		DECLARE @BitGanador BIT
		DECLARE CApuestasCarrera CURSOR FOR
			SELECT [ID Apuesta], [ID Usuario], Importe, Cuota FROM Apuestas
			WHERE [Codigo Carrera]=@CodigoCarrera

		OPEN CApuestasCarrera
		
		--Recorremos las apuestas
		FETCH NEXT FROM CApuestasCarrera INTO @IDApuesta, @IDUsuario, @Importe, @Cuota
		WHILE @@FETCH_STATUS = 0
		BEGIN
			BEGIN TRANSACTION
				EXECUTE DeterminarGanador @IDApuesta, @BitGanador OUTPUT
				IF @BitGanador = 1
					BEGIN
						SET @Importe = dbo.CalcularPremio (@Importe, @Cuota) --¿¿¿Dara problemas???
						EXECUTE ModificarSaldo @IDUsuario, @Importe, @Momento, 'Ingreso por acierto de apuesta'
					END
				FETCH NEXT FROM CApuestasCarrera INTO @IDApuesta, @IDUsuario, @Importe, @Cuota
			COMMIT
		END
	CLOSE CApuestasCarrera
	DEALLOCATE CApuestasCarrera
	COMMIT
END
GO
