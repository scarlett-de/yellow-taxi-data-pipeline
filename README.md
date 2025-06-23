# GCP Yellow Taxi Data Pipeline

This is a hands-on data engineering project where I built a full pipeline to ingest, store, and analyze NYC Yellow Taxi trip data using **Google Cloud Platform (GCP)**. The project simulates a production-grade ingestion and warehousing process using **Terraform**, **Python**, and **BigQuery**.

---

## 📦 Project Overview

This project automates the ingestion of Yellow Taxi data into Google Cloud Storage (GCS), loads it into BigQuery as both external and internal tables, and optimizes performance using **partitioning** and **clustering**. SQL queries are then used to analyze trip patterns and query performance.

**What this project does:**
- Provisions GCS bucket and BigQuery dataset using **Terraform**
- Downloads Yellow Taxi data and uploads it as Parquet to **GCS**
- Creates **external** and **internal** BigQuery tables
- Optimizes the internal table using **partitioning** and **clustering**
- Runs SQL queries to demonstrate data insights and query efficiency

---

## 🛠️ Tech Stack

- **Terraform** – Infrastructure as Code (IaC) for provisioning GCP resources
- **Google Cloud Storage (GCS)** – Cloud object storage for raw files
- **BigQuery** – Serverless data warehouse for fast SQL analytics
- **Python** – For data download and upload
- **SQL** – For querying and data analysis
- **Parquet** – Columnar storage format for performance

---

## ⚙️ Steps to Build the Pipeline

### Step 1: Provision Infrastructure with Terraform

- Define your GCS bucket and BigQuery dataset using Terraform files: `main.tf`, `variables.tf`, and `outputs.tf`
- Run the following commands:

```bash
terraform init
terraform apply
