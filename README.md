# Azure Synapse Data Pipeline

A scalable and robust data engineering pipeline built with **Azure Synapse Analytics** and **Azure Data Lake Storage (ADLS)**. This project follows the Medallion Architecture to ingest, cleanse, transform, and prepare data for Business Intelligence (BI) reporting using **Power BI**.

## Project Overview

This pipeline is designed to handle raw data ingestion, data cleaning and transformation, and preparation of aggregated data for insightful analysis. It ensures data quality, scalability, and efficient reporting, making it ideal for business intelligence applications.

## Architecture Overview

Adopted the **Medallion Architecture**, structuring the pipeline into three distinct layers:

1. **Bronze Layer:** Ingests raw data from ADLS using external tables, maintaining original data integrity.
2. **Silver Layer:** Cleanses and transforms data to ensure quality and consistency, readying it for analysis.
3. **Gold Layer:** Aggregates and optimizes data for BI reporting, creating views and materialized tables that provide actionable insights.


## Key Features

- **Data Ingestion:** Efficiently imports raw CSV data from ADLS into Azure Synapse Analytics.
- **Data Cleaning & Transformation:** Implements validation rules and transformation logic to ensure high data quality.
- **Error Handling:** Captures and logs data quality issues through dedicated error tables for proactive remediation.
- **Business Intelligence Integration:** Connects seamlessly with Power BI to deliver interactive and insightful reports.
- **Scalable Architecture:** Designed to handle growing data volumes and complexity with ease.

## Technologies Used

- **Azure Synapse Analytics:** For data warehousing and pipeline orchestration.
- **Azure Data Lake Storage (ADLS):** Secure and scalable storage solution for raw and processed data.
- **Power BI Desktop:** For creating interactive and visually appealing BI reports.
- **Python:** Utilized for data generation and preliminary data manipulation.
- **SQL:** For data transformation and management within Azure Synapse.

## Challenges Faced

- **Data Consistency Issues:** Encountered mismatches between product names and categories due to script bugs. Resolved by refining data generation scripts to ensure accurate data alignment.
- **SQL Optimization:** Faced errors with `ORDER BY` clauses in view definitions. Learned to adhere to SQL standards by removing `ORDER BY` from views and applying it during queries, enhancing performance.
- **Data Quality Management:** Needed robust validation and error logging mechanisms. Developed dedicated error tables to capture and analyze data quality issues, ensuring high data reliability.

## Key Learnings

- **Data Quality is Crucial:** Implementing thorough validation and error handling significantly enhances the reliability of downstream analyses.
- **Scalable Architecture:** The Medallion Architecture provides a clear and scalable structure, making the pipeline easier to manage and extend as data volumes grow.
- **Effective Problem-Solving:** Tackling data inconsistencies and SQL constraints reinforced the importance of a meticulous and solution-oriented approach in data engineering.
- **Collaboration and Iteration:** Regular feedback and iterative design led to substantial improvements in both performance and data quality.

## Contact

**Ratinder Bhullar**  
Data Engineer  
[[LinkedIn Profile](https://www.linkedin.com/in/ratinder-bhullar/)] 
[Email](mailto:ratinder.bhullar1@gmail.com)
