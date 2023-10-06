-- Used for generating the LETSEQ for annual statement comm generation process

SELECT TOP 1000 *
FROM LET_FORMATDATA
WHERE LETCODE_CODE = 'S1RMR|REVIEW' 
AND LETID_ACC = '8574509' -- Account Number
ORDER BY LETDATE DESC;


-- Used to see errored letters 

SELECT LETSEQ AS LetterNo, 
LETID_ACC AS AccountNumber, LETDATE AS LetterDate, 
LETCODE_CODE AS LetterType, 
LETFAILMESSAGE AS LetterFailMessage
FROM LET_FORMATDATA_ERROR
WHERE LETID_ACC = '2688084' -- AccountNumber
ORDER BY LETDATE DESC
