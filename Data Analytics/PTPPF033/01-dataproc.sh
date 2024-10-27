#!/bin/bash

PROJECT_ID=`gcloud config get-value project`

# Task 1. Run a Dataproc Serverless Spark batch template workload

# Submit a Spark batch workload using the Dataproc Cloud Storage to 
# BigQuery template to import the IUCR reference data into a BigQuery 
# table named chicago_iucr_ref under the crimes_ds dataset in your lab project.

#Parameter	Configuration
#Dataproc Batch Job Name Prefix	cepf-datalake-lab
SRC_DATA=    #IUCR Source CSV data	filled in at lab start
SRC_BUCKET=    #Source storage bucket	Sfilled in at lab start
SA=    #Service Account	filled in at lab start
SUBNET="lab-snet" #Subnet	lab-snet
REGION=    #Region	filled in at lab start
LOG_LEVEL="INFO" #Log level	INFO
##Template	GCSTOBIGQUERY
DATASET="crimes_ds" #BigQuery Dataset	crimes_ds
TABLE="chicago_iucr_ref" #Target BigQuery table	chicago_iucr_ref
TEMP_BUCKET=    #BigQuery Temp Bucket Name	filled in at lab start

# https://cloud.google.com/dataproc-serverless/docs/templates/storage-to-bigquery

gcloud dataproc batches submit spark --batch cepf-datalake-lab \
    --class=com.google.cloud.dataproc.templates.main.DataProcTemplate \
    --version="1.2" \
    --project=${PROJECT_ID} \
    --region=${REGION} \
    --jars="gs://dataproc-templates-binaries/latest/java/dataproc-templates.jar" \
    --subnet=${SUBNET} \
    --service-account=${SA} \
    --properties spark.dataproc.appContext.enabled=true \
    -- --template=GCSTOBIGQUERY \
    --templateProperty log.level=${LOG_LEVEL} \
    --templateProperty project.id=${PROJECT_ID} \
    --templateProperty gcs.bigquery.input.location=${SRC_BUCKET}/${SRC_DATA} \
    --templateProperty gcs.bigquery.input.format="csv" \
    --templateProperty gcs.bigquery.output.dataset=${DATASET} \
    --templateProperty gcs.bigquery.output.table=${TABLE} \
    --templateProperty gcs.bigquery.temp.bucket.name=${TEMP_BUCKET}

