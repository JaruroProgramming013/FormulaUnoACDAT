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
AS
	DECLARE @TotalApostado SMALLMONEY
	DECLARE @CodigoCarrera SMALLINT
	DECLARE @IdPiloto1 SMALLINT
	DECLARE @IdPiloto2 SMALLINT
	DECLARE @IdPiloto3 SMALLINT
	DECLARE @Tipo SMALLINT
	DECLARE @Importe SMALLMONEY
	DECLARE @Cuota DECIMAL(4,2)

	SELECT @CodigoCarrera = [Codigo Carrera] FROM inserted
	SELECT @IdPiloto1 = [ID Piloto1] FROM inserted
	SELECT @IdPiloto2 = [ID Piloto2] FROM inserted
	SELECT @IdPiloto3 = [ID Piloto3] FROM inserted
	SELECT @Tipo = Tipo FROM inserted
	SELECT @Importe = Importe FROM inserted
	SELECT @Cuota = Cuota FROM inserted

	SELECT @TotalApostado = SUM([Ganancia]) FROM dbo.GanaciasApuesta(@CodigoCarrera, @IdPiloto1, @IdPiloto2, @IdPiloto3, @Tipo, @Importe, @Cuota)

	IF @TotalApostado > 10000
		THROW 51001, 'Se ha superado el limite de apuestas a este piloto.', 1
	ROLLBACK
END
GO
