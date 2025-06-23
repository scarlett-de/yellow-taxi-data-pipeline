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
This will create a GCP bucket and BigQuery Dataset.

## Step 2: Download and Upload Parquet Files to GCS
I use the Python script to load data. 

First I install GCP and check if the installation is sucessful 
```ssh
pip install google-cloud-storage
```

```ssh
python3 -c "import google.cloud.storage; print('google-cloud-storage is installed!')"
```
Note: I place my GCP service account key JSON file in the project folder as gcs.json. 

## Step 3: Download and upload to GCS bucket

then run the below command to run the python script to download and load data
```ssh
python3 /Users/yitian66/Documents/DE-Datacamp/Homework3/load_yellow_taxi_data_2024.py
```

## Step 4: Create BigQuery tables
and then I run below query to create external and regular tables:

```sql
CREATE OR REPLACE EXTERNAL TABLE `modified-alloy-447921-n7.demo_dataset_hw3.yellow_taxi_external`

OPTIONS (
  format = 'PARQUET',
  uris = ['gs://bucket-modified-alloy-447921-n7/yellow_tripdata_2024-*.parquet']
);

CREATE OR REPLACE TABLE `modified-alloy-447921-n7.demo_dataset_hw3.yellow_taxi_table`
AS
SELECT * FROM `modified-alloy-447921-n7.demo_dataset_hw3.yellow_taxi_external`;
```

## Step 5: Partition and Cluster the Internal Table

```sql
CREATE OR REPLACE TABLE `demo_dataset_hw3.yellow_taxi_table_partitioned`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID as (
 SELECT * FROM `demo_dataset_hw3.yellow_taxi_table`)
```
<img src="[https://github.com/user-attachments/assets/e8f108b8-328d-4e46-b932-93809c472f80]" alt="image" width="600">


