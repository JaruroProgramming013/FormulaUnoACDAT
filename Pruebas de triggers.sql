USE ApuestasF1
GO

--Prueba del procedimiento FinalizarCarrera (no se puede volver a ejecutar)

EXECUTE FinalizarCarrera 1
EXECUTE FinalizarCarrera 1
EXECUTE FinalizarCarrera 1

GO

--Prueba modificar/borrar apuesta

UPDATE Apuestas
SET [ID Piloto1] = 8
WHERE [ID Apuesta] = 1

GO

DELETE Apuestas
WHERE Importe=5

GO
--Prueba apostar carrera después de una hora

DECLARE @Datetime  TIME = DATETIMEFROMPARTS(2021, 10, 14, 12, 0, 0, 0)
EXECUTE AnhadirCarrera 'Bahrein', @Datetime, 74

DECLARE @DatetimeApuesta  TIME = DATETIMEFROMPARTS(2021, 10, 14, 13, 1, 0, 0)
EXECUTE ApuestaTipo2 4, 9, 13, 17 

GO


--Prueba superar el limite de apuestas

EXECUTE IngresarRetirarDinero 4, 10000 
EXECUTE ApuestaTipo1 4, 2, 14, 1, 10000

GO

--Prueba limite de pilotos por carrera

EXECUTE InscribirPilotoCarrera 16,2
EXECUTE InscribirPilotoCarrera 17,1
EXECUTE InscribirPilotoCarrera 18,1
EXECUTE InscribirPilotoCarrera 19,1
EXECUTE InscribirPilotoCarrera 20,1
EXECUTE InscribirPilotoCarrera 21,1
EXECUTE InscribirPilotoCarrera 22,1
EXECUTE InscribirPilotoCarrera 23,1
EXECUTE InscribirPilotoCarrera 24,1
EXECUTE InscribirPilotoCarrera 25,1
