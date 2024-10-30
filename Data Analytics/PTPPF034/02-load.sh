#!/bin/bash

#Task 2. Load data into BigQuery from a Cloud Storage
#In this task, you load data from the complex Cloud Storage layout to BigQuery. 
#Source data is stored in a Cloud Storage bucket called ____.

# Create a native BigQuery table named stations and load data from stations.csv.
bq load --source_format=CSV --field_delimiter="~" --autodetect=true ${DATASET}.stations gs://${BUCKET}/stations.csv


# Create a native BigQuery table named trips and load data from trips.csv using 
# trips_schema as schema file.
gsutil cp gs://qwiklabs-gcp-02-6099416b3031-source-data/trips_schema .
bq load --source_format=CSV --field_delimiter="|" ${DATASET}.trips gs://${BUCKET}/trips.csv trips_schema
