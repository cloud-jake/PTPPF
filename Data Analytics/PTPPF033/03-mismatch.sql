-- Task 3. Identify if there are IUCR code/description discrepancies/mismatches across tables

-- crimes_ds.invalid_crimes_iucr

CREATE OR REPLACE TABLE crimes_ds.invalid_crimes_iucr AS (
/*
To complete this task you must create a BigQuery table called crimes_ds.invalid_crimes_iucr that contains all of the distinct combinations of IUCR, primary_type and description from the table chicago_crime where the IUCR code is not found in the chicago_iucr_ref table.
*/

-- # chicago_crime #
-- IUCR
-- primary_type
-- description

--  IUCR code is not found in the # chicago_iucr_ref # table

SELECT a.iucr, a.primary_type, a.description
FROM crimes_ds.chicago_crime  a

LEFT JOIN crimes_ds.chicago_iucr_ref b
ON a.iucr = b.IUCR

WHERE b.IUCR is null

GROUP BY 1,2,3
ORDER BY 1,2,3
)