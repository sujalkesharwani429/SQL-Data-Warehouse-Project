
/*
===============================================================================
                        BRONZE LAYER - DATA INGESTION
===============================================================================

Project       : Data Warehouse and Analytics Project
Script Name   : bronze_load.sql
Author        : Sujal Kesharwani
Created Date  : 2026-11-23
Layer         : Bronze (Raw Data Layer)

Description:
    This stored procedure loads raw data from CRM and ERP source
    systems into the corresponding Bronze Layer tables.

Source Systems:
    CRM - Customer Relationship Management
    ERP - Enterprise Resource Planning

Tables Loaded:

    CRM:
        1. bronze.crm_cust_info
        2. bronze.crm_prd_info
        3. bronze.crm_sales_details

    ERP:
        4. bronze.erp_loc_a101
        5. bronze.erp_cust_az12
        6. bronze.erp_px_cat_g1v2

Loading Method:
    - TRUNCATE TABLE : Removes existing records.
    - BULK INSERT    : Loads raw CSV data into SQL Server.
    - FIRSTROW = 2   : Skips the CSV header row.
    - TABLOCK        : Applies table-level locking.

Execution:
    EXEC Bronze.load_bronze;

WARNING:
    1. This procedure truncates existing table data before loading.
    2. Failed loads may leave tables empty or partially populated.
    3. Verify source file paths and SQL Server permissions.
    4. Ensure source CSV structures match destination table definitions.
    5. Do not execute against production data without authorization
       and a verified backup.

===============================================================================
*/
Create or alter procedure bronze. load_bronze as
Begin

print '==========================================================='
print 'Loading Bronze Layer'
print '==========================================================='

print '-----------------------------------------------------------'
print 'Loading CRM Table'
print '-----------------------------------------------------------'
print '*********************************************************************'

print '---------------------------------------------------------------------' 
print 'Table = bronze.crm_cust_info;'
Truncate table bronze.crm_cust_info;

Bulk Insert bronze.crm_cust_info
from 'C:\Users\sujal\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    Tablock 
);
print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 

print '=============================================================================================='

print '---------------------------------------------------------------------' 
print 'Table = bronze.crm_prd_info;'

Truncate table Bronze.crm_prd_info 

Bulk Insert Bronze.crm_prd_info
from 'C:\Users\sujal\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    Tablock 
);
print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 

print '=============================================================================================='

print '---------------------------------------------------------------------' 
print 'Table = bronze.crm_sales_details;'
 

Truncate table bronze.crm_sales_details;

Bulk Insert bronze.crm_sales_details
from 'C:\Users\sujal\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    Tablock 
);

print '-----------------------------------------------------------'
print 'Loading ERP Table'
print '-----------------------------------------------------------'
print '*********************************************************************'
print '-----------------------------------------------------------' 
print 'Table = bronze.erp_loc_a101' 

Truncate table bronze.erp_loc_a101;

Bulk Insert bronze.erp_loc_a101
from 'C:\Users\sujal\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    Tablock 
);
print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 

print '=============================================================================================='

print '---------------------------------------------------------------------' 
print 'Table = bronze.erp_cust_az12' 

Truncate table bronze.erp_cust_az12;

Bulk Insert bronze.erp_cust_az12
from 'C:\Users\sujal\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    Tablock 
);
print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 

print '=============================================================================================='

print '---------------------------------------------------------------------' 
print 'Table = bronze.erp_px_cat_g1v2' 

Truncate table bronze.erp_px_cat_g1v2;

Bulk Insert bronze.erp_px_cat_g1v2
from 'C:\Users\sujal\Downloads\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
with (
    firstrow = 2,
    fieldterminator = ',',
    Tablock 
);
print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 
End

Exec Bronze.load_bronze



