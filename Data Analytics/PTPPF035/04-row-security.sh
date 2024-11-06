CREATE ROW ACCESS POLICY
  ny_filter
ON
  customer_refined_data.customer_data GRANT TO ("serviceAccount:cepf-bq-user@qwiklabs-gcp-04-3a8408e05533.iam.gserviceaccount.com")
FILTER USING
  (state="NY" );

