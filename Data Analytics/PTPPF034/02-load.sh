#!/bin/bash

#Task 2. Load data into BigQuery from a Cloud Storage
#In this task, you load data from the complex Cloud Storage layout to BigQuery. 
#Source data is stored in a Cloud Storage bucket called ____.

# Create a native BigQuery table named stations and load data from stations.csv.
bq load --source_format=CSV --autodetect=true ${DATASET}.stations gs://${BUCKET}/stations.csv


# Create a native BigQuery table named trips and load data from trips.csv using 
# trips_schema as schema file.
bq load --source_format=CSV  ${DATASET}.trips gs://${BUCKET}/trips.csv gs://${BUCKET}/trips_schema
