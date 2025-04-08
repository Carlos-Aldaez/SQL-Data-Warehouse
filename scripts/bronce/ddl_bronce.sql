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
