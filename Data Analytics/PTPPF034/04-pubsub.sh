#!/bin/bash

PROJECT_ID=`gcloud config get-value project`
DATASET=

# Create Pub/Sub schema named station-payload-schema in Protocol Buffer format 
# with the following schema definition:

# station-payload-schema.proto3

gcloud pubsub schemas create station-payload-schema \
        --type=proto3 \
        --definition-file=station-payload-schema.proto3

# Create a Pub/Sub topic named station-topic which will receive
# simulated JSON payloads for new stations.

gcloud pubsub topics create station-topic \
  --schema=projects/$PROJECT_ID/schemas/station-payload-schema \
  --message-encoding=JSON

# Create a BigQuery table named stations_streaming 
# with same schema as of stations table.

bq query --use_legacy_sql=false --destination_table=${DATASET}.stations_streaming \
        'SELECT * FROM ${DATASET}.stations WHERE 1=0'

# Create a BigQuery subscription called station-bigquery-sub 
# and attached it to the Pub/Sub topic.

SUBSCRIPTION_ID="station-bigquery-sub"
TOPIC_ID="station-topic"

gcloud pubsub subscriptions create $SUBSCRIPTION_ID \
    --topic=$TOPIC_ID --use-topic-schema \
    --bigquery-table=${PROJECT_ID}.${DATASET}.stations_streaming


# Configure the subscription so that Pub/Sub writes the fields in messages 
# to the corresponding columns in the BigQuery table stations_streaming.



# SSH into lab-setup vm and execute following command to publish messages to Pub/Sub topic:
# ./send-messages.sh station-topic stations_stg.json



# Verify the realtime data ingest in stations_streaming BigQuery table
