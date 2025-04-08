/*
=============================================================================================
DDL Scrip: Creación de tablas Plata
=============================================================================================
Objetivo del Script:
  Este script crea tablas en el esquema 'plata', eliminando tablas existentes si ya existen.
  Corre este script para redefinir la estructura DDL de las tablas 'plata'
=============================================================================================
*/

IF OBJECT_ID('plata.crm_cust_inf', 'U') IS NOT NULL
  DROP TABLE plata.crm_cust_inf;
CREATE TABLE plata.crm_cust_inf (
  cst_id INT,
  cst_key NVARCHAR(50),
  cst_firstname NVARCHAR(50),
  cst_lastname NVARCHAR(50),
  cst_marital_status NVARCHAR(50),
  cst_gndr NVARCHAR(50),
  cst_create_date DATE,
  dwh_create_data DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('plata.crm_prd_inf', 'U') IS NOT NULL
  DROP TABLE plata.crm_prd_inf;
CREATE TABLE plata.crm_prd_inf (
  prd_id INT,
  prd_key NVARCHAR(50),
  prd_nm NVARCHAR(50),
  prd_cost INT,
  prd_line NVARCHAR(50),
  prd_start_dt DATETIME,
  prd_end_dt DATETIME
  dwh_create_data DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('plata.crm_sales_details', 'U') IS NOT NULL
  DROP TABLE plata.crm_sales_details;
CREATE TABLE plata.crm_sales_details (
  sls_ord_num NVARCHAR(50),
  sls_prd_key NVARCHAR(50),
  sls_cust_id INT,
  sls_order_dt DATETIME,
  sls_ship_dt DATETIME,
  sls_due_dt DATETIME,
  sls_sales FLOAT,
  sls_quantity INT,
  sls_price FLOAT
  dwh_create_data DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('plata.erp_cust_az12', 'U') IS NOT NULL
  DROP TABLE plata.erp_cust_az12;
CREATE TABLE plata.erp_cust_az12 (
  cid NVARCHAR(50),
  bdate DATE,
  gen NVARCHAR(50)
  dwh_create_data DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('plata.erp_loc_a101', 'U') IS NOT NULL
  DROP TABLE plata.erp_loc_a101;
CREATE TABLE plata.erp_loc_a101 (
  cid NVARCHAR(50),
  cntry NVARCHAR(50)
  dwh_create_data DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('plata.erp_px_cat_g1v2', 'U') IS NOT NULL
  DROP TABLE plata.erp_px_cat_g1v2;
CREATE TABLE plata.erp_px_cat_g1v2 (
  id NVARCHAR(50),
  cat NVARCHAR(50),
  subcat NVARCHAR(50),
  maintenance NVARCHAR(50)
  dwh_create_data DATETIME2 DEFAULT GETDATE()
);

--=============================================================
--=============================================================

-- Revisar valores nulos o duplicados en la clave primaria
-- Resultado esperado: No Result

SELECT
cst_id
COUNT(*)
FROM bronce.crm_cus_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Verificar espacios no deseados
-- Resultado esperado: No results
SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(sct_lastname)

--Estandarizaciòn y consistencia de datos
SELECT DISTINCT cst_gndr
FROM bronce.crm_cust_info

--=============================================================

INSERT INTO plata.crm_cust_into (
  cst_id,
  cst_key,
  cst_firstname,
  cst_lastname,
  cst_marital_status,
  cst_gndr,
  cst_create_date)
SELECT
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE  WHEN UPPER(TRIM(cst_marital_status,)) = 'S' THEN 'Single'
      WHEN UPPER(TRIM(cst_marital_status,)) = 'M' THEN 'Married'
      ELSE 'n/a'
END AS cst_marital_status, --Normalizaciòn a formato leible
CASE  WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
      WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
      ELSE 'n/a'
END AS cst_gndr, --Normalizaciòn a formato leible
cst_create_date
FROM (
SELECT
*,
ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
FROM bronce.crm_cus_info
) t WHERE flag_last = 1; -- Seleccionar el valor maas reciente


SELECT
prd_id,
prd_key,
REPLACE(SUBSTRING(prd_key, 1, 5),'-', '_') AS cat_id,
SUBSTRING(prd_key, 7, LEN(prd_key)) AS prod_key,
prd_nm,
ISNULL(prd_cost,0) AS prd_cost,
prd_line,
CASE  UPPER(TRIM(prd_line))  
      WHEN 'M' THEN 'Mountain'
      WHEN 'R' THEN 'Road'
      WHEN 'S' THEN 'Other Sales'
      WHEN 'T' THEN 'Touring'
      ELSE 'n/a'
ENS AS prd_line
prd_start_dt,
prd_end_dt,
FROM bronce.crm_prd_info
--=============================================================
--=============================================================
EXEC plata.load_plata;
  
CREATE OR ALTER PROCEDURE plata.load_plata AS
BEGIN
  DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
  BEGIN TRY
    SET @batch_start_time = GETDATE();
    PRINT '================================================================';
    PRINT 'Cargando Capa Plata';
    PRINT '================================================================';

    PRINT '----------------------------------------------------------------';
    PRINT 'Cargando tablas CRM';
    PRINT '----------------------------------------------------------------';

    SET @start_time = GETDATE();
    PRINT '>>Truncando tabla: plata.crm_cust_inf';
    TRUNCATE TABLE plata.crm_cust_inf;

    PRINT '>>Insertando data: plata.crm_cust_inf';
    BULK INSERT plata.crm_cust_inf
    FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Tiempo de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

    SET @start_time = GETDATE();
    PRINT '>>Truncando tabla: plata.crm_prd_inf';
    TRUNCATE TABLE plata.crm_prd_inf;

    PRINT '>>Insertando data: plata.crm_prd_inf';
    BULK INSERT plata.crm_prd_inf
    FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Tiempo de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

    SET @start_time = GETDATE();
    PRINT '>>Truncando tabla: plata.crm_sales_details';
    TRUNCATE TABLE plata.crm_sales_details;

    PRINT '>>Insertando data: plata.crm_sales_details';
    BULK INSERT plata.crm_sales_details
    FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Tiempo de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

    PRINT '----------------------------------------------------------------';
    PRINT 'Cargando tablas ERP';
    PRINT '----------------------------------------------------------------';

    SET @start_time = GETDATE();
    PRINT '>>Truncando tabla: plata.erp_cust_az12';
    TRUNCATE TABLE plata.erp_cust_az12;

    PRINT '>>Insertando data: plata.erp_cust_az12';
    BULK INSERT plata.erp_cust_az12
    FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Tiempo de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

    SET @start_time = GETDATE();
    PRINT '>>Truncando tabla: plata.erp_loc_a101';
    TRUNCATE TABLE plata.erp_loc_a101;

    PRINT '>>Insertando data: plata.erp_loc_a101';
    BULK INSERT plata.erp_loc_a101
    FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Tiempo de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';

    SET @start_time = GETDATE();
    PRINT '>>Truncando tabla: plata.erp_px_cat_g1v2';
    TRUNCATE TABLE plata.erp_px_cat_g1v2;

    PRINT '>>Insertando data: plata.erp_px_cat_g1v2';
    BULK INSERT plata.erp_px_cat_g1v2
    FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      TABLOCK
    );
    SET @end_time = GETDATE();
    PRINT '>> Tiempo de carga: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
    PRINT '>>------------------';

    SET @batch_end_time = GETDATE();
    PRINT '================================================================';
    PRINT 'Carga plata completa';
    PRINT '>> Tiempo de carga total: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' segundos';
    PRINT '================================================================';

  END TRY
      
  BEGIN CATCH
    PRINT '================================================================';
    PRINT 'OCURRIÓ UN ERROR DURANTE LA CARGA DE PLATA';
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
    PRINT '================================================================';
  END CATCH
END;
