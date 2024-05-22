USE Univ 
GO
-- –1 Listado con la cantidad de cursos.
--SELECT COUNT(*) FROM Cursos

-- –2 Listado con la cantidad de usuarios.
--SELECT COUNT(*) FROM Usuarios

-- –3 Listado con el promedio de costo de certificación de los cursos.
-- SELECT AVG(CostoCertificacion) FROM Cursos

-- –4 Listado con el promedio general de calificación de reseñas.
-- SELECT AVG(Puntaje) FROM Reseñas

-- –5 Listado con la fecha de estreno de curso más antigua.
--SELECT MIN(Estreno) FROM Cursos

-- –6 Listado con el costo de certificación menos costoso.
--SELECT MIN(CostoCertificacion) FROM Cursos

-- –7 Listado con el costo total de todos los cursos.
--SELECT SUM(CostoCurso) FROM Cursos

-- –8 Listado con la suma total de todos los pagos.
--SELECT SUM(Importe) FROM Pagos

-- –9 Listado con la cantidad de cursos de nivel principiante.
-- SELECT COUNT(*) FROM Cursos C
-- INNER JOIN Niveles N ON N.ID = C.IDNivel
-- WHERE N.Nombre = 'Principiante'

-- –10 Listado con la suma total de todos los pagos realizados en 2020.
-- SELECT SUM(Importe) FROM Pagos
-- WHERE YEAR(fecha) = 2020

-- –11 Listado con la cantidad de usuarios que son instructores.
--SELECT COUNT(DISTINCT IDUsuario) FROM Instructores_x_Curso

-- –12 Listado con la cantidad de usuarios distintos que se hayan certificado.
-- SELECT COUNT(DISTINCT I.IDUsuario) FROM Certificaciones C
-- INNER JOIN Inscripciones I ON I.ID = C.IDInscripcion

-- –13 Listado con el nombre del país y la cantidad de usuarios de cada país.
-- SELECT P.Nombre, COUNT(*) FROM Usuarios U
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Localidades L ON L.ID = D.IDLocalidad
-- INNER JOIN Paises P ON P.ID = L.IDPais
-- GROUP BY P.Nombre

-- –14 Listado con el apellido y nombres del usuario y el importe más costoso abonado como pago. 
--Sólo listar aquellos que hayan abonado más de $7500.
-- SELECT D.Apellidos, D.Nombres, U.NombreUsuario, MAX(P.Importe) FROM Usuarios U
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Inscripciones I ON I.IDUsuario = U.ID
-- INNER JOIN Pagos P ON P.IDInscripcion = I.ID
-- GROUP BY D.Apellidos, D.Nombres, U.NombreUsuario
-- HAVING MAX(P.Importe) > 7500 

-- –15 Listado con el apellido y nombres de usuario de cada usuario y el importe más costoso del curso al 
--cual se haya inscripto. Si hay usuarios sin inscripciones deben figurar en el listado de todas maneras.
-- SELECT D.Apellidos, D.Nombres, U.NombreUsuario, MAX(C.CostoCertificacion) FROM Usuarios U
-- LEFT JOIN Datos_Personales D ON D.ID = U.ID
-- LEFT JOIN Inscripciones I ON I.IDUsuario = U.ID
-- LEFT JOIN Cursos C ON C.ID = I.IDCurso
-- GROUP BY D.Apellidos, D.Nombres, U.NombreUsuario
 
-- –16 Listado con el nombre del curso, nombre del nivel, cantidad total de clases y duración total del curso en minutos.
-- SELECT C.Nombre, N.Nombre, COUNT(CL.ID), SUM(CL.Duracion) FROM Cursos C
-- INNER JOIN Niveles N ON N.ID = C.IDNivel
-- INNER JOIN Clases CL ON CL.IDCurso = C.ID
-- GROUP BY C. ID, C.Nombre, N.Nombre

-- –17 Listado con el nombre del curso y cantidad de contenidos registrados. Sólo listar aquellos cursos 
--que tengan más de 10 contenidos registrados.
-- SELECT C.Nombre, COUNT(CN.ID) FROM Cursos C
-- INNER JOIN Clases CL ON CL.IDCurso = C.ID
-- INNER JOIN Contenidos CN ON CN.IDClase = CL.ID
-- GROUP BY C.Nombre
-- HAVING COUNT(CN.ID) > 10

-- –18 Listado con nombre del curso, nombre del idioma y cantidad de tipos de idiomas.
-- SELECT C.Nombre, I.Nombre, COUNT(IC.IDFormatoIdioma) FROM Cursos C
-- INNER JOIN Idiomas_x_Curso IC ON IC.IDCurso = C.ID
-- INNER JOIN Idiomas I ON I.ID = IC.IDIdioma
-- GROUP BY I.Nombre, C.Nombre

-- –19 Listado con el nombre del curso y cantidad de idiomas distintos disponibles.
-- SELECT C.Nombre, COUNT(I.ID) FROM Cursos C
-- INNER JOIN Idiomas_x_Curso IC ON IC.IDCurso = C.ID
-- INNER JOIN Idiomas I ON I.ID = IC.IDIdioma
-- GROUP BY C.Nombre

-- –20 Listado de categorías de curso y cantidad de cursos asociadas a cada categoría. 
--Sólo mostrar las categorías con más de 5 cursos.
-- SELECT C.Nombre, COUNT(CU.ID) FROM Categorias C
-- INNER JOIN Categorias_x_Curso CC  ON CC.IDCategoria = C.ID
-- INNER JOIN Cursos CU ON CU.ID = CC.IDCurso
-- GROUP BY C.Nombre
-- HAVING COUNT(CU.ID) > 5

-- –21 Listado con tipos de contenido y la cantidad de contenidos asociados a cada tipo. 
--Mostrar también aquellos tipos que no hayan registrado contenidos con cantidad 0.
-- SELECT TC.Nombre, COUNT(C.ID) FROM TiposContenido TC
-- LEFT JOIN Contenidos C ON C.IDTipo = TC.ID
-- GROUP BY TC.Nombre

-- –22 Listado con Nombre del curso, nivel, año de estreno y el total recaudado en concepto de inscripciones. 
--Listar también aquellos cursos sin inscripciones con total igual a $0.
-- SELECT C.Nombre, N.Nombre, YEAR(C.Estreno), SUM(P.Importe) FROM Cursos C
-- INNER JOIN Niveles N ON N.ID = C.IDNivel
-- LEFT JOIN Inscripciones I ON I.IDCurso = C.ID
-- LEFT JOIN Pagos P ON P.IDInscripcion = I.ID
-- GROUP BY C.ID, C.Nombre, N.Nombre, C.Estreno

-- –23 Listado con Nombre del curso, costo de cursado y certificación y cantidad de usuarios distintos inscriptos
-- cuyo costo de cursado sea menor a $10000 y cuya cantidad de usuarios inscriptos sea menor a 5. 
--Listar también aquellos cursos sin inscripciones con cantidad 0.
-- SELECT C.Nombre, C.CostoCurso, C.CostoCertificacion, COUNT(DISTINCT U.ID) FROM Cursos C
-- LEFT JOIN Inscripciones I ON I.IDCurso = C.ID
-- INNER JOIN Usuarios U ON U.ID = I.IDUsuario
-- WHERE C.CostoCurso < 10000
-- GROUP BY C.ID, C.Nombre, C.CostoCurso, C.CostoCertificacion
-- HAVING COUNT(DISTINCT U.ID) <5 

-- –24 Listado con Nombre del curso, fecha de estreno y nombre del nivel del curso que 
--más recaudó en concepto de certificaciones.
-- SELECT TOP 1 C.Nombre, N.Nombre, C.Estreno, COUNT(C.CostoCertificacion) AS TotalCertificaciones FROM Cursos C
-- INNER JOIN Niveles N ON N.ID = C.IDNivel
-- LEFT JOIN Inscripciones I ON I.IDCurso = C.ID
-- LEFT JOIN Certificaciones CC ON CC.IDInscripcion = I.ID
-- GROUP BY C.ID, C.Nombre, N.Nombre, C.Estreno
-- ORDER BY TotalCertificaciones DESC

-- –25 Listado con Nombre del idioma del idioma más utilizado como subtítulo.
-- SELECT TOP 1 I.Nombre, COUNT(*) FROM Idiomas I
-- INNER JOIN Idiomas_x_Curso IC ON IC.IDIdioma = I.ID
-- INNER JOIN Cursos C ON C.ID = IC.IDCurso
-- WHERE IC.IDFormatoIdioma = 1
-- GROUP BY I.Nombre

-- –26 Listado con Nombre del curso y promedio de puntaje de reseñas apropiadas.
-- SELECT C.Nombre, AVG(Puntaje) FROM Reseñas R
-- INNER JOIN Inscripciones I ON I.ID = R.IDInscripcion
-- INNER JOIN Cursos C ON C.ID = I.IDCurso
-- GROUP BY C.Nombre

-- –27 Listado con Nombre de usuario y la cantidad de reseñas inapropiadas que registró.
-- SELECT U.NombreUsuario, COUNT(R.Inapropiada) FROM Reseñas R
-- INNER JOIN Inscripciones I ON I.ID = R.IDInscripcion
-- INNER JOIN Usuarios U ON U.ID = I.IDUsuario
-- WHERE R.Inapropiada = 1
-- GROUP BY U.NombreUsuario

-- –28 Listado con Nombre del curso, nombre y apellidos de usuarios y la cantidad de veces que 
--dicho usuario realizó dicho curso. No mostrar cursos y usuarios que contabilicen cero.
-- SELECT C.Nombre, D.Apellidos, D.Nombres, U.NombreUsuario, COUNT(*) FROM Usuarios U
-- INNER JOIN Datos_Personales D ON D.ID = U.ID
-- INNER JOIN Inscripciones I ON I.IDUsuario = U.ID
-- INNER JOIN Cursos C ON C.ID = I.IDCurso
-- GROUP BY C.Nombre, D.Apellidos, D.Nombres, U.NombreUsuario

-- –29 Listado con Apellidos y nombres, mail y duración total en concepto de clases de cursos a los que
-- se haya inscripto. Sólo listar información de aquellos registros cuya duración total supere los 400 minutos.


-- –30 Listado con nombre del curso y recaudación total. La recaudación total consiste en la sumatoria de costos
-- de inscripción y de certificación. Listarlos ordenados de mayor a menor por recaudación.
