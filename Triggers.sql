USE ApuestasF1
GO

-- No permite modificar ni borrar una apuesta una vez creada.
CREATE OR ALTER TRIGGER BloquearApuesta ON Apuestas
INSTEAD OF UPDATE, DELETE
AS
	ROLLBACK TRANSACTION
	RAISERROR ('La apuesta no se puede modificar ni borrar.', -- Message text.
               16, -- Severity.
               1 -- State.
               )
GO

-- No permite insertar una apuesta una vez haya pasado una hora del inicio de la carrera o ya haya finalizado.
CREATE OR ALTER TRIGGER ImpedirApuesta ON Apuestas
AFTER INSERT
AS
	DECLARE @MomentoActual SMALLDATETIME = CURRENT_TIMESTAMP
	DECLARE @CodigoCarrera SMALLINT
	SELECT @CodigoCarrera= [Codigo Carrera] FROM inserted

	IF (@MomentoActual>(SELECT DATEADD(HOUR, 1, [Fecha y Hora Inicio]) FROM Carreras
						WHERE @CodigoCarrera=Codigo))
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('No se puede realizar la apuestas, las apuestas deben realizarse antes o durante la primera hora de carrera.', -- Message text.
				   16, -- Severity.
				   1 -- State.
				   )
	END
GO


--No permite realizar mas apuestas si se supera el limite de 10.000 euros por tipo de apuesta
CREATE OR ALTER TRIGGER MaximoAlcanzado ON Apuestas
AFTER INSERT
AS BEGIN
	DECLARE @TotalApostado SMALLMONEY
	DECLARE @CodigoCarrera SMALLINT
	DECLARE @IdPiloto1 SMALLINT
	DECLARE @IdPiloto2 SMALLINT
	DECLARE @IdPiloto3 SMALLINT
	DECLARE @Tipo SMALLINT
	DECLARE @Importe SMALLMONEY
	DECLARE @Cuota DECIMAL(4,2)
    DECLARE @Posicion TINYINT

	SELECT @CodigoCarrera = [Codigo Carrera] FROM inserted
	SELECT @IdPiloto1 = [ID Piloto1] FROM inserted
	SELECT @IdPiloto2 = [ID Piloto2] FROM inserted
	SELECT @IdPiloto3 = [ID Piloto3] FROM inserted
	SELECT @Tipo = Tipo FROM inserted
	SELECT @Importe = Importe FROM inserted
	SELECT @Cuota = Cuota FROM inserted

	SELECT @CodigoCarrera = [Codigo Carrera] FROM inserted
	SELECT @IdPiloto1 = [ID Piloto1] FROM inserted
	SELECT @IdPiloto2 = [ID Piloto2] FROM inserted
	SELECT @IdPiloto3 = [ID Piloto3] FROM inserted
	SELECT @Posicion = Posicion FROM inserted
	SELECT @Tipo = Tipo FROM inserted

	SELECT @TotalApostado = SUM(ISNULL([Ganancia],0)) FROM dbo.GanaciasApuesta(@CodigoCarrera, @IdPiloto1, @IdPiloto2, @IdPiloto3,@Posicion, @Tipo)
	
	IF @TotalApostado > 10000
		BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('Se ha superado el limite de apuestas de este tipo con estas condiciones.', -- Message text.
					16, -- Severity.
					1 -- State.
					)
	END

END
GO


--Este trigger evita que se inserten numeros de pilotos duplicados en una misma carrera

CREATE OR ALTER TRIGGER EvitarMismoNumeroCarrera ON PilotosCarreras
AFTER INSERT
AS BEGIN
    IF (
        SELECT TOP 1 COUNT(P.Numero) AS NumeroVecesAparece
        FROM Pilotos P
                 INNER JOIN inserted PC on P.ID = PC.[ID Piloto]
        GROUP BY P.Numero
        ORDER BY NumeroVecesAparece DESC
    ) > 1
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('No inserte numeros duplicados de pilotos.', -- Message text.
				   16, -- Severity.
				   1 -- State.
				   )
	END
END
GO

--SELECT p.Numero, COUNT(P.Numero) AS NumeroVecesAparece
--        FROM Pilotos P
--                 INNER JOIN PilotosCarreras PC on P.ID = PC.[ID Piloto]
--		GROUP BY P.Numero
--        ORDER BY [Codigo Carrera]

GO

--Este trigger evita que en una carrera se introduzcan mas de 24 pilotos

CREATE OR ALTER TRIGGER LimiteCarrera ON PilotosCarreras
AFTER INSERT
AS BEGIN
    IF(
        SELECT COUNT(PC.[ID Piloto])
        FROM PilotosCarreras PC
        INNER JOIN inserted i ON PC.[Codigo Carrera]=i.[Codigo Carrera]
        GROUP BY PC.[Codigo Carrera]
    ) >= 24
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('Limite de pilotos alcanzado.', -- Message text.
				   16, -- Severity.
				   1 -- State.
				   )
	END
END