#!/bin/bash

PROJECT_ID=`gcloud config get-value project`
DATASET=

# Task 5. Ingest data in BigQuery using the Storage Write API
# You have to fix this application and run it with committed type.

# Create a BigQuery table named stations_api with same schema as of stations table.
bq query --use_legacy_sql=false --destination_table=${DATASET}.stations_api \
        'SELECT * FROM ${DATASET}.stations WHERE 1=0'

# SSH into lab-setup vm and fix the application so that it will support all the stream types.

# Application code is present in raw-api-ingestiondirectory.
# Refer to src/main/java/com/google/bigquery/ingestion/StorageWriteAPIIngestion.
# java code for more details.

# Once fixed, run the application in committed mode to process JSON records 
# and ingest them in to the BigQuery:

# ./gradlew run --args="  stations_api stations_stg.json committed"


