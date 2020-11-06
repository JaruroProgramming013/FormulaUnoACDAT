USE ApuestasF1
GO

-- No permite modificar ni borrar una apuesta una vez creada.
CREATE OR ALTER TRIGGER BloquearApuesta ON Apuestas
INSTEAD OF UPDATE, DELETE
AS
	THROW 51000, 'La apuesta no se puede modificar ni borrar.', 1
	ROLLBACK
GO

--No permite realizar más apuestas si se supera el limite de 10.000 euros por tipo de apuesta
CREATE OR ALTER TRIGGER MaximoAlcanzado ON Apuestas
AFTER INSERT
AS BEGIN

	DECLARE @TotalApostado SMALLMONEY
	DECLARE @CodigoCarrera SMALLINT
	DECLARE @IdPiloto1 SMALLINT
	DECLARE @IdPiloto2 SMALLINT
	DECLARE @IdPiloto3 SMALLINT
	DECLARE @Posicion TINYINT
	DECLARE @Tipo SMALLINT

	SELECT @CodigoCarrera = [Codigo Carrera] FROM inserted
	SELECT @IdPiloto1 = [ID Piloto1] FROM inserted
	SELECT @IdPiloto2 = [ID Piloto2] FROM inserted
	SELECT @IdPiloto3 = [ID Piloto3] FROM inserted
	SELECT @Posicion = Posicion FROM inserted
	SELECT @Tipo = Tipo FROM inserted

	SELECT @TotalApostado = SUM(ISNULL([Ganancia],0)) FROM dbo.GanaciasApuesta(@CodigoCarrera, @IdPiloto1, @IdPiloto2, @IdPiloto3,@Posicion, @Tipo)
	
	IF @TotalApostado > 10000
		BEGIN
		THROW 51001, 'Se ha superado el limite de apuestas a este piloto.', 1
		ROLLBACK
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
        ORDER BY NumeroVecesAparece
    ) > 1
    RAISERROR ('No inserte numeros duplicados de pilotos.', -- Message text.
               16, -- Severity.
               1 -- State.
               )
END

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
    RAISERROR ('Limite de pilotos alcanzado.', -- Message text. 
               16, -- Severity. 
               1 -- State. 
               ) 
END