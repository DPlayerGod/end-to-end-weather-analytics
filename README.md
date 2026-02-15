# end-to-end-weather-analytics

## Problem Statement
Weather conditions in Southeast Asia change rapidly and influence transportation, logistics, and daily decision-making. However, real-time weather data from public APIs is often unstructured and not analytics-ready. This project addresses the challenge of designing a **reproducible, cloud-based data pipeline** that ingests near real-time weather data, stores it in a scalable architecture, and transforms it into structured datasets suitable for analytical and visualization purposes.

## Project Overview
This project implements an end-to-end data engineering pipeline on **Google Cloud** following the **Medallion Architecture** (Bronze–Silver–Gold) pattern. 

* **Bronze (Raw):** Near real-time weather data is ingested via **Kafka** and processed by **Spark Streaming**, then stored in **Google Cloud Storage (GCS)** as raw JSON files to preserve source fidelity.

* **Silver (Standardized):** Data is cleaned, type-cast, and deduplicated in **BigQuery** using **dbt**, creating a reliable source of truth.

* **Gold (Analytics):** Business-ready datasets (e.g., Heat Index calculations, daily aggregations) are generated for high-performance querying and dashboarding.

The entire infrastructure is provisioned using **Terraform**, ensuring the project is fully reproducible across any environment.