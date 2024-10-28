#!/bin/bash

PROJECT_ID=`gcloud config get-value project`

# Task 1. Create a Pub/Sub topic with schema
# Create a Pub/Sub schema with name ##Schema##, using Avro as schema type
SCHEMA=

cp schema-01.json $SCHEMA

gcloud pubsub schemas create $SCHEMA \
        --type=avro \
        --definition-file=$SCHEMA

# Create a Pub/Sub topic ##Topic Name## with the schema Schema 
# and select the message encoding as JSON.
TOPIC=

gcloud pubsub topics create $TOPIC --schema=projects/$PROJECT_ID/schemas/$SCHEMA --message-encoding=JSON

