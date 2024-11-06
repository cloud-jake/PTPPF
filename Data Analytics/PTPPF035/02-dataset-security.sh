#!/bin/bash

PROJECT_ID=`gcloud config get-value project`
PROJECT_NUMBER=`gcloud projects describe $PROJECT_ID --format="value(projectNumber)"`
USER_ID="cepf-bq-user"
CUSTOMER_SA="${USER_ID}@${PROJECT_ID}.iam.gserviceaccount.com"
CUSTOMER_SA="customer-sa@qwiklabs-gcp-04-3a8408e05533.iam.gserviceaccount.com"

SINK_NAME=
DATASET=central_audit_data
LAKE=

# Task 2. Configure Dataset level security

# Create the Cloud Logging sink named ____ to capture the Dataplex Audit logs into the 
# BigQuery dataset central_audit_data with the following inclusion filter:


gcloud logging sinks create ${SINK_NAME} \
    bigquery.googleapis.com/projects/${PROJECT_ID}/datasets/${DATASET} \
    --log-filter='resource.type="audited_resource" AND resource.labels.service="dataplex.googleapis.com" AND protoPayload.serviceName="dataplex.googleapis.com"'

# Grant the BigQuery Data Editor role to the log sink's writer identity on the central_audit_data dataset.
# serviceAccount:service-123456789012@gcp-sa-logging.iam.gserviceaccount.com
#gcloud projects add-iam-policy-binding $PROJECT_ID \
#  --member="serviceAccount:service-${PROJECT_NUMBER}@gcp-sa-logging.iam.gserviceaccount.com" \
#  --role="roles/bigquery.dataEditor"

#bq query --use_legacy_sql=false \
#        "GRANT roles/bigquery.dataEditor ON SCHEMA ${PROJECT_ID}.${DATASET}
#        TO serviceAccount:service-${PROJECT_NUMBER}@gcp-sa-logging.iam.gserviceaccount.com"


GRANT `roles/bigquery.dataEditor` 
ON SCHEMA central_audit_data 
TO "serviceAccount:service-329232158424@gcp-sa-logging.iam.gserviceaccount.com"

# Set up the customer service account access

# Grant the Dataplex Data Owner permission to the customer user managed service account
# ____ on ##Consumer Banking - Customer Domain## data lake in Dataplex using the Lakes Permission feature.

# service-CUSTOMER_PROJECT_NUMBER@gcp-sa-dataplex.iam.gserviceaccount.com
# roles/dataplex.dataOwner

# gcloud dataplex lakes add-iam-policy-binding (LAKE : --location=LOCATION) --member=PRINCIPAL --role=ROLE 

gcloud dataplex lakes add-iam-policy-binding $LAKE \
    --location=us-central1 \
    --role=roles/dataplex.dataOwner \
    --member=serviceAccount:${CUSTOMER_SA}

