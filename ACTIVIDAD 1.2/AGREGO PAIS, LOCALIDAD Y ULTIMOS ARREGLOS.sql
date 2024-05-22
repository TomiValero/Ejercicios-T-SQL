USE ACTIVIDAD_1_2_20241C
GO
-- ALTER TABLE INSCRIPCIONES
-- ADD COSTO MONEY NOT NULL 
--ALTER TABLE RESENIAS
--ADD PUNTAJE DECIMAL(3, 1) NOT NULL CHECK(PUNTAJE BETWEEN 0 AND 10); 
--ADD INAPROPIADA BIT NOT NULL DEFAULT(0);\
-- ALTER TABLE USUARIOS
-- ADD CLAVE VARCHAR(512) NOT NULL DEFAULT('');
--ALTER TABLE PAGOS
-- DROP CONSTRAINT PK__PAGOS__B4AC38C03502960B
--ADD CONSTRAINT PK__PAGOS__ID PRIMARY KEY(ID_INSCRIPCION)

CREATE TABLE PAISES (
    ID_PAIS INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    NOMBRE VARCHAR(50) NOT NULL
)
GO
CREATE TABLE LOCALIDADES (
    ID_LOCALIDADES INT NOT NULL PRIMARY KEY,
    IDPAIS INT NOT NULL FOREIGN KEY REFERENCES PAISES(ID_PAIS),
    NOMBRE VARCHAR(50) NOT NULL
)
GO
ALTER TABLE INFO_PERSONAL
ADD ID_LOCALIDAD INT NOT NULL FOREIGN KEY REFERENCES LOCALIDADES(ID_LOCALIDADES)