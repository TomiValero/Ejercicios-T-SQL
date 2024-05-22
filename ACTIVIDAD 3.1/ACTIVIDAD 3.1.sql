USE Univ
ELSE
    BEGIN
        -- Opcional: Agregar un mensaje de error o una lógica adicional aquí
        PRINT 'El importe excede el costo total de la inscripción.'
    END
GO
-- 1 Hacer una función llamada FN_PagosxUsuario que a partir de un IDUsuario devuelva el total abonado en concepto de pagos. Si no hay pagos debe retornar 0.

-- CREATE OR ALTER FUNCTION FN_PagosxUsuario(
--     @ID_Usuario INT 
-- )
-- RETURNS MONEY 
-- AS
-- BEGIN 
--     DECLARE @TotalAbonado MONEY 
--     SELECT @TotalAbonado = (
--         SELECT SUM(P.Importe) FROM Pagos P
--         INNER JOIN Inscripciones I ON I.ID = P.IDInscripcion
--         WHERE I.IDUsuario = @ID_Usuario
--     )

--     IF @TotalAbonado IS NULL 
--     BEGIN 
--          SET @TotalAbonado = 0
--     END
--     RETURN @TotalAbonado
-- END  

-- SELECT U.NombreUsuario, dbo.FN_PagosxUsuario(U.ID) FROM Usuarios U

-- 2 Hacer una función llamada FN_DeudaxUsuario que a partir de un IDUsuario devuelva el total adeudado. Si no hay deuda debe retornar 0. 

-- CREATE OR ALTER FUNCTION FN_DeudaxUsuario(
--     @ID_Usuario INT 
-- )
-- RETURNS MONEY 
-- AS
-- BEGIN 
--     DECLARE @TotalAdeudado MONEY 
--     SELECT @TotalAdeudado = (
--         SELECT (SUM(I.Costo)-SUM(P.Importe)) FROM Pagos P
--         INNER JOIN Inscripciones I ON I.ID = P.IDInscripcion
--         WHERE I.IDUsuario = @ID_Usuario
--     )

--     IF @TotalAdeudado IS NULL 
--     BEGIN 
--          SET @TotalAdeudado = 0
--     END
--     RETURN @TotalAdeudado
-- END  

-- SELECT U.NombreUsuario, dbo.FN_DeudaxUsuario(U.ID) FROM Usuarios U


-- 3 Hacer una función llamada FN_CalcularEdad que a partir de un IDUsuario devuelva la edad del mismo. La edad es un valor entero.

-- CREATE OR ALTER FUNCTION FN_CalcularEdad(
--     @ID_Usuario INT 
-- )
-- RETURNS INT 
-- AS
-- BEGIN 
--     DECLARE @FechaNacimiento DATE
--     SELECT @FechaNacimiento = (SELECT D.Nacimiento FROM Datos_Personales D WHERE D.ID = @ID_Usuario)
--     DECLARE @Edad INT 
     
--     SET @Edad = DATEDIFF(YEAR, @FechaNacimiento, GETDATE()) - 
--             CASE 
--                 WHEN (MONTH(@FechaNacimiento) > MONTH(GETDATE())) OR 
--                      (MONTH(@FechaNacimiento) = MONTH(GETDATE()) AND DAY(@FechaNacimiento) > DAY(GETDATE())) 
--                 THEN 1 
--                 ELSE 0 
--             END;
--     RETURN @Edad 
-- END  

-- SELECT U.NombreUsuario, dbo.FN_CalcularEdad(U.ID) FROM Usuarios U

-- 4 Hacer una función llamada Fn_PuntajeCurso que a partir de un IDCurso devuelva el promedio de puntaje en concepto de reseñas.

-- CREATE OR ALTER FUNCTION Fn_PuntajeCurso(
--     @ID_Curso INT 
-- )
-- RETURNS MONEY 
-- AS
-- BEGIN 
--     DECLARE @PromPuntaje MONEY 
--     SELECT @PromPuntaje = (
--         SELECT AVG(R.Puntaje) FROM Reseñas R
--         INNER JOIN Inscripciones I ON I.ID = R.IDInscripcion
--         WHERE I.IDCurso = @ID_Curso
--     )
--     RETURN @PromPuntaje
-- END 

-- SELECT C.Nombre, dbo.Fn_PuntajeCurso(C.ID) FROM Cursos C



-- 5 Hacer una vista que muestre por cada usuario el apellido y nombre, una columna llamada Contacto que muestre el celular, si no tiene celular el teléfono, si no tiene teléfono el email, si no tiene email el domicilio. También debe mostrar la edad del usuario, el total pagado y el total adeudado.

-- CREATE OR ALTER VIEW VW_VistaP5 AS
-- SELECT D.Apellidos, D.Nombres, 
-- CASE 
--      WHEN D.Celular IS NOT NULL THEN D.Celular
--     WHEN D.Celular IS NULL AND D.Telefono IS NOT NULL THEN D.Telefono
--     WHEN D.Telefono IS NULL AND D.Email IS NOT NULL THEN D.Email
--     ELSE D.Domicilio
-- END AS CONTACTO,
-- dbo.FN_CalcularEdad(D.ID) AS EDAD,
-- dbo.FN_PagosxUsuario(D.ID) AS PAGADO,
-- dbo.FN_DeudaxUsuario(D.ID) AS DEUDA
-- FROM Datos_Personales D


-- SELECT * FROM VW_VistaP5

-- 6 Hacer uso de la vista creada anteriormente para obtener la cantidad de usuarios que adeuden más de los que pagaron.

-- SELECT COUNT(*) FROM VW_VistaP5 V
-- WHERE V.DEUDA > V.PAGADO

-- 7 Hacer un procedimiento almacenado que permita dar de alta un nuevo curso. Debe recibir todos los valores necesarios para poder insertar un nuevo registro.

-- CREATE OR ALTER PROCEDURE SP_AltaCurso(
--     @IDNivel TINYINT,
--     @Nombre VARCHAR(100),
--     @CostoCurso MONEY,
--     @CostoCertificacion MONEY,
--     @Estreno DATE
-- )
-- AS 
-- BEGIN
--     INSERT INTO Cursos (IDNivel, Nombre, CostoCurso, CostoCertificacion, Estreno)
--     VALUES (@IDNivel, @Nombre, @CostoCurso, @CostoCertificacion, @Estreno)
-- END

-- EXEC SP_AltaCurso 7, 'ALGEBRA', 40000, 800, '2024-9-15'

-- 8 Hacer un procedimiento almacenado que permita modificar porcentualmente el Costo de Cursada de todos los cursos. El procedimiento debe recibir un valor numérico que representa el valor a aumentar porcentualmente. Por ejemplo, si recibe un 60. Debe aumentar un 60% todos los costos.

-- CREATE OR ALTER PROCEDURE SP_AumentarCursos(
--     @Aumento INT
-- )
-- AS 
-- BEGIN
--     UPDATE Cursos SET CostoCurso =CostoCurso + ((CostoCurso*@Aumento)/100)
-- END


-- 9 Hacer un procedimiento almacenado llamado SP_PagarInscripcion que a partir de un IDInscripcion permita hacer un pago de la inscripción. El pago puede ser menor al costo de la inscripción o bien el total del mismo. El sistema no debe permitir que el usuario pueda abonar más dinero para una inscripción que el costo de la misma. Se debe registrar en la tabla de pagos con la información que corresponda.

-- CREATE OR ALTER PROCEDURE SP_PagarInscripcion(
--     @IDInscripcion INT,
--     @Fecha DATE,
--     @Importe MONEY
-- )
-- AS 
-- BEGIN
--     SET @Fecha = ISNULL(@Fecha,getdate())
--     DECLARE @IDUsuario INT
--     SELECT @IDUsuario = IDUsuario  FROM Inscripciones WHERE @IDInscripcion = ID
--     IF @Importe <= dbo.FN_DeudaxUsuario(@IDUsuario)
--     BEGIN 
--         INSERT INTO PAGOS (IDInscripcion, Fecha, Importe)
--         VALUES (@IDInscripcion, @Fecha, @Importe)
--     END
--     ELSE
--     BEGIN
--         PRINT 'El importe excede el costo total de la inscripción.'
--     END
-- END


-- 10 Hacer un procedimiento almacenado llamado SP_InscribirUsuario que reciba un IDUsuario y un IDCurso y realice la inscripción a dicho curso de ese usuario. El procedimiento debe realizar las siguientes comprobaciones: - El usuario no debe registrar deuda para poder inscribirse. - El usuario debe ser mayor de edad si el curso requiere esa condición. En caso que estas comprobaciones sean satisfechas entonces registrar la inscripción. Determinar el costo de la inscripción al valor actual del curso. Si alguna comprobación no se cumple, indicarlo con un mensaje de error correspondiente.

-- CREATE OR ALTER PROCEDURE SP_InscribirUsuario(
--     @IDUsuario INT,
--     @IDCurso INT,
--     @Fecha DATE
-- )
-- AS 
-- BEGIN
--     IF dbo.FN_DeudaxUsuario(@IDUsuario) = 0 
--     BEGIN
--          IF dbo.FN_CalcularEdad(@IDUsuario) > 18 
--         BEGIN
--             SET @Fecha = ISNULL(@Fecha,getdate())
--             DECLARE @Costo MONEY
--             SELECT @Costo = CostoCurso  FROM Cursos WHERE @IDCurso = ID
--             INSERT INTO Inscripciones (IDUsuario, IDCurso, Fecha, Costo)
--             VALUES (@IDUsuario, @IDCurso, @Fecha, @Costo)
--         END
--         ELSE
--         BEGIN
--          PRINT 'EL USUARIO ES MENOR'
--         END
--     END
--     ELSE
--     BEGIN
--          PRINT 'EL USUARIO TIENE DEUDA'
--     END
-- END
 
-- EXEC SP_InscribirUsuario 25,7,'2024-5-5' 

