/*
================================================================================
Procedimeinto de almacenamiento: Carga de capa bronce (Fuente -> Bronce)
================================================================================
Onjevo del script:
  Almacenar el procedimeinto de carga de datos externos de los docuemntos CSV en el esquema 'bronce'
  Ejecuta las siguientes accciones:
  - Truncar las tablas bronce antes de cargar la data.
  - Usa el comando 'BULK INSERT' para cargar la data de los archivos CSV en las tablas bronce.

Parametros:
  None,
  Este procedimiento almacenado no acepta ningun parametro o retorna ningun valor.

Ejemplo de uso:
  EXEC bonce.load_bronce;
================================================================================
*/
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
