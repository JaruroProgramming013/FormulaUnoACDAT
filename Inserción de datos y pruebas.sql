USE ApuestasF1

--INSERCION DE DATOS

GO
EXECUTE InscribirUsuario 'Jose', 'joselito@gmail.com', 'joselerelere'
EXECUTE InscribirUsuario 'Javi', 'javieruste@gmail.com', 'javieperoconduste'
EXECUTE InscribirUsuario 'George', 'sadouski@gmail.com', 'jorgeelcurioso'
EXECUTE InscribirUsuario 'Josema', 'xemita95@gmail.com', 'matador'
EXECUTE InscribirUsuario 'Leo', 'ElLeo@gmail.com', 'soyprofe'
EXECUTE InscribirUsuario 'Companhero1', 'companhero1@gmail.com', 'compa1'
EXECUTE InscribirUsuario 'Companhero2', 'companhero2@gmail.com', 'compa2'
EXECUTE InscribirUsuario 'Companhero3', 'companhero3@gmail.com', 'compa3'
EXECUTE InscribirUsuario 'Companhero4', 'companhero4@gmail.com', 'compa4'
EXECUTE InscribirUsuario 'Companhero5', 'companhero5@gmail.com', 'compa5'
EXECUTE InscribirUsuario 'Companhero6', 'companhero6@gmail.com', 'compa6'
EXECUTE InscribirUsuario 'Companhero7', 'companhero7@gmail.com', 'compa7'
EXECUTE InscribirUsuario 'Companhero8', 'companhero8@gmail.com', 'compa8'
EXECUTE InscribirUsuario 'Companhero9', 'companhero9@gmail.com', 'compa9'
EXECUTE InscribirUsuario 'Companhero10', 'companhero10@gmail.com', 'compa10'
EXECUTE InscribirUsuario 'Companhero11', 'companhero11@gmail.com', 'compa11'


GO

EXECUTE InsertarPiloto 2, 'Peter', 'Perez', 'PER', 'Ferrari'
EXECUTE InsertarPiloto 5, 'Thomas', 'Jones', 'JON', 'McLaren'
EXECUTE InsertarPiloto 8, 'Robert', 'Kubica', 'KUB', 'McLaren'
EXECUTE InsertarPiloto 14, 'Fernando', 'Alonso', 'ALO', 'Renault'
EXECUTE InsertarPiloto 76, 'Christian', 'Verstapen', 'VER', 'Ferrari'
EXECUTE InsertarPiloto 12, 'Felipe', 'Massa', 'MAS', 'Renault'
EXECUTE InsertarPiloto 43, 'Lewis', 'Hamilton', 'HAM', 'Mercedes'
EXECUTE InsertarPiloto 1, 'Sebastian', 'Vetel', 'VET', 'Force India'
EXECUTE InsertarPiloto 38, 'Carlos', 'Sainz', 'SAI', 'Virgin'
EXECUTE InsertarPiloto 21, 'Peter', 'Perez', 'PET', 'Ferrari'
EXECUTE InsertarPiloto 77, 'Bernard', 'Bauer', 'BAU', 'Brawn'
EXECUTE InsertarPiloto 48, 'Valteri', 'Botas', 'BOT', 'Red Bull'
EXECUTE InsertarPiloto 9, 'Daniel', 'Kyviat', 'KVI', 'Toro Rosso'
EXECUTE InsertarPiloto 4, 'Mark', 'Weber', 'WEB', 'Williams'
EXECUTE InsertarPiloto 55, 'Daniel', 'Ricciardo', 'RIC', 'Williams'


GO

DECLARE @Datetime DATETIME

SET @Datetime = DATETIMEFROMPARTS(2020, 12, 23, 14, 0, 0, 0)
EXECUTE AnhadirCarrera 'Suzuka', @Datetime, 63
SET @Datetime = DATETIMEFROMPARTS(2021, 1, 18, 15, 0, 0, 0)
EXECUTE AnhadirCarrera 'Imola', @Datetime, 72
SET @Datetime = DATETIMEFROMPARTS(2021, 2, 14, 14, 0, 0, 0)
EXECUTE AnhadirCarrera 'Montreal', @Datetime, 58
SET @Datetime = DATETIMEFROMPARTS(2021, 3, 28, 13, 0, 0, 0)
EXECUTE AnhadirCarrera 'Monza', @Datetime, 83
SET @Datetime = DATETIMEFROMPARTS(2021, 5, 2, 20, 30, 0, 0)
EXECUTE AnhadirCarrera 'AbuDabi', @Datetime, 73
SET @Datetime = DATETIMEFROMPARTS(2021, 6, 30, 15, 30, 0, 0)
EXECUTE AnhadirCarrera 'Monaco', @Datetime, 61
SET @Datetime = DATETIMEFROMPARTS(2021, 8, 24, 18, 0, 0, 0)
EXECUTE AnhadirCarrera 'SaoPaulo', @Datetime, 58
SET @Datetime = DATETIMEFROMPARTS(2021, 9, 29, 7, 0, 0, 0)
EXECUTE AnhadirCarrera 'Indianapolis', @Datetime, 69

GO

EXECUTE InscribirPilotoCarrera 1,1
EXECUTE InscribirPilotoCarrera 2,1
EXECUTE InscribirPilotoCarrera 3,1
EXECUTE InscribirPilotoCarrera 4,1
EXECUTE InscribirPilotoCarrera 5,1
EXECUTE InscribirPilotoCarrera 6,1
EXECUTE InscribirPilotoCarrera 7,1
EXECUTE InscribirPilotoCarrera 9,1
EXECUTE InscribirPilotoCarrera 10,1
EXECUTE InscribirPilotoCarrera 11,1
EXECUTE InscribirPilotoCarrera 12,1
EXECUTE InscribirPilotoCarrera 13,1
EXECUTE InscribirPilotoCarrera 14,1
EXECUTE InscribirPilotoCarrera 15,1
EXECUTE InscribirPilotoCarrera 1,2
EXECUTE InscribirPilotoCarrera 2,2
EXECUTE InscribirPilotoCarrera 3,2
EXECUTE InscribirPilotoCarrera 4,2
EXECUTE InscribirPilotoCarrera 5,2
EXECUTE InscribirPilotoCarrera 6,2
EXECUTE InscribirPilotoCarrera 7,2
EXECUTE InscribirPilotoCarrera 9,2
EXECUTE InscribirPilotoCarrera 10,2
EXECUTE InscribirPilotoCarrera 11,2
EXECUTE InscribirPilotoCarrera 12,2
EXECUTE InscribirPilotoCarrera 13,2
EXECUTE InscribirPilotoCarrera 14,2
EXECUTE InscribirPilotoCarrera 15,2
EXECUTE InscribirPilotoCarrera 1,3
EXECUTE InscribirPilotoCarrera 2,3
EXECUTE InscribirPilotoCarrera 3,3
EXECUTE InscribirPilotoCarrera 4,3
EXECUTE InscribirPilotoCarrera 5,3
EXECUTE InscribirPilotoCarrera 6,3
EXECUTE InscribirPilotoCarrera 7,3
EXECUTE InscribirPilotoCarrera 9,3
EXECUTE InscribirPilotoCarrera 10,3
EXECUTE InscribirPilotoCarrera 11,3
EXECUTE InscribirPilotoCarrera 12,3
EXECUTE InscribirPilotoCarrera 13,3
EXECUTE InscribirPilotoCarrera 14,3
EXECUTE InscribirPilotoCarrera 15,3

GO

DECLARE @Ahora DATETIME
SET @Ahora = CURRENT_TIMESTAMP
EXECUTE GenerarTransaccion 1, @Ahora, 1, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 2, @Ahora, 1, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 3, @Ahora, 1, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 4, @Ahora, 1, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 5, @Ahora, 1, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 10, @Ahora, 1, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 1, @Ahora, 10, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 1, @Ahora, 100, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 1, @Ahora, -80, 'Transaccion de prueba'
EXECUTE GenerarTransaccion 1, @Ahora, -1, 'Transaccion de prueba'

GO

--PRUEBAS DE FUNCIONES ESCLARES

DECLARE @Resultado DECIMAL (4,2)
DECLARE @Tiempo SMALLDATETIME
SET @Tiempo = CURRENT_TIMESTAMP
SET @Resultado = dbo.AsignarCuota(1, 1, NULL, NULL, 1, @Tiempo)
PRINT @Resultado
SET @Resultado = dbo.AsignarCuota(1, 1, 2, 3, 1, @Tiempo)
PRINT @Resultado

GO

DECLARE @Ganado SMALLMONEY
SET @Ganado = dbo.CalcularPremio (4,4)
PRINT @Ganado
SET @Ganado = dbo.CalcularPremio (3.1,4.2)
PRINT @Ganado
SET @Ganado = dbo.CalcularPremio (400,1.3)
PRINT @Ganado

GO

--PRUEBA RESTO DE PROCEDIMIENTOS

DECLARE @Tiempo SMALLDATETIME
SET @Tiempo = CURRENT_TIMESTAMP
EXECUTE ModificarSaldo 1, 100, @Tiempo, 'Prueba Ingreso de 100 euros en usuario 1'
EXECUTE ModificarSaldo 2, 100, @Tiempo, 'Prueba Ingreso de 100 euros en usuario 2'
EXECUTE ModificarSaldo 1, -30, @Tiempo, 'Prueba Retirada de 30 euros en usuario 1'
EXECUTE ModificarSaldo 3, 100, @Tiempo, 'Prueba Ingreso de 100 euros en usuario 3'
EXECUTE ModificarSaldo 4, 100, @Tiempo, 'Prueba Ingreso de 100 euros en usuario 4'
EXECUTE ModificarSaldo 5, 100, @Tiempo, 'Prueba Ingreso de 100 euros en usuario 5'
EXECUTE ModificarSaldo 6, 100, @Tiempo, 'Prueba Ingreso de 100 euros en usuario 6'
EXECUTE ModificarSaldo 10, 77, @Tiempo, 'Prueba Ingreso de 100 euros en usuario 10'
EXECUTE ModificarSaldo 8, 43, @Tiempo, 'Pruebas en usuario 8'
EXECUTE ModificarSaldo 8, 36, @Tiempo, 'Pruebas en usuario 8'
EXECUTE ModificarSaldo 8, 42, @Tiempo, 'Pruebas en usuario 8'
EXECUTE ModificarSaldo 8, -23, @Tiempo, 'Pruebas en usuario 8'
--EXECUTE ModificarSaldo 8, -100, @Tiempo, 'Pruebas en usuario 8' --> Prueba error por retirada de dinero en exceso

GO

EXECUTE GrabarApuestas 2, 1 , 1, 1, null, null, 3, 4
EXECUTE GrabarApuestas 2, 3 , 1, 4, null, null, 4, 20
EXECUTE GrabarApuestas 4, 1 , 1, 6, null, null, 8, 1
EXECUTE GrabarApuestas 4, 2 , 1, 6, null, null, 1, 5
EXECUTE GrabarApuestas 5, 3 , 1, 9, null, null, 6, 45
EXECUTE GrabarApuestas 10, 1 , 3, 4, 5, 1,  null, 21
EXECUTE GrabarApuestas 8, 3 , 3, 15, 7 , 4, null, 17
EXECUTE GrabarApuestas 10, 2 , 1, 8, null, null, 6, 3
EXECUTE GrabarApuestas 5, 2 , 3, 11, 14, 2, null, 12
EXECUTE GrabarApuestas 5, 3, 1, 2, null, null, 4, 30
EXECUTE GrabarApuestas 8, 2 , 3, 4, 3, 2, null, 23
EXECUTE GrabarApuestas 2, 1 , 1, 7, null, null, 3, 12
EXECUTE GrabarApuestas 8, 3, 1, 9, null, null, 1, 18
EXECUTE GrabarApuestas 4, 2 , 3, 4, 1, 3, null, 4
EXECUTE GrabarApuestas 2, 2 , 2, 6, null, null, 4, 2
EXECUTE GrabarApuestas 2,1 , 2, 10, null, null, 2, 5
EXECUTE GrabarApuestas 1,2 , 2, 4, null, null, 3, 6
EXECUTE GrabarApuestas 3,3 , 2, 12, null, null, 4, 7
EXECUTE GrabarApuestas 3, 3 , 2, 3, null, null, 6, 9
EXECUTE GrabarApuestas 4 ,2 , 2, 5, null, null, 1, 2
EXECUTE GrabarApuestas 1 ,2 , 2, 5, null, null, 1, 2
EXECUTE GrabarApuestas 2 ,2 , 2, 5, null, null, 1, 2
EXECUTE GrabarApuestas 3 ,2 , 2, 5, null, null, 1, 2
EXECUTE GrabarApuestas 4 ,2 , 2, 5, null, null, 1, 2
EXECUTE GrabarApuestas 5 ,2 , 2, 5, null, null, 1, 2
EXECUTE GrabarApuestas 5 ,2 , 1, 1, 1, null, 3, 5
EXECUTE GrabarApuestas 3 ,1 , 1, 1, null, null, 9, 5

GO

DECLARE @Tiempo TIME
SET @TIEMPO = TIMEFROMPARTS( 0 ,1,20,341,3)
EXECUTE IntroducirDatosFinCarrera 1, 1, @Tiempo, 3
SELECT @TIEMPO = TIMEFROMPARTS( 0,1,40,45,3)
EXECUTE IntroducirDatosFinCarrera 2, 1, @Tiempo, 2
SELECT @TIEMPO = TIMEFROMPARTS( 0,1,32,65,3)
EXECUTE IntroducirDatosFinCarrera 3, 1, @Tiempo, 1
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,34,76,3)
EXECUTE IntroducirDatosFinCarrera 4, 1, @Tiempo, 5
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,50,65,3)
EXECUTE IntroducirDatosFinCarrera 5, 1, @Tiempo, 6
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,12,24,3)
EXECUTE IntroducirDatosFinCarrera 6, 1, @Tiempo, 7
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,17,37,3)
EXECUTE IntroducirDatosFinCarrera 7, 1, @Tiempo, 9
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,18,13,3)
EXECUTE IntroducirDatosFinCarrera 8, 1, @Tiempo, 8
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,40,63,3)
EXECUTE IntroducirDatosFinCarrera 9, 1, @Tiempo, 4
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,1,34,3)
EXECUTE IntroducirDatosFinCarrera 10, 1, @Tiempo, 10
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,41,45,3)
EXECUTE IntroducirDatosFinCarrera 11, 1, @Tiempo, 13
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,51,76,3)
EXECUTE IntroducirDatosFinCarrera 12, 1, @Tiempo, 15
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,33,76,3)
EXECUTE IntroducirDatosFinCarrera 13, 1, @Tiempo, 12
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,43,56,3)
EXECUTE IntroducirDatosFinCarrera 14, 1, @Tiempo, 14
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,13,33,3)
EXECUTE IntroducirDatosFinCarrera 15, 1, @Tiempo, 11

SELECT @TIEMPO =TIMEFROMPARTS( 0,1,24,34,3)
EXECUTE IntroducirDatosFinCarrera 1, 2, @Tiempo, 5
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,50,45,3)
EXECUTE IntroducirDatosFinCarrera 2, 2, @Tiempo, 4
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,32,65,3)
EXECUTE IntroducirDatosFinCarrera 3, 2, @Tiempo, 15
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,4,76,3)
EXECUTE IntroducirDatosFinCarrera 4, 2, @Tiempo, 12
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,52,65,3)
EXECUTE IntroducirDatosFinCarrera 5, 2, @Tiempo, 1
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,32,24,3)
EXECUTE IntroducirDatosFinCarrera 6, 2, @Tiempo,13
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,15,37,3)
EXECUTE IntroducirDatosFinCarrera 7, 2, @Tiempo, 7
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,58,13,3)
EXECUTE IntroducirDatosFinCarrera 8, 2, @Tiempo, 2
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,44,63,3)
EXECUTE IntroducirDatosFinCarrera 9, 2, @Tiempo, 10
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,13,34,3)
EXECUTE IntroducirDatosFinCarrera 10, 2, @Tiempo, 11
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,4,45,3)
EXECUTE IntroducirDatosFinCarrera 11, 2, @Tiempo, 3
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,5,76,3)
EXECUTE IntroducirDatosFinCarrera 12, 2, @Tiempo, 9
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,33,76,3)
EXECUTE IntroducirDatosFinCarrera 13, 2, @Tiempo, 14
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,3,56,3)
EXECUTE IntroducirDatosFinCarrera 14, 2, @Tiempo, 8
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,13,33,3)
EXECUTE IntroducirDatosFinCarrera 15, 2, @Tiempo, 6

SELECT @TIEMPO =TIMEFROMPARTS( 0,1,24,34,3)
EXECUTE IntroducirDatosFinCarrera 1, 3, @Tiempo, 13
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,50,45,3)
EXECUTE IntroducirDatosFinCarrera 2, 3, @Tiempo,9
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,32,65,3)
EXECUTE IntroducirDatosFinCarrera 3, 3, @Tiempo, 12
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,4,76,3)
EXECUTE IntroducirDatosFinCarrera 4, 3, @Tiempo, 3
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,52,65,3)
EXECUTE IntroducirDatosFinCarrera 5, 3, @Tiempo, 8
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,32,24,3)
EXECUTE IntroducirDatosFinCarrera 6, 3, @Tiempo,10
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,15,37,3)
EXECUTE IntroducirDatosFinCarrera 7, 3, @Tiempo, 15
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,58,13,3)
EXECUTE IntroducirDatosFinCarrera 8, 3, @Tiempo, 2
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,44,63,3)
EXECUTE IntroducirDatosFinCarrera 9, 3, @Tiempo, 11
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,13,34,3)
EXECUTE IntroducirDatosFinCarrera 10, 3, @Tiempo, 4
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,4,45,3)
EXECUTE IntroducirDatosFinCarrera 11, 3, @Tiempo, 5
SELECT @TIEMPO =TIMEFROMPARTS( 0,1,5,76,3)
EXECUTE IntroducirDatosFinCarrera 12, 3, @Tiempo, 1
SET @TIEMPO =TIMEFROMPARTS( 0,1,33,76,3)
EXECUTE IntroducirDatosFinCarrera 13, 3, @Tiempo, 7
SET @TIEMPO =TIMEFROMPARTS( 0,1,3,56,3)
EXECUTE IntroducirDatosFinCarrera 14, 3, @Tiempo, 6
SET @TIEMPO =TIMEFROMPARTS( 0,1,13,33,3)
EXECUTE IntroducirDatosFinCarrera 15, 3, @Tiempo, 14


SELECT * FROM Pilotos
select * from Transacciones
select * from Apuestas
select * from PilotosCarreras
order by [Codigo Carrera],Posicion

GO

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
EXECUTE GrabarApuestas 3 ,1 , 3, 8, 2, 3, null, 5

GO
DECLARE @BIT BIT
EXECUTE  @BIT = DeterminarGanador 28, @BIT
PRINT @BIT

EXECUTE  @BIT = DeterminarGanador 13, @BIT
PRINT @BIT

EXECUTE  @BIT = DeterminarGanador 14, @BIT
PRINT @BIT

EXECUTE  @BIT = DeterminarGanador 22, @BIT
PRINT @BIT

GO


EXECUTE FinalizarCarrera 1
EXECUTE FinalizarCarrera 2
EXECUTE FinalizarCarrera 3

GO
