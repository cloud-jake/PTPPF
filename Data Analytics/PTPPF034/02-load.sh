#!/bin/bash

bq mk -t bq-jake:CYSL.Member ./member.json
bq load --source_format=CSV --skip_leading_rows=1 CYSL.Competition gs://bq-jake-cysl/CYSL\ Schema\ -\ Competition.csv


