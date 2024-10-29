#!/bin/bash

PROJECT_ID=`gcloud config get-value project`
TOPIC_NAME=
REGION=

# Task 3. Run a data publisher job with the data generator flex template

# Use the following schema to be used by the Dataflow data generator template, 
# to create about 10k messages per second with random contents and save it to the file 
# with the name schema.json to the Storage bucket ##Bucket Name##:
BUCKET_NAME=${PROJECT_ID}

gsutil cp schema.json gs://$BUCKET_NAME/

# Once the schema is uploaded to Cloud Storage, you can run the data generator job
#  with the following command, to be executed in the Cloud Shell:

SCHEMA_LOCATION=gs://$PROJECT_ID/schema.json
# Note: Substitute the following variables before running the command: 
# TOPIC_NAME, PROJECT_ID, and SCHEMA_LOCATION.

gcloud dataflow flex-template run data-generator \
--template-file-gcs-location \
gs://dataflow-templates-us-central1/latest/flex/Streaming_Data_Generator \
--region $REGION \
--parameters \
schemaLocation=$SCHEMA_LOCATION,\
topic=projects/$PROJECT_ID/topics/$TOPIC_NAME,qps=10000

