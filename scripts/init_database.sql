/*
=======================================================================
Crear la Base de datos y esquemas
=======================================================================
Script:
  Este script crea una nueva base de datos 'DataWarehouse' después de verificar si ya existe.
  Si existe la base de datos, se elimina y se crea nuevamente. Así mismo crea tres esquemas en la base de datos: 'bronce', 'plata' y 'oro'.
*/

USE MASTER;
GO

-- Eliminar y recrear la base de datos 'DataWarehouse'
IF EXISTS (SELECT 1 FROM sys.databases WHWRE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO

--Crear la base de datos 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--Crear esquemas
CREATE SCHEMA bronce;
GO

CREATE SCHEMA plata;
GO

CREATE SCHEMA oro;
GO
