/*
===============================================================================
  Project      : Data Warehouse and Analytics Project
  Script Name  : silver_ddl.sql
  Layer        : Silver (Cleaned Data Layer)
  Description  : Creates Silver tables for CRM and ERP source data.
  Author       : Sujal Kesharwani
  Created Date : 2026-11-24

  WARNING:
  This script drops existing Silver tables before recreating them.
  Any data stored in these tables will be permanently deleted.
  Make sure you have a backup before execution.
===============================================================================
*/

USE Datawarehouse;
GO

-- ============================================================
-- CRM TABLES
-- ============================================================

IF OBJECT_ID('Silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE Silver.crm_cust_info;
GO

CREATE TABLE Silver.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gender NVARCHAR(50),
    cst_Create_date DATE,
    dwh_create_date datetime2 default getdate()
);
GO


IF OBJECT_ID('Silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE Silver.crm_prd_info;
GO

CREATE TABLE Silver.crm_prd_info (
    prd_id INT,
    cat_id NVARCHAR(50),
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_create_date datetime2 default getdate()
);
GO


IF OBJECT_ID('Silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE Silver.crm_sales_details;
GO

CREATE TABLE Silver.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    dwh_create_date datetime2 default getdate()
);
GO


-- ============================================================
-- ERP TABLES
-- ============================================================

IF OBJECT_ID('Silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE Silver.erp_loc_a101;
GO

CREATE TABLE Silver.erp_loc_a101 (
    cid NVARCHAR(50),
    cntry NVARCHAR(50),
    dwh_create_date datetime2 default getdate()
);
GO


IF OBJECT_ID('Silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE Silver.erp_cust_az12;
GO

CREATE TABLE Silver.erp_cust_az12 (
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50),
    dwh_create_date datetime2 default getdate()
);
GO


IF OBJECT_ID('Silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE Silver.erp_px_cat_g1v2;
GO

CREATE TABLE Silver.erp_px_cat_g1v2 (
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintanance NVARCHAR(50),
    dwh_create_date datetime2 default getdate()
);
GO

-- ============================================================
-- SILVER TABLE CREATION COMPLETED
-- ============================================================

PRINT 'Silver Layer Tables Created Successfully!';
GO
