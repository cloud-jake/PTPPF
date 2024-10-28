#!/bin/bash 

PROJECT_ID=`gcloud config get-value project`
PROJECT_NUMBER=`gcloud projects describe $PROJECT_ID --format="value(projectNumber)"`


# Task 2. Create a BigQuery table and BigQuery subscription

#Create a native table named from_pubsub in the ratings dataset with the following fields:
#url:STRING,
#review:STRING,

bq mk --table --schema=url:STRING,review:STRING \
ratings.from_pubsub 

#Create a BigQuery subscription

# Grant the BigQuery Data Editor role and the 
# BigQuery Metadata Viewer role to the Pub/Sub service account.
#The service account is: service-PROJECT_ID@gcp-sa-pubsub.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:service-${PROJECT_ID}@gcp-sa-pubsub.iam.gserviceaccount.com" \
  --role="roles/bigquery.dataEditor"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:service-${PROJECT_ID}@gcp-sa-pubsub.iam.gserviceaccount.com" \
  --role="roles/bigquery.metadataViewer"

# Create a BigQuery subscription called ##Subscription Name## 
# and attached it to the Pub/Sub topic ##Topic Name##.

# Configure the subscription so that Pub/Sub writes the fields in messages to the 
# corresponding columns in the BigQuery table from_pubsub.

SUBSCRIPTION_ID=
TOPIC_ID=

gcloud pubsub subscriptions create $SUBSCRIPTION_ID \
    --topic=$TOPIC_ID \
    --bigquery-table=${PROJECT_ID}.ratings.from_pubsub