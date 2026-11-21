
/*
===============================================================================
                         DATABASE INITIALIZATION SCRIPT
===============================================================================

Project      : Data Warehouse Project
Script Name  : 00_init_database.sql
Author       : Sujal Kesharwani
Created Date : 2026-11-22

Description:
    This script initializes the Datawarehouse database and creates
    the Bronze, Silver, and Gold schemas.

Objectives:
    1. Drop the existing Datawarehouse database.
    2. Create a new Datawarehouse database.
    3. Create Bronze schema.
    4. Create Silver schema.
    5. Create Gold schema.

WARNING:
    Executing this script will permanently delete the existing
    Datawarehouse database and all its contents.

    Make sure you have a backup before execution.
    Do not execute this script on a production database.

===============================================================================
*/

-- Switch to master database
USE master;
GO

-- Drop database if it already exists
DROP DATABASE Datawarehouse;
GO

-- Create Datawarehouse database
CREATE DATABASE Datawarehouse;
GO

-- Switch to Datawarehouse database
USE Datawarehouse;
GO

-- Create Bronze schema
CREATE SCHEMA Bronze;
GO

-- Create Silver schema
CREATE SCHEMA Silver;
GO

-- Create Gold schema
CREATE SCHEMA Gold;
GO
