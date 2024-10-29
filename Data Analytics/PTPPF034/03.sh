#!/bin/bash

PROJECT_ID=`gcloud config get-value project`

# Task 3. Create a stored procedure

# Create a table named station_normalized, with the same schema as the stations_ext table.
#bq query --use_legacy_sql=false --destination_table=${DATASET}.station_normalized \
#        'SELECT * FROM ${DATASET}.stations_ext WHERE 1=0'


# Write a stored procedure called cepf_sp_normalize_stations to normalize the station name 
# and ingest the data into station_normalized table.

# create table `GCP_Dataset.abc` as select x,y,z from mnp



CREATE OR REPLACE PROCEDURE $DATASET.cepf_sp_normalize_stations()
BEGIN
  EXECUTE IMMEDIATE CONCAT(
        CREATE OR REPLACE TABLE ${DATASET}.station_normalized AS 
        SELECT * EXCEPT(station_name),
        CASE 
        WHEN station_name LIKE '% / %' THEN REPLACE(stattion_name, ' / ',' at ')
        WHEN station_name LIKE '%/%' THEN REPLACE(stattion_name, '/',' & ')
        ELSE station_name
        END AS station_name
        FROM ${DATASET}.stations_ext;
  );
END;

# Call the stored procedure to normalize and ingest data.


CALL $DATASET.cepf_sp_normalize_stations();


