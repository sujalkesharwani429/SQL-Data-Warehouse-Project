/*
===============================================================================
                        BRONZE LAYER - DATA CLEANSING
===============================================================================

Project       : Data Warehouse and Analytics Project
Script Name   : Silver_load.sql
Author        : Sujal Kesharwani
Created Date  : 2026-11-24
Layer         : Silver (Cleaned Data Layer)

Description:
    This stored procedure loads raw data from Bronze layer source
    systems into the corresponding Bronze Layer tables.

Source Systems:
    CRM - Customer Relationship Management
    ERP - Enterprise Resource Planning

Tables Loaded:

    CRM:
        1. Silver.crm_cust_info
        2. Silver.crm_prd_info
        3. Silver.crm_sales_details

    ERP:
        4. Silver.erp_loc_a101
        5. Silver.erp_cust_az12
        6. Silver.erp_px_cat_g1v2

Loading Method:
    - TRUNCATE TABLE : Removes existing records.
    - INSERT : Loads raw Data from Bronze data into SQL Server.
    
Execution:
    EXEC Silver.load_silver;

WARNING:
    1. This procedure truncates existing table data before loading.
    2. Failed loads may leave tables empty or partially populated.
    3. Verify source file paths and SQL Server permissions.
    4. Ensure source CSV structures match destination table definitions.
    5. Do not execute against production data without authorization
       and a verified backup.

===============================================================================
/*
Create or alter procedure Silver.load_silver as
Begin

print '==========================================================='
print 'Loading Silver Layer'
print '==========================================================='

print '-----------------------------------------------------------'
print 'Loading CRM Table'
print '-----------------------------------------------------------'
print '***********************************************************'

print '---------------------------------------------------------------------' 
print 'Table = Silver.crm_cust_info'

Truncate table Silver.crm_cust_info

Insert into Silver.crm_cust_info (
       [cst_id]
      ,[cst_key]
      ,[cst_firstname]
      ,[cst_lastname]
      ,[cst_marital_status]
      ,[cst_gender]
      ,[cst_Create_date]
) 
SELECT
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    CASE
        WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
        WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
        ELSE 'n/a'
    END AS cst_marital_status, -- Normalize marital status values to readable format
    CASE
        WHEN UPPER(TRIM(cst_gender)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(cst_gender)) = 'M' THEN 'Male'
        ELSE 'n/a'
    END AS cst_gender, -- Normalize gender values to readable format
    cst_create_date
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
    FROM bronze.crm_cust_info
    WHERE cst_id IS NOT NULL
) t
WHERE flag_last = 1; -- Select the most recent record per customer

print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 

print '=============================================================================================='

print '---------------------------------------------------------------------' 
print 'Table = Silver.crm_prd_info'

Truncate table Silver.crm_prd_info

INSERT INTO Silver.crm_prd_info (
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
Select 
prd_id,
Replace(SUBSTRING(prd_key, 1, 5), '-','_') as Cat_id,
SUBSTRING(prd_key, 7, len(prd_key)) as Prd_key,
prd_nm,
isnull(prd_cost, 0) as prd_cost,
case Upper(prd_line)
       when 'M' then 'Mountain'
       when 'R' then 'Road'
       when 'S' then 'Other Sales'
       when 'T' then 'Touring'
       Else 'N/A'
END as Prd_line,
CAST (prd_start_dt AS DATE) as prd_start_dt, 
CAST (LEAD(prd_start_dt) over (Partition by prd_key order by prd_end_dt)-1 AS DATE) as prd_End_dt
from bronze.crm_prd_info

print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 
print '=============================================================================================='

print '---------------------------------------------------------------------' 
print 'Table = Silver.crm_sales_details'

Truncate table Silver.crm_sales_details

Insert into Silver.crm_sales_details (
       [sls_ord_num]
      ,[sls_prd_key]
      ,[sls_cust_id]
      ,[sls_order_dt]
      ,[sls_ship_dt]
      ,[sls_due_dt]
      ,[sls_sales]
      ,[sls_quantity]
      ,[sls_price]
)
select 
       [sls_ord_num]
      ,[sls_prd_key]
      ,[sls_cust_id]
      
      ,case 
       when sls_order_dt = 0 or len(sls_order_dt) != 8 then null
       else cast(cast(sls_order_dt AS VARCHAR) AS DATE)
       END AS sls_order_dt,
       
       case
                   when sls_ship_dt = 0 or len(sls_ship_dt) != 8 then null
                   else cast(cast(sls_ship_dt AS VARCHAR) AS DATE)
       END AS sls_ship_dt,

       CASE
                   when sls_due_dt = 0 or len(sls_due_dt) != 8 then null
                   else cast(cast(sls_due_dt AS VARCHAR) AS DATE)
       END AS sls_due_dt,

       CASE
                   when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity * ABS(sls_price)
                   then sls_quantity * ABS(sls_price)
                   ELSE sls_sales
          END as sls_sales,
          sls_quantity,

        CASE
                      when sls_price is null or sls_price <= 0
                      then sls_sales / nullif (sls_quantity, 0)
                      ELSE sls_price
          END AS sls_price
                 from Bronze.crm_sales_details

print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 
print '=============================================================================================='

print '-----------------------------------------------------------'
print 'Loading ERP Table'
print '-----------------------------------------------------------'
print '***********************************************************'

print '-------------------------------------------------------------------' 
print 'Table = Silver.erp_cust_az12' 
Truncate table silver.erp_cust_az12;

Insert into Silver.erp_cust_az12 (
Cid,
bdate,
gen
)
select 
CASE when cid like 'NAS%' THEN Substring(Cid, 4, LEN(Cid))
Else Cid
END AS Cid, 
CASE WHEN bdate > GETDATE() THEN null
ELSE bdate
END AS bdate,
CASE WHEN upper(Trim(gen)) IN ('F', 'Female') Then 'FEMALE'
     WHEN Upper(Trim(gen)) IN ('M', 'Male') Then 'MALE'
Else 'N/A'
END AS gen

from bronze.erp_cust_az12

print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 
print '=============================================================================================='

print '-------------------------------------------------------------------' 
print 'Table = Silver.erp_loc_a101' 
Truncate table silver.erp_loc_a101;

Insert into Silver.erp_loc_a101 (
Cid,
cntry
)
Select 
Replace(cid, '-', '') cid,
CASE WHEN Trim(cntry) = 'DE' Then 'Germany'
     WHEN Trim(cntry) in ('US', 'USA') Then 'United States'
     WHEN Trim(cntry) = '' or cntry is null then 'N/A'
ELSE Trim(cntry)
END AS cntry
from Bronze.erp_loc_a101

print '-------------------------------------------------------------------' 
print 'Table = Silver.erp_cust_g1v2' 
Truncate table silver.erp_px_cat_g1v2;
insert into silver.erp_px_cat_g1v2(
id,
cat,
subcat,
maintanance
)
select 
id,
cat,
subcat,
maintanance
from bronze.erp_px_cat_g1v2
print '---------------------------------------------------------------------' 
print 'Rows inserted'
print '---------------------------------------------------------------------' 
print '=============================================================================================='
END

exec Silver.load_silver
*/
