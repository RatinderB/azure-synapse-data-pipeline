-- Create Schema for Medallion Architecture
CREATE SCHEMA [bronze];
CREATE SCHEMA [silver];
CREATE SCHEMA [gold];
CREATE SCHEMA [error];


-- Create a Master Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'z#66u$G6bT';

-- Create Database Scoped Credential using SAS Token
CREATE DATABASE SCOPED CREDENTIAL ADLSCredential
WITH
    IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = 'sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2024-09-23T06:02:02Z&st=2024-09-22T22:02:02Z&spr=https&sig=GrODlYJ%2Bcj0dyCMEysJBi96gTTBjELAOgVvDLLtqrUk%3D';


-- Create External Data Source
CREATE EXTERNAL DATA SOURCE [ADLSDataSource]
WITH (
    TYPE = HADOOP,
    LOCATION = 'abfss://project-data@synapseds.dfs.core.windows.net/',
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

