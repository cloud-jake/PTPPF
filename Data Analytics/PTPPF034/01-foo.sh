#!/bin/bash

PROJECT_ID=`gcloud config get-value project`

BUCKET="foo-bucket"
DATASET="foo-dataset"




gcloud bigquery datasets create $DATASET \
  --location=US \
  --project=${PROJECT_ID}


bq mk --external_table --project=${PROJECT_ID} --dataset=${DATASET} --table=stations_ext \
  gs://${BUCKET}/stations_stg.csv

