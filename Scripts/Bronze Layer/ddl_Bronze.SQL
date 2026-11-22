
/*
===============================================================================
                    BRONZE LAYER - TABLE CREATION
===============================================================================

Project       : Data Warehouse and Analytics Project
Script Name   : bronze_ddl.sql
Author        : Sujal Kesharwani
Created Date  : 2026-11-23
Layer         : Bronze (Raw Data Layer)

Description:
    This script creates the required tables in the Bronze schema
    to store raw data from CRM and ERP source systems.

Source Systems:
    1. CRM (Customer Relationship Management)
    2. ERP (Enterprise Resource Planning)

Tables Created:

    CRM Tables:
        1. bronze.crm_cust_info
        2. bronze.crm_prd_info
        3. bronze.crm_sales_details

    ERP Tables:
        4. bronze.erp_loc_a101
        5. bronze.erp_cust_az12
        6. bronze.erp_px_cat_g1v2

Execution Process:
    1. Switch to the Datawarehouse database.
    2. Check whether each table already exists.
    3. Drop the existing table if found.
    4. Create new tables with the specified columns and data types.

WARNING:
    1. This script drops existing tables before recreating them.
    2. Dropping tables permanently deletes their existing data.
    3. Dependent objects or relationships may be affected.
    4. Ensure that backups are available before execution.
    5. Execute this script only when table recreation is intended.

===============================================================================
use Datawarehouse

if OBJECT_ID ('bronze.crm_cust_info', 'U') is not null
drop table bronze.crm_cust_info

Create Table bronze.crm_cust_info (
	cst_id int,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR (50),
	cst_material_status NVARCHAR(50),
	cst_gender NVARCHAR(50),
	cst_Create_date DATE
)

if OBJECT_ID ('bronze.crm_prd_info', 'U') is not null
drop table bronze.crm_prd_info

Create Table bronze.crm_prd_info (
prd_id int,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost int,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);

if OBJECT_ID ('bronze.crm_sales_details', 'U') is not null
drop table bronze.crm_sales_details

Create Table bronze.crm_sales_details (
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR (50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
);

if OBJECT_ID ('bronze.erp_loc_a101', 'U') is not null
drop table bronze.erp_loc_a101

Create Table bronze.erp_loc_a101 (
cid NVARCHAR (50),
cntry NVARCHAR (50)
);

if OBJECT_ID ('Bronze.erp_cust_az12', 'U') is not null
drop table Bronze.erp_cust_az12

Create Table Bronze.erp_cust_az12 (
cid Nvarchar (50),
bdate date,
gen Nvarchar (50)
);

if OBJECT_ID ('Bronze.erp_px_cat_g1v2', 'U') is not null
drop table Bronze.erp_px_cat_g1v2

Create Table Bronze.erp_px_cat_g1v2(
id Nvarchar (50),
cat Nvarchar (50),
subcat Nvarchar (50),
maintanance Nvarchar (50)
);*/
