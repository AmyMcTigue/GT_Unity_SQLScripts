-- Used for generating the LETSEQ for annual statement comm generation process

SELECT TOP 1000 *
FROM LET_FORMATDATA
WHERE LETCODE_CODE = 'S1RMR|REVIEW' 
AND LETID_ACC = '8574509' -- Account Number
ORDER BY LETDATE DESC;

