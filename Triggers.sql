USE ApuestasF1
GO

-- No permite modificar ni borrar una apuesta una vez creada.
CREATE TRIGGER BloquearApuesta ON Apuestas
INSTEAD OF UPDATE, DELETE
AS
	THROW 51000, 'La apuesta no se puede modificar ni borrar.', 1
	ROLLBACK
GO