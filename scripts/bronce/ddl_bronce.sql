/*
=============================================================================================
DDL Scrip: Creación de tablas Bronce
=============================================================================================
Objetivo del Script:
  Este script crea tablas en el esquema 'bronce', eliminando tablas existentes si ya existen.
  Corre este script para redefinir la estructura DDL de las tablas 'bronce'
=============================================================================================
*/

IF OBJECT_ID ('bronce.crm_cust_inf', 'u') IS NOT NULL
  DROP TABLE bronce.crm_cust_inf;
CREATE TABLE bronce.crm_cust_inf (
  cst_id INT,
  cst_key NVARCHAR(50),
  cst_firstname NVARCHAR(50),
  cst_lastname NVARCHAR(50),
  cst_marital_status NVARCHAR(50),
  cst_gndr NVARCHAR(50),
  cst_create_date DATE
);

IF OBJECT_ID ('bronce.crm_prd_inf', 'u') IS NOT NULL
  DROP TABLE bronce.crm_prd_inf;
CREATE TABLE bronce.crm_prd_inf (
  prd_id INT,
  prd_key NVARCHAR(50),
  prd_nm NVARCHAR(50),
  prd_cost INT,
  prd_line NVARCHAR(50),
  prd_start_dt DATETIME,
  prd_end_dt DATETIME
);

IF OBJECT_ID ('bronce.crm_sales_details', 'u') IS NOT NULL
  DROP TABLE bronce.crm_sales_details;
CREATE TABLE bronce.crm_sales_details (
  sls_ord_num NVARCHAR(50),
  sls_prd_key NVARCHAR(50),
  sls_cust_id INT,
  sls_order_dt DATETIME,
  sls_ship_dt DATETIME,
  sls_due_dt DATETIME,
  sls_sales FLOAT,
  sls_quantity INT,
  sls_price FLOAT
);

IF OBJECT_ID ('bronce.erp_cust_az12', 'u') IS NOT NULL
  DROP TABLE bronce.erp_cust_az12;
CREATE TABLE bronce.erp_cust_az12 (
  cid NVARCHAR(50),
  bdate DATE,
  gen NVARCHAR(50)
);

IF OBJECT_ID ('bronce.erp_loc_a101', 'u') IS NOT NULL
  DROP TABLE bronce.erp_loc_a101 ;
CREATE TABLE bronce.erp_loc_a101 (
  cid NVARCHAR(50),
  cntry NVARCHAR(50)
);

IF OBJECT_ID ('bronce.erp_px_cat_g1v2', 'u') IS NOT NULL
  DROP TABLE bronce.erp_px_cat_g1v2;
CREATE TABLE bronce.erp_px_cat_g1v2 (
  id NVARCHAR(50),
  cat NVARCHAR(50),
  subcat NVARCHAR(50),
  maintenance NVARCHAR(50)
);

--=============================================================
--=============================================================
EXEC bronce.load_bronce
  
CREATE OR ALTER PROCEDURE bronce.load_bronce AS
  BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
      SET @bach_start_time = GETDATE();
      PRINT '================================================================';
      PRINT 'Cargando Capa Bronce';
      PRINT '================================================================';
    
      PRINT '----------------------------------------------------------------';
      PRINT 'Cargando tablas CRM';
      PRINT '----------------------------------------------------------------';

      SET @start_time = GETDATE();
      PRINT '>>Truncando tabla: bronce.crm_cust_inf'
      TRUNCATE TABLE bronce.crm_cust_inf;
  
      PRINT '>>Insertando data: bronce.crm_cust_inf'
      BULK INSERT bronce.crm_cust_inf
      FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
      WITH (
        FIRSTROW = 2,
        FIELDTERMAATOR = ',',
        TABLOCK
      );
      SET @end_time = GETDATE();
      PRINT '>> Tiempo de carga: ' + CAST(DATEIFF(second, @start_time, @end_time) AS NVARCHAR) + 'segundos';

      SET @start_time = GETDATE();
      PRINT '>>Truncando tabla: bronce.crm_prd_inf'
      TRUNCATE TABLE bronce.crm_prd_inf;
  
      PRINT '>>Insertando data: bronce.crm_prd_inf'
      BULK INSERT bronce.crm_prd_inf
      FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
      WITH (
        FIRSTROW = 2,
        FIELDTERMAATOR = ',',
        TABLOCK
      );
      SET @end_time = GETDATE();
      PRINT '>> Tiempo de carga: ' + CAST(DATEIFF(second, @start_time, @end_time) AS NVARCHAR) + 'segundos';

      SET @start_time = GETDATE();
      PRINT '>>Truncando tabla: bronce.crm_sales_details'
      TRUNCATE TABLE bronce.crm_sales_details;
  
      PRINT '>>Insertando data: bronce.crm_sales_details'
      BULK INSERT bronce.crm_sales_details
      FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
      WITH (
        FIRSTROW = 2,
        FIELDTERMAATOR = ',',
        TABLOCK
      );
      SET @end_time = GETDATE();
      PRINT '>> Tiempo de carga: ' + CAST(DATEIFF(second, @start_time, @end_time) AS NVARCHAR) + 'segundos';
  
      PRINT '----------------------------------------------------------------';
      PRINT 'Cargando tablas ERP';
      PRINT '----------------------------------------------------------------';

      SET @start_time = GETDATE();
      PRINT '>>Truncando tabla: bronce.erp_cust_az12'
      TRUNCATE TABLE bronce.erp_cust_az12;
  
      PRINT '>>Insertando data: bronce.erp_cust_az12'
      BULK INSERT bronce.erp_cust_az12
      FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
      WITH (
        FIRSTROW = 2,
        FIELDTERMAATOR = ',',
        TABLOCK
      );
      SET @end_time = GETDATE();
      PRINT '>> Tiempo de carga: ' + CAST(DATEIFF(second, @start_time, @end_time) AS NVARCHAR) + 'segundos';

      SET @start_time = GETDATE();
      PRINT '>>Truncando tabla: bronce.erp_loc_a101'
      TRUNCATE TABLE bronce.erp_loc_a101;
  
      PRINT '>>Insertando data: bronce.erp_loc_a101'
      BULK INSERT bronce.erp_loc_a101
      FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
      WITH (
        FIRSTROW = 2,
        FIELDTERMAATOR = ',',
        TABLOCK
      );
      SET @end_time = GETDATE();
      PRINT '>> Tiempo de carga: ' + CAST(DATEIFF(second, @start_time, @end_time) AS NVARCHAR) + 'segundos';

      SET @start_time = GETDATE();
      PRINT '>>Truncando tabla: bronce.erp_px_cat_g1v2'
      TRUNCATE TABLE bronce.erp_px_cat_g1v2;
  
      PRINT '>>Insertando data: bronce.erp_px_cat_g1v2'
      BULK INSERT bronce.erp_px_cat_g1v2
      FROM 'XXXXXXXXXXXXXXXXXXXXXXXX'
      WITH (
        FIRSTROW = 2,
        FIELDTERMAATOR = ',',
        TABLOCK
      );
      SET @end_time = GETDATE();
      PRINT '>> Tiempo de carga: ' + CAST(DATEIFF(second, @start_time, @end_time) AS NVARCHAR) + 'segundos';
      PRINT '>>------------------';

      SET @batch_end_time = GETDATE();
      PRINT '================================================================';
      PRINT 'Carga bronce completa';
      PRINT '>> Tiempo de carga total: ' + CAST(DATEIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'segundos';
      PRINT '================================================================';
      
    END TRY
      
    BEGIN CATCH
      PRINT '================================================================';
      PRINT 'OCURRIO UN ERROR DURANTE LA CARGA DE BRONCE';
      PRINT 'Error Messagge' + ERROR_MESSAGE();
      PRINT 'Error Messagge' + CAST (ERROR_NUMBER() AS NVARCHAR);
      PRINT 'Error Messagge' + CAST (ERROR_STATE() AS NVARCHAR);
      PRINT '================================================================';
    END CATCH
END;
