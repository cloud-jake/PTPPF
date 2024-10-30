#!/bin/bash

#  Task 1. Create Cloud Storage external table

PROJECT_ID=`gcloud config get-value project`

BUCKET=
# qwiklabs-gcp-02-6099416b3031-source-data
DATASET=
# cepf_bikeshare

bq mk --dataset --location=US --project_id=${PROJECT_ID} ${DATASET}

bq mkdef --source_format=CSV --autodetect=true gs://${BUCKET}/stations_stg.csv > table.def
bq mk --table \
  --external_table_definition=table.def \
  $DATASET.stations_ext 

