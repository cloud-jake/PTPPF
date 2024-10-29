#!/bin/bash

#  Task 1. Create Cloud Storage external table

PROJECT_ID=`gcloud config get-value project`

BUCKET=
DATASET=


bq mk --dataset --location=US --project=${PROJECT_ID} ${DATASET}

bq mkdef --source_format=CSV gs://${BUCKET}/stations_stg.csv > table.def
bq mk --table \
  --external_table_definition=table.def \
  $DATASET.stations_ext 

