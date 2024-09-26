-- Create Schema for Medallion Architecture
CREATE SCHEMA [bronze];
CREATE SCHEMA [silver];
CREATE SCHEMA [gold];
CREATE SCHEMA [error];


-- Create a Master Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<Password123>';

-- Create Database Scoped Credential using SAS Token
CREATE DATABASE SCOPED CREDENTIAL ADLSCredential
WITH
    IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = '<SAS TOKEN HERE>';


-- Create External Data Source
CREATE EXTERNAL DATA SOURCE [ADLSDataSource]
WITH (
    TYPE = HADOOP,
    LOCATION = 'abfss://<container>@<storage-account>.dfs.core.windows.net/',
    CREDENTIAL = ADLSCredential
);

-- Create External File Format

CREATE EXTERNAL FILE FORMAT [CSVFileFormat]
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2,  -- Skip header row
        ENCODING = 'UTF8'
    )
);

