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

- Define GCS bucket and BigQuery dataset using Terraform files: `main.tf`, `variables.tf`, and `outputs.tf`
- Run the following commands:

```bash
terraform init
terraform apply
