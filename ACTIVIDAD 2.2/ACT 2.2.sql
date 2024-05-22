Use Univ
Go

-- 1 Listado con nombre de usuario de todos los usuarios y sus respectivos nombres y apellidos.
-- SELECT U.*, D.Nombres, D.Apellidos  FROM Usuarios U
-- INNER JOIN Datos_Personales D ON U.ID = D.ID

-- 2 Listado con apellidos, nombres, fecha de nacimiento y nombre del país de nacimiento. 
-- SELECT D.Apellidos, D.Nombres, D.Nacimiento, P.Nombre FROM Datos_Personales D
-- INNER JOIN Localidades L ON D.IDLocalidad = L.ID
-- INNER JOIN Paises P ON L.IDPais = P.ID

-- 3 Listado con nombre de usuario, apellidos, nombres, email o celular de todos los usuarios que vivan en una domicilio comience con vocal. 
--NOTA: Si no tiene email, obtener el celular.
-- SELECT U.NombreUsuario, D.Nombres, D.Apellidos,
-- CASE 
--     WHEN D.Email IS NOT NULL THEN Email
--     ELSE D.Celular
-- END AS 'Contacto'
-- FROM Usuarios U
-- INNER JOIN Datos_Personales D ON U.ID = D.ID
-- WHERE D.Domicilio LIKE '[AEIOUaeiou]%' 

--  4 Listado con nombre de usuario, apellidos, nombres, email o celular o domicilio como 'Información de contacto'.
--NOTA: Si no tiene email, obtener el celular y si no posee celular obtener el domicilio.
-- SELECT U.NombreUsuario, D.Nombres, D.Apellidos,
-- CASE 
--     WHEN D.Email IS NOT NULL THEN Email
--     WHEN D.Celular IS NOT NULL THEN Celular
--     ELSE D.Domicilio
-- END AS 'Informacion de Contacto'
-- FROM Usuarios U
-- INNER JOIN Datos_Personales D ON U.ID = D.ID

--  5 Listado con apellido y nombres, nombre del curso y costo de la inscripción de todos los usuarios inscriptos a cursos.
--NOTA: No deben figurar los usuarios que no se inscribieron a ningún curso.
-- SELECT D.Apellidos, D.Nombres, C.Nombre, I.Costo FROM Usuarios U
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Inscripciones I ON I.IDUsuario = U.ID
-- INNER JOIN Cursos C ON C.ID = I.IDCurso
-- ORDER BY D.Apellidos

--  6 Listado con nombre de curso, nombre de usuario y mail de todos los inscriptos a cursos que se hayan estrenado en el año 2020.
-- SELECT C.Nombre, U.NombreUsuario, D.Email FROM Inscripciones I
-- INNER JOIN Usuarios U ON U.ID = I.IDUsuario  
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Cursos C ON C.ID = I.IDCurso
-- WHERE YEAR(C.Estreno) = 2020
-- ORDER BY D.Apellidos

--  7 Listado con nombre de curso, nombre de usuario, apellidos y nombres, fecha de inscripción, costo de inscripción, fecha de pago e importe de pago.
--Sólo listar información de aquellos que hayan pagado.
-- SELECT C.Nombre, U.NombreUsuario, D.Apellidos, D.Nombres, I.Fecha, I.Costo, PA.Fecha, PA.Importe FROM Usuarios U
-- INNER JOIN Inscripciones I ON I.IDUsuario = U.ID 
-- INNER JOIN Pagos PA ON PA.IDInscripcion = I.ID
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Cursos C ON C.ID = I.IDCurso
-- WHERE PA.Importe > 0 
-- ORDER BY D.Apellidos

--  8 Listado con nombre y apellidos, género, fecha de nacimiento, mail, nombre del curso y fecha de certificación de todos aquellos usuarios 
--que se hayan certificado.
-- SELECT D.Apellidos, D.Nombres, D.Genero, D.Nacimiento, D.Email, C.Nombre, CE.Fecha FROM Usuarios U
-- INNER JOIN Inscripciones I ON I.IDUsuario = U.ID 
-- INNER JOIN Pagos PA ON PA.IDInscripcion = I.ID
-- INNER JOIN Certificaciones CE ON CE.IDInscripcion = I.ID
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Cursos C ON C.ID = I.IDCurso
-- WHERE PA.Importe > 0 
-- ORDER BY D.Apellidos

--  9 Listado de cursos con nombre, costo de cursado y certificación, costo total (cursado + certificación) con 10% de todos los cursos de 
--nivel Principiante.
-- SELECT  C.Nombre, C.CostoCurso, CE.Fecha,  (C.CostoCurso + C.CostoCertificacion)*0.9 AS 'COSTO TOTAL', N.Nombre FROM Cursos C 
-- INNER JOIN Inscripciones I ON I.IDCurso = C.ID 
-- INNER JOIN Certificaciones CE ON CE.IDInscripcion = I.ID
-- INNER JOIN Niveles N ON N.ID = C.IDNivel 
-- WHERE N.Nombre = 'Principiante'

--  10 Listado con nombre y apellido y mail de todos los instructores. Sin repetir.
-- SELECT DISTINCT D.Apellidos, D.Nombres, D.Email FROM Instructores_x_Curso INS
-- INNER JOIN Usuarios U ON U.ID = INS.IDUsuario
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- ORDER BY D.Apellidos

--  11 Listado con nombre y apellido de todos los usuarios que hayan cursado algún curso cuya categoría sea 'Historia'.
-- SELECT DISTINCT D.Apellidos, D.Nombres FROM Inscripciones I
-- INNER JOIN Usuarios U ON U.ID = I.IDUsuario
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Categorias_x_Curso CC ON CC.IDCurso = I.IDCurso
-- INNER JOIN Categorias C ON C.ID = CC.IDCategoria
-- WHERE C.Nombre = 'Historia'
-- ORDER BY D.Apellidos

--  12 Listado con nombre de idioma, código de curso y código de tipo de idioma. Listar todos los idiomas indistintamente si no tiene cursos 
--relacionados.
-- SELECT DISTINCT I.Nombre, IC.IDCurso, IC.IDFormatoIdioma FROM Idiomas I
-- LEFT JOIN  Idiomas_x_Curso IC ON IC.IDIdioma = I.ID
-- LEFT JOIN  Cursos C ON C.ID = IC.IDCurso

--  13 Listado con nombre de idioma de todos los idiomas que no tienen cursos relacionados.
-- SELECT DISTINCT I.Nombre FROM Idiomas I
-- LEFT JOIN  Idiomas_x_Curso IC ON IC.IDIdioma = I.ID
-- LEFT JOIN  Cursos C ON C.ID = IC.IDCurso
-- WHERE IC.IDCurso IS NULL

--  14 Listado con nombres de idioma que figuren como audio de algún curso. Sin repeticiones.
-- SELECT DISTINCT I.Nombre FROM Idiomas I
-- INNER JOIN  Idiomas_x_Curso IC ON IC.IDIdioma = I.ID
-- INNER JOIN  FormatosIdioma F ON F.ID = IC.IDFormatoIdioma
-- INNER JOIN  Cursos C ON C.ID = IC.IDCurso
-- WHERE F.ID = 2

--  15 Listado con nombres y apellidos de todos los usuarios y el nombre del país en el que nacieron. Listar todos los países
-- indistintamente si no tiene usuarios relacionados.
-- SELECT D.Apellidos, D.Nombres, P.Nombre FROM Usuarios U
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Localidades L ON D.IDLocalidad = L.ID
-- RIGHT JOIN Paises P ON L.IDPais = P.ID

--  16 Listado con nombre de curso, fecha de estreno y nombres de usuario de todos los inscriptos. Listar todos los nombres de usuario 
--indistintamente si no se inscribieron a ningún curso.
-- SELECT C.Nombre, C.Estreno, U.NombreUsuario FROM Inscripciones I  
-- INNER JOIN Cursos C ON C.ID = I.IDCurso
-- RIGHT JOIN Usuarios U ON U.ID = I.IDUsuario

--  17 Listado con nombre de usuario, apellido, nombres, género, fecha de nacimiento y mail de todos los usuarios que no cursaron ningún curso.
-- SELECT U.NombreUsuario, D.Apellidos, D.Nombres, D.Genero, D.Nacimiento, D.Email FROM Usuarios U
-- LEFT JOIN Inscripciones I ON I.IDUsuario = U.ID 
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- LEFT JOIN Cursos C ON C.ID = I.IDCurso
-- WHERE C.ID IS NULL
-- ORDER BY D.Apellidos

--  18 Listado con nombre y apellido, nombre del curso, puntaje otorgado y texto de la reseña. Sólo de aquellos usuarios que hayan realizado una
-- reseña inapropiada.
-- SELECT U.NombreUsuario, D.Apellidos, C.Nombre, R.Puntaje, R.Observaciones FROM Usuarios U
-- INNER JOIN Inscripciones I ON I.IDUsuario = U.ID 
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Cursos C ON C.ID = I.IDCurso
-- INNER JOIN Reseñas R ON R.IDInscripcion = I.ID
-- WHERE R.Inapropiada = 1
-- ORDER BY D.Apellidos

--  19 Listado con nombre del curso, costo de cursado, costo de certificación, nombre del idioma y nombre del tipo de idioma de todos 
--los cursos cuya fecha de estreno haya sido antes del año actual. Ordenado por nombre del curso y luego por nombre de tipo de idioma.
-- Ambos ascendentemente.
-- SELECT  C.Nombre, C.CostoCurso, C.CostoCertificacion, I.Nombre, F.Nombre FROM Cursos C 
-- INNER JOIN  Idiomas_x_Curso IC ON IC.IDCurso = C.ID
-- INNER JOIN Idiomas I ON I.ID = IC.IDIdioma 
-- INNER JOIN  FormatosIdioma F ON F.ID = IC.IDFormatoIdioma
-- WHERE YEAR(C.Estreno) < 2024
-- ORDER BY C.NOMBRE ASC, F.Nombre ASC

--  20 Listado con nombre del curso y todos los importes de los pagos relacionados.
-- SELECT C.Nombre, PA.Importe FROM Cursos C 
-- INNER JOIN Inscripciones I ON I.IDCurso = C.ID
-- INNER JOIN Pagos PA ON PA.IDInscripcion = I.ID

-- 21 Listado con nombre de curso, costo de cursado y una leyenda que indique "Costoso" si el costo de cursado es mayor a $ 15000, 
--"Accesible" si el costo de cursado está entre $2500 y $15000, "Barato" si el costo está entre $1 y $2499 y "Gratis" si el costo es $0.
-- SELECT C.Nombre, C.CostoCurso, 
-- CASE 
--     WHEN C.CostoCurso > 15000 THEN 'Costoso'
--     WHEN C.CostoCurso BETWEEN 2500 AND 15000 THEN 'Accesible'
--     WHEN C.CostoCurso BETWEEN 1 AND 2499 THEN 'Barato'
--     WHEN C.CostoCurso = 0 THEN 'Gratis'
-- END AS 'LEYENDA'
-- FROM Cursos C 
-- ORDER BY CostoCurso DESC


