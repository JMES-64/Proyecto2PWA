CREATE DATABASE Proyecto2PWA
GO
USE Proyecto2PWA
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Se crean las tablas

--Tabla del empleado
CREATE TABLE Empleado(
IDE int IDENTITY(1,1) NOT NULL,
Nombre varchar(max) NOT NULL,
Direccion varchar(max) NOT NULL,
Correo varchar(max) NOT NULL,
Telefono int NOT NULL,
Emergencia int NOT NULL
CONSTRAINT [PK_IDE]PRIMARY KEY CLUSTERED
(
IDE ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Tabla de roles
CREATE TABLE Roles(
IDR int IDENTITY(1,1) NOT NULL,
Rol varchar(max) NOT NULL,
Permisos varchar(max) NOT NULL,
IDE int NOT NULL,
CONSTRAINT [PK_IDR]PRIMARY KEY CLUSTERED
(
IDR ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Tabla del historial
CREATE TABLE Historial(
IDH int IDENTITY(1,1) NOT NULL,
Info varchar(max) NOT NULL,
Empleo varchar(max) NOT NULL,
IDE int NOT NULL
CONSTRAINT [PK_IDH]PRIMARY KEY CLUSTERED
(
IDH ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Tabla turnos
CREATE TABLE Turno(
IDT int IDENTITY (1,1) NOT NULL,
Turn varchar(max) NOT NULL,
DiaInicio varchar (max)NOT NULL,
DiaFinal varchar (max) NOT NULL,
Libres varchar(max) NOT NULL,
IDE int NOT NULL
CONSTRAINT [PK_IDT]PRIMARY KEY CLUSTERED
(
IDT ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Tabla Nomina
CREATE TABLE Nomina (
IDN int IDENTITY (1,1) NOT NULL,
Salario float NOT NULL,
Deducciones float NOT NULL,
Bonificaciones float NOT NULL,
Total float NOT NULL,
IDE int NOT NULL
CONSTRAINT [PK_IDN]PRIMARY KEY CLUSTERED
(
IDN ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Tabla desempe�o
CREATE TABLE Desempeno(
IDD int IDENTITY (1,1) NOT NULL,
Objetivo varchar(max) NOT NULL,
Seguimiento varchar (max) NOT NULL,
Retroalimentacion varchar(max) NOT NULL,
IDE int NOT NULL
CONSTRAINT [PK_IDD]PRIMARY KEY CLUSTERED
(
IDD ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Tabla reunion
CREATE TABLE Reunion(
IDM int IDENTITY (1,1) NOT NULL,
Fecha datetime NOT NULL,
Evaluacion int NOT NULL,
IDE int NOT NULL
CONSTRAINT [PK_IDM]PRIMARY KEY CLUSTERED
(
IDM ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Crea las llaves foraneas y las vincula
ALTER TABLE Roles  WITH CHECK ADD  CONSTRAINT [FK_Rol_Empleado] FOREIGN KEY(IDE)
REFERENCES Empleado (IDE)
GO
ALTER TABLE Roles CHECK CONSTRAINT [FK_Rol_Empleado]
GO

ALTER TABLE Historial  WITH CHECK ADD  CONSTRAINT [FK_Historial_Empleado] FOREIGN KEY(IDE)
REFERENCES Empleado (IDE)
GO
ALTER TABLE Historial CHECK CONSTRAINT [FK_Historial_Empleado]
GO

ALTER TABLE Turno  WITH CHECK ADD  CONSTRAINT [FK_Turno_Empleado] FOREIGN KEY(IDE)
REFERENCES Empleado (IDE)
GO
ALTER TABLE Turno CHECK CONSTRAINT [FK_Turno_Empleado]
GO

ALTER TABLE Nomina  WITH CHECK ADD  CONSTRAINT [FK_Nomina_Empleado] FOREIGN KEY(IDE)
REFERENCES Empleado (IDE)
GO
ALTER TABLE Nomina CHECK CONSTRAINT [FK_Nomina_Empleado]
GO

ALTER TABLE Desempeno  WITH CHECK ADD  CONSTRAINT [FK_Desempeno_Empleado] FOREIGN KEY(IDE)
REFERENCES Empleado (IDE)
GO
ALTER TABLE Desempeno CHECK CONSTRAINT [FK_Desempeno_Empleado]
GO

ALTER TABLE Reunion  WITH CHECK ADD  CONSTRAINT [FK_Reunion_Empleado] FOREIGN KEY(IDE)
REFERENCES Empleado (IDE)
GO
ALTER TABLE Reunion CHECK CONSTRAINT [FK_Reunion_Empleado]
GO

--Procedimientos almacenados
--Para editar Empleados
CREATE PROCEDURE EditaEmp(
@IDE int,
@Nombre varchar(max),
@Direccion varchar(max),
@Correo varchar(max),
@Telefono int,
@Emergencia int
)
AS BEGIN
UPDATE Empleado SET
Nombre= @Nombre,
Direccion= @Direccion,
Correo= @Correo,
Telefono= @Telefono,
Emergencia= @Emergencia
WHERE IDE=@IDE
END
GO

--Ver roles del empleado
CREATE PROCEDURE ListarR(
@IDE int
)
AS BEGIN
SELECT * FROM Roles
WHERE IDE=@IDE
END
GO

--Ver Historial del empleado
CREATE PROCEDURE ListarH(
@IDE int
)
AS BEGIN
SELECT * FROM Historial
WHERE IDE=@IDE
END
GO

--Ver Turnos del empleado
CREATE PROCEDURE ListarT(
@IDE int
)
AS BEGIN
SELECT * FROM Turno
WHERE IDE=@IDE
END
GO

--Ver Desempe�o del empleado
CREATE PROCEDURE ListarD(
@IDE int
)
AS BEGIN
SELECT * FROM Desempeno
WHERE IDE=@IDE
END
GO

--Ver Nominas del empleado
CREATE PROCEDURE ListarN(
@IDE int
)
AS BEGIN
SELECT * FROM Nomina
WHERE IDE=@IDE
END
GO

--Ver Reuniones del empleado
CREATE PROCEDURE ListarRe(
@IDE int
)
AS BEGIN
SELECT * FROM Reunion
WHERE IDE=@IDE
END
GO

--Crea la Nomina
CREATE PROCEDURE CreaN(
@Salario float,
@Deducciones float,
@Bonificaciones float,
@Total float,
@IDE int
)
AS
BEGIN
INSERT INTO Nomina(Salario,Deducciones,Bonificaciones,Total,IDE)
VALUES(
@Salario,
@Deducciones,
@Bonificaciones,
@Total,
@IDE
)
END
GO

-- Funciones de edici�n

--Para editar Roles
CREATE PROCEDURE EditaRol(
@IDR int,
@Rol varchar(max),
@Permisos varchar(max),
@IDE int
)
AS BEGIN
UPDATE Roles SET
Rol= @Rol,
Permisos= @Permisos,
IDE= @IDE
WHERE IDR=@IDR
END
GO

--Para editar desempe�o
CREATE PROCEDURE EditaDes(
@IDD int,
@Objetivo varchar(max),
@Seguimiento varchar(max),
@Retroalimentacion varchar(max),
@IDE int
)
AS BEGIN
UPDATE	Desempeno SET
Objetivo= @Objetivo,
Seguimiento= @Seguimiento,
Retroalimentacion= @Retroalimentacion,
IDE= @IDE
WHERE IDD=@IDD
END
GO

--Para editar historial
CREATE PROCEDURE EditaHis(
@IDH int,
@Info varchar(max),
@Empleo varchar(max),
@IDE int
)
AS BEGIN
UPDATE Historial SET
Info= @Info,
Empleo= @Empleo,
IDE= @IDE
WHERE IDH=@IDH
END
GO

--Editar el turno
CREATE PROCEDURE EditaT(
@IDT int,
@Turn varchar(max),
@DiaInicio varchar(max),
@DiaFinal varchar(max),
@Libres varchar (max),
@IDE int
)
AS BEGIN
UPDATE Turno SET
Turn= @Turn,
DiaInicio= @DiaInicio,
DiaFinal=@DiaFinal,
Libres= @Libres,
IDE= @IDE
WHERE IDT=@IDT
END
GO
--Borrar el empleado y toda la informaci�n relacionada
CREATE PROCEDURE BorraEmp(
@IDE int
)
AS BEGIN
DELETE FROM Desempeno
WHERE IDE=@IDE
DELETE FROM Historial
WHERE IDE=@IDE
DELETE FROM Nomina
WHERE IDE=@IDE
DELETE FROM Turno
WHERE IDE=@IDE
DELETE FROM Reunion
WHERE IDE=@IDE
DELETE FROM Roles
WHERE IDE=@IDE
DELETE FROM Empleado
WHERE IDE=@IDE
END
GO
