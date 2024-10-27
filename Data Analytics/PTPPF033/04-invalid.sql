--Task 4. Perform comparison based on IUCR descriptions
--From last task it is clear that there are codes in the chicago_crime (transactions) table that are not in the chicago_iucr_ref --(reference data) table. You must now extract data that will allow you to understand why there is a misalignment between these two tables.
--Create a BigQuery table called crimes_ds.matching_iucr_descriptions that contains the records returned in the previous task, where the IUCR code did not match, that can be matched using the fields primary_description and secondary_description of the table chicago_iucr_ref joined with the type of crime and description fields from the chicago_crime table.
--This will allow you to see how the data ingestion job could be enhanced to reduce or eliminate this issue.

CREATE OR REPLACE TABLE crimes_ds.matching_iucr_descriptions AS (

SELECT invalid.*
FROM crimes_ds.invalid_crimes_iucr  invalid

LEFT JOIN crimes_ds.chicago_iucr_ref ref
ON invalid.primary_type = ref.PRIMARY_DESCRIPTION
AND invalid.description = ref.SECONDARY_DESCRIPTION

WHERE ref.IUCR IS NOT NULL

)