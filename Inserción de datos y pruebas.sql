--INSERCIÓN DE DATOS
USE ApuestasF1

GO
EXECUTE InscribirUsuario 'José', 'joselito@gmail.com', 'joselerelere'
EXECUTE InscribirUsuario 'Javi', 'javieruste@gmail.com', 'javieperoconduste'
EXECUTE InscribirUsuario 'George', 'sadouski@gmail.com', 'jorgeelcurioso'
EXECUTE InscribirUsuario 'Josema', 'xemita95@gmail.com', 'matador'
EXECUTE InscribirUsuario 'Leo', 'ElLeo@gmail.com', 'soyprofe'
EXECUTE InscribirUsuario 'Companhero1', 'compañero1@gmail.com', 'compa1'
EXECUTE InscribirUsuario 'Companhero2', 'compañero2@gmail.com', 'compa2'
EXECUTE InscribirUsuario 'Companhero3', 'compañero3@gmail.com', 'compa3'
EXECUTE InscribirUsuario 'Companhero4', 'compañero4@gmail.com', 'compa4'
EXECUTE InscribirUsuario 'Companhero5', 'compañero5@gmail.com', 'compa5'
EXECUTE InscribirUsuario 'Companhero6', 'compañero6@gmail.com', 'compa6'
EXECUTE InscribirUsuario 'Companhero7', 'compañero7@gmail.com', 'compa7'
EXECUTE InscribirUsuario 'Companhero8', 'compañero8@gmail.com', 'compa8'
EXECUTE InscribirUsuario 'Companhero9', 'compañero9@gmail.com', 'compa9'
EXECUTE InscribirUsuario 'Companhero10', 'compañero10@gmail.com', 'compa10'
EXECUTE InscribirUsuario 'Companhero11', 'compañero11@gmail.com', 'compa11'

--select * from Usuarios

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

--select * from Pilotos

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

--select * from Carreras

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



SELECT * FROM PilotosCarreras

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

SELECT * FROM TRANSACCIONES

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
--EXECUTE ModificarSaldo 8, -100, @Tiempo, 'Pruebas en usuario 8' --> Prueba error por retirada de más dinero en exceso
select * from Usuarios
select * from Transacciones

GO

					
EXECUTE GrabarApuestas 1, 1 , 1, 1, null, null, 3, 10
EXECUTE GrabarApuestas 2, 3 , 1, 4, null, null, 4, 5
EXECUTE GrabarApuestas 4, 1 , 1, 6, null, null, 8, 4
EXECUTE GrabarApuestas 4, 2 , 1, 6, null, null, 1, 5
EXECUTE GrabarApuestas 5, 3 , 1, 9, null, null, 6, 7
EXECUTE GrabarApuestas 7, 1 , 3, 4, 5, 1, null, 5
EXECUTE GrabarApuestas 8, 3 , 3, 15, 7 , 4, null, 4
EXECUTE GrabarApuestas 9, 2 , 1, 8, null, null, 6, 3
EXECUTE GrabarApuestas 5, 2 , 3, 11, 14, 2, null, 24
EXECUTE GrabarApuestas 10, 3, 1, 2, null, null, 4, 30
EXECUTE GrabarApuestas 11, 2 , 3, 4, 3, 2, null, 23
EXECUTE GrabarApuestas 12, 1 , 1, 7, null, null, 3, 12
EXECUTE GrabarApuestas 7, 3, 1, 9, null, null, 1, 18
EXECUTE GrabarApuestas 14, 2 , 3, 4, 1, 3, null, 4
EXECUTE GrabarApuestas 16, 2 , 2, 6, null, null, null, 2
EXECUTE GrabarApuestas 11,1 , 2, 10, null, null, null, 5
EXECUTE GrabarApuestas 1,2 , 2, 4, null, null, null, 6
EXECUTE GrabarApuestas 7,3 , 2, 12, null, null, null, 7
EXECUTE GrabarApuestas 11,3 , 2, 3, null, null, null, 9
EXECUTE GrabarApuestas 8,2 , 2, 5, null, null, null, 2


SELECT * FROM Pilotos
select * from Transacciones
