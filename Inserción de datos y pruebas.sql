--INSERCIÓN DE DATOS

--Usuarios:
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

EXECUTE InscribirPiloto 2, 'Peter', 'Perez', 'PER', 'Ferrari'
EXECUTE InscribirPiloto 5, 'Thomas', 'Jones', 'JON', 'McLaren'
EXECUTE InscribirPiloto 8, 'Robert', 'Kubica', 'KUB', 'McLaren'
EXECUTE InscribirPiloto 14, 'Fernando', 'Alonso', 'ALO', 'Renault'
EXECUTE InscribirPiloto 76, 'Christian', 'Verstapen', 'VER', 'Ferrari'
EXECUTE InscribirPiloto 12, 'Felipe', 'Massa', 'MAS', 'Renault'
EXECUTE InscribirPiloto 43, 'Lewis', 'Hamilton', 'HAM', 'Mercedes'
EXECUTE InscribirPiloto 1, 'Sebastian', 'Vetel', 'VET', 'Force India'
EXECUTE InscribirPiloto 38, 'Carlos', 'Sainz', 'SAI', 'Virgin'
EXECUTE InscribirPiloto 21, 'Peter', 'Perez', 'PET', 'Ferrari'
EXECUTE InscribirPiloto 77, 'Bernard', 'Bauer', 'BAU', 'Brawn'
EXECUTE InscribirPiloto 48, 'Valteri', 'Botas', 'BOT', 'Red Bull'
EXECUTE InscribirPiloto 9, 'Daniel', 'Kyviat', 'KVI', 'Toro Rosso'
EXECUTE InscribirPiloto 4, 'Mark', 'Weber', 'WEB', 'Williams'
EXECUTE InscribirPiloto 5, 'Daniel', 'Ricciardo', 'RIC', 'Williams'

GO

DECLARE @Datetime DATETIME

SET @Datetime = DATETIMEFROMPARTS(2020, 12, 23, 14, 0, 0, 0)
EXECUTE AñadirCarrera 'Suzuka', @Datetime, 63
SET @Datetime = DATETIMEFROMPARTS(2021, 1, 18, 15, 0, 0, 0)
EXECUTE AñadirCarrera 'Imola', @Datetime, 72
SET @Datetime = DATETIMEFROMPARTS(2021, 2, 14, 14, 0, 0, 0)
EXECUTE AñadirCarrera 'Montreal', @Datetime, 58
SET @Datetime = DATETIMEFROMPARTS(2021, 3, 28, 13, 0, 0, 0)
EXECUTE AñadirCarrera 'Monza', @Datetime, 83
SET @Datetime = DATETIMEFROMPARTS(2021, 5, 2, 20, 30, 0, 0)
EXECUTE AñadirCarrera 'AbuDabi', @Datetime, 73
SET @Datetime = DATETIMEFROMPARTS(2021, 6, 30, 15, 30, 0, 0)
EXECUTE AñadirCarrera 'Monaco', @Datetime, 61
SET @Datetime = DATETIMEFROMPARTS(2021, 8, 24, 18, 0, 0, 0)
EXECUTE AñadirCarrera 'SaoPaulo', @Datetime, 58
SET @Datetime = DATETIMEFROMPARTS(2021, 9, 29, 7, 0, 0, 0)
EXECUTE AñadirCarrera 'Indianapolis', @Datetime, 69

select * from PilotoCarreras