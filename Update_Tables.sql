-- Description: Used for updating tables in the database
-- Be CAREFUL using this script, it can cause data loss if used incorrectly

-- Add table 
UPDATE LET_FORMATDATAARC
-- Add column to change and the new value 
SET LETDATE = '2023-01-31 00:00:00.000'
-- Add conditions to find the row to update
WHERE LETDOCBHEADER = '73465419'