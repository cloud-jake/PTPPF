/*
Task 5. Create a BigQuery table 'mismatched_iucr_descriptions'
In the previous task you have seen that the reference data table chicago_iucr_ref containes some IUCR codes that are missing the left padding with zeroes that is used in the chicago_crime table. However the total number of the records found in Task 4 does not match with the total number of records found in Task 3. That means there are still some crime records in the chicago_crime table that you haven't matched with either the IUCR or description fields in the chicago_iucr_ref table.

Create a BigQuery table called crimes_ds.mismatched_iucr_descriptions that contains the records from the chicago_crime data listing the IUCR codes and descriptions for records that were not returned in Task 4 in order to explore how those columns differ from the data in the IUCR code reference table.

These are the distinct combinations of IUCR, primary_type and description records that do not match with either the IUCR or description fields in the chicago_iucr_ref table.
*/

CREATE OR REPLACE TABLE crimes_ds.mismatched_iucr_descriptions AS (

SELECT invalid.*
FROM crimes_ds.invalid_crimes_iucr  invalid

LEFT JOIN crimes_ds.chicago_iucr_ref ref
ON invalid.primary_type = ref.PRIMARY_DESCRIPTION
AND invalid.description = ref.SECONDARY_DESCRIPTION

WHERE ref.IUCR IS NULL

GROUP BY 1,2,3
)

