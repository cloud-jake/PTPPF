#!/bin/bash

PROJECT_ID=`gcloud config get-value project`

# Task 4. Run a Cloud Dataflow Job
TOPIC_NAME=
REGION=

# Create a file with the name my_udf.js and the following content:

gsutil cp my_udf.js gs://$PROJECT_ID/

# Create a new table from_dataflow in BigQuery dataset ratings with the following fields:
# url:STRING,
# points:INTEGER

bq mk --table --schema=url:STRING,points:INTEGER \
ratings.from_dataflow

# Use the following configurations to run the Cloud Dataflow Job:
#
#Parameter	Configuration
#Job Name	pubsub-to-bigquery
#Region	##Region##
#Output table	from_dataflow
#Javascript UDF name	transform
#Pub/Sub topic	##Topic Name##
#Transform Path	Path to my_udf.js file
#Hint: Please enable streaming engine for this job.

gcloud dataflow flex-template run pubsub-to-bigquery \
--template-file-gcs-location \
gs://dataflow-templates-us-central1/latest/flex/PubSub_to_BigQuery_Flex \
--region $REGION \
--enable-streaming-engine \
--parameters \
javascriptTextTransformGcsPath=gs://$PROJECT_ID/my_udf.js,\
javascriptTextTransformFunctionName=transform,\
inputTopic=projects/$PROJECT_ID/topics/$TOPIC_ID,\
outputTableSpec=${PROJECT_ID}.ratings.from_dataflow