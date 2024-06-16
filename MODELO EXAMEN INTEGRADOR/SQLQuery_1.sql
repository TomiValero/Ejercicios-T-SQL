Use ModeloExamenIntegrador_20241C
Go

--1)
-- CREATE OR ALTER TRIGGER trg_InsertProduccion
-- ON Produccion
-- INSTEAD OF INSERT
-- AS
-- BEGIN

--     DECLARE @Fecha DATE;
--     DECLARE @IDOperario BIGINT;
--     DECLARE @IDPieza BIGINT;
--     DECLARE @Medida DECIMAL(5,3);
--     DECLARE @Cantidad INT;
--     DECLARE @CostoUnitario MONEY;
--     DECLARE @CostoTotal MONEY;
--     DECLARE @Experiencia INT;

--     SELECT 
--         @IDOperario = I.IDOperario,
--         @IDPieza = I.IDPieza,
--         @Fecha = I.Fecha,
--         @Medida = I.Medida,
--         @Cantidad = I.Cantidad
--     FROM INSERTED I; 

--     SET @CostoUnitario = (SELECT P.CostoUnitarioProduccion FROM Piezas P
--     INNER JOIN INSERTED I ON P.IDPieza = I.IDPieza);

--     SET @CostoTotal = @Cantidad * @CostoUnitario;

--     IF @Fecha > GETDATE() 
--     BEGIN 

--         SET @Experiencia = YEAR(GETDATE()) -(SELECT Year(O.AnioAlta)
--         FROM Operarios O 
--         INNER JOIN inserted I ON O.IDOperario = I.IDOperario);

--         IF @Experiencia <= 5 AND @CostoUnitario > 15
--         BEGIN
--             RAISERROR('NO TIENES PERMISIO DE INSERTAR', 16, 0);
--             RETURN;
--         END;
--     END;

--     INSERT INTO Produccion (IDOperario, IDPieza, Fecha, Medida, Cantidad, CostoTotal)
--     VALUES (@IDOperario, @IDPieza, @Fecha, @Medida, @Cantidad, @CostoTotal);
-- END;

--2)
-- SELECT 
-- P.Nombre AS Pieza, 
-- M.Nombre AS Material,
-- (SELECT COUNT(*) FROM Operarios O
-- WHERE O.IDOperario <> ALL (
--     SELECT PR.IDOperario FROM Produccion PR
--     WHERE PR.IDPieza = P.IDPieza
--     )
-- ) AS OperariosNuncaProdujeron
-- FROM Piezas P
-- INNER JOIN Materiales M ON M.IDMaterial = P.IDMaterial

--3)
-- CREATE OR ALTER PROCEDURE SP_Punto_3(
--     @NombreMaterial VARCHAR(50),
--     @Porcentaje DECIMAL(6,2)
-- )
-- AS 
-- BEGIN
--     IF @Porcentaje <= -100 OR @Porcentaje > 1000 OR @Porcentaje = 0
--     BEGIN
--         RAISERROR('PORCENTAJE NO VALIDO', 16, 0);
--         RETURN;
--     END;

--     DECLARE @CostoUnitaro SMALLINT;
--     DECLARE @NuevoCosto SMALLINT;
--     DECLARE @IDMaterial SMALLINT;

--     SELECT @IDMaterial = M.IDMaterial FROM Materiales M WHERE M.Nombre = @NombreMaterial;

--     SELECT @CostoUnitaro = P.CostoUnitarioProduccion FROM Piezas P WHERE P.IDMaterial = @IDMaterial;

--     SET @NuevoCosto = @CostoUnitaro * ((@Porcentaje/100)+1)
    
--     UPDATE Piezas SET CostoUnitarioProduccion = @NuevoCosto WHERE IDMaterial = @IDMaterial
-- END

--4)
-- CREATE OR ALTER PROCEDURE SP_Punto_4(
--     @Fecha1 DATE,
--     @Fecha2 DATE
-- )
-- AS 
-- BEGIN
--     DECLARE @Mayor DATE;
--     DECLARE @Menor DATE;

--     IF @Fecha1 > @Fecha2 
--     BEGIN 
--         SET @Mayor = @Fecha1
--         SET @Menor = @Fecha2
--     END
--     ELSE 
--     BEGIN
--         SET @Mayor = @Fecha2
--         SET @Menor = @Fecha1
--     END 

--     SELECT ISNULL(SUM(P.CostoTotal),0) FROM Produccion P 
--     WHERE P.Fecha BETWEEN @Menor AND @Mayor;

-- END

--5)
-- --Opcion 1 yo
-- SELECT  M.Nombre AS MATERIAL, SUM(PR.CostoTotal) AS CostoTotalEstropeada FROM Piezas P 
-- INNER JOIN Materiales M ON M.IDMaterial = P.IDMaterial
-- INNER JOIN Produccion PR ON PR.IDPieza = P.IDPieza
-- WHERE PR.Medida < P.MedidaMinima OR PR.Medida > P.MedidaMaxima  
-- GROUP BY M.Nombre
-- HAVING SUM(PR.CostoTotal) > 100

-- --Opcion 2 Angel
-- SELECT  M.Nombre AS MATERIAL, SUM(PR.CostoTotal) AS CostoTotalEstropeada 
-- FROM Materiales M  
-- INNER JOIN Piezas P  ON M.IDMaterial = P.IDMaterial
-- INNER JOIN Produccion PR ON PR.IDPieza = P.IDPieza
-- WHERE PR.Medida NOT BETWEEN P.MedidaMinima AND P.MedidaMaxima
-- GROUP BY M.Nombre
-- HAVING SUM(PR.CostoTotal) > 100