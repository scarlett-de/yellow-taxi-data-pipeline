# GCP Yellow Taxi Data Pipeline

This is a hands-on data engineering project where I built a complete pipeline to bring in, store, and analyze NYC Yellow Taxi trip data using Google Cloud Platform (GCP). The goal was to mimic a real-world production setup for data ingestion and warehousing using tools like Terraform, Python, and BigQuery.

## Project Overview

I automated the process of loading Yellow Taxi data into Google Cloud Storage (GCS), then moved that data into BigQuery, creating both external tables (that read directly from GCS) and internal tables (stored in BigQuery). I also worked on improving query speed by using partitioning and clustering. Finally, I ran some SQL queries to explore trip patterns and check how well the optimizations worked.

## Tech Used

- **Terraform** – Infrastructure as Code (IaC) for provisioning GCP resources
- **Google Cloud Storage (GCS)** – Cloud object storage for raw files
- **BigQuery** – Serverless data warehouse for fast SQL analytics
- **Python** – For data download and upload
- **SQL** – For querying and data analysis
- **Parquet** – Columnar storage format for performance


## Steps to Build the Pipeline

### Step 1: Provision Infrastructure with Terraform

- Define GCS bucket and BigQuery dataset using Terraform files: `main.tf`, `variables.tf`
- Run the following commands:

```bash
terraform init
terraform apply
```
This created a GCS bucket for storing raw Parquet files and a BigQuery dataset for loading and querying data.

### Step 2: Install Dependencies and Configure GCP Access

First I prepare local environment for GCP operations
```ssh
pip install google-cloud-storage
```

```ssh
python3 -c "import google.cloud.storage; print('google-cloud-storage is installed!')"
```

Note: I place my GCP service account key JSON file in the project folder as gcs.json. 

### Step 3: Download and Upload Parquet Files to GCS
Used a Python script to:
- Download NYC Yellow Taxi data (in Parquet format) from a public source.
- Upload the files to the created GCS bucket.

Run the below command
```ssh
python3 /Users/yitian66/Documents/DE_Projects/Project2/load_yellow_taxi_data_2024.py
```

### Step 4: Create BigQuery tables
and then I run below query to create external and regular tables:

**External Table**: Points to Parquet files in GCS (no data copy, cost-effective for exploration).
```sql
CREATE OR REPLACE EXTERNAL TABLE `modified-alloy-447921-n7.demo_dataset_hw3.yellow_taxi_external`

OPTIONS (
  format = 'PARQUET',
  uris = ['gs://bucket-modified-alloy-447921-n7/yellow_tripdata_2024-*.parquet']
);
```

**Internal Table**: Materialized version for faster queries and further processing and analysis.
```sql
CREATE OR REPLACE TABLE `modified-alloy-447921-n7.demo_dataset_hw3.yellow_taxi_table`
AS
SELECT * FROM `modified-alloy-447921-n7.demo_dataset_hw3.yellow_taxi_external`;
```

### Step 5: Partition and Cluster the Internal Table
To Improve query performance and reduce costs, I use partition and cluster. 

```sql
CREATE OR REPLACE TABLE `demo_dataset_hw3.yellow_taxi_table_partitioned`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID as (
 SELECT * FROM `demo_dataset_hw3.yellow_taxi_table`)
```

The tables are sucussfully created as below: 
<img src="https://github.com/user-attachments/assets/f75131bf-b46b-4d96-93b2-85663d64f41d" alt="image" width="400">


## Analytics Queries

### 1. to count total records
```sql
SELECT COUNT(*) FROM `yellow_taxi_table`;
```

### 2. Comparing External and Internal Tables in BigQuery
I included the following two SQL queries to analyze and compare the behavior of querying an external Parquet table in GCS versus a native BigQuery-managed table:

```sql
select count(distinct PULocationID) from demo_dataset_hw3.yellow_taxi_external
```
```sql
select count(distinct PULocationID) from demo_dataset_hw3.yellow_taxi_table
```
The query on the external Parquet table showed 0 MB scanned because BigQuery only read the one column I needed (PULocationID). Since Parquet is a column-based format, it’s really efficient for that.

The same query on the internal BigQuery table scanned 155.12 MB, because BigQuery counts all the data it reads from its own storage, even if it’s just one column.


## Columnar Query Efficiency
I run below query to retrive PULocationID, and retrive both PULocationID and DOLocationID:

```sql
select PULocationID from yellow_taxi_table
```

```sql
select PULocationID,DOLocationID from yellow_taxi_table
```
Bytes processed of above two queries are 155.12 mb, 310.24 mb respectively. 

Reason is BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.

## Partition Efficiency

**Partition by tpep_dropoff_datetime and Cluster on VendorID**. 

Below is the code:

```sql
CREATE OR REPLACE TABLE yellow_taxi_table_partitioned
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID as (
 SELECT * FROM yellow_taxi_table)
```

and then I run the below two queries and compare the bytes processed. 

```sql
select distinct VendorID, tpep_dropoff_datetime
from yellow_taxi_table
where date(tpep_dropoff_datetime) between '2024-03-01' and '2024-03-15'
```

```sql
select distinct VendorID, tpep_dropoff_datetime
from yellow_taxi_table_partitioned
where date(tpep_dropoff_datetime) between '2024-03-01' and '2024-03-15'
```

310.24 MB for non-partitioned table and 26.84 MB for the partitioned table.

## Skills Demonstrated

- Docker and container orchestration
- Custom ingestion scripts with Python
- Relational data modeling and ingestion
- SQL analytics and business insight generation

## 👤 Author

**YITIAN WANG**  
[LinkedIn](www.linkedin.com/in/yitian-w-de) • [GitHub](https://github.com/scarlett-de)


